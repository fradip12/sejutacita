import 'package:citav2/views/onboard/splash.dart';
import 'package:citav2/views/onboard/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Splash(), transition: Transition.zoom),
        GetPage(
            name: '/welcome',
            page: () => Welcome(),
            transition: Transition.zoom)
      ],
    );
  }
}
