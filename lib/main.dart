import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/views/AuthScreens/splash_screen.dart';
import 'package:fm_pro/views/dashboard_screen_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

String init_screen = "0";
bool is_login  =  false;
SharedPreferences? pre;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Only call clearSavedSettings() during testing to reset internal values.
  await Upgrader.clearSavedSettings(); // REMOVE this for release builds
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor mycolor = MaterialColor(0xff574B97, <int, Color>{
    50: Color(0xff574B97),
    100: Color(0xff574B97),
    200: Color(0xff574B97),
    300: Color(0xff574B97),
    400: Color(0xff574B97),
    500: Color(0xff574B97),
    600: Color(0xff574B97),
    700: Color(0xff574B97),
    800: Color(0xff574B97),
    900: Color(0xff574B97),
  },
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey:navigatorKey,
        title: 'Rise Pro',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
    );
  }
}



///