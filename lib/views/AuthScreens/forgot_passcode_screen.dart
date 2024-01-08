import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/AuthScreens/password_changed_successfull_screen.dart';
import '../../global/global_theme_button.dart';
import '../../global/my_string.dart';
import '../../utils/list.dart';
import '../../widgets/custom_texts.dart';


class ForgotPasscodeScreen extends StatefulWidget {

  const ForgotPasscodeScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasscodeScreenState createState() => _ForgotPasscodeScreenState();
}

class _ForgotPasscodeScreenState extends State<ForgotPasscodeScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor:
          context.isDarkMode ? myColors.white : myColors.white,

          appBar:  PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: context.isDarkMode ? myColors.darker_blue : myColors.darker_blue,
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
              child: Stack(
                children: [
                  Container(
                    height: mediaQuerryData.size.height / 1.4,
                    width: mediaQuerryData.size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/passcode_bg_top.png"),
                            fit: BoxFit.fill)),),
                  Container(
                    margin: EdgeInsets.only(
                        top: mediaQuerryData.size.height / 2.4),
                    padding: EdgeInsets.fromLTRB(20,120,20,16),
                    height: mediaQuerryData.size.height,
                    width: mediaQuerryData.size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(context.isDarkMode
                                ? "assets/images/sign_in_bg_bottom_dark.png"
                                : "assets/images/sign_in_bg_bottom.png"),
                            fit: BoxFit.fill)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              child: CustomText.CustomBoldText(MyString.FORGOT_PASSCODE, context.isDarkMode
                                  ? myColors.white
                                  : myColors.black,
                                  FontWeight.w700, 23, 1,TextAlign.center)
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor”",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? myColors.white
                                    : myColors.black,
                                fontSize: 12,
                                fontFamily:
                                MyString.PlusJakartaSanslight,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          //Email Textfield............................................................................................
                          Container(
                            height: 48,
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            decoration: BoxDecoration(
                              border: Border.all(color: myColors.border_txtfield),
                              borderRadius: BorderRadius.circular(10),
                              color: myColors.bg_txtfield,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 32,
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: myColors.orange,
                                  ),
                                  child: Image.asset("assets/images/img_email.png",),
                                ),
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
                                            color: myColors.txt_txtfield,
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

                          //Submit Button..................................................................................................
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, anotherAnimation) {
                                    return PasswordChangedSuccessfullScreen();
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
                              margin: EdgeInsets.only(top: 40),
                              child: GlobalThemeButton(
                                buttonName: MyString.SUBMIT,
                                buttonColor: context.isDarkMode ?myColors.orange :myColors.app_theme,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
