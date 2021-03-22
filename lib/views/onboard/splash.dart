import 'dart:async';

import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/core/responsive.dart';
import 'package:citav2/core/shared/app.dart';
import 'package:citav2/widgets/button/default_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      //Go to Onboard if isWelcome
      if (!App.data.getBool('isWelcome')) {
        Get.offNamed('/lobby');
        // Get.offNamed('/welcome');
      } else
        Get.offNamed('/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = getWidth(context);
    if (!App.data.containsKey('isWelcome')) {
      App.data.setBool('isWelcome', true);
    }
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => Scaffold(
        backgroundColor: state.materialColor,
        body: Center(
          child: GitIcon(
            size: (width * 0.5).toInt(),
          ),
        ),
      ),
    );
  }
}
