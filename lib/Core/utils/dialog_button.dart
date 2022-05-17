import 'package:deal_bazaar/Core/utils/capsule_button.dart';
import 'package:flutter/material.dart';
import 'package:deal_bazaar/Core/utils/capsule_button.dart';

import '../../UI/base_view/base_view.dart';

class DialogButton extends StatefulWidget {
  final VoidCallback? action;
  final String titleText;
  final String buttonText;

  const DialogButton({
    Key? key,
    this.action,
    required this.titleText,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<DialogButton> createState() => _DialogButtonState();
}

class _DialogButtonState extends State<DialogButton> {
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
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 35.h),
          Icon(
            Icons.warning,
            size: 150,
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
