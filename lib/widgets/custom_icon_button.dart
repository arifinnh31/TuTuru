// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(33),
          child: Row(
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(33),
                  border: Border.all(color: Colors.black38, width: 1),
                ),
                child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(icon),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
      ],
    );
  }
}
