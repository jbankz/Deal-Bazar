import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';

import '../../../Core/services/local/local_db.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocalDb.checkUserExists(),
      initialData: const [],
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const CircularProgressIndicator();
        } else if (snapshot.data == true) {
          return HomeScreen();
          // return MorningSectionPhotosUploadScreen();
          // return HomePageMyBuildings();
        } else {
          return HomeScreen();
          // return LogInPage();
        }
      },
    );

    // return const SplashScreen();
    // return const SignInView();
    // return const SignUpView();
    // return const OtpNumberView();
    // return const Dashboard();
    // return const PaymentMethodsView();
    // return const ConversationScreen();
  }
}
