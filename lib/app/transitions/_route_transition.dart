import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum TransitionType { slide, fade, scale }
enum SlideDirection { left, right, up, down }

CustomTransitionPage<T> customTransitionPage<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  TransitionType type = TransitionType.scale,
  SlideDirection direction = SlideDirection.right,
  Duration duration = const Duration(milliseconds: 400),
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: Material(
      // Use Material 3 styling
      color: Theme.of(context).colorScheme.background,
      type: MaterialType.transparency,
      child: child,
    ),
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (type) {
        case TransitionType.fade:
          return FadeTransition(opacity: animation, child: child);

        case TransitionType.scale:
          return ScaleTransition(scale: animation, child: child);

        case TransitionType.slide:
        default:
          Offset beginOffset;
          switch (direction) {
            case SlideDirection.left:
              beginOffset = const Offset(-1, 0);
              break;
            case SlideDirection.right:
              beginOffset = const Offset(1, 0);
              break;
            case SlideDirection.up:
              beginOffset = const Offset(0, -1);
              break;
            case SlideDirection.down:
              beginOffset = const Offset(0, 1);
              break;
          }
          return SlideTransition(
            position: Tween<Offset>(begin: beginOffset, end: Offset.zero)
                .animate(animation),
            child: child,
          );
      }
    },
  );
}