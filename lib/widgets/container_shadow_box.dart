import 'package:flutter/material.dart';

class ContainerShadowBox extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color color;
  final BorderRadius? borderRadius;
  final String? image;
  final String? text;
  final Widget? child;
  final VoidCallback? onTap;

  const ContainerShadowBox({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.color = Colors.white,
    this.borderRadius,
    this.image,
    this.text,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(0.0, 10.0),
              blurRadius: 10.0,
              spreadRadius: -5.0,
            ),
          ],
          color: color,
          borderRadius: borderRadius,
        ),
        child: image != null
            ? Image.asset(
                image!,
                scale: 5.5,
              )
            : text != null
                ? Text(text!)
                : child,
      ),
    );
  }
}
