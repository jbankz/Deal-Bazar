import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_bazaar/Core/services/authorization/auth_service.dart';
import 'package:deal_bazaar/Core/services/local/local_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:deal_bazaar/core/models/messages_model.dart';
import 'package:deal_bazaar/core/models/user_model.dart';
import 'package:deal_bazaar/core/others/response_status.dart';
import 'package:deal_bazaar/marka_imports.dart';
// ignore: library_prefixes
import 'package:path/path.dart' as Path;

import '../../../core/enums/process_status.dart';


class DbService {
  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // // Method to add User Data to Collections
  Future<ResponseStatus> addUserData({required UserModel user}) async {
    ResponseStatus status =
        ResponseStatus(status: ProcessStatus.loading, value: {});

    try {
      await _firestore
          .collection('users')
          .doc(user.dbId)
          .set(user.toFirebase())
          .whenComplete(() {
        status.status = ProcessStatus.compeleted;
      });
    } on PlatformException catch (e) {
      status.status = ProcessStatus.failed;
      status.value = {
        'error': e.message,
      };
    }
    return status;
  }

  // send message to Customer Support

  static Future<void> sendMessageCustomerSupport({
    required UserModel user,
    required String message,
  }) async {
    final refMessages = FirebaseFirestore.instance
        .collection('customerSupport')
        .doc(user.dbId)
        .collection('messages')
        .doc();

    final newMessage = MessageModel(
      dbId: user.dbId,
      emailAddress: user.emailAddress,
      // imageUrl: user.imageUrl,
      fullName: user.fullName,

      phoneNumber: user.phoneNumber,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.set(newMessage.messageToFirebase());
  }

  List<MessageModel> getMessage(QuerySnapshot snapshot) {
    List<MessageModel> cartProducts = [];
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        cartProducts.add(MessageModel.fromFirebase(firebase: element));
      }
    }
    return cartProducts;
  }

  Stream<List<MessageModel>> getMessages(String dbId) =>
      FirebaseFirestore.instance
          .collection('customerSupport')
          .doc(dbId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map(getMessage);

  // // Method to add User Image to Storage
  Future<String> uploadImageToStorage(
      String userName, XFile? image, String email) async {
    late String retVal;
    log('Inside DB Function ');

    Reference storageReference = FirebaseStorage.instance
        .ref('Users/$email/$userName/${Path.basename(image!.path)}');
    log('Inside DB2 Function ');
    log('Storage $storageReference');
    try {
      log('In Here');
      await storageReference.putFile(File(image.path)).then((res) async {
        log('Im Here');
        await res.ref.getDownloadURL().then((fileURL) async {
          // ignore: unnecessary_brace_in_string_interps
          log('Im Null Because of DB ${fileURL}');
          retVal = fileURL;
        });
      }); //  Image Upload code

    } on PlatformException catch (e) {
      log(e.toString());
      retVal = e.toString();

      // return null;
    }
    return retVal;
  }

  //// Method to add a product to a user cart

  Future<ResponseStatus> addProductToCart(
      {required String dbId, required ProductModel product}) async {
    ResponseStatus status =
        ResponseStatus(status: ProcessStatus.loading, value: {});
    print("adding to cart");
    try {
      LocalDb.getDbID().then((value) async {
        final doc =
            _firestore.collection('users').doc(value).collection('cart').doc();

        await doc.set(product.toFirebase());
        await doc.update({'id': doc.id}).whenComplete(() {
          status.status = ProcessStatus.compeleted;
        });
      });
      print("addded");
    } on PlatformException catch (e) {
      print("failed");
      status.status = ProcessStatus.failed;
      status.value = {
        'error': e.message,
      };
    }
    return status;
  }

  deleteFromCart({required String dbId, required String id}) async {
    log('IM Here clearing Produts');
    try {
      LocalDb.getDbID().then((value) async {
        await _firestore
            .collection('users')
            .doc(value)
            .collection('cart')
            .doc(id)
            .delete();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  deleteFromWishlist({required String dbId, required String wishlistId}) async {
    LocalDb.getDbID().then((value) async {
      await _firestore
          .collection('users')
          .doc(value)
          .collection('wishlist')
          .doc(wishlistId)
          .delete();
    });
  }

  Future<ProcessStatus> placeOrder(
      {required OrderStatusModel order,
      required String dbId,
      required List<ProductModel> products}) async {
    ProcessStatus status = ProcessStatus.loading;
    try {
      await _firestore
          .collection('users')
          .doc(dbId)
          .collection('orders')
          .doc(order.orderId)
          .set(order.toFirebase());
      for (var prod in products) {
        log('Prod ID ${prod.id}');
        await deleteFromCart(dbId: dbId, id: prod.id.toString());
      }
      status = ProcessStatus.compeleted;
    } catch (e) {
      status = ProcessStatus.failed;
      log(e.toString());
    }
    return status;
  }

  Future<UserModel> getUserData({required String dbId}) async {
    UserModel user = UserModel();
    try {
      await _firestore.collection('users').doc(dbId).get().then((value) {
        user = UserModel.fromFirebase(firebase: value);
      });
    } catch (e) {
      log(e.toString());
    }
    return user;
  }

  increaseProductQuantityInCart(
      {required String dbId, required String id, required int quan}) async {
    try {
      LocalDb.getDbID().then((value) async {
        await _firestore
            .collection('users')
            .doc(dbId)
            .collection('cart')
            .doc(id)
            .update({
          'quantity': quan + 1,
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }

  decreaseProductQuantityInCart(
      {required String dbId, required String id, required int quan}) async {
    try {
      LocalDb.getDbID().then((value) async {
        await _firestore
            .collection('users')
            .doc(dbId)
            .collection('cart')
            .doc(id)
            .update({
          'quantity': quan + -1,
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<ProcessStatus> shiftToCart(
      {required ProductModel product,
      required String dbId,
      required String wishlistId}) async {
    ProcessStatus status = ProcessStatus.loading;
    try {
      LocalDb.getDbID().then((value1) async {
        final doc =
            _firestore.collection('users').doc(value1).collection('cart').doc();

        await doc.set(product.toFirebase()).then((value) async {
          await doc.update({'id': doc.id}).whenComplete(() async {
            await _firestore
                .collection('users')
                .doc(value1)
                .collection('wishlist')
                .doc(wishlistId)
                .delete()
                .whenComplete(() {
              status = ProcessStatus.compeleted;
            });
          });
        });
      });
    } catch (e) {
      log(e.toString());
      status = ProcessStatus.failed;
    }
    return status;
  }

  Future<ResponseStatus> addProductToWishList(
      {required String dbId, required ProductModel product}) async {
    ResponseStatus status =
        ResponseStatus(status: ProcessStatus.loading, value: {});

    try {
      LocalDb.getDbID().then((value) async {
        final doc = _firestore
            .collection('users')
            .doc(value)
            .collection('wishlist')
            .doc();

        await doc.set(product.toFirebase());
        await doc.update({'id': doc.id}).whenComplete(() {
          status.status = ProcessStatus.compeleted;
        });
      });
    } on PlatformException catch (e) {
      status.status = ProcessStatus.failed;
      status.value = {
        'error': e.message,
      };
    }
    return status;
  }

  List<ProductModel> getAllCartProducts(QuerySnapshot snapshot) {
    List<ProductModel> cartProducts = [];
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        cartProducts.add(ProductModel.fromFirebase(firebase: element));
      }
    }
    return cartProducts;
  }

  Stream<List<ProductModel>> cartProducts({required String dbId}) {
    FirebaseAuth user = FirebaseAuth.instance;

    return _firestore
        .collection('users')
        .doc(dbId)
        .collection('cart')
        .snapshots()
        .map(getAllCartProducts);
  }

  List<ProductModel> getAllWishlistProducts(QuerySnapshot snapshot) {
    List<ProductModel> wishlistProducts = [];
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        wishlistProducts.add(ProductModel.fromFirebase(firebase: element));
      }
    }
    return wishlistProducts;
  }

  Stream<List<ProductModel>> wishlistProducts({required String dbId}) {
    return _firestore
        .collection('users')
        .doc(dbId)
        .collection('wishlist')
        .snapshots()
        .map(getAllCartProducts);
  }

  List<OrderStatusModel> getAllPendingOrders(QuerySnapshot snapshot) {
    List<OrderStatusModel> pendingOrders = [];

    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        if (element['isDelievered'] == false) {
          pendingOrders.add(OrderStatusModel.fromFirebase(firebase: element));
        }
        // ignore: curly_braces_in_flow_control_structures
      }
    }
    return pendingOrders;
  }

  Stream<List<OrderStatusModel>> pendingOrders({required String dbId}) {
    return _firestore
        .collection('users')
        .doc(dbId)
        .collection('orders')
        .snapshots()
        .map(getAllPendingOrders);
  }

  List<OrderStatusModel> getAllDelieveredOrders(QuerySnapshot snapshot) {
    List<OrderStatusModel> delieveredOrders = [];

    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        if (element['isDelievered'] == true) {
          delieveredOrders
              .add(OrderStatusModel.fromFirebase(firebase: element));
        }
        // ignore: curly_braces_in_flow_control_structures
      }
    }
    return delieveredOrders;
  }

  Stream<List<OrderStatusModel>> delieveredOrders({required String dbId}) {
    return _firestore
        .collection('users')
        .doc(dbId)
        .collection('orders')
        .snapshots()
        .map(getAllDelieveredOrders);
  }
}
