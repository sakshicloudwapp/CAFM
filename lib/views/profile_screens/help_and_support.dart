import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/global_theme_button.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/widgets/customNavigator.dart';

import '../../global/my_string.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: data,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor:
              context.isDarkMode ? myColors.app_theme : myColors.app_theme,
              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            automaticallyImplyLeading: false,
            backgroundColor: myColors.app_theme,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: myColors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              MyString.help_support,
              style: TextStyle(color: myColors.white, fontSize: 18),
            ),
          ),
        ),
        body: bodyWidget(),
        bottomSheet: BottomAppBar(
          // height: 150,
            child: Container(
              height: 150,
              padding: EdgeInsets.only(left: 30,right: 30,bottom: 70),
              child: GestureDetector(
                onTap: (){
                  CustomNavigator.popNavigate(context);
                },
                child: GlobalThemeButton2(buttonName: MyString.Message_Noknok, buttonColor:myColors.app_theme,),
              ),
            )
        ),
      ),

    );
  }

  /// Widget Body ui////........
  bodyWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),

          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                MyString.help_and_support,
                style: TextStyle(
                    color: myColors.black,
                    fontSize: 24,
                    fontFamily: MyString.PlusJakartaSansSemibold),
              )),

          SizedBox(
            height: 10,
          ),

          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                MyString.you_can_help,
                style: TextStyle(
                    color: myColors.black,
                    fontSize: 12,
                    height: 1.5,
                    fontFamily: MyString.PlusJakartaSansregular),
              )),


          /// Divider..........................
          Container(
            margin: EdgeInsets.only(top: 40),
            height: 0.9,
            color: myColors.grey_38,
          ),


          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              MyString.contact,
              style: TextStyle(
                  color: myColors.black,
                  fontSize: 12,
                  height: 1.5,
                  fontFamily: MyString.PlusJakartaSansSemibold),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child:   Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: SvgPicture.asset("assets/icons/ic_phone.svg"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Text(
                      "+91 40 4012 1010",
                      style: TextStyle(
                          color:myColors.app_theme,
                          fontSize: 12,
                          fontFamily: MyString.PlusJakartaSansregular),
                    ),
                  ),
                ]
            ),
          ),


          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child:   Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: SvgPicture.asset("assets/icons/ic_email.svg"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Text(
                      "hello@rynasolutions.com",
                      style: TextStyle(
                          color:myColors.app_theme,
                          fontSize: 12,
                          fontFamily: MyString.PlusJakartaSansregular),
                    ),
                  ),
                ]
            ),
          ),


          // rowiconwithname(
          //     "assets/images/water.png", "Water", "png", "emergency", "992"),



        ],
      ),
    );
  }

  headingtext(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
            color: myColors.black, fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  rowiconwithname(
      String icon, String titlename, String tag, String status, String data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          tag == "svg"
              ? SvgPicture.asset(icon)
              : Image.asset(
            icon,
            height: 17,
            width: 17,
          ),
          SizedBox(
            width: 15,
          ),
          status != "emergency"
              ? Expanded(
              flex: 1,
              child: Text(
                titlename,
                style: TextStyle(
                    color: myColors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ))
              : Container(
              width: 130,
              child: Text(
                titlename,
                style: TextStyle(
                    color: myColors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              )),
          status == "emergency"
              ? Expanded(
              flex: 1,
              child: Text(
                data,
                style: TextStyle(
                    color: myColors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ))
              : Container(),
        ],
      ),
    );
  }
}
