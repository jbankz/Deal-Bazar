import 'package:deal_bazaar/Core/Constants/Animations.dart';
import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/OnboardingScreens/OnboardingFinalScreen.dart';
import 'package:deal_bazaar/UI/shared/textview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'widgets/info_widget.dart';

class OnBoardingScreens extends StatefulWidget {
  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  List<Widget> getPages() {
    return [
      OnBoardingWidget(
        image: onBoarding1,
        title: 'Lorem ipsum dolor sit amet',
        slogan: 'Lorem ipsum dolor sit amet, consectetur '
            'adipiscing elit. Duis magna justo, '
            'scelerisque et euismod',
      ),
      OnBoardingWidget(
        image: onBoarding2,
        title: 'Lorem ipsum dolor sit amet',
        slogan: 'Lorem ipsum dolor sit amet, consectetur '
            'adipiscing elit. Duis magna justo, '
            'scelerisque et euismod',
      ),
      OnBoardingWidget(
        image: onBoarding3,
        title: 'Lorem ipsum dolor sit amet',
        slogan: 'Lorem ipsum dolor sit amet, consectetur '
            'adipiscing elit. Duis magna justo, '
            'scelerisque et euismod',
      ),
      OnBoardingWidget(
        image: onBoarding4,
        title: 'Lorem ipsum dolor sit amet',
        slogan: 'Lorem ipsum dolor sit amet, consectetur '
            'adipiscing elit. Duis magna justo, '
            'scelerisque et euismod',
      ),
      OnBoardingWidget(
        image: onBoarding5,
        title: 'Lorem ipsum dolor sit amet',
        slogan: 'Lorem ipsum dolor sit amet, consectetur '
            'adipiscing elit. Duis magna justo, '
            'scelerisque et euismod',
      ),
    ];
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          scrollPhysics: ScrollPhysics(parent: ClampingScrollPhysics()),
          controlsPadding: EdgeInsets.zero,
          rawPages: getPages(),
          onChange: (i) => setState(() {
            _index = i;
          }),
          dotsDecorator: DotsDecorator(
            size: Size(10.w, 6.h),
            activeSize: Size(20.w, 6.h),
            color: yellowColor.withOpacity(0.4),
            activeColor: yellowColor,
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r)),
          ),
          next: _arrowWidget(),
          back: _arrowWidget(isNext: false),
          baseBtnStyle: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
          onDone: () => Get.offAll(() => OnboardingFinalScreen()),
          onSkip: () => Get.offAll(() => OnboardingFinalScreen()),
          showBackButton: _index != 0,
          showSkipButton: _index == 0,
          skip: TextView(
            text: 'SKIP',
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          done: TextView(
            text: 'DONE',
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _arrowWidget({bool isNext = true, Widget? widget}) => CircleAvatar(
        radius: 20.r,
        backgroundColor: yellowColor,
        child: widget ??
            Icon(
              isNext ? Icons.arrow_forward : Icons.arrow_back,
              color: blackColor,
            ),
      );
}
