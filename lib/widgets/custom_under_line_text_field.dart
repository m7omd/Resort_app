import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class CustomUnderlineTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Color underlineColor;
  final Color? fillColor;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  CustomUnderlineTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.hintStyle,
    this.textStyle,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.underlineColor = Colors.blue,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: textStyle ?? const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: fillColor,
        errorStyle: TextStyle(color: AppColors.red),
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: underlineColor)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: underlineColor)),
        errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 3)),
      ),
      onSaved: onSaved,
    );
  }
}
