import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:line_icons/line_icons.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  final String leading;
  final Widget body;
  final bool back;

  const DefaultAppBar({Key key, this.title, this.leading, this.body,this.back})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
            leading: back ? InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                LineIcons.arrowCircleLeft,
                color: state.textColor,
              ),
            ): Container(),
            title: text(title: title),
            backgroundColor: state.materialColor) ,
        body: body,
      ),
    );
  }
}
