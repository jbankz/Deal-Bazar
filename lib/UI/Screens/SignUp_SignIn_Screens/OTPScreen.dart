import 'package:deal_bazaar/Core/Constants/Assets.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/Core/utils/dialog_button.dart';
import 'package:deal_bazaar/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/otp_view_model.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/sign_up_viewmodel.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  final String userNumber;
  final String varificationId;
  OTPScreen({required this.userNumber, required this.varificationId});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOtpCodecontroller = TextEditingController();
  final FocusNode _pinOtpCodeFocus = FocusNode();
  String? verificationCode;

  final BoxDecoration pinOtpDecoration = BoxDecoration(
    color: Color(0xff4B4B4B),
    borderRadius: BorderRadius.circular(10),
  );
  _showDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogButton(
            titleText: 'Your Phone Number has been Verified',
            buttonText: 'DONE',
            action: () {
              BaseViewWidget.devLog('Pressed');
              // Get.back();
              Navigator.of(context, rootNavigator: true).pop(context);
              Get.off(() => HomeScreen()); // Get.offAll();
            },
          );
        });
  }

  String pin = '';
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OtpViewModel>();
    final vm = context.watch<SignUpViewModel>();
    return Scaffold(
      backgroundColor: yellowColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h), // Set this height
        child: Container(
          width: 325.w,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: yellowColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 26.w,
                  height: 26.w,
                  padding: EdgeInsets.only(left: 7.w),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5.r),
                    boxShadow: [
                      BoxShadow(
                        color: greyColor.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 0.1,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
              ),
              Text(
                'Verification',
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.notifications,
                size: 30.sp,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              SendOTPScreenPic,
            ),
            SizedBox(
              width: 266.w,
              child: Text(
                'Deal Bazar has sent the verification'
                'code to your number',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.userNumber,
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 26.w,
                    height: 26.h,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(10.r),
                      color: blackColor.withOpacity(0.8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.edit,
                        color: whiteColor,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            PinPut(
              fieldsCount: 6,
              textStyle: TextStyle(fontSize: 25, color: Colors.white),
              eachFieldWidth: 40,
              eachFieldHeight: 55,
              focusNode: _pinOtpCodeFocus,
              controller: _pinOtpCodecontroller,
              submittedFieldDecoration: pinOtpDecoration,
              selectedFieldDecoration: pinOtpDecoration,
              followingFieldDecoration: pinOtpDecoration,
              pinAnimationType: PinAnimationType.rotation,
              onSubmit: (pin) async {
                print(pin);
                setState(() {
                  verificationCode = pin;
                });
              },
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel,
                  barrierColor: Colors.black45,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (BuildContext buildContext, Animation animation,
                      Animation secondaryAnimation) {
                    return Center(
                      child: Container(
                        width: 284.w,
                        height: 345.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          children: [
                            Material(
                              child: Text(
                                'Your Phone Number has been Verified',
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Image.asset(
                              OTPverifiedPic,
                              scale: 3,
                            ),
                            SizedBox(height: 10.h),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => HomeScreen());
                              },
                              child: Material(
                                child: Container(
                                  width: 240.w,
                                  height: 44.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: blackColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Done',
                                      style: GoogleFonts.lato(
                                        fontSize: 16.sp,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 240.w,
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: blackColor,
                ),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      print("button pressed");
                      try {
                        print("this is");
                        print(verificationCode);
                        viewModel.setState2(true);
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: widget.varificationId,
                                smsCode: verificationCode!))
                            .then((value) => {
                                  print("user confirmed"),
                                  viewModel.setState2(false),
                                  if (value.user != null)
                                    {
                                      print("user verified"),
                                      vm.setFinalDataFromPhon(
                                          id: value.user!.uid,
                                          fullName: "",
                                          email: "",
                                          password: "",
                                          addressLine: "",
                                          phoneNumber: widget.userNumber,
                                          zipCode: "",
                                          addressLine2: "",
                                          faceId: "")
                                    }
                                });
                      } catch (e) {
                        viewModel.setState2(false);
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Invalid OTP"),
                          duration: Duration(seconds: 3),
                        ));
                      }
                    },
                    child: Text(
                      'VERIFY & CONTINUE',
                      style: GoogleFonts.lato(
                        color: whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
