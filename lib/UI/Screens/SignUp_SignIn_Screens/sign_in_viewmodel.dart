import 'package:deal_bazaar/Core/Constants/logger.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:deal_bazaar/core/services/authorization/auth_service.dart';
import 'package:deal_bazaar/core/services/local/local_db.dart';

import '../../../core/enums/process_status.dart';
import '../../../Core/utils/messages.dart';
import '../../../marka_imports.dart';

class SignInViewModel with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setState(bool state) {
    _loading = state;
    notifyListeners();
  }

  signInUser({required String email, required String password}) async {
    setState(true);

    await AuthService()
        .signInUser(email: email, password: password)
        .then((value) async {
      if (value.status == ProcessStatus.compeleted) {
        final dbId = value.value['dbId'];
        log(dbId);
        await LocalDb.setUserRecords(
          dbId: dbId,
          email: email,
        ).whenComplete(() {
          setState(false);
          Get.offAll(
            HomeScreen(),
            transition: Transition.noTransition,
          );
        });
      } else if (value.status == ProcessStatus.failed) {
        final response = value.value['response'];
        showSnack('Error', response ?? '', isError: true);
      }
    }).catchError((e) {
      showSnack('Error', e.errorMessage ?? '', isError: true);
    });
    setState(false);
  }
}
