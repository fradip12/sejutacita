import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/bloc/chooser/chooser_bloc.dart';
import 'package:citav2/core/responsive.dart';
import 'package:citav2/core/services/api.dart';
import 'package:citav2/views/onboard/welcome.dart';
import 'package:citav2/widgets/button/chooser_button.dart';
import 'package:citav2/widgets/button/default_button.dart';
import 'package:citav2/widgets/button/default_icon.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:citav2/widgets/text/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum SingingCharacter { lafayette, jefferson }

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  final GlobalKey<FormFieldState> searchGlob = GlobalKey<FormFieldState>();
  bool test = false;

  @override
  Widget build(BuildContext context) {
    final width = getWidth(context);
    ChooserBloc choose = BlocProvider.of(context)..add(Lazy());

    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Row(
                    children: [
                      GitIcon(
                        size: 25,
                      ),
                      text(title: 'LookGit'),
                    ],
                  ),
                  backgroundColor: state.materialColor,
                ),
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: width * .25,
                        floating: false,
                        pinned: false,
                        backgroundColor: Colors.white,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          collapseMode: CollapseMode.none,
                          background: Center(
                              child: TextFormFieldBorder(
                            hintText: 'Cari sesuatu',
                            suffix: Icon(LineIcons.search),
                            onChanged: (String value) {
                              print(value);
                            },
                            globControl: search,
                            globKey: searchGlob,
                            isSecure: false,
                          )),
                        ),
                      ),
                    ];
                  },
                  body: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BlocBuilder<ChooserBloc, ChooserState>(
                              builder: (context, state) => ChooserButton(
                                title: 'Lazy Loading',
                                isSelected: state.index == 0,
                                func: () {
                                  if (state.index == 1) choose.add(Lazy());

                                  // test = !test;
                                  // test ? theme.add(ToBlack()) : theme.add(ToWhite());
                                },
                              ),
                            ),
                            BlocBuilder<ChooserBloc, ChooserState>(
                              builder: (context, state) => ChooserButton(
                                title: 'Index',
                                isSelected: state.index == 1,
                                func: () {
                                  if (state.index == 0) choose.add(Index());
                                  // test = !test;
                                  // test ? theme.add(ToBlack()) : theme.add(ToWhite());
                                },
                              ),
                            ),
                            Button(
                              title: 'test',
                              func: () {
                                Get.to(Welcome());
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
