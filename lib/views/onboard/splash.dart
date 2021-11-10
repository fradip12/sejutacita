import 'dart:async';

import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/core/responsive.dart';
import 'package:citav2/core/shared/app.dart';
import 'package:citav2/widgets/button/default_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    new Timer(new Duration(seconds: 3), () {
      Get.offNamed('/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = getWidth(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => Scaffold(
        backgroundColor: state.materialColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GitIcon(
                size: (width * 0.5).toInt(),
                color: state.textColor,
              ),
              Text(
                'Github : fradip12',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
