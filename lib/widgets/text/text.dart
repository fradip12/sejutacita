import 'package:citav2/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget normalText({@required String title}) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) => Text(
      title,
      style: TextStyle(fontSize: 16, color: state.materialColor),
    ),
  );
}
