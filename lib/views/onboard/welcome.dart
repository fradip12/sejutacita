import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/core/shared/app.dart';
import 'package:citav2/widgets/button/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<String> text = ['Welcome', 'to', 'LookGit'];
  bool end = false;
  bool color = false;
  @override
  void initState() {
    super.initState();
    App.data.setBool('isWelcome', false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => Container(
          child: Scaffold(
        backgroundColor: state.materialColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250.0,
                child: TypewriterAnimatedTextKit(
                  text: text,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(fontSize: 30.0, color: state.textColor),
                ),
              ),
              Button(
                title: 'Start',
                func: () {
                  color = !color;
                  Get.toNamed('/lobby');
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
