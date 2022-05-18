import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Function()? onTap;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextDecoration? decoration;

  TextView({
    required this.text,
    this.textOverflow = TextOverflow.clip,
    this.textAlign = TextAlign.left,
    this.color,
    this.onTap,
    this.fontSize = 14.0,
    this.textStyle,
    this.decoration,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(text,
          style: textStyle ??
              GoogleFonts.roboto(
                  color: color,
                  fontWeight: fontWeight,
                  fontSize: fontSize.sp,
                  fontStyle: fontStyle),
          textAlign: textAlign,
          overflow: textOverflow,
          maxLines: maxLines),
    );
  }
}
