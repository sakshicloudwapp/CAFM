import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/AuthScreens/authentication_successfull_screen.dart';
import 'package:fm_pro/views/AuthScreens/forgot_passcode_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../global/global_theme_button.dart';
import '../../global/my_string.dart';
import '../../services/webservices.dart';
import '../../utils/list.dart';
import '../../widgets/custom_texts.dart';
import 'forgot_password_screen.dart';

class EnterPasscodeScreen extends StatefulWidget {
  const EnterPasscodeScreen({Key? key}) : super(key: key);

  @override
  _EnterPasscodeScreenState createState() => _EnterPasscodeScreenState();
}

class _EnterPasscodeScreenState extends State<EnterPasscodeScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  deviceIdApi()async{
    await Webservices.RequestDeviceId(context);
  }

  _checkValidation(){
    if(textEditingController.text.trim().isEmpty || textEditingController.text.isEmpty ||  textEditingController.text.length  != 4){
      print("hhfd");
    }else{
      deviceIdApi();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: context.isDarkMode ? myColors.app_theme : myColors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: context.isDarkMode
                    ? myColors.darker_blue
                    : myColors.darker_blue,
                // Status bar brightness (optional)
                statusBarIconBrightness:
                    context.isDarkMode ? Brightness.light : Brightness.light,
                // For Android (dark icons)
                statusBarBrightness: context.isDarkMode
                    ? Brightness.light
                    : Brightness.light, // For iOS (dark icons)
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
                          height: mediaQuerryData.size.height / 1.4,
                          width: mediaQuerryData.size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/passcode_bg_top.png"),
                                  fit: BoxFit.fill)),
                        ),

                        Container(
                          margin:
                              EdgeInsets.only(top: mediaQuerryData.size.height / 2.4),
                          padding: EdgeInsets.fromLTRB(20, 120, 20, 16),
                          width: mediaQuerryData.size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(context.isDarkMode
                                      ? "assets/images/sign_in_bg_bottom_dark.png"
                                      : "assets/images/sign_in_bg_bottom.png"),
                                  fit: BoxFit.fill)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: CustomText.CustomBoldText(
                                      MyString.ENTER_PASSCODE,
                                      context.isDarkMode
                                          ? myColors.white
                                          : myColors.black,
                                      FontWeight.w700,
                                      23,
                                      1,
                                      TextAlign.center)),
                              Container(
                                padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
                                child: CustomText.CustomRegularText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor”",
                                    context.isDarkMode
                                        ? myColors.white
                                        : myColors.black, FontWeight.w400, 12, 2, TextAlign.center)
                              ),

                              //OTP View...........................................................................................
                              Container(
                                width: 250,
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Form(
                                  key: formKey,
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: PinCodeTextField(
                                        appContext: context,
                                        pastedTextStyle: TextStyle(
                                          color: myColors.bg_txtfield,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: MyString.PlusJakartaSansBold,
                                        ),
                                        length: 4,
                                        obscureText: false,
                                        obscuringCharacter: '*',
                                        blinkWhenObscuring: true,
                                        animationType: AnimationType.fade,
                                        validator: (v) {},
                                        pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          borderRadius: BorderRadius.circular(5),
                                          borderWidth: 1,
                                          fieldHeight: 39,
                                          fieldWidth: 41,
                                          activeFillColor: myColors.bg_txtfield,
                                          inactiveColor: myColors.bg_txtfield,
                                          inactiveFillColor: myColors.bg_txtfield,
                                          activeColor: myColors.bg_txtfield,
                                          errorBorderColor: myColors.color_red,
                                          disabledColor: myColors.bg_txtfield,
                                          selectedColor: myColors.bg_txtfield,
                                          selectedFillColor: myColors.bg_txtfield,
                                        ),
                                        cursorColor: Colors.black,
                                        animationDuration:
                                        const Duration(milliseconds: 300),
                                        enableActiveFill: true,
                                        errorAnimationController: errorController,
                                        controller: textEditingController,
                                        keyboardType: TextInputType.number,
                                         boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 0),
                                color: myColors.border_txtfield,
                                 blurRadius: 1.5,
                              )
                            ],
                                        onCompleted: (v) {
                                          debugPrint("Completed");
                                        },
                                        onChanged: (value) {
                                          debugPrint(value);
                                          setState(() {
                                            currentText = value;
                                          });
                                        },
                                        beforeTextPaste: (text) {
                                          debugPrint("Allowing to paste $text");
                                          return true;
                                        },
                                      )),
                                ),
                              ),

                              //Forgot passcode...............................................
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation, anotherAnimation) {
                                        return ForgotPasscodeScreen();
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
                                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                    child: CustomText.CustomRegularText(
                                        MyString.Forgot_Passcode,
                                       myColors.orange,
                                        FontWeight.w400,
                                        12,
                                        1,
                                        TextAlign.center)),
                              ),

                              //SUBMIT Button..................................................................................................
                              InkWell(
                                onTap: () {
                                  _checkValidation();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: GlobalThemeButton(
                                    buttonName: MyString.SUBMIT,
                                    buttonColor: context.isDarkMode
                                        ? myColors.orange
                                        : myColors.app_theme,
                                  ),
                                ),
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
