import 'package:citav2/core/shared/app.dart';
import 'package:citav2/views/lobby/lobby_root.dart';
import 'package:citav2/views/onboard/splash.dart';
import 'package:citav2/views/onboard/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as tx;
import 'package:citav2/bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await App.init();
  runApp(MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        initialRoute: '/',
        getPages: [
          GetPage(
              name: '/', page: () => Splash(), transition: tx.Transition.zoom),
          GetPage(
              name: '/welcome',
              page: () => Welcome(),
              transition: tx.Transition.zoom),
          GetPage(
              name: '/lobby',
              page: () => LobbyRoot(),
              transition: tx.Transition.zoom)
        ],
      ),
    );
  }
}
