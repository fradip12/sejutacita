import 'package:citav2/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  final String leading;
  final Widget body;

  const DefaultAppBar({Key key, this.title, this.leading, this.body})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => Scaffold(
        appBar:
            AppBar(title: Text(title), backgroundColor: state.materialColor),
      ),
    );
  }
}
