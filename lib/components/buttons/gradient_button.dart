import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String? text;
  final Icon? icon;
  final void Function() onTap;
  final double height;
  final double width;
  final BorderRadiusGeometry? borderRadius;
  final ShapeBorder? shape;
  final Widget? child;
  const GradientButton({
    super.key,
    this.text,
    this.icon,
    this.borderRadius,
    this.shape,
    required this.onTap,
    this.height = 40,
    required this.width,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: shape != null
            ? ShapeDecoration(
                shape: shape!,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(.75),
                  ],
                ),
              )
            : BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(.65),
                  ],
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(25),
              ),
        child: Center(
          child: child ??
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    if (text != null) const SizedBox(width: 8),
                  ],
                  if (text != null)
                    Text(
                      text!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                    ),
                ],
              ),
        ),
      ),
    );
  }
}
