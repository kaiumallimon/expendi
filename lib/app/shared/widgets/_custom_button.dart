import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    this.color,
    this.textColor,
    required this.onPressed,
    this.isLoading = false,
  });
  final double width;
  final double height;
  final String text;
  final Color? color;
  final Color? textColor;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? theme.colorScheme.primary,
          foregroundColor: textColor ?? theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? Row(
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          children: [
            CupertinoActivityIndicator(
              color: textColor ?? theme.colorScheme.onPrimary,
            ),
            const SizedBox(width: 12),
            Text(
              'Loading...',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor ?? theme.colorScheme.onPrimary,
              ),
            ),
          ],
        )
            : Text(
          text,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor ?? theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
