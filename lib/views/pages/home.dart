import 'package:cached_network_image/cached_network_image.dart';
import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/bloc/chooser/chooser_bloc.dart';
import 'package:citav2/bloc/data/issue_data/issue_data_bloc.dart';
import 'package:citav2/bloc/data/repo_data/repo_data_bloc.dart';
import 'package:citav2/bloc/data/user_data/data_bloc.dart';
import 'package:citav2/bloc/paging/paging_bloc.dart';
import 'package:citav2/bloc/radio/radio_bloc.dart';
import 'package:citav2/core/responsive.dart';
import 'package:citav2/core/services/extension.dart';
import 'package:citav2/widgets/button/chooser_button.dart';
import 'package:citav2/widgets/button/default_icon.dart';
import 'package:citav2/widgets/button/paging_button.dart';
import 'package:citav2/widgets/circle_random.dart';
import 'package:citav2/widgets/custom_icon.dart';
import 'package:citav2/widgets/eye_icon.dart';
import 'package:citav2/widgets/item_shimmer.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:citav2/widgets/text/text_field.dart';
import 'package:flutter/cupertino.dart';
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
  RepoDataBloc repoBloc;
  IssueDataBloc issueBloc;
  PagingBloc pageEvent;
  RadioBloc radioBloc;
  double maxScroll;
  double currentScroll;
  int page = 1;

  @override
  void initState() {
    super.initState();
    dataBloc = BlocProvider.of<DataBloc>(context);
    repoBloc = BlocProvider.of<RepoDataBloc>(context);
    radioBloc = BlocProvider.of<RadioBloc>(context);
    issueBloc = BlocProvider.of<IssueDataBloc>(context);

    pageEvent = BlocProvider.of<PagingBloc>(context);
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

    if (choose.state.index == 0)
      contr.addListener(() {
        maxScroll = contr.position.maxScrollExtent;
        currentScroll = contr.position.pixels;
        if (currentScroll == maxScroll) {
          print('current Scroll : ' + currentScroll.toString());
          print('maxScroll' + maxScroll.toString());
          if (radioBloc.state.index == 0)
            repoBloc.add(MoreRepo(keywords: search.text));
          if (radioBloc.state.index == 1)
            issueBloc.add(MoreDataIssue(keywords: search.text));
          if (radioBloc.state.index == 2)
            dataBloc.add(MoreData(keywords: search.text));
        }
      });
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) => BlocBuilder<RadioBloc, RadioState>(
        builder: (context, searchState) => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                            searchState.index == 0
                                ? repoBloc.add(FetchRepo(keywords: value))
                                : searchState.index == 1
                                    ? issueBloc
                                        .add(FetchDataIssue(keywords: value))
                                    : dataBloc.add(FetchData(keywords: value));
                          },
                          globControl: search,
                          globKey: searchGlob,
                          isSecure: false,
                        )),
                      ),
                    ),
                  ];
                },
                body: BlocBuilder<ChooserBloc, ChooserState>(
                  builder: (context, chooserState) => Column(
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
                          ChooserButton(
                            title: 'Lazy Loading',
                            isSelected: chooserState.index == 0,
                            func: () {
                              if (chooserState.index == 1) choose.add(Lazy());

                              // test = !test;
                              // test ? theme.add(ToBlack()) : theme.add(ToWhite());
                            },
                          ),
                          ChooserButton(
                            title: 'Index',
                            isSelected: chooserState.index == 1,
                            func: () {
                              if (chooserState.index == 0) choose.add(Index());
                              // test = !test;
                              // test ? theme.add(ToBlack()) : theme.add(ToWhite());
                            },
                          ),
                        ],
                      ),
                      Expanded(
                          child: chooserState.index == 0
                              ? buildList(searchState.index)
                              : buildListIndex(searchState.index))
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  buildListIndex(int type) {
    switch (type) {
      case 0:
        return BlocBuilder<RepoDataBloc, RepoDataState>(
            builder: (context, state) {
          if (state is RepoDataUnintialized) {
            return Center(child: Container(child: Text('LookGit')));
          }
          if (state is RepoDataClear) {
            return Text('Cari sesuatu load index');
          }
          if (state is RepoDataError) {
            return Text(state.message);
          }
          if (state is RepoDataLoaded) {
            return Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: WaterfallFlow.builder(
                    itemCount: 10,
                    gridDelegate:
                        SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, idx) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                                  title: inCaps(state
                                                      .repo.item[idx].name)),
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
                                    Container(
                                      constraints:
                                          BoxConstraints(maxHeight: 50),
                                      child: text10(
                                          title: state
                                                  .repo.item[idx].description ??
                                              ''),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        state.repo.item[idx].language != null
                                            ? CircleRandom(
                                                index: idx % 5,
                                              )
                                            : Container(),
                                        SizedBox(width: 5),
                                        text10(
                                            title:
                                                state.repo.item[idx].language ??
                                                    ''),
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
                                              state.repo.item[idx].seenCount ??
                                                  0)),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              pagingIndex(0)
            ]);
          }
          return Center(
            child: Container(child: Text('Data Kosong')),
          );
        });

        break;
      case 1:
        return BlocBuilder<IssueDataBloc, IssueDataState>(
            builder: (context, state) {
          if (state is IssueDataUnintialized) {
            return Center(child: Container(child: Text('LookGit')));
          }
          if (state is IssueDataClear) {
            return Text('Cari sesuatu load index');
          }
          if (state is IssueDataError) {
            return Text(state.message);
          }
          if (state is IssueLoaded) {
            return Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: WaterfallFlow.builder(
                    itemCount: 10,
                    gridDelegate:
                        SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, idx) {
                      return Card(
                        elevation: 7,
                        margin: EdgeInsets.symmetric(horizontal: 15),
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
                                    imageUrl:
                                        state.issue.items[idx].user.avatar),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    text16Bold(
                                        title: inCaps(
                                            state.issue.items[idx].title)),
                                    Container(
                                        constraints:
                                            BoxConstraints(maxHeight: 50),
                                        child: text10Overflow(
                                            title:
                                                state.issue.items[idx].body)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              pagingIndex(1)
            ]);
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
            return Text('Cari sesuatu load index');
          }
          if (state is DataError) {
            return Text(state.message);
          }
          if (state is DataLoaded) {
            return Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: WaterfallFlow.builder(
                    itemCount: 10,
                    gridDelegate:
                        SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, idx) {
                      return Card(
                        elevation: 7,
                        margin: EdgeInsets.symmetric(horizontal: 15),
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
                                        title: inCaps(
                                            state.user.items[idx].login)),
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
                    }),
              ),
              pagingIndex(2)
            ]);
          }
          return Center(
            child: Container(child: Text('Data Kosong')),
          );
        });

        break;
    }
  }

  pagingIndex(int chooserIndex) {
    switch (chooserIndex) {
      case 0:
        return BlocBuilder<PagingBloc, PagingState>(
          builder: (context, pageState) => Container(
            margin: EdgeInsets.only(bottom: 15),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PagingButton(
                  icon: LineIcons.arrowLeft,
                  func: () {
                    pageEvent.add(Back());
                    repoBloc.add(FetchRepo(
                        keywords: search.text, page: pageState.index));
                  },
                ),
                text16Bold(title: '${pageState.index}'),
                PagingButton(
                  icon: LineIcons.arrowRight,
                  func: () {
                    pageEvent.add(Next());
                    repoBloc.add(FetchRepo(
                        keywords: search.text, page: pageState.index));
                  },
                ),
              ],
            ),
          ),
        );
        break;
      case 1:
        return BlocBuilder<PagingBloc, PagingState>(
          builder: (context, pageState) => Container(
            margin: EdgeInsets.only(bottom: 15),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PagingButton(
                  icon: LineIcons.arrowLeft,
                  func: () {
                    pageEvent.add(Back());
                    issueBloc.add(FetchDataIssue(
                        keywords: search.text, page: pageState.index));
                  },
                ),
                text16Bold(title: '${pageState.index}'),
                PagingButton(
                  icon: LineIcons.arrowRight,
                  func: () {
                    pageEvent.add(Next());
                    issueBloc.add(FetchDataIssue(
                        keywords: search.text, page: pageState.index));
                  },
                ),
              ],
            ),
          ),
        );
        break;
      case 2:
        return BlocBuilder<PagingBloc, PagingState>(
          builder: (context, pageState) => Container(
            margin: EdgeInsets.only(bottom: 15),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PagingButton(
                  icon: LineIcons.arrowLeft,
                  func: () {
                    pageEvent.add(Back());
                    dataBloc.add(FetchData(
                        keywords: search.text, page: pageState.index));
                  },
                ),
                text16Bold(title: '${pageState.index}'),
                PagingButton(
                  icon: LineIcons.arrowRight,
                  func: () {
                    pageEvent.add(Next());
                    dataBloc.add(FetchData(
                        keywords: search.text, page: pageState.index));
                  },
                ),
              ],
            ),
          ),
        );
        break;
      default:
    }
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
                                  Container(
                                    constraints: BoxConstraints(maxHeight: 50),
                                    child: text10(
                                        title:
                                            state.repo.item[idx].description ??
                                                ''),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      state.repo.item[idx].language != null
                                          ? CircleRandom(
                                              index: idx % 5,
                                            )
                                          : Container(),
                                      SizedBox(width: 5),
                                      text10(
                                          title:
                                              state.repo.item[idx].language ??
                                                  ''),
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
                                            state.repo.item[idx].seenCount ??
                                                0)),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  }
                  return LoadItem();
                });
          }
          return Center(
            child: Container(child: Text('Data Kosong')),
          );
        });
        break;
      case 1:
        return BlocBuilder<IssueDataBloc, IssueDataState>(
            builder: (context, state) {
          if (state is IssueDataUnintialized) {
            return Center(child: Container(child: Text('LookGit')));
          }
          if (state is IssueDataClear) {
            return Text('Cari sesuatu');
          }
          if (state is IssueDataError) {
            return Text(state.message);
          } else if (state is IssueLoaded) {
            return WaterfallFlow.builder(
                itemCount: state.hasReachedMax
                    ? state.issue.items.length
                    : state.issue.items.length + 1,
                gridDelegate:
                    SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, idx) {
                  if (idx < state.issue.items.length) {
                    return Card(
                      elevation: 7,
                      margin: EdgeInsets.symmetric(horizontal: 15),
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
                                  imageUrl: state.issue.items[idx].user.avatar),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text16Bold(
                                      title:
                                          inCaps(state.issue.items[idx].title)),
                                  Container(
                                      constraints:
                                          BoxConstraints(maxHeight: 50),
                                      child: text10Overflow(
                                          title: state.issue.items[idx].body)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return LoadItem();
                });
          }
          return LoadItem();
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
                      margin: EdgeInsets.symmetric(horizontal: 15),
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
                  } else {
                    return LoadItem();
                  }
                });
          }
          return LoadItem();
        });

        break;
    }
  }
}
