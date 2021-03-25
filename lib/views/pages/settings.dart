import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/widgets/appbar/default_app.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatelessWidget {
  ThemeBloc theme;
  Widget mSetting(var heading, var subLabel, var value) {
    bool isDark;
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      isDark = state.themeType == 'dark';
      return Card(
        elevation: 10,
        margin: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: text16Bold(
                    title: heading,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: text14(
                      title: subLabel,
                    ),
                  ),
                  Switch(
                    value: isDark,
                    onChanged: (value) {
                      isDark ? theme.add(ToWhite()) : theme.add(ToBlack());
                    },
                    activeTrackColor: Colors.black,
                    activeColor: Colors.white,
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = BlocProvider.of<ThemeBloc>(context);

    return SafeArea(
      child: DefaultAppBar(
          title: 'Settings',
          body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        mSetting(
                            'Theme',
                            'Change to ${theme.state.themeType == 'dark' ? 'Light' : 'Dark'}',
                            true),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
  // return DefaultAppBar(
  //   title: 'Settings',
  //   body: Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [text16Bold(title: 'Preferences')],
  //         ),
  //       ],
  //     ),
  //   ),
  // );

}
