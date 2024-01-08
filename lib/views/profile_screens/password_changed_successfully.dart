import 'package:flutter/material.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/views/dashboard_screen_main.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../widgets/customNavigator.dart';



class PasswordChangedSuccessfully extends StatefulWidget {
  const PasswordChangedSuccessfully({Key? key}) : super(key: key);

  @override
  State<PasswordChangedSuccessfully> createState() => _PasswordChangedSuccessfullyScreenState();
}

class _PasswordChangedSuccessfullyScreenState extends State<PasswordChangedSuccessfully> {
  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Container(
               width: double.infinity,
               height: mediaQuerryData.size.height*0.55,

               child:  Image.asset("assets/images/change_pass_bg_img.png",fit: BoxFit.cover,),
             ),

              SizedBox(height: 25,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Text("Password successfully changed.",textAlign: TextAlign.center,style: TextStyle(color: myColors.grey_33,fontSize: 24,fontWeight: FontWeight.w600),),
              ),

              SizedBox(height: 50,),

              GestureDetector(
                onTap: (){
                  // PersistentNavBarNavigator.p(
                  //   context,
                  //   screen: DashboardScreenMain(),
                  //   withNavBar: false, // OPTIONAL VALUE. True by default.
                  //   pageTransitionAnimation: PageTransitionAnimation.fade,
                  // );
                  CustomNavigator.custompushAndRemoveUntil(context, DashboardScreenMain());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: myColors.app_theme,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(child: Text("Done",style: TextStyle(color: myColors.white,fontSize: 14,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w600),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
