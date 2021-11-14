import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops_manager/pdf/page/pdf_page.dart';
import 'package:shops_manager/shop/Screens/flash_screen.dart';
import 'package:shops_manager/shop/Screens/test.dart';
import 'package:shops_manager/shop/shared-pref/shop-shared-pref.dart';
import 'package:shops_manager/widgets/global/sale_product_sucess.dart';
import 'package:shops_manager/widgets/global/toast.dart';

import 'export.dart';
import 'globalcode/date.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isLogin;
  var isLoading = true;
  var shopName;
  var managerName;
  var date;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // logout();
    date = getDate();
    print("[Init]");
    loginCheck();
    super.initState();
  }

  loginCheck() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    setState(() {
      isLogin = p.getBool('is-login');
    });
    shopName = p.getString('shop-name');
    print("[shopName]" + shopName.toString());
    managerName = p.getString('manager-name');
    print("[managerName]" + managerName.toString());
    if (shopName != null && managerName != null) {
      try {
        await users
            .doc(shopName)
            .collection(managerName)
            .doc(managerName)
            .collection('logins')
            .doc(date)
            .get()
            .then(
          (DocumentSnapshot documentSnapshot) async {
            if (documentSnapshot.exists) {
              var temp = documentSnapshot;
              var todayLogin=temp['_isLogin'];
              if (todayLogin==null || todayLogin==false) {
                print("[_isLogin]");
                setState(() {
                  isLogin = false;
                });
              } else if(todayLogin){
                await users.doc(shopName).get().then((v) {
                  if (v['_is_active']==true) {
                    print("['_is_active]");
                    setState(() {
                      isLogin = true;
                      isLoading = false;
                    });
                  }else{
                    show(context, "You are in blocking list");
                    print("[You are in blocking list]");
                    setState(() {
                      isLogin=false;
                    });
                  }
                });
              }
            }else{
              setState(() {
                isLogin=false;
              });
            }
          },
        );
      } catch (e) {
        setState(() {
          isLogin = false;
        });
        print(e);
      }
    } else {
      setState(() {
        isLogin = false;
      });
    }

    if (isLogin != null) {
      setState(() {
        isLoading = false;
      });
    } else {}
    print("[isLogin]" + isLogin.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        if (isLoading &&
            (snapshot.connectionState == ConnectionState.waiting)) {
          return MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
        } else {
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
              home: (isLogin != true || isLogin == null)
                  ? LoginPage()
                  : Homepage());
        }
      },
    );
  }
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

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Image.asset('assets/image.png'),
        ),
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();
  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
