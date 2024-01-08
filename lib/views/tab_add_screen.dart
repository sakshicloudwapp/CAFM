import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/model/models/GetUserModel.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/views/AssetLookup/asset_lookup_screen.dart';
import 'package:fm_pro/views/PPM/ppm_new_workorder_screen.dart';
import 'package:fm_pro/views/notification_screen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/models/GetNotificationWorkOrdersModel.dart';

class TabAddScreen extends StatefulWidget {
  const TabAddScreen({Key? key}) : super(key: key);

  @override
  State<TabAddScreen> createState() => _TabAddScreenState();
}

class _TabAddScreenState extends State<TabAddScreen> {

  String name = "";
  String user_name = "";
  String user_img = "";
  String user_designation = "";
  List<GetNotificationWorkOrdersModel> getNotificationList = [];


  void initState() {
    super.initState();
    getSharedprefences();
    getNotificationApi();
  }


  List<GetUserModel> getuserlist = [];

  getuserApi() async{
    await Webservices.RequestGetUserInformation(context, getuserlist);
    setState(() {});
  }

  SharedPreferences? pre ;
  getSharedprefences() async{
    getuserApi();
    pre = await SharedPreferences.getInstance();
    user_name = pre!.getString("user_name").toString();
    user_img = pre!.getString("user_profile").toString();
    user_designation = pre!.getString("designation").toString();
    print("username>>${user_img}");

    setState((){});
  }
  getNotificationApi() async {
    getNotificationList.clear();
    setState(() {});
    await Webservices.RequestGetNotificationWorkOrders(context,getNotificationList);
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(data: mediaQuerryData,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AppBar(
              backgroundColor: myColors.app_theme,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: myColors.app_theme,
                // Status bar brightness (optional)
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark, // For iOS (dark icons)
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              flexibleSpace: Container(
                color: myColors.app_theme,
                padding: EdgeInsets.fromLTRB(20, 18, 0, 0),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      child: CircleAvatar(
                        radius: 60,
                        child:   user_img.toString() == "null" ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset("assets/images/user_img.png",fit: BoxFit.cover,width: 45,
                              height: 45,)):  ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(user_img,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, exception, stackTrace) {
                                return Image.asset(
                                  "assets/images/user_img.png",
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                );
                              },
                              width: 45,
                              height: 45,)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //  height: 45,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                 user_name.toString() == "null" ? "" :  "Hi,"+ user_name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: MyString.PlusJakartaSansregular,
                                  color: myColors.white,
                                ),
                              ),
                            ),

                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                user_designation.toString() == "null" ? "" : user_designation,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily:
                                  MyString.PlusJakartaSansregular,
                                  color: myColors.yellow,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Notification Icon.........
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: NotifiicationScreen(getworklist: getNotificationList,),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                        setState(() {});
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 130,
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/images/ic_notification.svg",
                                width: 30,
                                height: 30,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.fromLTRB(15, 1, 0, 0),
                              width: 23,
                              height: 23,
                              decoration: BoxDecoration(
                                  color: myColors.color_red,
                                  shape: BoxShape.circle),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "${getNotificationList.length.toString()}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 9,

                                    fontWeight: FontWeight.w700,
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'assets/font/poppins_regular.ttf',
                                    color: myColors.white,
                                  ),
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
          ),
          body:  Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0)),
              color: myColors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: myColors.purple
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "What do you want \n to do?",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              fontFamily: MyString.PlusJakartaSansSemibold,
                              color: myColors.app_theme,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Image.asset("assets/images/addTab_bg_icon.png",height: 160,width: 160,),
                        SizedBox(height: 50,)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: ()async{
                      SharedPreferences p =  await SharedPreferences.getInstance();
                      p.setString(
                          "menu_ID", "");
                      CustomNavigator.pushNavigate(
                          context,PPM_New_Workorder_Screen(title: MyString.Create_correctiveWork_order, appbartitle: "",assetcode: '', ServiceId: '3', ppmId: '', parentId: 0,));
                    },
                    child:   Container(
                      margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                      alignment: Alignment.center,
                      //width: MediaQuery.of(context).size.width/1.8,
                      padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: myColors.app_theme,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 30,
                            child: Image.asset(
                              "assets/images/createWork.png",
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              MyString.Create_correctiveWork_order,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                MyString.PlusJakartaSansregular,
                                color: myColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: ()async{
                      SharedPreferences p =  await SharedPreferences.getInstance();
                      p.setString(
                          "menu_ID", "");
                      CustomNavigator.pushNavigate(
                          context,PPM_New_Workorder_Screen(title:   MyString.Create_reactiveWork_order, appbartitle: "",assetcode: '', ServiceId: '2', ppmId: '', parentId: 0,));
                    },
                    child:   Container(
                      margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                      alignment: Alignment.center,
                      //width: MediaQuery.of(context).size.width/1.8,
                      padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: myColors.app_theme,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 30,
                            child: Image.asset(
                              "assets/images/createWork.png",
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              MyString.Create_reactiveWork_order,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                MyString.PlusJakartaSansregular,
                                color: myColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: (){
                    },
                    child:   Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width/1.4,
                      padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: myColors.purple,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 25,
                            width: 35,
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/call_icon.png",
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              MyString.Call_your_Team_member,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                MyString.PlusJakartaSansregular,
                                color: myColors.app_theme,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      CustomNavigator.pushNavigate(context, AssetLookupScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width/1.8,
                      padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: myColors.app_theme,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 25,
                            width: 35,
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/insta_img.png",
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              MyString.Asset_Lookup,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                MyString.PlusJakartaSansregular,
                                color: myColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
