import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc(ThemeState state)
      : super(state ??
            ThemeState(
                materialColor: Colors.black,
                textColor: Colors.white,
                themeType: 'dark'));

  // ThemeBloc()
  //     : super(ThemeState(
  //           materialColor: Colors.black,
  //           textColor: Colors.white,
  //           themeType: 'dark'));
  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState(
          materialColor: Color(json['materialColor'] as int),
          themeType: json['themeType'] == 0 ? 'dark' : 'light',
          textColor: Color(json['textColor'] as int));
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, int> toJson(ThemeState state) {
    try {
      return {
        'materialColor': state.materialColor.value,
        'textColor': state.textColor.value,
        'themeType': state.themeType == 'dark' ? 0 : 1
      };
    } catch (e) {
      return null;
    }
  }

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
