import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/views/dashboard_screen_main.dart';

class SucessWorkOrderScreen extends StatefulWidget {
  const SucessWorkOrderScreen({Key? key}) : super(key: key);

  @override
  State<SucessWorkOrderScreen> createState() => _SucessWorkOrderScreenState();
}

class _SucessWorkOrderScreenState extends State<SucessWorkOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigate();
  }

  /// Navigate other Screen.............
  _navigate(){
        Timer(
          Duration(seconds: 2),
              () => Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => DashboardScreenMain()),ModalRoute.withName('/'))
      );
    }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
      //   key: _scaffoldkey ,
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            backgroundColor: myColors.white,
           body: Container(
             height: MediaQuery.of(context).size.height,
             alignment: Alignment.center,
             child: SingleChildScrollView(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset("assets/new_images/Animation - 1698647247841 1.gif",),
                   Text("SUCCESS",
                   style: TextStyle(
                     fontSize: 16,
                     fontFamily: MyString.PlusJakartaSansBold,
                     fontWeight: FontWeight.w700,
                     color: myColors.green_3
                   ),),
                   Text("Show success message",
                     style: TextStyle(
                         fontSize: 16,
                         fontFamily: MyString.PlusJakartaSansregular,
                         fontWeight: FontWeight.w400,
                         color: myColors.grey_new
                     ),)
                 ],
               ),
             ),
           ),
        )
    );
  }
}
