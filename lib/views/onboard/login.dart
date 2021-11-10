import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/bloc/login/login_bloc.dart';
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

  bool end = false;
  bool color = false;
  LoginBloc loginBloc;
  @override
  void initState() {
    super.initState();
    App.data.setBool('isWelcome', false);
    loginBloc = BlocProvider.of<LoginBloc>(context);
    print(loginBloc.state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => BlocBuilder<LoginBloc, LoginState>(
          builder: (context, loginState) => Container(
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
                            // loginBloc.add(InitLoggin());
                            // loginBloc.add(FetchLogin(
                            //     password: pass.text, username: user.text));
                            final response = await Git.login(
                                pass: pass.text, user: user.text);
                            print(response.runtimeType);
                            if (response is LoginResult) {
                              Get.toNamed('/lobby');
                            }
                          })
                    ],
                  ),
                ),
              ))),
    );
  }
}
