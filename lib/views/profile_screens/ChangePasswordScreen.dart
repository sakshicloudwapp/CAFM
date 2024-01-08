
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/global_theme_button.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/views/profile_screens/PasswordSuccessfullyChangedScreen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  /// Controllers
  TextEditingController newpassController = TextEditingController();
  TextEditingController con_newpassController = TextEditingController();
  TextEditingController passController = TextEditingController();

  /// FocusNode...
  final newpassFocus = FocusNode();
  final con_newpassFocus = FocusNode();
  final passFocus = FocusNode();

  bool is_password = false;

  bool is_remember = false;

  bool is_old_pass = false;
  String oldpass_error_str = "";

  bool is_re_pass = false;
  String re_pass_error_str = "";

  bool is_new_pass = false;
  String new_pass_error_str = "";

  unfocusTextfield() {
    newpassFocus.unfocus();
    con_newpassFocus.unfocus();
    passFocus.unfocus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    unfocusTextfield();
  }

  checkValidation(){
    if(passController.text.trim().isEmpty){
      is_old_pass = true;
      oldpass_error_str = "Please enter old password";
      setState(() {});
    }else if(newpassController.text.trim().isEmpty){
      is_new_pass = true;
      is_old_pass = false;
      new_pass_error_str = "Please enter new password";
      setState(() {});
    } else if(newpassController.text.trim().isEmpty){
      is_re_pass = true;
      is_new_pass = false;
      is_old_pass = false;
      re_pass_error_str = "Please enter Retype new password";
      setState(() {});
    }
    else if(newpassController.text.trim() !=  con_newpassController.text.trim()){
      is_re_pass = true;
      is_new_pass = false;
      is_old_pass = false;
      re_pass_error_str = "Oops! New password must match.";
      setState(() {});
    }else{
      CustomNavigator.pushreplacementNavigate(context, PasswordSuccesChangedScreen());
    }
  }

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
              backgroundColor: myColors.white,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: myColors.white,
                  //ios
                  statusBarBrightness: Brightness.light,
                  // android
                  statusBarIconBrightness: Brightness.dark),
              leading: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconButton(
                  onPressed: () {
                    CustomNavigator.popNavigate(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: myColors.arrow_Color,
                    size: 30,
                  ),
                ),
              ),
              actions: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.clear,
                        color: myColors.arrow_Color,
                        size: 30,
                      )),
                )
              ],
            ),
          ),
          body: GestureDetector(
            onTap: (){
              unfocusTextfield();
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Change Password.........................................
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Text(
                        MyString.change_password,
                        style: TextStyle(
                            color: myColors.black,
                            fontSize: 24,
                            fontFamily: MyString.PlusJakartaSansSemibold),
                      ),
                    ),

                    /// Divider..........................
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      height: 0.9,
                      color: myColors.grey_38,
                    ),

                    hsized20,

                    textfield(passController,passFocus,TextInputType.text,TextInputAction.next,"Type current password"),
                    /// Old password error message....................................
                    is_old_pass == true
                        ? Container(
                      padding:
                      EdgeInsets.only(left: 25, right: 2, top: 8),
                      child: Text(
                        oldpass_error_str,
                        style: TextStyle(
                            color: myColors.medium_red,
                            fontSize: 12,
                            fontFamily: MyString.PlusJakartaSansSemibold),
                      ),
                    )
                        : Container(),

                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 0.9,
                      color: myColors.grey_38,
                    ),
                    hsized15,

                    textfield(newpassController,newpassFocus,TextInputType.text,TextInputAction.next,"Type new password"),
                    /// New password error message....................................
                    is_new_pass == true
                        ? Container(
                      padding:
                      EdgeInsets.only(left: 25, right: 2, top: 8),
                      child: Text(
                        new_pass_error_str,
                        style: TextStyle(
                            color: myColors.medium_red,
                            fontSize: 12,
                            fontFamily: MyString.PlusJakartaSansSemibold),
                      ),
                    )
                        : Container(),

                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 0.9,
                      color: myColors.grey_38,
                    ),
                    hsized20,
                    textfield(con_newpassController,con_newpassFocus,TextInputType.text,TextInputAction.next,"Retype new password"),

                    /// Retype New password error message....................................
                    is_re_pass == true
                        ? Container(
                      padding:
                      EdgeInsets.only(left: 25, right: 2, top: 8),
                      child: Text(
                        re_pass_error_str,
                        style: TextStyle(
                            color: myColors.medium_red,
                            fontSize: 12,
                            fontFamily: MyString.PlusJakartaSansSemibold),
                      ),
                    )
                        : Container(),


                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 0.9,
                      color: myColors.grey_38,
                    ),
                  ],
                ),
              ),
            ),
          ),

          bottomSheet: BottomAppBar(
         //   height: 120,
            child: Container(
              height: 120,
              padding: EdgeInsets.only(left: 25,right: 25,bottom: 40),
              child: GestureDetector(
                onTap: (){
                  checkValidation();
                },
                child: GlobalThemeButton2(buttonName: 'Save'.tr, buttonColor: myColors.app_theme,),
              ),
            )
          ),
        ));
  }
  textfield( TextEditingController controller,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction,
      String hinttext,){
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 35,
      alignment: Alignment.topCenter,
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        obscureText: true,
        focusNode: focusNode,
        keyboardType: textInputType,
        style: TextStyle(
            color: myColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: MyString.PlusJakartaSansSemibold),
        textInputAction: textInputAction,
        decoration: InputDecoration(
            filled: true,
            fillColor: myColors.white,
            border: InputBorder.none,
            enabledBorder:InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hinttext,
            hintStyle: TextStyle(
                color: myColors.grey_two,
                fontWeight: FontWeight.w400,
                fontSize: 13,
                fontFamily: MyString.PlusJakartaSansSemibold),
            contentPadding:
            EdgeInsets.only(left: 2, right: 2, bottom: 10)),
      ),
    );
  }
}
