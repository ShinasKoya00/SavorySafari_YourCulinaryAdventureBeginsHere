import 'package:flutter/material.dart';

class ContainerShadowBox extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color color;
  final Color textColor;
  final BorderRadius? borderRadius;
  final String? imageAsset;
  final String? imageNetwork;
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
    this.textColor = Colors.black,
    this.borderRadius,
    this.imageAsset,
    this.imageNetwork,
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
              offset: const Offset(0.0, 10.0),
              blurRadius: 10.0,
              spreadRadius: -5.0,
            ),
          ],
          color: color,
          borderRadius: borderRadius,
        ),
        child: imageAsset != null
            ? Image.asset(
                imageAsset!,
                scale: 5.5,
              )
            : imageNetwork != null
                ? Image.network(
                    imageNetwork!,
                  )
                : text != null
                    ? Text(
                        text!,
                        style: TextStyle(color: textColor),
                      )
                    : child,
      ),
    );
  }
}
