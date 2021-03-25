import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            materialColor: Colors.black,
            textColor: Colors.white,
            themeType: 'dark'));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ToWhite) {
      yield ThemeState(
          materialColor: Colors.white,
          textColor: Colors.black,
          themeType: 'light');
    } else if (event is ToBlack) {
      yield ThemeState(
          materialColor: Colors.black,
          textColor: Colors.white,
          themeType: 'dark');
    }
  }
}
