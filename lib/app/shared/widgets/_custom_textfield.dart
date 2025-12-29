import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.width,
    required this.height,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.textStyle,
    this.fillColor,
    this.borderColor,
    this.foregroundColor,
  });

  final bool isPassword;
  final double width;
  final double height;
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextStyle? textStyle;
  final Color? fillColor;
  final Color? borderColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        cursorColor: borderColor ?? theme.colorScheme.primary,
        obscureText: isPassword,
        style: textStyle ?? theme.textTheme.bodyLarge?.copyWith(
          color: foregroundColor ?? theme.colorScheme.onPrimary,
        ),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(
            color: foregroundColor ?? theme.colorScheme.onPrimary,
          ),
          hintStyle: TextStyle(
            color: foregroundColor ?? theme.colorScheme.onPrimary,
          ),
          filled: true,
          fillColor: fillColor ?? theme.colorScheme.primary.withAlpha(50),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor ?? theme.colorScheme.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
