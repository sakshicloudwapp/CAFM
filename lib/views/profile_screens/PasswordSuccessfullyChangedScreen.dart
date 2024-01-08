
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/global_theme_button.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:get/get.dart';


class PasswordSuccesChangedScreen extends StatefulWidget {
  const PasswordSuccesChangedScreen({super.key});

  @override
  State<PasswordSuccesChangedScreen> createState() =>
      _PasswordSuccesChangedScreenState();
}

class _PasswordSuccesChangedScreenState
    extends State<PasswordSuccesChangedScreen> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MediaQuery(
        data: data.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor:myColors.medium_blue,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: myColors.white,
                  //ios
                  statusBarBrightness: Brightness.light,
                  // android
                  statusBarIconBrightness: Brightness.dark),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: myColors.medium_blue,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: myColors.blue4),
                    child: SvgPicture.asset("assets/icons/ic_lock.svg"),
                  ),
                ),

                hsized100,
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                   MyString.Password_successfully_changed,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: myColors.black,
                        fontSize: 24,
                        fontFamily: MyString.PlusJakartaSansBold),
                  ),
                )
              ],
            ),
          ),

          bottomSheet: BottomAppBar(
              //height: 150,
              child: Container(
                height: 150,
                padding: EdgeInsets.only(left: 30,right: 30,bottom: 70),
                child: GestureDetector(
                  onTap: (){
                    CustomNavigator.popNavigate(context);
                   // CustomNavigator.pushreplacementNavigate(context, PasswordSuccesChangedScreen());
                    //CustomNavigator.popNavigate(context);
                  },
                  child: GlobalThemeButton2(buttonName: 'Done'.tr, buttonColor: myColors.app_theme,),
                ),
              )
          ),
        ));
  }
}
