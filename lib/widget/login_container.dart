import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final double? height;
  final Color? color;
  final void Function()? onPressed;
  final Widget? icon;
  final String? imagePath;
  final double? imageHeight;
  const Box({
    super.key,
    this.imagePath,
    this.imageHeight,
    this.color,
    this.icon,
    this.onPressed,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height ?? 55,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Center(child: (IconButton(onPressed: onPressed, icon: icon!))),
      ),
    );
  }
}

class RoundBox extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;
  const RoundBox({super.key, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                imagePath,
                height: 30,
              ),
            ),
          )),
    );
  }
}
