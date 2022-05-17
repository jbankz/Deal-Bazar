import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:deal_bazaar/marka_imports.dart';
import 'package:flutter/material.dart';

import '../../../Core/utils/capsule_button.dart';

class DialogButton2 extends StatefulWidget {
  final VoidCallback? action;
  final String titleText;
  final String buttonText;
  final String? middleText;

  const DialogButton2({
    Key? key,
    this.action,
    this.middleText,
    required this.titleText,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<DialogButton2> createState() => _DialogButton2State();
}

class _DialogButton2State extends State<DialogButton2> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: BaseViewWidget.height * 0.2319, horizontal: 20.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            widget.titleText,
            style: TextStyle(color: Colors.yellow),
          ),
          SizedBox(height: 35.h),
          SvgPicture.asset(MarkaIllustrations.sucessIllustration),
          if (widget.middleText != null) SizedBox(height: 10.h),
          if (widget.middleText != null)
            Text(
              widget.middleText!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          SizedBox(height: 35.h),
          CapsuleButton(
            text: widget.buttonText,
            action: widget.action,
          ),
        ],
      ),
    );
  }
}
