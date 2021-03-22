import 'package:citav2/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class GitIcon extends StatelessWidget {
  final int size;

  const GitIcon({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => Icon(
        LineIcons.github,
        size: size.toDouble(),
        color: state.textColor,
      ),
    );
  }
}
