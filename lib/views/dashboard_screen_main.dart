import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/NewScreens/TimeScreen/TimeScreen.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/AssetLookup/asset_lookup_screen.dart';
import 'package:fm_pro/views/PPM/ppm_screen.dart';
import 'package:fm_pro/views/Reactive/reactive_workorders_screen.dart';
import 'package:fm_pro/views/tab_account_screen.dart';
import 'package:fm_pro/views/tab_add_screen.dart';
import 'package:fm_pro/views/tab_home_screen.dart';
import 'package:fm_pro/views/tab_ppm_screen.dart';
import 'package:fm_pro/views/tab_reactive_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:upgrader/upgrader.dart';

import '../global/my_string.dart';
import '../model/models/homePageModel.dart';
import '../services/webservices.dart';
import 'PPM/ppm_new_workorder_screen.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class DashboardScreenMain extends StatefulWidget {
  const DashboardScreenMain({Key? key}) : super(key: key);

  @override
  _DashboardScreenMainState createState() => _DashboardScreenMainState();
}

class _DashboardScreenMainState extends State<DashboardScreenMain> {
  PersistentTabController? controller;
  late bool _hideNavBar;
  int tabIndex = 0;
  String pagename = "";
  String selected_btn = "";
  PersistentBottomSheetController? _controller; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  onCallBack(String title) {
    selected_btn = title;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PersistentTabController();
    _hideNavBar = false;
  }

  String statusId = "0";

  updatestatus(int currentindex, String statusId2) {
    statusId = statusId2;
    controller!.jumpToTab(currentindex);
    tabIndex = currentindex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return UpgradeAlert(
     // key:navigatorKey,
      upgrader: Upgrader(

      ),
      child: WillPopScope(
          onWillPop: () async {
            await showDialog(
              context: context,
              useSafeArea: false,
              builder: (context) => Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          "Are you sure you want to exit app?",
                          style: TextStyle(
                              color: myColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text("No"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    myColors.app_theme)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          ElevatedButton(
                            child: const Text("Yes"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    myColors.app_theme)),
                            onPressed: () {
                              exit(0);
                              //   Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
            return false;
          },
          child: MediaQuery(
            data: data,
            child: Scaffold(
              body: getPage(tabIndex),

              bottomNavigationBar: Container(
                  alignment: Alignment.center,
                  height: 55,
                  margin: EdgeInsets.only(bottom: 18, left: 20, right: 20, top: 0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: myColors.app_theme,
                      borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// tab 1....
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              tabIndex = 0;
                            //  appbarTitle = "PPM_WO".tr;
                            });
                          },
                          child: Container(
                              child: _bottomNavigationBarItem(
                                icon: tabIndex == 0
                                    ? "assets/images/fill_home.svg"
                                    : "assets/images/home.svg",
                                iconsize: 25,
                              )),
                        ),

                        /// tab 2....
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              tabIndex = 1;
                            });
                          },
                          child: Container(
                              child: _bottomNavigationBarItem(
                                icon: tabIndex == 1
                                    ? "assets/images/fill_document_text.svg"
                                    : "assets/images/document_text.svg",
                                iconsize: 25,
                              )),
                        ),

                        /// tab 3....
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              tabIndex = 2;
                            });
                          },
                          child: Container(
                              child: _bottomNavigationBarItem(
                                icon: tabIndex == 2
                                    ? "assets/images/fill_add_square.svg"
                                    : "assets/icons/add_square.svg",
                                iconsize: 25,
                              )),
                        ),


                        /// tab 5....
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              tabIndex = 3;
                            });
                          },
                          child: Container(
                              child: _bottomNavigationBarItem(
                                icon: tabIndex == 3
                                    ? "assets/images/fill_user.svg"
                                    : "assets/images/user.svg",
                                iconsize: 25,
                              )),
                        ),
                      ],
                    ),
                  )),
            ),
          )),
    );
  }

  _bottomNavigationBarItem({required String icon, required double iconsize}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: iconsize,
            width: iconsize,
          ),
        ],
      ),
    );
  }

  List<HomePageModel> gethomepageList = [];
  List<HomePageDataModel> gethomepagedataList = [];


  onCallback(String status){
  }
  getPage(int page) {
    print("page >>>>>" + page.toString());
    switch (page) {
      case 0:
        {
          return TabHomeScreen(
            pagename: '1',
            updatestatus: updatestatus,
          );
        }
      case 1:
        {
          return TabPpmScreen(
            statusId: statusId,
            serviceId: "1",
            title: 'PPM W/O',
            isBack: 'false', appbartitle: 'PPM W/O', onCallback: onCallback,
          );
        }
      case 2:
        {
         return TabAddScreen();
        }

      case 3:
        {
          return  TabAccountScreen();
        }
      default:
        {
          return TabHomeScreen(
            pagename: '1',
            updatestatus: updatestatus,
          );
        }
    }
  }

  List<Widget> _buildScreens() {
    return [
      TabHomeScreen(
        pagename: '1',
        updatestatus: updatestatus,
      ),
      TabPpmScreen(
        statusId: statusId,
        serviceId: "1",
        title: 'PPM W/O',
        isBack: 'false', appbartitle: 'PPM W/O', onCallback: onCallback,
      ),
      //  TabHomeScreen(pagename: '3',),
      // TabReactiveScreen(),
      TabPpmScreen(
        statusId: statusId,
        serviceId: "2",
        title: 'Reactive W/O',
        isBack: 'false', appbartitle: 'Reactive W/O', onCallback: onCallback,
      ),
      TabAccountScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        contentPadding: 0,

        // onSelectedTabPressWhenNoScreensPushed: (){
        //
        // },
        iconSize: 10,
        icon: Image.asset(
          "assets/images/tab_blue_icon/ic_home_blue.png",
          height: 32,
          width: 32,
        ),
        inactiveIcon: Image.asset(
          "assets/images/tab_grey_icon/ic_home_grey.png",
          height: 32,
          width: 32,
        ),

        activeColorPrimary: myColors.white,
        inactiveColorPrimary: myColors.white,
      ),
      PersistentBottomNavBarItem(
        // contentPadding: 8.0,
        icon: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 40),
            child: Image.asset(
              "assets/images/tab_blue_icon/ic_ppm_blue.png",
              height: 32,
              width: 32,
            )),
        inactiveIcon: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 40),
          child: Image.asset(
            "assets/images/tab_grey_icon/ic_ppm_grey.png",
            height: 30,
            width: 30,
          ),
        ),

        activeColorPrimary: myColors.color_filled_icon,
        inactiveColorPrimary: myColors.color_not_filled_icon,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          padding: EdgeInsets.only(left: 30),
          child: Image.asset(
            "assets/images/tab_blue_icon/ic_reactive_blue.png",
            height: 48,
            width: 48,
          ),
        ),
        inactiveIcon: Container(
          padding: EdgeInsets.only(left: 30),
          child: Image.asset("assets/images/tab_grey_icon/ic_reactive_grey.png",
              height: 46, width: 46),
        ),
        activeColorPrimary: myColors.color_filled_icon,
        inactiveColorPrimary: myColors.color_not_filled_icon,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/tab_blue_icon/ic_account_blue.png",
          height: 49,
          width: 49,
        ),
        inactiveIcon: Image.asset(
            "assets/images/tab_grey_icon/ic_account_grey.png",
            height: 46,
            width: 46),
        activeColorPrimary: myColors.color_filled_icon,
        inactiveColorPrimary: myColors.color_not_filled_icon,
      ),
    ];
  }

 /* void addbottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      ShowBottomSheetAdd();
    });
  }*/

  Future<void> ShowBottomSheetAdd() {
    return showModalBottomSheet<void>(
      enableDrag: false,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: myColors.white,
            ),
            child: AddBottomSheetUi(
              callback: onCallBack, updatestatus: updatestatus,
            ));
      },
    );
  }
}

