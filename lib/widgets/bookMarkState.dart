import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savory_safari/utils/colors.dart';

class Bookmarkstate extends StatefulWidget {
  final double height;
  final double width;
  final Color color;

  const Bookmarkstate({
    super.key,
    this.height = 40,
    this.width = 40,
    this.color = MyColors.grey,
  });

  @override
  State<Bookmarkstate> createState() => _BookmarkstateState();
}

class _BookmarkstateState extends State<Bookmarkstate> {
  bool _isBookMarked = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: InkWell(
        onTap: () {
          setState(() {
            _isBookMarked = !_isBookMarked;
          });
        },
        child: _isBookMarked
            ? Icon(
                CupertinoIcons.bookmark,
                size: 22,
                color: widget.color,
              )
            : Icon(
                CupertinoIcons.bookmark_fill,
                size: 22,
                color: MyColors.bottomNavGreenishYellow,
              ),
      ),
    );
  }
}
