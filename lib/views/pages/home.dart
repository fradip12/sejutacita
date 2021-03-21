import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/core/responsive.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:citav2/widgets/text/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  final GlobalKey<FormFieldState> searchGlob = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final width = getWidth(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: normalText(title: 'LookGit'),
              backgroundColor: state.textColor,
            ),
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: width * .25,
                      floating: false,
                      pinned: false,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        collapseMode: CollapseMode.none,
                      
                        background: Center(
                            child: TextFormFieldBorder(
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
                      Container(
                        height: width * .15,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              color: Colors.black,
                            )),
                            Expanded(
                                child: Container(
                              color: Colors.pink,
                            )),
                            Expanded(
                                child: Container(
                              color: Colors.orange,
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
