import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/main.dart';
import 'package:fm_pro/model/models/homePageModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/views/AuthScreens/signin_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../dashboard_screen_main.dart';
import 'onboarding_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Sharedprefences........


  // appvaersion() async{
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String version = packageInfo.version;
  //   String code = packageInfo.buildNumber;
  //   print("version>>${version}");
  //   print("code>>${code}");
  //
  // }

  SharedPreferences? p;
  getPrefences()async{
    p = await SharedPreferences.getInstance();
    var base_url = p!.getString("mainurl");
    main_base_url = base_url.toString();
    print("main_base_url${main_base_url}");
    init_screen = p!.getString('init_screen').toString();
    is_login = p!.getBool('isLogin') == null ? false : true;
    print("is_login.......$is_login");
    setState((){});
    RequestGetHomePage(context);
    _navigate();
  }


  /// Navigate other Screen.............
  _navigate(){
    // p.setString("access_token", authtocken);
    // if(p!.getString('init_screen') == null || p!.getString('init_screen') == "0"){
    //   Timer(
    //       Duration(seconds: 5),
    //           () => Navigator.pushAndRemoveUntil(
    //               context, MaterialPageRoute(builder: (context) => SigninScreen()),ModalRoute.withName('/'))
    //   );
    // }else
      if(p!.getBool('isLogin') == null || p!.getBool('isLogin') == false || p!.getString("access_token") == null){
      Timer(
          Duration(seconds: 5),
              () => Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => SigninScreen()),ModalRoute.withName('/'))
      );
    }else{
      Timer(
          Duration(seconds: 5),
              () => Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => DashboardScreenMain(),
          ),ModalRoute.withName('/'))
      );
    }
  }

  Future<void> RequestGetHomePage(
      BuildContext context,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${p.getString("access_token")}'
    };
    try{
      var request = http.Request('GET',
          Uri.parse(main_base_url+AllApiServices.Gethomepage));
      request.body = '''''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(await response.stream.bytesToString());


        print("fgrhjhjd"+jsonResponse.toString());
        HomePageModel   model =  HomePageModel.fromJson(jsonResponse);
        setState((){});
        var list = jsonResponse['data'];

        list.forEach((e){
          HomePageDataModel   model2 =  HomePageDataModel.fromJson(e);
          setState((){});
        });

      }
      else {

        print("jfbjjgfc");
       // await Future<int>.delayed(Duration(seconds: 1));
        response.reasonPhrase.toString() == "Unauthorized" ?
        p.setBool("isLogin", false): null;


        print(response.reasonPhrase.toString());
      }

    }on SocketException catch(e){
      CustomToast.showToast(msg: e.toString());
    }

  }


  String? deviceId = "1235";

  /// get Device Id..............
  _getdevicetocken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //deviceId = await _getId();
    print("devuce${deviceId}");
    preferences.setString("deviceId", deviceId.toString());
    setState((){});
  }

  // Future<String?> _getId() async {
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) { // import 'dart:io'
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  //   } else if(Platform.isAndroid) {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     return androidDeviceInfo.androidId; // unique ID on Android
  //   }
  // }


  void initState() {
    super.initState();
    getPrefences();
    _getdevicetocken();

  }


  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          backgroundColor: myColors.color_filled_icon,
          body: Container(
            alignment: Alignment.center,
            child: Container(
               height: 150,
               width: 150,
            /*  decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: myColors.circle_theme,
              ),*/
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset("assets/icons/processed-0a8559a5-4a39-4246-a3b8-2a28c361fd35_Lorj6OVX-removebg-preview.png",height: 150,width: 150,),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
