import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CIcon extends StatelessWidget {
  final int size;
  final IconData iconData;

  const CIcon({Key key, this.size, this.iconData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: size.toDouble(),
      color: Colors.grey[400],
    );
  }
}
