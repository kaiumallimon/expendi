
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
  });

  final bool isPassword;
  final double width;
  final double height;
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        obscureText: isPassword,
        style: textStyle ?? theme.textTheme.bodyLarge,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: theme.colorScheme.primary.withAlpha(50),
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
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
