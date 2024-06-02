import 'package:flutter/material.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: title,
          fontSize: 30,
        ),
        ContainerShadowBox(
          onTap: () {},
          height: 30,
          padding: const EdgeInsets.only(left: 15, right: 8),
          borderRadius: BorderRadius.circular(15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text(subTitle), const SizedBox(width: 5), Icon(icon, size: 11)]),
        )
      ],
    );
  }
}
