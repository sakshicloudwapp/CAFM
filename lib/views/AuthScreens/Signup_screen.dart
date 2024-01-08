import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/views/AuthScreens/signin_screen.dart';
import 'package:fm_pro/views/AuthScreens/send_to_mail_successfully.dart';

import '../../global/global_theme_button.dart';
import '../../global/my_string.dart';
import '../../utils/list.dart';
import 'authentication_successfull_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String countrycode = "+91";
  var numberController = new TextEditingController();

  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuerryData,
      child: Scaffold(
        backgroundColor: myColors.app_bg,
        body: SafeArea(
          child: Container(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/bg_top.png"),
                            fit: BoxFit.fill)),
                    child: Column(
                      children: [
                        //Header...................................................................................................
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 60,
                                width: 50,
                                child: SvgPicture.asset(
                                  "assets/images/back_white.svg",
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  MyString.sign_up,
                                  style: TextStyle(
                                      color: myColors.white,
                                      fontSize: 20,
                                      fontFamily: "assets/fonts/KoHo-Bold.ttf",
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              flex: 1,
                            ),
                            Container(
                              height: 60,
                              width: 50,
                            ),
                          ],
                        ),

                        //Welcome Text.............................................................................................
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  MyString.New_user,
                                  style: TextStyle(
                                      color: myColors.white,
                                      fontSize: 20,
                                      fontFamily: "assets/fonts/KoHo-Bold.ttf",
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  MyString.Create_your_account,
                                  style: TextStyle(
                                      color: myColors.yellow,
                                      fontSize: 14,
                                      fontFamily:
                                      "assets/fonts/KoHo-Regular.ttf",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Main Screen...............................................................................................
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                MyString.Sign_up,
                                style: TextStyle(
                                    color: myColors.orange,
                                    fontSize: 16,
                                    fontFamily: "assets/fonts/KoHo-Bold.ttf",
                                    fontWeight: FontWeight.w700),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                MyString.New_user_register_here,
                                style: TextStyle(
                                    color: myColors.black,
                                    fontSize: 14,
                                    fontFamily:
                                    "assets/fonts/KoHo-Regular.ttf",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),

                            //First Name..............................................................................................................
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.First_name,
                                  style: TextStyle(
                                      fontFamily:
                                      "assets/fonts/DM_Sans/DMSans-Regular.ttf",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: myColors.black),
                                ),
                              ),
                            ),
                            //First Name Textfield............................................................................................
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: myColors.bg_txtfield,
                              ),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                onChanged: (String value) {
                                  print("TAG" + value);
                                  setState(() {});
                                },
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily:
                                  'assets/fonts/DM_Sans/DMSans-Regular.ttf',
                                  color: myColors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: MyString.admin,
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: myColors.txt_txtfield,
                                      fontFamily:
                                      "assets/fonts/DM_Sans/DMSans-Regular.ttf"),
                                  counter: Offstage(),
                                  isDense: true,
                                  // this will remove the default content padding
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                ),
                                maxLines: 1,
                                cursorColor: myColors.black,
                              ),
                            ),

                            //Last Name..............................................................................................................
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.Last_name,
                                  style: TextStyle(
                                      fontFamily:
                                      "assets/fonts/DM_Sans/DMSans-Regular.ttf",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: myColors.black),
                                ),
                              ),
                            ),
                            //Last Name Textfield............................................................................................
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: myColors.bg_txtfield,
                              ),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                onChanged: (String value) {
                                  print("TAG" + value);
                                  setState(() {});
                                },
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily:
                                  'assets/fonts/DM_Sans/DMSans-Regular.ttf',
                                  color: myColors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: MyString.admin,
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: myColors.txt_txtfield,
                                      fontFamily:
                                      "assets/fonts/DM_Sans/DMSans-Regular.ttf"),
                                  counter: Offstage(),
                                  isDense: true,
                                  // this will remove the default content padding
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                ),
                                maxLines: 1,
                                cursorColor: myColors.black,
                              ),
                            ),

                            //Email..............................................................................................................
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.Email,
                                  style: TextStyle(
                                      fontFamily:
                                      "assets/fonts/DM_Sans/DMSans-Regular.ttf",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: myColors.black),
                                ),
                              ),
                            ),
                            //Email Textfield............................................................................................
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: myColors.bg_txtfield,
                              ),
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
                                  'assets/fonts/DM_Sans/DMSans-Regular.ttf',
                                  color: myColors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: MyString.mail_companyname_com,
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: myColors.txt_txtfield,
                                      fontFamily:
                                      "assets/fonts/DM_Sans/DMSans-Regular.ttf"),
                                  counter: Offstage(),
                                  isDense: true,
                                  // this will remove the default content padding
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                ),
                                maxLines: 1,
                                cursorColor: myColors.black,
                              ),
                            ),

                            //Mobile number ..............................................................................................................
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.Mobile_number,
                                  style: TextStyle(
                                      fontFamily:
                                      "assets/fonts/DM_Sans/DMSans-Regular.ttf",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: myColors.black),
                                ),
                              ),
                            ),

                            //Mobile number Textfield...........................................................................................
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: myColors.bg_txtfield,
                              ),
                              child: Row(
                                children: [
                                  CountryCodePicker(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    onChanged: (e) {
                                      countrycode = e.dialCode.toString();
                                      print("country code >>>" + countrycode);
                                    },
                                    initialSelection: 'IN',
                                    favorite: ['+965', 'KU'],
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: false,
                                    alignLeft: false,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      controller: numberController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily:
                                        'assets/fonts/DM_Sans/DMSans-Regular.ttf',
                                        color: myColors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: MyString.Mobile_number,
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: myColors.txt_txtfield,
                                            fontFamily:
                                            "assets/fonts/DM_Sans/DMSans-Regular.ttf"),
                                        counter: Offstage(),
                                        isDense: true,
                                        // this will remove the default content padding
                                        contentPadding:
                                        EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      ),
                                      maxLines: 1,
                                      cursorColor: myColors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //Password..................................................................................................
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.Password,
                                  style: TextStyle(
                                      fontFamily:
                                      "assets/fonts/DM_Sans/DMSans-Regular.ttf",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: myColors.black),
                                ),
                              ),
                            ),
                            //Password Textfield............................................................................................
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: myColors.bg_txtfield,
                              ),
                              child: TextField(
                                keyboardType: TextInputType.visiblePassword,
                                onChanged: (String value) {
                                  print("TAG" + value);
                                  setState(() {});
                                },
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily:
                                  'assets/fonts/DM_Sans/DMSans-Regular.ttf',
                                  color: myColors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "********",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: myColors.txt_txtfield,
                                      fontFamily:
                                      "assets/fonts/DM_Sans/DMSans-Regular.ttf"),
                                  counter: Offstage(),
                                  isDense: true,
                                  // this will remove the default content padding
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                ),
                                maxLines: 1,
                                cursorColor: myColors.black,
                              ),
                            ),

                            //Signup Button..................................................................................................
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        anotherAnimation) {
                                      return SendToMailSuccessfully();
                                    },
                                    transitionDuration:
                                    Duration(milliseconds: 1000),
                                    transitionsBuilder: (context, animation,
                                        anotherAnimation, child) {
                                      animation = CurvedAnimation(
                                          curve: curveList[4],
                                          parent: animation);
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
                                margin: EdgeInsets.only(top: 20),
                                child: GlobalThemeButton(
                                  buttonName: MyString.sign_up,
                                  buttonColor: myColors.app_theme,
                                ),
                              ),
                            ),

                            //Already have an account.................................................................................................
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        anotherAnimation) {
                                      return SigninScreen();
                                    },
                                    transitionDuration:
                                    Duration(milliseconds: 1000),
                                    transitionsBuilder: (context, animation,
                                        anotherAnimation, child) {
                                      animation = CurvedAnimation(
                                          curve: curveList[4],
                                          parent: animation);
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
                                margin: EdgeInsets.fromLTRB(0, 40, 0, 16),
                                alignment: Alignment.center,
                                child: RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily:
                                      'assets/fonts/DM_Sans/DMSans-Regular.ttf',
                                      color: myColors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: MyString.Already_have_an_account),
                                      TextSpan(
                                          text: MyString.Sign_In,
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: myColors.orange)),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                height: 3,
                                width: 123,
                                decoration: BoxDecoration(
                                  color: myColors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
