import 'package:deal_bazaar/Core/services/local/local_db.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/SendOTPScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:deal_bazaar/core/enums/process_status.dart';
import 'package:deal_bazaar/core/models/user_model.dart';
import 'package:deal_bazaar/core/others/response_status.dart';
import 'package:deal_bazaar/core/services/database/db_service.dart';

import '../../../UI/Screens/SignUp_SignIn_Screens/OTPScreen.dart';
import '../../../marka_imports.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// [OTPMethods] ///

// Method to verify user number and then sent the otp code to the provided number

  Future<ProcessStatus> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    ProcessStatus status = ProcessStatus.loading;

    // Widget? widget;
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) {
            /// [MethodToDirectlyEnterOTP] ///
            // _auth.signInWithCredential(credential).then(
            //   (UserCredential credential) {
            //     status = ProcessStatus.compeleted;

            //     Get.off(() => const SignUpView());
            //     log('OTP Verified');
            //   },
            // );
          },
          verificationFailed: (FirebaseAuthException exception) {
            status = ProcessStatus.failed;

            Get.snackbar('Verification Failed', '${exception.message}',
                backgroundColor: MarkaColors.gold,
                colorText: MarkaColors.white,
                duration: const Duration(seconds: 10),
                snackPosition: SnackPosition.BOTTOM);
          },
          // ignore: avoid_types_as_parameter_names
          codeSent: (String verificationId, int) {
            status = ProcessStatus.compeleted;

            log('Code Sent');
            print("this is is");
            print(verificationId);

            Get.off(
              () => OTPScreen(
                userNumber: phoneNumber,
                varificationId: verificationId,
              ),
              transition: Transition.noTransition,
            );
          },
          codeAutoRetrievalTimeout: (String ver) {});
    } catch (e) {
      status = ProcessStatus.failed;

      Get.snackbar('Error', 'OTP Verification Failed',
          backgroundColor: MarkaColors.gold,
          colorText: MarkaColors.white,
          duration: const Duration(seconds: 10),
          snackPosition: SnackPosition.BOTTOM);
    }
    // return widget;
    return status;
  }

// Method to verify otp code sent to the user

  Future<ProcessStatus> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    ProcessStatus status = ProcessStatus.loading;
    try {
      final _credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp.trim());
      await _auth.signInWithCredential(_credential).then(
          (UserCredential credential) => status = ProcessStatus.compeleted);
    } catch (e) {
      log(e.toString());
      status = ProcessStatus.failed;
    }
    return status;
  }

  /// [UserSignUpMethods] ///

  Future<ResponseStatus> registerUser({required UserModel ourUser}) async {
    ResponseStatus status =
        ResponseStatus(status: ProcessStatus.loading, value: {});
    print("this is email");
    print(ourUser.emailAddress);
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: ourUser.emailAddress.toString().trim(),
              password: ourUser.password.toString())
          .then((user) async {
        ourUser.dbId = user.user!.uid;

        await DbService().addUserData(user: ourUser).then((value) {
          if (value.status == ProcessStatus.compeleted) {
            status.status = ProcessStatus.compeleted;
            status.value = {
              'dbId': user.user!.uid,
              'response': 'Success',
            };
          } else if (value.status == ProcessStatus.failed) {
            status.status = ProcessStatus.failed;
            log('Im Here and Catched Db Add Function Error');

            status.value = {
              'response': value.value['error'],
            };
          }
        });
      });
    } on PlatformException catch (e) {
      log('Im Here and Catched Platform Exception');

      status.status = ProcessStatus.failed;

      status.value = {
        'response': e.message,
      };
    } on FirebaseAuthException catch (k) {
      log('Im Here and Catched Firebase Exception');
      status.status = ProcessStatus.failed;

      status.value = {
        'response': k.message,
      };
    }
    return status;
  }

  Future<ResponseStatus> registerUserWithGoogle(
      {required UserModel ourUser, required String id}) async {
    ResponseStatus status =
        ResponseStatus(status: ProcessStatus.loading, value: {});
    print("this is email");
    print(ourUser.emailAddress);
    try {
      ourUser.dbId = id;

      await DbService().addUserData(user: ourUser).then((value) {
        if (value.status == ProcessStatus.compeleted) {
          status.status = ProcessStatus.compeleted;
          status.value = {
            'dbId': id,
            'response': 'Success',
          };
        } else if (value.status == ProcessStatus.failed) {
          status.status = ProcessStatus.failed;
          log('Im Here and Catched Db Add Function Error');

          status.value = {
            'response': value.value['error'],
          };
        }
      });
    } on PlatformException catch (e) {
      log('Im Here and Catched Platform Exception');

      status.status = ProcessStatus.failed;

      status.value = {
        'response': e.message,
      };
    } on FirebaseAuthException catch (k) {
      log('Im Here and Catched Firebase Exception');
      status.status = ProcessStatus.failed;

      status.value = {
        'response': k.message,
      };
    }
    return status;
  }

  Future<ResponseStatus> registerUserWithPhon(
      {required UserModel ourUser, required String id}) async {
    ResponseStatus status =
        ResponseStatus(status: ProcessStatus.loading, value: {});
    print("this is email");
    print(ourUser.emailAddress);
    try {
      ourUser.dbId = id;

      await DbService().addUserData(user: ourUser).then((value) {
        if (value.status == ProcessStatus.compeleted) {
          status.status = ProcessStatus.compeleted;
          status.value = {
            'dbId': id,
            'response': 'Success',
          };
        } else if (value.status == ProcessStatus.failed) {
          status.status = ProcessStatus.failed;
          log('Im Here and Catched Db Add Function Error');

          status.value = {
            'response': value.value['error'],
          };
        }
      });
    } on PlatformException catch (e) {
      log('Im Here and Catched Platform Exception');

      status.status = ProcessStatus.failed;

      status.value = {
        'response': e.message,
      };
    } on FirebaseAuthException catch (k) {
      log('Im Here and Catched Firebase Exception');
      status.status = ProcessStatus.failed;

      status.value = {
        'response': k.message,
      };
    }
    return status;
  }

  /// [UserSignIn] ///
  Future<ResponseStatus> signInUser({required email, required password}) async {
    ResponseStatus status =
        ResponseStatus(status: ProcessStatus.loading, value: {});
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        status.status = ProcessStatus.compeleted;
        LocalDb.setUserRecords(dbId: user.user!.uid, email: email);
        status.value = {
          'dbId': user.user!.uid,
          'response': 'Success',
        };
      });
    } on PlatformException catch (e) {
      log('Im Here and Catched Platform Exception: $e');

      status.status = ProcessStatus.failed;

      status.value = {
        'response': e.message,
      };
    } on FirebaseAuthException catch (k) {
      log('Im Here and Catched Firebase Exception: $k');
      status.status = ProcessStatus.failed;

      status.value = {
        'response': k.message,
      };
    }
    return status;
  }
}
