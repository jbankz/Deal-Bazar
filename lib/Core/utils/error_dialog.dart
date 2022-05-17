import 'package:deal_bazaar/marka_imports.dart';
import 'package:flutter/material.dart';

import '../../UI/base_view/base_view.dart';
import 'capsule_button.dart';

class ErrorDialog extends StatefulWidget {
  final VoidCallback? action;
  final String errorText;
  final String statusText;

  final String buttonText;

  const ErrorDialog({
    Key? key,
    this.action,
    required this.statusText,
    required this.errorText,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: BaseViewWidget.height * 0.21, horizontal: 20.w),
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
          Text('Error: ' + widget.statusText,
              style: TextStyle(color: Colors.black)),
          SizedBox(height: 35.h),
          Icon(
            Icons.error,
            size: 150,
          ),
          SizedBox(height: 35.h),
          Text(widget.errorText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
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
