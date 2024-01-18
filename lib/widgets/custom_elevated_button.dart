// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final Color buttonColor;
  final VoidCallback onPressed;
  final Widget child;

  const CustomElevatedButton({
    Key? key,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.buttonColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: buttonColor == Get.theme.primaryColor
              ? Colors.white
              : Get.theme.primaryColor,
          side: BorderSide(color: Get.theme.primaryColor, width: 1),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
