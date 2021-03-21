import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class Button extends StatelessWidget {
  final String title;
  final Function func;

  const Button({Key key, this.title,this.func})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: state.textColor,
          shape: StadiumBorder(),
        ),
        onPressed: func,
        child: normalText(title: title),
      ),
    );
  }
}
