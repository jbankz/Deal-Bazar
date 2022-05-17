import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextStyle? style;
  final EdgeInsets? margins;
  final int? maxlines;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final String? text;
  const CustomText(this.text,
      {Key? key,
      this.color,
      this.style,
      this.margins,
      this.overflow,
      this.maxlines,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margins ?? const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Text(text ?? '',
          maxLines: maxlines,
          overflow: overflow,
          textAlign: textAlign ?? TextAlign.left,
          style: TextStyle(color: Colors.white)),
    );
  }
}
