import 'package:cached_network_image/cached_network_image.dart';
import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/bloc/chooser/chooser_bloc.dart';
import 'package:citav2/bloc/data/repo_data/repo_data_bloc.dart';
import 'package:citav2/bloc/data/user_data/data_bloc.dart';
import 'package:citav2/bloc/radio/radio_bloc.dart';
import 'package:citav2/core/responsive.dart';
import 'package:citav2/core/services/extension.dart';
import 'package:citav2/widgets/button/chooser_button.dart';
import 'package:citav2/widgets/button/default_button.dart';
import 'package:citav2/widgets/button/default_icon.dart';
import 'package:citav2/widgets/circle_random.dart';
import 'package:citav2/widgets/eye_icon.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:citav2/widgets/text/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';
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
  RepoDataBloc repoBloc;
  RadioBloc radioBloc;
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
    repoBloc = BlocProvider.of<RepoDataBloc>(context);
    radioBloc = BlocProvider.of<RadioBloc>(context);

    contr.addListener(() {
      maxScroll = contr.position.maxScrollExtent - 10;
      currentScroll = contr.position.pixels;
      if (currentScroll > maxScroll) {
        print('current Scroll : ' + currentScroll.toString());
        print('maxScroll' + maxScroll.toString());
        dataBloc.add(MoreData(keywords: search.text));
        repoBloc.add(MoreRepo(keywords: search.text));
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

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) => BlocBuilder<RadioBloc, RadioState>(
        builder: (context, searchState) => GestureDetector(
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
                          repoBloc.add(FetchRepo(keywords: value));
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
                      defaultSelected: searchState.index,
                      orientation: RGOrientation.HORIZONTAL,
                      onChanged: (index) {
                        if (index == 0) return radioBloc.add(RepoEvent());
                        if (index == 1) return radioBloc.add(IssueEvent());
                        if (index == 2) return radioBloc.add(UserEvent());
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
                    ],
                  ),
                  Expanded(child: buildList(searchState.index))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildList(int type) {
    switch (type) {
      case 0:
        return BlocBuilder<RepoDataBloc, RepoDataState>(
            builder: (context, state) {
          if (state is RepoDataUnintialized) {
            return Center(child: Container(child: Text('LookGit')));
          }
          if (state is RepoDataClear) {
            return Text('Cari sesuatu');
          }
          if (state is RepoDataError) {
            return Text(state.message);
          }
          if (state is RepoDataLoaded) {
            return WaterfallFlow.builder(
                itemCount: state.hasReachedMax
                    ? state.repo.item.length
                    : state.repo.item.length + 1,
                gridDelegate:
                    SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, idx) {
                  if (idx < state.repo.item.length) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      elevation: 7,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        margin: EdgeInsets.symmetric(vertical: 25),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CachedNetworkImage(
                                            height: 25,
                                            width: 25,
                                            fit: BoxFit.fill,
                                            imageUrl: state
                                                .repo.item[idx].owner.avatar),
                                      ),
                                      SizedBox(width: 15),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            text16Bold(
                                                title: inCaps(
                                                    state.repo.item[idx].name)),
                                            text10(
                                                title: state.repo.item[idx]
                                                    .owner.login),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  text10(
                                      title: state.repo.item[idx].description ?? ''),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      CircleRandom(),
                                      SizedBox(width: 5),
                                      text10(
                                          title: state.repo.item[idx].language),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    EyeIcon(
                                      size: 15,
                                    ),
                                    text10(
                                        title: kPoint(
                                            state.repo.item[idx].seenCount ?? 0)),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  }
                  if (state.repo.totalCount == state.repo.item.length) {
                    return Container();
                  } else {
                    return Center(
                      child: Container(child: CircularProgressIndicator()),
                    );
                  }
                });
          }
          return Center(
            child: Container(child: Text('Data Kosong')),
          );
        });
        break;
      case 2:
        return BlocBuilder<DataBloc, DataState>(builder: (context, state) {
          if (state is DataUnintialized) {
            return Center(child: Container(child: Text('LookGit')));
          }
          if (state is DataClear) {
            return Text('Cari sesuatu');
          }
          if (state is DataError) {
            return Text(state.message);
          } else if (state is DataLoaded) {
            return WaterfallFlow.builder(
                itemCount: state.hasReachedMax
                    ? state.user.items.length
                    : state.user.items.length + 1,
                gridDelegate:
                    SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, idx) {
                  if (idx < state.user.items.length) {
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
                                  imageUrl: state.user.items[idx].avatar),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text16Bold(
                                      title:
                                          inCaps(state.user.items[idx].login)),
                                  text10(title: state.user.items[idx].type),
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
                  if (state.user.total == state.user.items.length) {
                    return Container();
                  } else {
                    return Center(
                      child: Container(child: CircularProgressIndicator()),
                    );
                  }
                });
          }
          return Center(
            child: Container(child: CircularProgressIndicator()),
          );
        });

        break;
    }
  }
}
