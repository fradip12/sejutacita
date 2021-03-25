import 'package:cached_network_image/cached_network_image.dart';
import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/core/responsive.dart';
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
    String urlImage =
        "https://avatars.githubusercontent.com/u/65805640?s=460&u=bc0d9b5c006e297bdb5aa928d6acb46d732ddab1&v=4";

    return SafeArea(
      child: DefaultAppBar(
          title: 'Settings',
          back : true,
          body: Column(
            children: <Widget>[
              SingleChildScrollView(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: CachedNetworkImage(
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                        imageUrl: urlImage),
                  ),
                ],
              ),
              Container(
                constraints: BoxConstraints(maxWidth: getWidth(context) * 0.6),
                child: text16Bold(
                    center: true,
                    title: 'Thank you for having me to join this Dev Test'),
              ),
            ],
          )),
    );
  }
}
