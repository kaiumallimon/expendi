import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.theme,
    required this.height,
    required this.title,
    required this.subtitle,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.leading,
  });

  final ThemeData theme;
  final double height;
  final String title;
  final String subtitle;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // borderRadius: const BorderRadius.only(
        //   bottomLeft: Radius.circular(24),
        //   bottomRight: Radius.circular(24),
        // ),
        borderRadius: borderRadius,
        color: backgroundColor ?? theme.scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.only(
        top: height + 10,
        left: 20,
        right: 20,
        bottom: height,
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                Text(
                  title,
                  style: leading==null? theme.textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: foregroundColor ?? theme.textTheme.displayLarge?.color,
                  ):theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: foregroundColor ?? theme.textTheme.displayLarge?.color,
                  ),
                ),
                if(leading==null) const SizedBox(height: 8),
               if(leading==null) Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color:
                        foregroundColor?.withAlpha(150) ??
                        theme.textTheme.bodyMedium?.color?.withAlpha(150),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
