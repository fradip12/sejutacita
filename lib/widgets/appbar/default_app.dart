import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  final String leading;
  final Widget body;

  const DefaultAppBar({Key key, this.title, this.leading, this.body}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black54,
      ),
    );
  }
}
