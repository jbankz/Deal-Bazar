import 'package:flutter/material.dart';

import '../../../Core/utils/colors.dart';

class LeadingWidget extends StatelessWidget {
  final Function()? onTap;
  const LeadingWidget({this.onTap, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.arrow_back_ios,
        color: MarkaColors.black,
      ),
    );
  }
}
