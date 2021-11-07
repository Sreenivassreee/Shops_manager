import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shops_manager/pdf/page/pdf_page.dart';


import 'export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'arial',
          primarySwatch: Colors.red,
          cardColor: Colors.white,
          scaffoldBackgroundColor: Colors.indigo[50],
          // cardColor: Colors.grey[850],
//        cardColor: Color(0xFF171332),
          primaryColor: Colors.black,
          accentColor: Colors.red,
          // canvasColor: Colors.grey[50],
          applyElevationOverlayColor: true,
          disabledColor: Colors.grey,
          dividerColor: Colors.white,
          cursorColor: Colors.indigo[50],
          canvasColor: Colors.red,
          // bottomAppBarColor: Colors.indigo[50],
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.transparent,
          ),
          appBarTheme: AppBarTheme(
            color: Colors.indigo[50],
            centerTitle: false,
          )

          // appBarTheme: AppBarTheme(
          //   color: Colors.red,

          //   elevation: 0.0,
          // accentColor: Colors.yellow,
          // primaryColor: Colors.red,
          // scaffoldBackgroundColor: Colors.yellow[200],
          // buttonColor: Colors.amber,
          // dialogBackgroundColor: Colors.yellow,
          // ),
          ),
      home: LoginPage()
    );
  }

  MaterialColor bl = const MaterialColor(
    0xFFE8EAF6,
    const <int, Color>{
      50: const Color(0xFFE8EAF6),
      100: const Color(0xFFE8EAF6),
      200: const Color(0xFFE8EAF6),
      300: const Color(0xFFE8EAF6),
      400: const Color(0xFFE8EAF6),
      500: const Color(0xFFE8EAF6),
      600: const Color(0xFFE8EAF6),
      700: const Color(0xFFE8EAF6),
      800: const Color(0xFFE8EAF6),
      900: const Color(0xFFE8EAF6),
    },
  );
}
