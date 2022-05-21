import 'package:flutter/foundation.dart';
// import 'package:deal_bazaar/core/enums/process_status.dart';
import 'package:deal_bazaar/core/services/authorization/auth_service.dart';
import 'package:phonenumbers_core/core.dart';

import '../../../core/enums/process_status.dart';


class OtpViewModel with ChangeNotifier {
  bool _loading = false;
  bool _loading2 = false;

  bool get loading => _loading;
  bool get loader2 => _loading2;

  setState(bool newState) {
    _loading = newState;
    notifyListeners();
  }

  setState2(bool newState) {
    _loading2 = newState;
    notifyListeners();
  }

  verifyNumberLocally({required String phoneNumber}) =>
      PhoneNumber.parse(phoneNumber).isValid;

  callToFirebase({required String phoneNumber}) async {
    await AuthService()
        .verifyPhoneNumber(phoneNumber: phoneNumber)
        .then((value) {
      if (value == ProcessStatus.failed) {
        setState(false);
      } else if (value == ProcessStatus.compeleted) {
        setState(false);
      }
    });
  }

  // Future<ProcessStatus> finalCallToFirebase(
  //         {required String verificationId, required String otp}) async =>
  //     await AuthService().verifyOtp(verificationId: verificationId, otp: otp);
  //     .then((value) {
  //   if (value == ProcessStatus.compeleted) {
  //     // return ProcessStatus.compeleted;
  //   } else if (value == ProcessStatus.failed) {
  //     // return ProcessStatus.failed;
  //   }
  // });
}
