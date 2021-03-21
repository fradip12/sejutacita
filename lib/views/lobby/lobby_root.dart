import 'package:citav2/views/pages/aboutme.dart';
import 'package:citav2/views/pages/account.dart';
import 'package:citav2/views/pages/home.dart';
import 'package:citav2/views/pages/settings.dart';
import 'package:flutter/material.dart';

class LobbyRoot extends StatefulWidget {
  @override
  _LobbyRootState createState() => _LobbyRootState();
}

class _LobbyRootState extends State<LobbyRoot> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> page = [Home(), Account(), AboutMe(), Settings()];
  @override
  Widget build(BuildContext context) {
    return page[0];
  }
}
