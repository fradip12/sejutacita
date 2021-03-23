import 'package:cached_network_image/cached_network_image.dart';
import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/bloc/chooser/chooser_bloc.dart';
import 'package:citav2/bloc/data/data_bloc.dart';
import 'package:citav2/core/responsive.dart';
import 'package:citav2/core/services/api.dart';
import 'package:citav2/core/services/extension.dart';
import 'package:citav2/views/onboard/welcome.dart';
import 'package:citav2/widgets/appbar/search_floating.dart';
import 'package:citav2/widgets/button/chooser_button.dart';
import 'package:citav2/widgets/button/default_button.dart';
import 'package:citav2/widgets/button/default_icon.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:citav2/widgets/text/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';
import 'package:get/route_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

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
  DataBloc dataBloc;
  // void onScroll() {
  //   double maxScroll = contr.position.maxScrollExtent;
  //   double currentScroll = contr.position.pixels;

  //   if (currentScroll == maxScroll) return data.add(DataEvent());
  // }
  double maxScroll;
  double currentScroll;
  @override
  void initState() {
    super.initState();
    dataBloc = BlocProvider.of<DataBloc>(context);

    contr.addListener(() {
      maxScroll = contr.position.maxScrollExtent - 10;
      currentScroll = contr.position.pixels;
      if (currentScroll > maxScroll) {
        print('current Scroll : ' + currentScroll.toString());
        print('maxScroll' + maxScroll.toString());
        dataBloc.add(MoreData(keywords:search.text));
      }
    });
  }

  @override
  void dispose() {
    contr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = getWidth(context);
    ChooserBloc choose = BlocProvider.of(context)..add(Lazy());
    var _listHorizontal = ["Repositories", "Issue", "Users"];
    var _indexHorizontal = 0;

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
                              dataBloc.add(FetchData(keywords: value));
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
                    children: [
                      FlutterRadioGroup(
                          titles: _listHorizontal,
                          labelVisible: true,
                          activeColor: Colors.black,
                          titleStyle: TextStyle(fontSize: 14),
                          defaultSelected: _indexHorizontal,
                          orientation: RGOrientation.HORIZONTAL,
                          onChanged: (index) {
                            setState(() {
                              _indexHorizontal = index;
                            });
                          }),
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
                              // Get.to(Welcome());
                              // data.add(DataEvent());
                              // Git.fetchUser('fradip', 1, 10)
                              //     .then((value) => print(value.items.length));
                            },
                          )
                        ],
                      ),
                      Expanded(
                        child: buildList(),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget buildList() {
    return BlocBuilder<DataBloc, DataState>(builder: (context, state) {
      if (state is DataUnintialized) {
        return Center(child: Container(child: Text('LookGit')));
      } else {
        DataLoaded userLoaded = state as DataLoaded;
        return WaterfallFlow.builder(
            itemCount: userLoaded.hasReachedMax
                ? userLoaded.user.items.length
                : userLoaded.user.items.length + 1,
            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, crossAxisSpacing: 12, mainAxisSpacing: 12),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, idx) {
              if (state is DataLoaded) {
                if (idx < userLoaded.user.items.length) {
                  return Card(
                    elevation: 7,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.symmetric(vertical: 25),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CachedNetworkImage(
                                height: 25,
                                width: 25,
                                fit: BoxFit.fill,
                                imageUrl: userLoaded.user.items[idx].avatar),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text16Bold(
                                    title: inCaps(
                                        userLoaded.user.items[idx].login)),
                                text10(title: userLoaded.user.items[idx].type),
                              ],
                            ),
                          ),
                          Card(
                              elevation: 7,
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: text10(title: 'Follow'))),
                        ],
                      ),
                    ),
                  );
                }
                if (userLoaded.user.total == userLoaded.user.items.length) {
                  return Container();
                } else {
                  return Center(
                    child: Container(child: CircularProgressIndicator()),
                  );
                }
              }
              if (state is DataError) {
                return Text(state.message);
              }
              return Center(
                child: Container(child: CircularProgressIndicator()),
              );
            });
      }
    });
  }
}
