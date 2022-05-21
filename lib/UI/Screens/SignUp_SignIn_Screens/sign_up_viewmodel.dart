import 'package:deal_bazaar/Core/Constants/logger.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:deal_bazaar/core/models/user_model.dart';
import 'package:deal_bazaar/core/services/authorization/auth_service.dart';
import 'package:deal_bazaar/core/services/database/db_service.dart';
import 'package:deal_bazaar/core/services/local/local_db.dart';
import 'package:deal_bazaar/marka_imports.dart';

import '../../../Core/services/error/firebase_exception.dart';
import '../../../core/enums/process_status.dart';
import '../CartScreen/CheckoutScreen.dart';

class SignUpViewModel with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setState(bool state) {
    _loading = state;
    notifyListeners();
  }

  // ignore: prefer_final_fields, unused_field
  UserModel _user = UserModel();

  // Method to get Data from First Page
  XFile? _userPhoto;
  XFile? get userPhoto => _userPhoto;

  setUserPhoto(XFile image) {
    _userPhoto = image;
    notifyListeners();
  }

  setFinalData(
      {required String fullName,
      required String addressLine2,
      required String faceId,
      required String email,
      required String password,
      required String phoneNumber,
      required String addressLine,
      required String zipCode}) {
    setState(true);

    _user.phoneNumber = phoneNumber;
    _user.addressLine = addressLine;
    _user.fullName = fullName;
    _user.password = password;
    _user.emailAddress = email;
    _user.zipCode = zipCode;
    _user.addressLine2 = addressLine2;
    _user.faceID = faceId;

    _signUpUser();
  }

  setFinalDataFromGoogle(
      {required String fullName,
      required String addressLine2,
      required String faceId,
      required String email,
      required String password,
      required String phoneNumber,
      required String addressLine,
      required String id,
      required String zipCode}) {
    setState(true);

    _user.phoneNumber = phoneNumber;
    _user.addressLine = addressLine;
    _user.fullName = fullName;
    _user.password = password;
    _user.emailAddress = email;
    _user.zipCode = zipCode;
    _user.dbId = id;

    _signUpUserWithGoogle(id);
  }

  setFinalDataFromPhon(
      {required String fullName,
      required String addressLine2,
      required String faceId,
      required String email,
      required String password,
      required String phoneNumber,
      required String addressLine,
      required String id,
      required String zipCode}) {
    setState(true);

    _user.phoneNumber = phoneNumber;
    _user.addressLine = addressLine;
    _user.fullName = fullName;
    _user.password = password;
    _user.emailAddress = email;
    _user.zipCode = zipCode;

    _signUpUserWithPhon(id);
  }

  loginUser({required String email, required String password}) async {
    setState(true);
    Get.to(HomeScreen());

    await AuthService()
        .signInUser(email: email, password: password)
        .then((value) {
      Get.to(HomeScreen());
    }).catchError((e) {
      Get.snackbar('Sign Up Error', e.errorMessage ?? '',
          backgroundColor: MarkaColors.red2,
          colorText: MarkaColors.white,
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  // ignore: unused_element
  _signUpUser() async {
    await AuthService().registerUser(ourUser: _user).then((value) async {
      if (value.status == ProcessStatus.compeleted) {
        final dbId = value.value['dbId'];
        await LocalDb.setUserRecords(
          dbId: dbId,
          email: _user.emailAddress.toString(),
        ).whenComplete(() {
          Get.offAll(
            HomeScreen(),
            transition: Transition.noTransition,
          );
        });
      }
    }).catchError((e) {
      Get.snackbar('Sign Up Error', e.errorMessage ?? '',
          backgroundColor: MarkaColors.red2,
          colorText: MarkaColors.white,
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM);
    });
    setState(false);
  }

  _signUpUserWithGoogle(String id) async {
    await AuthService()
        .registerUserWithGoogle(ourUser: _user, id: id)
        .then((value) async {
      if (value.status == ProcessStatus.compeleted) {
        final dbId = value.value['dbId'];
        log(dbId);
        await LocalDb.setUserRecords(
          dbId: dbId,
          email: _user.emailAddress.toString(),
        ).whenComplete(() {
          setState(false);
          Get.offAll(
            HomeScreen(),
            transition: Transition.noTransition,
          );
        });
      } else if (value.status == ProcessStatus.failed) {
        final response = value.value['response'];
        Get.snackbar('Sign Up Error', '$response',
            backgroundColor: MarkaColors.gold,
            colorText: MarkaColors.white,
            duration: const Duration(seconds: 10),
            snackPosition: SnackPosition.BOTTOM);

        setState(false);
      }
    });
  }

  _signUpUserWithPhon(String id) async {
    await AuthService()
        .registerUserWithPhon(ourUser: _user, id: id)
        .then((value) async {
      if (value.status == ProcessStatus.compeleted) {
        final dbId = value.value['dbId'];
        log(dbId);
        await LocalDb.setUserRecords(
          dbId: dbId,
          email: _user.emailAddress.toString(),
        ).whenComplete(() {
          setState(false);
          Get.offAll(
            HomeScreen(),
            transition: Transition.noTransition,
          );
        });
      } else if (value.status == ProcessStatus.failed) {
        final response = value.value['response'];
        Get.snackbar('Sign Up Error', '$response',
            backgroundColor: MarkaColors.gold,
            colorText: MarkaColors.white,
            duration: const Duration(seconds: 10),
            snackPosition: SnackPosition.BOTTOM);

        setState(false);
      }
    });
  }
}
