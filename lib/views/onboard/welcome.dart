import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          color: Colors.black,
          child: Text('Welcome'),
        ),
      ),
    );
  }
}