import 'package:flutter/material.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';

class CapsuleButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final String text;
  final Color? textColor;

  final BorderRadius? borderRadius;
  final VoidCallback? action;
  const CapsuleButton(
      {Key? key,
      this.action,
      this.height,
      this.textColor,
      this.borderRadius,
      required this.text,
      this.width,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action ?? () {},
      child: Container(
        width: width ?? 240.w,
        height: height ?? 40.h,
        decoration: BoxDecoration(
          color: color ?? MarkaColors.lightGold,
          borderRadius: borderRadius ?? BorderRadius.circular(22.0),
        ),
        child: Center(
          child: Text(text,
              style: TextStyle(
                color: color ?? MarkaColors.white,
              )),
        ),
      ),
    );
  }
}
