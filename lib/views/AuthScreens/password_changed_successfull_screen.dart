import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/AuthScreens/signin_screen.dart';

import '../../widgets/custom_texts.dart';

class PasswordChangedSuccessfullScreen extends StatefulWidget {
  const PasswordChangedSuccessfullScreen({Key? key}) : super(key: key);

  @override
  State<PasswordChangedSuccessfullScreen> createState() => _PasswordChangedSuccessfullScreenState();
}

class _PasswordChangedSuccessfullScreenState extends State<PasswordChangedSuccessfullScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SigninScreen()))
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
                SvgPicture.asset("assets/images/check_circle.svg",color:
                context.isDarkMode? myColors.white:myColors.app_theme,),
                Container(
                  margin: EdgeInsets.only(top:10),
                    child: CustomText.CustomBoldText(MyString.Your_password_changed_Successfully
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
