import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Core/Constants/Colors.dart';

class CustomTextFieldWithLeadingIcon extends StatelessWidget {
  final IconData leadingIcon;
  final String hint;
  final Color bcColor;
  final String? Function(String?)? validatorFunction;
  final TextEditingController controller;
  final bool obsecure;
  final TextInputType? keyboardType;

  CustomTextFieldWithLeadingIcon(
      {required this.hint,
      required this.obsecure,
      required this.controller,
      this.validatorFunction,
      required this.leadingIcon,
      this.keyboardType,
      required this.bcColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: bcColor,
        border: Border.all(color: blackColor),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: TextFormField(
        obscureText: obsecure,
        controller: controller,
        validator: validatorFunction,
        cursorColor: blackColor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        style: GoogleFonts.roboto(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            leadingIcon,
            color: greyColor,
          ),
          hintStyle: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: greyColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
