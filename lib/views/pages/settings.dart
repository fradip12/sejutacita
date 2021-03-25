import 'package:citav2/widgets/appbar/default_app.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      title: 'Settings',
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  color: Colors.amber,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
