import 'package:citav2/widgets/text/text.dart';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  var titleName;
  var icon;
  var isVisible = false;
  var isVisibleIcon = true;

  TopBar(var this.titleName, {var this.icon, var this.isVisible});

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(color: Colors.red, height: 70),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width * 0.15,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    widget.isVisible
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: text(
                                  title: widget.titleName,
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                            child: text(
                              title: widget.titleName,
                            ),
                          ),
                    widget.isVisible
                        ? GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 8,
                              ),
                            ))
                        : GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 8,
                                right: 8,
                              ),
                            ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.05),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.red),
              ),
            ],
          )
        ],
      ),
    );
  }
}
