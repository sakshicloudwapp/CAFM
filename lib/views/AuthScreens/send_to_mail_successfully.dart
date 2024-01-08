import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';

import '../../global/my_string.dart';
import '../dashboard_screen_main.dart';

class SendToMailSuccessfully extends StatefulWidget {
  const SendToMailSuccessfully({Key? key}) : super(key: key);

  @override
  State<SendToMailSuccessfully> createState() => _SendToMailSuccessfullyState();
}

class _SendToMailSuccessfullyState extends State<SendToMailSuccessfully> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
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
        body: Container(
          height: mediaQuerryData.size.height,
          width: mediaQuerryData.size.width,
          decoration: BoxDecoration(
            color: myColors.app_theme,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/check_circle.svg"),
                Container(
                  margin: EdgeInsets.only(top:10),
                  child: Text(MyString.Your_login_details_sent_to_mail_Successfully,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: myColors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: "assets/fonts/DM_Sans/DMSans-Bold.ttf",
                      fontSize: 14,
                    ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
