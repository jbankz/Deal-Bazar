import 'package:flutter/foundation.dart';
import 'package:deal_bazaar/core/models/user_model.dart';
import 'package:deal_bazaar/core/services/database/db_service.dart';

class UserViewModel with ChangeNotifier {
  // ignore: prefer_final_fields
  UserModel _userModel = UserModel();
  UserModel get user => _userModel;

  setUserData({required String dbId}) async {
    await DbService().getUserData(dbId: dbId).then((value) {
      _userModel.fullName = value.fullName;

      _userModel.emailAddress = value.emailAddress;

      _userModel.phoneNumber = value.phoneNumber;
      _userModel.addressLine = value.addressLine;
      _userModel.faceID = value.faceID;
      _userModel.zipCode = value.zipCode;
      _userModel.dbId = value.dbId;
      // _userModel.imageUrl = value.imageUrl;

      notifyListeners();
    });
  }

  setUserDbId({required String dbId}) {
    _userModel.dbId = dbId;
    notifyListeners();
  }
}
