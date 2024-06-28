import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';

class BookmarkState extends StatefulWidget {
  final double height;
  final double width;
  final Color color;

  const BookmarkState({
    super.key,
    this.height = 40,
    this.width = 40,
    this.color = MyColors.grey,
  });

  @override
  State<BookmarkState> createState() => _BookmarkStateState();
}

class _BookmarkStateState extends State<BookmarkState> {
  bool _isBookMarked = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: InkWell(
        onTap: () {
          setState(() {
            _isBookMarked = !_isBookMarked;
          });
        },
        child: Icon(
          _isBookMarked ? CupertinoIcons.bookmark : CupertinoIcons.bookmark_fill,
          size: SizeConfig.getIconSize(22), // Dynamic icon size
          color: _isBookMarked ? widget.color : MyColors.bottomNavGreenishYellow,
        ),
      ),
    );
  }
}