class AddBottomSheetUi extends StatefulWidget {
  Function callback;
  Function updatestatus;

  AddBottomSheetUi({Key? key, required this.callback,required this.updatestatus}) : super(key: key);

  @override
  _AddBottomSheetUiState createState() => _AddBottomSheetUiState();
}

class _AddBottomSheetUiState extends State<AddBottomSheetUi> {
  String isClicked = "";

  onCallBack(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              isClicked = "0";
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PPM_New_Workorder_Screen(
                          title: "New workorder", appbartitle: "",assetcode: '', ServiceId: '3', ppmId: '', parentId: 0,
                        // callback: onCallBack,
                        // serviceTypeId: "3",
                        // updatestatus: widget.updatestatus, title: 'Corrective Workorder',
                      )


                  ));

             /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ReactiveWorkordersScreen(
                        callback: onCallBack,
                        serviceTypeId: "3",
                        updatestatus: widget.updatestatus, title: 'Corrective Workorder',
                      )


              ));*/
              setState(() {});

            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
              decoration: BoxDecoration(
                border: Border.all(color: myColors.app_theme),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: isClicked == "0" ? myColors.app_theme : myColors.white,
              ),
              child: Text(
                MyString.Create_Workorder,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: MyString.PlusJakartaSansBold,
                  color: isClicked == "0" ? myColors.white : myColors.app_theme,
                ),
              ),
            ),
          ),


          InkWell(
            onTap: () {
              isClicked = "1";
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
              decoration: BoxDecoration(
                border: Border.all(color: myColors.app_theme),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: isClicked == "1" ? myColors.app_theme : myColors.white,
              ),
              child: Text(
                MyString.Call_your_team_member,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: MyString.PlusJakartaSansBold,
                  color: isClicked == "1" ? myColors.white : myColors.app_theme,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              isClicked = "2";
              Navigator.of(context).pop();
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: AssetLookupScreen(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
              decoration: BoxDecoration(
                border: Border.all(color: myColors.app_theme),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: isClicked == "2" ? myColors.app_theme : myColors.white,
              ),
              child: Text(
                MyString.Asset_Lookup,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: MyString.PlusJakartaSansBold,
                  color: isClicked == "2" ? myColors.white : myColors.app_theme,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
