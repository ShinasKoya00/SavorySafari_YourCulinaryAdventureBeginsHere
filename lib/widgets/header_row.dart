import 'package:flutter/material.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';
import 'package:savory_safari/widgets/container_shadow_box.dart';
import 'package:savory_safari/widgets/my_text.dart';

class HeaderRow extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;

  const HeaderRow({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: title,
          fontSize: SizeConfig.getFontSize(15), // Dynamic font size
        ),
        ContainerShadowBox(
          onTap: () {
            // Handle onTap event if needed
          },
          height: SizeConfig.getHeight(30),
          // Dynamic height
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getWidth(15), // Dynamic horizontal padding
          ),
          borderRadius: BorderRadius.circular(SizeConfig.getWidth(15)),
          // Dynamic border radius
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                subTitle,
                style: TextStyle(fontSize: SizeConfig.getFontSize(10)), // Dynamic font size
              ),
              const SizedBox(width: 5),
              Icon(
                icon,
                size: SizeConfig.getWidth(11), // Dynamic icon size
              ),
            ],
          ),
        )
      ],
    );
  }
}
