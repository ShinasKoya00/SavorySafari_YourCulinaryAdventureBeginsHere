import 'package:flutter/material.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';

class ContainerShadowBox extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color color;
  final Color boxShadowColor;
  final Color textColor;
  final BorderRadius? borderRadius;
  final String? imageAsset;
  final String? imageNetwork;
  final String? text;
  final double? textSize;
  final double? iconSize; // Add icon size
  final Widget? child;
  final VoidCallback? onTap;

  const ContainerShadowBox({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.color = Colors.white,
    this.boxShadowColor = Colors.grey,
    this.textColor = Colors.black,
    this.borderRadius,
    this.imageAsset,
    this.imageNetwork,
    this.text,
    this.textSize = 14,
    this.iconSize = 22, // Default icon size
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

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
              color: boxShadowColor,
              offset: const Offset(0.0, 10.0),
              blurRadius: 10.0,
              spreadRadius: -5.0,
            ),
          ],
          color: color,
          borderRadius:
              borderRadius ?? BorderRadius.circular(SizeConfig.getWidth(12)), // Dynamic border radius
        ),
        child: imageAsset != null
            ? Image.asset(
                imageAsset!,
                scale: SizeConfig.getWidth(5.5), // Dynamic image scale
              )
            : imageNetwork != null
                ? Image.network(
                    imageNetwork!,
                  )
                : text != null
                    ? Text(
                        text!,
                        style: TextStyle(color: textColor, fontSize: textSize),
                      )
                    : child,
      ),
    );
  }
}
