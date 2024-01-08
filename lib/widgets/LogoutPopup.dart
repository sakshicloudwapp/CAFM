import 'package:flutter/material.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/global_theme_button.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:get/get.dart';

import '../global/sizedbox.dart';
import 'customNavigator.dart';




class LogoutPopupScreen extends StatefulWidget {
  LogoutPopupScreen({super.key,});

  @override
  State<LogoutPopupScreen> createState() => _LogoutPopupScreenState();
}

class _LogoutPopupScreenState extends State<LogoutPopupScreen> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor:Colors.transparent,

        bottomNavigationBar: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: myColors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              margin: EdgeInsets.only(bottom: 0,left: 25,right: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //     hsized20,
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            CustomNavigator.popNavigate(context);
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey,
                            size: 20,
                          )),
                    ),

                    hsized10,

                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        MyString.Are_you_sure_logout,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: myColors.black,
                            fontFamily: MyString.PlusJakartaSansSemibold,
                            fontSize: 15),
                      ),
                    ),


                    hsized50,
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                //CustomNavigator.popNavigate(context);
                logoutapi();
              },
              child: Container(
                  height: 80,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: GlobalThemeButton2(
                      buttonName: "Yes".tr,
                      buttonColor:  myColors.app_theme)),
            ),
          ],
        ),
      ),
    );
  }

  logoutapi() async{
    await Webservices.RequestLogout(context);
    setState(() {});
  }

}