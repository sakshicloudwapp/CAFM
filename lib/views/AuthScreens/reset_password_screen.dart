import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/global_theme_button.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/utils/list.dart';
import 'package:fm_pro/views/AuthScreens/forgot_password_screen.dart';
import 'package:fm_pro/widgets/custom_texts.dart';

import 'password_changed_successfull_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  /// Textfield Controller ..........

  TextEditingController enterPasswordController = TextEditingController();
  TextEditingController enterRePasswordController = TextEditingController();

  /// FocusNode.............
  FocusNode enterPassFocusNode = FocusNode();
  FocusNode reEnterPassFocusNode = FocusNode();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getdevicetocken();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    enterPassFocusNode.unfocus();
    reEnterPassFocusNode.unfocus();
  }



  ///  Clear textfield..............
  cleartextfield(){
    enterPasswordController.clear();
    enterRePasswordController.clear();
  }

  /// Objects...................
  bool is_password = true;
  bool is_reEnterPass = true;

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: WillPopScope(
          onWillPop: (){
            exit(0);
          },
          child: Scaffold(
            backgroundColor: context.isDarkMode ? myColors.app_theme : myColors.white,

            body: Container(
              height: mediaQuerryData.size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ///TOP.................
                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10,top: 60),
                          height: mediaQuerryData.size.height / 2.6,
                          //  width: mediaQuerryData.size.width,
                          child: Image.asset("assets/images/resetPass_bg_img.png",height: 340,width: mediaQuerryData.size.width,fit: BoxFit.fill,),
                        ),

                        ///Bottom................
                        Container(
                          margin: EdgeInsets.only(top: mediaQuerryData.size.height / 2.2),
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                          width: mediaQuerryData.size.width,
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),

                              Container(
                                  child: CustomText.CustomBoldText(
                                      MyString.reset_pass,
                                      context.isDarkMode
                                          ? myColors.white
                                          : myColors.black,
                                      FontWeight.w700,
                                      23,
                                      1,
                                      TextAlign.center)),

                              Container(
                                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: Text(
                                  "Reset your password by entering new password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? myColors.white
                                        : myColors.black,
                                    fontSize: 12,
                                    fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),

                              //Email Textfield............................................................................................

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(23, 25, 0, 0),
                                    child: Text("Enter Password",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"
                                      ),),
                                  ),
                                  Container(
                                    height: 48,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    decoration: BoxDecoration(
                                      border:
                                      Border.all(color: myColors.border_txtfield),
                                      borderRadius: BorderRadius.circular(10),
                                      // color: myColors.bg_txtfield,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            obscureText: is_password,
                                            controller: enterPasswordController,
                                            focusNode: enterPassFocusNode,
                                            keyboardType: TextInputType.emailAddress,
                                            onChanged: (String value) {
                                              print("TAG" + value);
                                              setState(() {});
                                            },
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily:
                                              'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                                              color: myColors.black,
                                            ),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "*******",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: myColors.hintTxt,
                                                    fontFamily:
                                                    "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                                                counter: Offstage(),
                                                isDense: true,
                                                // this will remove the default content padding
                                                contentPadding:
                                                EdgeInsets.fromLTRB(16, 8, 8, 0)),
                                            maxLines: 1,
                                            cursorColor: myColors.black,
                                          ),
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: (){
                                            is_password = !is_password;
                                            setState((){});
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            padding: EdgeInsets.all(3),
                                            child: is_password == true ? Image.asset("assets/images/img_blackLock.png"):
                                            Icon(Icons.lock_open,color: myColors.black,) ,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              //Password Textfield............................................................................................
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(23, 20, 0, 0),
                                    child: Text("Re-Enter Password",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"
                                      ),),
                                  ),
                                  Container(
                                    height: 48,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    decoration: BoxDecoration(
                                      border:
                                      Border.all(color: myColors.border_txtfield),
                                      borderRadius: BorderRadius.circular(10),
                                      //color: myColors.bg_txtfield,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            obscureText: is_reEnterPass,
                                            controller: enterRePasswordController,
                                            focusNode: reEnterPassFocusNode,
                                            keyboardType: TextInputType.visiblePassword,
                                            onChanged: (String value) {
                                              print("TAG" + value);
                                              setState(() {});
                                            },
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily:
                                              'assets/fonts/Poppins/Poppins-Regular.ttf',
                                              color: myColors.black,
                                            ),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "*******",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: myColors.hintTxt,
                                                    fontFamily:
                                                    "assets/fonts/Poppins/Poppins-Regular.ttf"),
                                                counter: Offstage(),
                                                isDense: true,
                                                // this will remove the default content padding
                                                contentPadding:
                                                EdgeInsets.fromLTRB(16, 8, 8, 0)),
                                            maxLines: 1,
                                            cursorColor: myColors.black,
                                          ),
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: (){
                                            is_reEnterPass = !is_reEnterPass;
                                            setState((){});
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            padding: EdgeInsets.all(3),
                                            child: is_reEnterPass == true ? Image.asset("assets/images/img_blackLock.png"):
                                            Icon(Icons.lock_open,color: myColors.black,) ,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              //Login Button..................................................................................................
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation, anotherAnimation) {
                                        return PasswordChangedSuccessfullScreen();
                                      },
                                      /*
                                            (context, animation, anotherAnimation) {
                                            return PasswordChangedSuccessfullScreen();
                                          },
                                           */
                                      transitionDuration:
                                      Duration(milliseconds: 1000),
                                      transitionsBuilder: (context, animation,
                                          anotherAnimation, child) {
                                        animation = CurvedAnimation(
                                            curve: curveList[4], parent: animation);
                                        return SlideTransition(
                                          position: Tween(
                                              begin: Offset(1.0, 0.0),
                                              end: Offset(0.0, 0.0))
                                              .animate(animation),
                                          child: child,
                                        );
                                      }));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: GlobalThemeButton(
                                    buttonName: MyString.reset,
                                    buttonColor: context.isDarkMode
                                        ? myColors.orange
                                        : myColors.app_theme,
                                  ),
                                ),
                              ),

                              //Forgot account.....................................
                            /*  InkWell(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation, anotherAnimation) {
                                        return ForgotPasswordScreen();
                                      },
                                      transitionDuration:
                                      Duration(milliseconds: 1000),
                                      transitionsBuilder: (context, animation,
                                          anotherAnimation, child) {
                                        animation = CurvedAnimation(
                                            curve: curveList[4], parent: animation);
                                        return SlideTransition(
                                          position: Tween(
                                              begin: Offset(1.0, 0.0),
                                              end: Offset(0.0, 0.0))
                                              .animate(animation),
                                          child: child,
                                        );
                                      }));
                                },
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    child: CustomText.CustomRegularText(
                                        MyString.Forgot_Your_Account,
                                        context.isDarkMode
                                            ? myColors.white
                                            : myColors.black,
                                        FontWeight.w400,
                                        12,
                                        1,
                                        TextAlign.center)),
                              ),
*/
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

}
