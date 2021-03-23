import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Orientation getOrientation(BuildContext context) {
  return MediaQuery.of(context).orientation;
}
