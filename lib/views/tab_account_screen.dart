import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/GetResourceProfile.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/views/profile_screens/LoginAndAccessibilityScreen.dart';
import 'package:fm_pro/views/profile_screens/NotificationScreen.dart';
import 'package:fm_pro/views/profile_screens/Personal_Data.dart';
import 'package:fm_pro/views/profile_screens/change_password.dart';
import 'package:fm_pro/views/profile_screens/help_and_support.dart';
import 'package:fm_pro/views/profile_screens/terms_Conditions.dart';
import 'package:fm_pro/widgets/LogoutPopup.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/my_string.dart';
import '../global/sizedbox.dart';
import '../widgets/custom_texts.dart';


class TabAccountScreen extends StatefulWidget {
  const TabAccountScreen({Key? key}) : super(key: key);

  @override
  _TabAccountScreenState createState() => _TabAccountScreenState();
}

class _TabAccountScreenState extends State<TabAccountScreen> {
  bool status_toggle = true;
  String name = "";
  String user_name = "";
  String user_img = "";
  String user_designation = "";

  List<GetResorcePRofile> getresourceprofilelist = [];
  List<ResourcesProfile>? resources = [];
  List<ResourceLanguages>? resourceLanguages = [];
  List<ResourceSkillSets> resourceSkillSets = [];
  List<ResourceTypes>? resourceTypes = [];
  List<ResourceSubTypes>? resourceSubTypes = [];
  List<Roles>? roles = [];
  List<Departments>? departments = [];
  List<Designations>? designations = [];
  List<Divisions>? divisions = [];
  List<Vendors>? vendors = [];
  List<Clients>? clients = [];
  List<Countries>? countries = [];
  List<States>? states = [];
  List<Cities>? cities = [];
  List<Accounts>? accounts = [];
  List<RoleAccesses>? roleAccesses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedprefences();
    gerResorceprofileApi();
  }

  SharedPreferences? pre;

  getSharedprefences() async {
    pre = await SharedPreferences.getInstance();
    user_name = pre!.getString("user_name").toString();
    user_img = pre!.getString("user_profile").toString();
    user_designation = pre!.getString("designation").toString();
    print("username>>${user_name}");

    setState(() {});
  }

  gerResorceprofileApi() async {
    getresourceprofilelist.clear();
    resourceLanguages!.clear();
    resourceSkillSets.clear();
    resourceTypes!.clear();
    resourceSubTypes!.clear();
    roles!.clear();
    departments!.clear();
    designations!.clear();
    divisions!.clear();
    vendors!.clear();
    clients!.clear();
    countries!.clear();
    states!.clear();
    cities!.clear();
    accounts!.clear();
    roleAccesses!.clear();
    setState(() {});
    await Webservices.RequestGetResourceProfile(
        context, getresourceprofilelist);
    setState(() {});
    if (getresourceprofilelist != null) {
      resourceLanguages = getresourceprofilelist.first.resourceLanguages;
      resourceSkillSets = getresourceprofilelist.first.resourceSkillSets!;
      resourceTypes = getresourceprofilelist.first.resourceTypes;
      resourceSubTypes = getresourceprofilelist.first.resourceSubTypes;
      roles = getresourceprofilelist.first.roles;
      departments = getresourceprofilelist.first.departments;
      designations = getresourceprofilelist.first.designations;
      divisions = getresourceprofilelist.first.divisions;
      vendors = getresourceprofilelist.first.vendors;
      clients = getresourceprofilelist.first.clients;
      states = getresourceprofilelist.first.states;
      countries = getresourceprofilelist.first.countries;
      cities = getresourceprofilelist.first.cities;
      accounts = getresourceprofilelist.first.accounts;
      roleAccesses = getresourceprofilelist.first.roleAccesses;
      resources = getresourceprofilelist.first.resources;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.white,
          appBar: PreferredSize(
            preferredSize: Size.zero,
            child: AppBar(
              elevation: 0,
              backgroundColor: myColors.app_theme,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: myColors.app_theme,
                  //ios
                  statusBarBrightness: Brightness.dark,
                  // android
                  statusBarIconBrightness: Brightness.light),
              automaticallyImplyLeading: false,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// user profile data.....................
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(color: myColors.app_theme),
                  child: Column(
                    children: [
                      hsized20,

                      /// user profile image.........................................
                      Container(
                        width: 75,
                        height: 75,
                        child: CircleAvatar(
                          radius: 35,
                          child: user_img.toString() == "null"
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    "assets/images/user_img.png",
                                    fit: BoxFit.cover,
                                    width: 75,
                                    height: 75,
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    user_img,
                                    fit: BoxFit.cover,
                                    width: 75,
                                    height: 75,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, exception, stackTrace) {
                                      return Image.asset(
                                        "assets/images/user_img.png",
                                        fit: BoxFit.cover,
                                        width: 75,
                                        height: 75,
                                      );
                                    },
                                  )),
                        ),
                      ),

                      hsized10,

                      /// user name.........................................
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Hi, ${user_name}",
                          style: TextStyle(
                              color: myColors.white,
                              fontSize: 16,
                              fontFamily: MyString.PlusJakartaSansSemibold,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      hsized7,

                      /// user Designation.........................................
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          user_designation,
                          style: TextStyle(
                              color: myColors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily:
                              MyString.PlusJakartaSansBold),
                        ),
                      ),

                      hsized30
                    ],
                  ),
                ),

                /// About app.........................................
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Text(
                    MyString.About_app,
                    style: TextStyle(
                        color: myColors.black,
                        fontSize: 14,
                        fontFamily: MyString.PlusJakartaSansBold),
                  ),
                ),

                /// About app.........................................
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Text(
                    "Version: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: MyString.PlusJakartaSansregular,),
                  ),
                ),

                Container(
                    margin: EdgeInsets.only(top: 18),
                    height: 0.6,
                    color: myColors.grey_38),

                ///Change Password.....................................................

                /// Login & Accessibility.....................
                GestureDetector(
                  onTap: (){
                    CustomNavigator.pushNavigate(context, LoginAccessibilityScreen());
                  },
                  child: listview(MyString.Login_Accessibility),
                ),

                /// Notifications.....................
                GestureDetector(
                  onTap: (){
                   CustomNavigator.pushNavigate(context, NotificationScreen());
                  },
                  child: listview(MyString.Notifications),
                ),

                /// Terms Conditions.....................
                GestureDetector(
                  onTap: (){
                   CustomNavigator.pushNavigate(context,  TermAndConditionsScreen(title: "Terms & Conditions"),);
                  },
                  child: listview(MyString.Terms_Conditions),
                ),

                /// Privacy Policy.....................
                GestureDetector(
                  onTap: (){
                    CustomNavigator.pushNavigate(context,  TermAndConditionsScreen(
                      title: 'Privacy Policy',
                    ),);
                  },
                  child: listview(MyString.Privacy_Policy),
                ),

                /// Help Support.....................
                GestureDetector(
                  onTap: (){
                    CustomNavigator.pushNavigate(context,HelpAndSupport());
                  },
                  child: listview(MyString.help_and_support),
                ),

                /// Log out.....................
                GestureDetector(
                  onTap: (){
                    logoutpopup();
                  },
                  child: listview(MyString.Logout),
                ),


                /// Change pass
               /* GestureDetector(
                  onTap: () {
                    CustomNavigator.custompush(
                        context, ChangePassword(), false);
                  },
                  child: Container(
                    height: 45,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: myColors.light_yellow,
                    ),
                    child: CustomText.CustomRegularText(
                        MyString.change_password,
                        myColors.black,
                        FontWeight.w400,
                        12,
                        1,
                        TextAlign.center),
                  ),
                ),*/

                ///Allow Notification.....................................................
                // Container(
                //   height: 45,
                //   alignment: Alignment.centerLeft,
                //   margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                //   padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                //     border: Border.all(color: myColors.grey_38),
                //     color: myColors.grey_37,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       CustomText.CustomRegularText(
                //           MyString.Allow_Notification,
                //           myColors.black,
                //           FontWeight.w400,
                //           12,
                //           1,
                //           TextAlign.center),
                //
                //       ///Toggle....................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                //         alignment: Alignment.centerRight,
                //         child: FlutterSwitch(
                //           width: 40.0,
                //           height: 18.0,
                //           /* switchBorder: Border.all(
                //           color: Mycolors.white_color,
                //           width: 6.0,
                //         ),*/
                //           /*  toggleBorder: Border.all(
                //               color: myColors.white,
                //               width: 0.0,
                //             ),*/
                //           inactiveSwitchBorder: Border.all(
                //             color: myColors.grey_ten,
                //             width: 0.0,
                //           ),
                //           inactiveToggleColor: myColors.white,
                //           inactiveColor: myColors.grey_ten,
                //           //  inactiveToggleBorder: BoxBorder.,
                //           activeColor: myColors.grey_bar1,
                //           activeToggleColor: myColors.app_theme,
                //           valueFontSize: 0.0,
                //           toggleSize: 18.0,
                //           value: status_toggle,
                //           borderRadius: 18.0,
                //           padding: 0.0,
                //           showOnOff: true,
                //           onToggle: (val) {
                //             setState(() {
                //               status_toggle = val;
                //             });
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                ///Ammend my Personal data.....................................................
                // GestureDetector(
                //   onTap: () {
                //     CustomNavigator.custompush(
                //         context, PersonalDataScreen(), true);
                //   },
                //   child: Container(
                //     height: 45,
                //     alignment: Alignment.centerLeft,
                //     margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                //     padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(8)),
                //       border: Border.all(color: myColors.grey_38),
                //       color: myColors.grey_37,
                //     ),
                //     child: CustomText.CustomRegularText(
                //         // user_name+" "+
                //         MyString.Ammend_my_Personal_data,
                //         myColors.black,
                //         FontWeight.w400,
                //         12,
                //         1,
                //         TextAlign.center),
                //   ),
                // ),

                ///Terms & Conditions.....................................................
                // GestureDetector(
                //   onTap: () {
                //     CustomNavigator.custompush(
                //         context,
                //         TermAndConditionsScreen(title: "Terms & Conditions"),
                //         true);
                //   },
                //   child: Container(
                //     height: 45,
                //     alignment: Alignment.centerLeft,
                //     margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                //     padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(8)),
                //       border: Border.all(color: myColors.grey_38),
                //       color: myColors.grey_37,
                //     ),
                //     child: CustomText.CustomRegularText(
                //         MyString.Terms_Conditions,
                //         myColors.black,
                //         FontWeight.w400,
                //         12,
                //         1,
                //         TextAlign.center),
                //   ),
                // ),

                ///Privacy Policy.....................................................
                // GestureDetector(
                //   onTap: () {
                //     CustomNavigator.custompush(
                //         context,
                //         TermAndConditionsScreen(
                //           title: 'Privacy Policy',
                //         ),
                //         true);
                //   },
                //   child: Container(
                //     height: 45,
                //     alignment: Alignment.centerLeft,
                //     margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                //     padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(8)),
                //       border: Border.all(color: myColors.grey_38),
                //       color: myColors.grey_37,
                //     ),
                //     child: CustomText.CustomRegularText(
                //         MyString.Privacy_Policy,
                //         myColors.black,
                //         FontWeight.w400,
                //         12,
                //         1,
                //         TextAlign.center),
                //   ),
                // ),

                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }

  void logoutpopup() {
    showModalBottomSheet<int>(
      barrierColor: Colors.black.withOpacity(0.80),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          //  color: Colors.black.withOpacity(0.80),
            child: LogoutPopupScreen());
      },
    );
  }
  listview(String title){
    return Container(
      width: double.infinity,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// About app.........................................
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20,right: 20,top: 20),
            child: Text(title,style: TextStyle(color: myColors.black,fontSize: 12,fontFamily: MyString.PlusJakartaSansBold),),
          ),

          title == "Log_out"?Container():
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            height: 0.6,color: myColors.grey_38,)
        ],
      ),
    );
  }

}
