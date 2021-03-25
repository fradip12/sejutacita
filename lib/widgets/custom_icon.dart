import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CIcon extends StatelessWidget {
  final Color color;
  final int size;
  final IconData iconData;
  final Function func;

  const CIcon({Key key, this.size, this.iconData, this.color, this.func})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func ?? () {},
      child: Icon(
        iconData,
        size: size.toDouble(),
        color: color ?? Colors.grey[400],
      ),
    );
  }
}
