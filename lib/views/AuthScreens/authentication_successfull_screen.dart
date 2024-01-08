import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/dashboard_screen_main.dart';
import '../../widgets/custom_texts.dart';

class AuthenticationSuccessfullScreen extends StatefulWidget {
  const AuthenticationSuccessfullScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationSuccessfullScreenState createState() =>
      _AuthenticationSuccessfullScreenState();
}

class _AuthenticationSuccessfullScreenState
    extends State<AuthenticationSuccessfullScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashboardScreenMain()))
    );
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuerryData,
      child: Scaffold(

        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: context.isDarkMode ? myColors.app_theme : myColors.white,
              // Status bar brightness (optional)
              statusBarIconBrightness: context.isDarkMode ? Brightness.dark :Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: context.isDarkMode ? Brightness.light : Brightness.light, // For iOS (dark icons)
            ),
            automaticallyImplyLeading: false,
            backgroundColor: myColors.white,
            elevation: 0,

          ),
        ),
        body: Container(
          height: mediaQuerryData.size.height,
          width: mediaQuerryData.size.width,
          decoration: BoxDecoration(
            color: context.isDarkMode? myColors.app_theme : myColors.white,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/check_circle.svg" ,color:
                context.isDarkMode? myColors.white:myColors.app_theme,),
                Container(
                  margin: EdgeInsets.only(top:10),
                  child: CustomText.CustomBoldText(MyString.Your_device_authenticated_Successfully
                      , context.isDarkMode? myColors.white : myColors.app_theme  , FontWeight.w700, 14, 2, TextAlign.center)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
