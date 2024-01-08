import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/AuthScreens/Signup_screen.dart';
import 'package:fm_pro/views/AuthScreens/password_changed_successfull_screen.dart';
import 'package:fm_pro/views/AuthScreens/reset_password_screen.dart';
import 'package:fm_pro/views/AuthScreens/signin_screen.dart';

import '../../global/global_theme_button.dart';
import '../../global/my_string.dart';
import '../../utils/list.dart';
import '../../widgets/custom_texts.dart';
import 'authentication_successfull_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor:
          context.isDarkMode ? myColors.app_theme : myColors.white,

          appBar:  PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: context.isDarkMode ? myColors.black_statusbar : myColors.black_statusbar,
                // Status bar brightness (optional)
                statusBarIconBrightness: context.isDarkMode ? Brightness.light :Brightness.light,
                // For Android (dark icons)
                statusBarBrightness: context.isDarkMode ? Brightness.light : Brightness.light, // For iOS (dark icons)
              ),
              automaticallyImplyLeading: false,
              backgroundColor: myColors.white,
              elevation: 0,

            ),
          ),
          body: SafeArea(
            child: Container(
              height: mediaQuerryData.size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                          height: mediaQuerryData.size.height / 2.6,
                          //  width: mediaQuerryData.size.width,
                          child: Image.asset("assets/images/forgot_bg_img.png",height: 340,width: mediaQuerryData.size.width,fit: BoxFit.fill,),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: mediaQuerryData.size.height / 2.3),
                          padding: EdgeInsets.fromLTRB(20,20,20,16),
                          width: mediaQuerryData.size.width,
                          decoration: BoxDecoration(
                              /*image: DecorationImage(
                                  image: AssetImage(context.isDarkMode
                                      ? "assets/images/forgot_bottom_dark.png"
                                      : "assets/images/forgot_bottom_light.png"),
                                  fit: BoxFit.fill)*/
                            color: Colors.white
                              ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: CustomText.CustomBoldText(MyString.FORGOT_PASSWORD, context.isDarkMode
                                      ? myColors.white
                                      : myColors.black,
                                      FontWeight.w700, 24, 1,TextAlign.center)
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(60, 10, 60, 0),
                                child: Text(
                                  "Provide your email, we will send you verification link",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? myColors.white
                                        : myColors.black,
                                    fontSize: 12,
                                    fontFamily:
                                    MyString.PlusJakartaSansregular,
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
                                    child: Text("Enter Email",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: MyString.PlusJakartaSansregular,
                                      ),),
                                  ),
                                  Container(
                                    height: 48,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: myColors.border_txtfield),
                                      borderRadius: BorderRadius.circular(10),
                                    //  color: myColors.bg_txtfield,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            keyboardType: TextInputType.emailAddress,
                                            onChanged: (String value) {
                                              print("TAG" + value);
                                              setState(() {});
                                            },
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily:
                                              MyString.PlusJakartaSansregular,
                                              color: myColors.black,
                                            ),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: MyString.Enter_Your_mail,
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: myColors.hintTxt,
                                                    fontFamily:
                                                    MyString.PlusJakartaSansregular,),
                                                counter: Offstage(),
                                                isDense: true,
                                                // this will remove the default content padding
                                                contentPadding: EdgeInsets.fromLTRB(16, 8, 8, 0)
                                            ),
                                            maxLines: 1,
                                            cursorColor: myColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              //NEXT Button..................................................................................................
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  /*InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      padding:EdgeInsets.all(16),
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:context.isDarkMode ?myColors.orange :myColors.app_theme,
                                      ),
                                      child: Image.asset("assets/images/img_arrow_left_white.png"),
                                    ),
                                  ),*/

                                  Expanded(flex: 1,child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(PageRouteBuilder(
                                          pageBuilder:
                                              (context, animation, anotherAnimation) {
                                            return ResetPasswordScreen();
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
                                      margin: EdgeInsets.only(left: 10,top: 20),
                                      child: GlobalThemeButton(
                                        buttonName: MyString.Submit,
                                        buttonColor: context.isDarkMode ?myColors.orange :myColors.app_theme,
                                      ),
                                    ),
                                  ),)
                                ],
                              ),

                              ///----- Signup----------

                            /*  InkWell(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation, anotherAnimation) {
                                        return ForgotPasswordScreen();
                                      },
                                      transitionDuration: Duration(milliseconds: 1000),
                                      transitionsBuilder:
                                          (context, animation, anotherAnimation, child) {
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
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                  child: Text(
                                    MyString.Forgot_Your_Account,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? myColors.white
                                          : myColors.black,
                                      fontSize: 12,
                                      fontFamily: "assets/fonts/KoHo-Light.ttf",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),*/

                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 40),
                                  child: RichText(text:
                                  TextSpan(
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: 'Don’t have an account?',
                                          style: TextStyle(
                                              fontFamily: MyString.PlusJakartaSansregular,
                                              fontSize: 14,
                                              color: Colors.black
                                          )),

                                      TextSpan( text: '  Sign up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyString.PlusJakartaSansBold,
                                              color: myColors.orange,
                                              fontSize: 14
                                          ),
                                          recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SigninScreen()));
                                        },
                                      ),
                                    ],
                                  ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(20),
                                height: 3,
                                width: MediaQuery.of(context).size.width / 2.6,
                                decoration: BoxDecoration(
                                  color: myColors.orange
                                ),
                              )

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
