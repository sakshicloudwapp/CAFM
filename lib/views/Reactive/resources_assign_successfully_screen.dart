import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../global/my_string.dart';
import '../dashboard_screen_main.dart';

class ResourcesAssignSuccessfullyScreen extends StatefulWidget {

  const ResourcesAssignSuccessfullyScreen({Key? key}) : super(key: key);

  @override
  _ResourcesAssignSuccessfullyScreenState createState() => _ResourcesAssignSuccessfullyScreenState();
}

class _ResourcesAssignSuccessfullyScreenState extends State<ResourcesAssignSuccessfullyScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
            () =>   PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: DashboardScreenMain(),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        )
      /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreenMain()))*/
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
                  child: Text(MyString.Resource_Assigned_Successfully,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: myColors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: MyString.PlusJakartaSansBold,
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
