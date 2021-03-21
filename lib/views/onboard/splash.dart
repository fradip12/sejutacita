import 'dart:async';

import 'package:citav2/core/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:line_icons/line_icons.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    new Timer(new Duration(seconds: 3), () {
      //Go to Onboard if isOnboard
      Get.offNamed('/welcome');
      //or
      //go to home is !isOnboard
    });

    //startTime();
  }

  @override
  Widget build(BuildContext context) {
    final width = getWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Icon(
          LineIcons.github,
          size: width * .5,
        ),
      ),
    );
  }
}
