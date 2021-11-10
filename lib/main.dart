import 'package:citav2/bloc/fetch_item/fetchitem_bloc.dart';
import 'package:citav2/bloc/login/login_bloc.dart';
import 'package:citav2/core/shared/app.dart';
import 'package:citav2/views/lobby/lobby_root.dart';
import 'package:citav2/views/onboard/splash.dart';
import 'package:citav2/views/onboard/login.dart';
import 'package:citav2/views/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as tx;
import 'package:citav2/bloc/bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  await App.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(ThemeState(
              materialColor:
                  HydratedBloc.storage.read('materialColor') ?? Colors.black,
              textColor: HydratedBloc.storage.read('textColor') ?? Colors.white,
              themeType: HydratedBloc.storage.read('themeType') ?? 'dark')),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<FetchItemBloc>(
          create: (BuildContext context) => FetchItemBloc(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        initialRoute: '/',
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme(textTheme)),
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
              transition: tx.Transition.zoom),
          GetPage(
              name: '/setting',
              page: () => Settings(),
              transition: tx.Transition.rightToLeftWithFade)
        ],
      ),
    );
  }
}
