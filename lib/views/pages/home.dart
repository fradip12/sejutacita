import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/core/responsive.dart';
import 'package:citav2/widgets/button/default_icon.dart';
import 'package:citav2/widgets/custom_icon.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:citav2/widgets/text/text_field.dart';
import 'package:flutter/cupertino.dart';
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
  ScrollController contr = new ScrollController();
  double maxScroll;
  double currentScroll;
  int page = 1;

  @override
  void initState() {
    super.initState();

    // pageEvent = BlocProvider.of<PagingBloc>(context);
  }

  @override
  void dispose() {
    contr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = getWidth(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) => GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      actions: [
                        CIcon(
                          iconData: LineIcons.bars,
                          size: 30,
                          color: themeState.textColor,
                          func: () {
                            Get.toNamed('/setting');
                          },
                        )
                      ],
                      title: Row(
                        children: [
                          GitIcon(
                            size: 25,
                          ),
                          text(title: 'LookGit'),
                        ],
                      ),
                      backgroundColor: themeState.materialColor,
                    ),
                    body: NestedScrollView(
                      controller: contr,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            expandedHeight: width * .22,
                            floating: false,
                            pinned: false,
                            backgroundColor: Colors.white,
                            flexibleSpace: FlexibleSpaceBar(
                              centerTitle: true,
                              collapseMode: CollapseMode.none,
                              background: Center(
                                  child: TextFormFieldBorder(
                                hintText: 'Looking for something ?',
                                suffix: Icon(LineIcons.search),
                                onSubmitted: (String value) {
                                  print('Look for : ' + value);
                                },
                                globControl: search,
                                globKey: searchGlob,
                                isSecure: false,
                              )),
                            ),
                          ),
                        ];
                      },
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Container(child: Text('list item here'))],
                      ),
                    )),
              ),
            ));
  }
}
