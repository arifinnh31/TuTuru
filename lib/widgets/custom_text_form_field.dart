// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
// import 'package:tuturu/core/app_export.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  bool? obscureText;

  CustomTextFormField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.obscureText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 288,
      height: 60,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: Color(0xFFF2F2F2),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.obscureText != null
              ? IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(widget.obscureText == true
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText!;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
