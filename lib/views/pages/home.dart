import 'package:cached_network_image/cached_network_image.dart';
import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/bloc/login/login_bloc.dart';
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
                                    margin: EdgeInsets.only(
                                        left: 12.0, right: 12.0),
                                    child: GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: 12,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://media.suara.com/pictures/970x544/2020/03/05/64264-strategi-mengurangi-jumlah-pakaian-di-rumah.jpg',
                                                fit: BoxFit.cover,
                                                height: width * 0.5,
                                                width: width,
                                              ),
                                            ),
                                            _text('Nama Item', fontSize: 12),
                                            _text(
                                              'Harga',
                                            ),
                                          ],
                                        );
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
            ));
  }
}

Widget _text(String text,
    {var fontSize = 12.0,
    textColor = Colors.black,
    var isCentered = false,
    var maxLine = 1,
    var lineThrough = false,
    var latterSpacing = 0.25,
    var textAllCaps = false,
    var isLongText = false}) {
  return Text(textAllCaps ? text.toUpperCase() : text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      style: TextStyle(
          decoration:
              lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
          color: textColor,
          height: 1.5,
          letterSpacing: latterSpacing));
}
