import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class EyeIcon extends StatelessWidget {
  final int size;

  const EyeIcon({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Icon(
      LineIcons.eye,
      size: size.toDouble(),
      color: Colors.grey[400],
    );
  }
}
