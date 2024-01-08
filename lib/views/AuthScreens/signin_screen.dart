import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/model/UserModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/AuthScreens/enter_passcode_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/global_theme_button.dart';
import '../../utils/list.dart';
import '../../widgets/custom_texts.dart';
import 'forgot_password_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  /// Textfield Controller ..........
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  /// FocusNode.............
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  String? deviceId = "1235";
  String _site = AllApiServices.Prod_Url;
  String base_url = "";

  setbaseurl() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("mainurl",_site);
    setState((){});
  }

  /// get Device Id..............
  _getdevicetocken(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("mainurl",_site);
    setState((){});
    deviceId = id;
    print("devuce${deviceId}");
    preferences.setString("deviceId", deviceId.toString());
    setState((){});
  }

  String deviceIdentifier = '';
  init() async{
    print("fjjfg");
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      final WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
      deviceIdentifier = webInfo.vendor! +
          webInfo.userAgent! +
          webInfo.hardwareConcurrency.toString();
    } else {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceIdentifier = androidInfo.id!;
        print("deviceIdentifier>>${deviceIdentifier}");
        _getdevicetocken(deviceIdentifier);
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceIdentifier = iosInfo.identifierForVendor!;
        print("deviceIdentifier>>${deviceIdentifier}");
        _getdevicetocken(deviceIdentifier);
      } else if (Platform.isLinux) {
        final LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
        deviceIdentifier = linuxInfo.machineId!;
        _getdevicetocken(deviceIdentifier);
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setbaseurl();
    init();
    //_getdevicetocken();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailFocusNode.unfocus();
    passFocusNode.unfocus();
  }


  /// Check Validation..................
  CheckValiadtion() async{
    SharedPreferences p = await SharedPreferences.getInstance();
    String base_url3 = p.getString("mainurl").toString();
    base_url = base_url3;
    main_base_url = base_url;
    print("dbjfsj${base_url}");
    setState((){});
    if(base_url.toString() == "null" || base_url == ""){
      CustomToast.showToast(msg: "Please select  url");
    }
    else{
      print("main_base_url>>${main_base_url}");
      /// Call Api..............................
      Userlogin();
    }
  }


  List<UserModel> userlist = [];
  /// Caliing Api function..................
  Userlogin()async{
    await Webservices.RequestLogin(context, emailController.text, passController.text,deviceId.toString(),userlist);
    setState((){});
  }

  ///  Clear textfield..............
  cleartextfield(){
    emailController.clear();
    passController.clear();
  }

  /// Objects...................
  bool is_password = true;

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
            /*    appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: context.isDarkMode
                      ? myColors.dark_blue
                      : myColors.dark_blue,
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
            ),*/
            body: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    // height:MediaQuery.of(context).size.height ,
                    margin: EdgeInsets.only(top: 0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/new_images/SIGNIN-IC.png"),fit: BoxFit.fill)
                    ),
                    child: Container(
                      //height:MediaQuery.of(context).size.height ,
                      margin: EdgeInsets.only(top: mediaQuerryData.size.height/1.72,left: 20,right: 20),
                      //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      width: mediaQuerryData.size.width,
                      decoration: BoxDecoration(
                          color: Colors.transparent
                      ),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 0,
                            ),

                            Container(
                                child: Padding(padding: EdgeInsets.only(top: 20),
                                  child:  CustomText.CustomBoldText(
                                      MyString.SIGN_IN,
                                      myColors.black,
                                      FontWeight.w700,
                                      23,
                                      1,
                                      TextAlign.center),)),

                            Container(
                              padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
                              child: Text(
                                "Proceed with your login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: myColors.black,
                                  fontSize: 12,
                                  fontFamily: MyString.PlusJakartaSansregular,
                                  //   fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            //Email Textfield............................................................................................

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
                                  child: Text("Username",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: MyString.PlusJakartaSansregular,
                                    ),),
                                ),
                                Container(
                                  height: 48,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                          controller: emailController,
                                          focusNode: emailFocusNode,
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
                                              hintText: MyString.Username,
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: myColors.hintTxt,
                                                  fontFamily: MyString.PlusJakartaSansregular),
                                              counter: Offstage(),
                                              isDense: true,
                                              // this will remove the default content padding
                                              contentPadding:
                                              EdgeInsets.fromLTRB(16, 8, 8, 0)),
                                          maxLines: 1,
                                          cursorColor: myColors.black,
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 32,
                                        padding: EdgeInsets.all(5),
                                        child: Image.asset(
                                          "assets/images/img_blackUser.png",
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
                                  margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                                  child: Text("Password",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily:  MyString.PlusJakartaSansregular
                                    ),),
                                ),
                                Container(
                                  height: 48,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                          obscureText: is_password,
                                          controller: passController,
                                          focusNode: passFocusNode,
                                          keyboardType: TextInputType.visiblePassword,
                                          onChanged: (String value) {
                                            print("TAG" + value);
                                            setState(() {});
                                          },
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: MyString.PlusJakartaSansregular,
                                            color: myColors.black,
                                          ),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: MyString.Password,
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: myColors.hintTxt,
                                                  fontFamily:
                                                  MyString.PlusJakartaSansregular),
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

                            //Checkbox and Forgot password..............................................................................
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(top: 15),
                              child: InkWell(
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
                                    padding: EdgeInsets.only(left: 8),
                                    child: CustomText.CustomBoldText(
                                        MyString.Forgot_Password,
                                        myColors.black,
                                        FontWeight.w700,
                                        12,
                                        1,
                                        TextAlign.center)),
                              ),
                            ),

                           /// Url Radio Button hide...................
                          // selectUrl(),

                            //Login Button..................................................................................................
                            InkWell(
                              onTap: () {
                                print("djkgjg");
                                CheckValiadtion();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 0,bottom: 2),
                                child: GlobalThemeButton(
                                  buttonName: MyString.SIGN_IN,
                                  buttonColor: myColors.app_theme,

                                ),
                              ),
                            ),

                            //Forgot account.....................................
                            InkWell(
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
                                      myColors.black,
                                      FontWeight.w400,
                                      12,
                                      1,
                                      TextAlign.center)),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,)
                ],
              ),
            ),
          ),
        ));
  }

  selectUrl(){
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      //  height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Visibility(
            visible: false,
            child: Row(
              children: [
                Text('DEV Url',style: TextStyle(color: myColors.app_theme,fontSize: 12,fontWeight: FontWeight.w500)),
                Radio(
                  value: AllApiServices.DEV_Url,
                  groupValue: _site,
                  fillColor: MaterialStateProperty.all(myColors.app_theme),
                  onChanged: (String? value) async{
                    SharedPreferences pre = await SharedPreferences.getInstance();
                    setState(() {
                      _site = value.toString();
                      pre.setString("mainurl", _site);
                      //AllApiServices.main_base_url.toString() = _site;
                      print("site ${_site}");
                    });
                  },
                ),
              ],
            ),
          ),

          Row(
            children: [
              Text('UAT Url',style: TextStyle(color: myColors.app_theme,fontSize: 12,fontWeight: FontWeight.w500)),
              Radio(
                value:AllApiServices.UAT_Url,
                groupValue: _site,
                fillColor: MaterialStateProperty.all(myColors.app_theme),
                onChanged: (String? value) async{
                  SharedPreferences pre = await SharedPreferences.getInstance();
                  setState(() {
                    _site = value.toString();
                    pre.setString("mainurl", _site);
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Prod Url',style: TextStyle(color: myColors.app_theme,fontSize: 12,fontWeight: FontWeight.w500),),
              Radio(
                value: AllApiServices.Prod_Url,
                groupValue: _site,
                fillColor: MaterialStateProperty.all(myColors.app_theme),
                onChanged: (String? value) async{
                  SharedPreferences pre = await SharedPreferences.getInstance();
                  setState(() {
                    _site = value.toString();
                    pre.setString("mainurl", _site);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
