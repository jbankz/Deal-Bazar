import 'dart:async';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/OnboardingScreens/OnboardingScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/sign_up_viewmodel.dart';
import 'package:deal_bazaar/UI/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Core/others/important.dart';
import 'UI/Model/DrawerModel.dart';
import 'UI/Screens/CartScreen/cart_view_model.dart';
import 'UI/Screens/HomeScreen/HomeScreen.dart';
import 'UI/Screens/SignUp_SignIn_Screens/otp_view_model.dart';
import 'UI/Screens/SignUp_SignIn_Screens/sign_in_viewmodel.dart';
import 'UI/Screens/user_viewmodel/user_viewmodel.dart';
import 'UI/webview/web_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Imp.stripe;

  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DrawerModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignUpViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => OtpViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => WebViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignInViewModel(),
        ),
      ],
      child: DealBazaar(),
    ),
  );
}

class DealBazaar extends StatefulWidget {
  @override
  _DealBazaarState createState() => _DealBazaarState();
}

class _DealBazaarState extends State<DealBazaar> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Get.offAll(
        () => OnBoardingScreens(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: whiteColor,
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: blackColor,
            displayColor: whiteColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
