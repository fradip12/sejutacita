import 'package:cached_network_image/cached_network_image.dart';
import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/bloc/fetch_item/fetchitem_bloc.dart';
import 'package:citav2/bloc/login/login_bloc.dart';
import 'package:citav2/core/models/item/item_model.dart';
import 'package:citav2/core/responsive.dart';
import 'package:citav2/core/services/api.dart';
import 'package:citav2/widgets/button/default_icon.dart';
import 'package:citav2/widgets/custom_icon.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:citav2/widgets/text/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';

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
  FetchItemBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<FetchItemBloc>(context);
    print(homeBloc.state);
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
        builder: (context, themeState) =>
            BlocBuilder<FetchItemBloc, FetchitemState>(
                builder: (context, homeState) {
              homeBloc.add(FetchDataHome());
              List<ItemResult> data = [];

              if (homeState is FetchitemLoaded) {
                data = homeState.data;
                return builderHome(
                  context: context,
                  data: data,
                  isLoad: false,
                  themeState: themeState,
                  width: width,
                );
              } else {
                return builderHome(
                  context: context,
                  data: data,
                  isLoad: true,
                  themeState: themeState,
                  width: width,
                );
              }
            }));
  }

  builderHome(
      {BuildContext context,
      ThemeState themeState,
      double width,
      List<ItemResult> data,
      bool isLoad}) {
    return GestureDetector(
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
              title: text(title: 'Inspira Dev Test'),
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
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12.0, right: 12.0),
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: isLoad ? 10 : data.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (isLoad == true) {
                                  return SizedBox(
                                    width: 200.0,
                                    height: 100.0,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.black,
                                      highlightColor: Colors.white,
                                      child: Text(
                                        'Loading',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        child: CachedNetworkImage(
                                          imageUrl: data[index].image,
                                          fit: BoxFit.cover,
                                          height: width * 0.5,
                                          width: width,
                                        ),
                                      ),
                                      _text(data[index].title ?? 'Nama Item',
                                          fontSize: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _text(
                                            '\$ ${data[index].price.toDouble()}',
                                          ),
                                          Row(
                                            children: [
                                              _text(
                                                'Rating : ',
                                              ),
                                              _text(
                                                '${data[index].rating.rate}',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

Widget _text(String text,
    {var fontSize = 12.0,
    textColor = Colors.black,
    var latterSpacing = 0.25,
    var textAllCaps = false}) {
  return Text(textAllCaps ? text.toUpperCase() : text,
      maxLines: 1,
      style: TextStyle(
          color: textColor, height: 1.5, letterSpacing: latterSpacing));
}
