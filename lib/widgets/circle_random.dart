import 'dart:math';

import 'package:flutter/material.dart';

class CircleRandom extends StatefulWidget {
  final int index;

  const CircleRandom({Key key, this.index}) : super(key: key);
  @override
  _CircleRandomState createState() => _CircleRandomState();
}

class _CircleRandomState extends State<CircleRandom> {
  List colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black
  ];

  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colors.elementAt(widget.index)),
    );
  }
}
