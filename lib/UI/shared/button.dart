import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:deal_bazaar/UI/shared/textview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Core/Constants/Colors.dart';

class ButtonWidget extends StatelessWidget {
  final String? btnText;
  final Function()? onTap;
  final bool? isLoading;

  const ButtonWidget(
      {required this.btnText,
      required this.onTap,
      this.isLoading = false,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: blackColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextView(
                text: btnText!,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                color: Colors.white,
              ),
            ),
            isLoading!
                ? Center(
                    child: CupertinoActivityIndicator(
                    color: yellowColor,
                  ))
                : Icon(
                    Icons.arrow_forward,
                    size: 25.sp,
                    color: whiteColor,
                  ),
          ],
        ),
      ),
    );
  }
}
