import 'package:citav2/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget material({@required String title}) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) => Text(
      title,
      style: TextStyle(fontSize: 16, color: state.materialColor),
    ),
  );
}

Widget text({@required String title}) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) => Text(
      title,
      style: TextStyle(fontSize: 16, color: state.textColor),
    ),
  );
}

Widget text10({@required String title}) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) => Text(
      title,
      style: TextStyle(fontSize: 12, color: Colors.black),
    ),
  );
}

Widget text16Bold({@required String title}) {
  return Text(
    title,
    style: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
  );
}

Widget chooserText({@required String title, Color color}) {
  return Text(
    title,
    style: TextStyle(fontSize: 16, color: color),
  );
}
