import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

 

class LoaderWidget extends StatelessWidget {
  final String message;
  final Color? color;
  const LoaderWidget({Key? key, required this.message, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(message,
              style: TextStyle( color: color ?? Colors.white)),
          SpinKitThreeBounce(
            color: color ?? Colors.white,
            size: 35.0,
          ),
        ],
      ),
    );
  }
}
