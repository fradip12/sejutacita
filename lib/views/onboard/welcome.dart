import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/core/models/login/login_model.dart';
import 'package:citav2/core/services/api.dart';
import 'package:citav2/core/shared/app.dart';
import 'package:citav2/widgets/button/default_button.dart';
import 'package:citav2/widgets/text/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  TextEditingController user = TextEditingController();
  final GlobalKey<FormFieldState> userGlob = GlobalKey<FormFieldState>();
  TextEditingController pass = TextEditingController();
  final GlobalKey<FormFieldState> passGlob = GlobalKey<FormFieldState>();

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
                width: Get.size.width * 0.65,
                child: TextFormFieldBorder(
                  hintText: 'username',
                  prefixIcon: Icon(LineIcons.user),
                  onSubmitted: (String value) {
                    print('Look for : ' + value);
                  },
                  globControl: user,
                  globKey: userGlob,
                  isSecure: false,
                ),
              ),
              SizedBox(
                width: Get.size.width * 0.65,
                child: TextFormFieldBorder(
                  hintText: 'password',
                  prefixIcon: Icon(LineIcons.key),
                  onSubmitted: (String value) {
                    print('Look for : ' + value);
                  },
                  globControl: pass,
                  globKey: passGlob,
                  isSecure: false,
                ),
              ),
              Button(
                title: 'Login',
                func: () async {
                  final response =
                      await Git.login(pass: pass.text, user: user.text);

                  if (response is LoginResult) {
                    color = !color;
                    Get.toNamed('/lobby');
                  } else {
                    Get.snackbar('Err', 'Login Error');
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
