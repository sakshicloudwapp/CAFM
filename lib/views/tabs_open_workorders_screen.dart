import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/views/tabs_open_workorders_detail_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../global/my_string.dart';
import '../widgets/custom_texts.dart';

class ReactiveModel {
  String title;
  bool isChecked;
  bool isAssigned;

  ReactiveModel(this.title, this.isChecked, this.isAssigned);
}

List<ReactiveModel> reactiveCheckList = [];

class TabOpenWorkordersScreen extends StatefulWidget {
  String title;

  TabOpenWorkordersScreen({Key? key, required this.title}) : super(key: key);

  @override
  _TabOpenWorkordersScreenState createState() =>
      _TabOpenWorkordersScreenState();
}

class _TabOpenWorkordersScreenState extends State<TabOpenWorkordersScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    reactiveCheckList = [
      ReactiveModel("ahgh", true, false),
      ReactiveModel("ahgh", true, false),
      ReactiveModel("ahgh", true, false),
      ReactiveModel("ahgh", true, false),
      ReactiveModel("ahgh", true, false),
      ReactiveModel("ahgh", true, false),
      ReactiveModel("ahgh", true, false),
      ReactiveModel("ahgh", true, false),
      ReactiveModel("ahgh", true, false),
      ReactiveModel("ahgh", true, false),
      ReactiveModel("ahgh", true, false),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(192),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: myColors.app_theme,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,  // For iOS (dark icons)
              ),
              automaticallyImplyLeading: false,
              backgroundColor: myColors.app_theme,
              elevation: 0,
              flexibleSpace: Container(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                alignment: Alignment.center,
                child: SafeArea(
                  child: Column(
                    children: [
                      //Header..............................................................................................................
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
                                child: CustomText.CustomBoldTextDM(
                                    MyString.Discover,
                                    myColors.white,
                                    FontWeight.w700,
                                    16,
                                    1,
                                    TextAlign.center)),
                            flex: 1,
                          ),
                          Container(
                            height: 60,
                            width: 50,
                          ),
                        ],
                      ),

                      ///Tabbar...............................................................................................
                      Container(
                        height: 100,
                        width: mediaQuerryData.size.width,
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24)),
                          color: myColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                              child: CustomText.CustomSemiBoldText(
                                  MyString.Open_Wos,
                                  myColors.black,
                                  FontWeight.w600,
                                  16,
                                  1,
                                  TextAlign.center),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                              height: 40,
                              width: mediaQuerryData.size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: myColors.app_theme,
                              ),
                              child: TabBar(
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  color: myColors.app_theme_light,
                                  border: Border.all(color: myColors.app_theme),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelColor: myColors.grey_one,
                                unselectedLabelColor: myColors.white,
                                isScrollable: true,
                                physics: BouncingScrollPhysics(),
                                onTap: (tab_index) {
                                  print('Tab $tab_index is tapped');
                                  _tabController.index = tab_index;
                                  setState(() {});
                                },
                                enableFeedback: true,
                                tabs: [
                                  // First tab
                                  Tab(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        MyString.PPM_,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily:
                                          MyString.PlusJakartaSansBold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // second tab
                                  Tab(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        MyString.Reactive,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily:
                                          MyString.PlusJakartaSansBold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Third tab
                                  Tab(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        MyString.Corrective,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily:
                                          MyString.PlusJakartaSansBold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Fourth tab
                                  Tab(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(2, 0, 3, 0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        MyString.Contractor,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily:
                                          MyString.PlusJakartaSansBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // first tab bar view widget
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reactiveCheckList.length,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: TabsOpenWQorkordersDetailScreen(),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade,
                            );
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 3),
                            child: TAB_list(
                              index: index,
                              btn_name: widget.title,
                            ),
                          ),
                        );
                      })),

              // second tab bar view widget
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reactiveCheckList.length,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: TabsOpenWQorkordersDetailScreen(),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade,
                            );
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 3),
                            child: TAB_list(
                              index: index,
                              btn_name: widget.title,
                            ),
                          ),
                        );
                      })),

              // Third tab bar view widget
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reactiveCheckList.length,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                                   PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: TabsOpenWQorkordersDetailScreen(),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.fade,
                            );
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 3),
                            child: TAB_list(
                              index: index,
                              btn_name: widget.title,
                            ),
                          ),
                        );
                      })),
              // Fourth tab bar view widget
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reactiveCheckList.length,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                                   PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: TabsOpenWQorkordersDetailScreen(),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.fade,
                            );
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 3),
                            child: TAB_list(
                              index: index,
                              btn_name: widget.title,
                            ),
                          ),
                        );
                      })),
            ],
          ),
        ));
  }
}

///Tab List................................................................................................................................................................................................
class TAB_list extends StatefulWidget {
  int index;
  String btn_name;

  TAB_list({Key? key, required this.index, required this.btn_name})
      : super(key: key);

  @override
  _TAB_listState createState() => _TAB_listState();
}

class _TAB_listState extends State<TAB_list> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(
              color: reactiveCheckList[widget.index].isChecked == true
                  ? myColors.active_twelve
                  : myColors.grey_border),
          color: reactiveCheckList[widget.index].isChecked == true
              ? myColors.white
              : myColors.app_theme_light),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: CustomText.CustomSemiBoldText(
                      "# MMN14349",
                      myColors.app_theme,
                      FontWeight.w600,
                      12,
                      1,
                      TextAlign.center),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 43,
                          padding: EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          child: CustomText.CustomBoldTextDM(
                              "Status",
                              myColors.black,
                              FontWeight.w400,
                              12,
                              1,
                              TextAlign.center)),

                      ///button..............
                      Container(
                        alignment: Alignment.center,
                        height: 18,
                        width: 50,
                        margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: widget.btn_name == "Open"
                              ? myColors.cyan
                              : widget.btn_name == "Completed"
                                  ? myColors.green_accept
                                  : myColors.app_theme,
                        ),
                        child: CustomText.CustomBoldText(
                            widget.btn_name == "All"
                                ? MyString.New
                                : widget.btn_name,
                            myColors.white,
                            FontWeight.w700,
                            8,
                            1,
                            TextAlign.center),
                      ),

                      ///Arrow............
                      InkWell(
                        onTap: () {
                          reactiveCheckList[widget.index].isChecked =
                              !reactiveCheckList[widget.index].isChecked;
                          setState(() {});
                        },
                        child: Container(
                          width: 25,
                          height: 30,
                          child: Center(
                              child: SvgPicture.asset(
                            reactiveCheckList[widget.index].isChecked == true
                                ? "assets/images/ic_arrow_down_grey.svg"
                                : "assets/images/ic_arrow_right_grey.svg",
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: reactiveCheckList[widget.index].isChecked,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
              child: Column(
                children: [
                  Container(
                    height: 1.2,
                    color: myColors.active_twelve,
                  ),

                  ///Location....
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: CustomText.CustomMediumText(
                              "Location :",
                              myColors.grey_eleven,
                              FontWeight.w500,
                              12,
                              1,
                              TextAlign.center),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: CustomText.CustomMediumText(
                              "Khadiya Tower",
                              myColors.grey_one,
                              FontWeight.w400,
                              12,
                              1,
                              TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              ///Problem.....
                              Container(
                                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: CustomText.CustomMediumText(
                                          "Problem :",
                                          myColors.grey_eleven,
                                          FontWeight.w500,
                                          12,
                                          1,
                                          TextAlign.center),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: CustomText.CustomMediumText(
                                          "Backstore lights busted 6 no’s",
                                          myColors.grey_one,
                                          FontWeight.w400,
                                          12,
                                          1,
                                          TextAlign.center),
                                    ),
                                  ],
                                ),
                              ),

                              ///due date....
                              Container(
                                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: CustomText.CustomMediumText(
                                          "Due Date :",
                                          myColors.grey_eleven,
                                          FontWeight.w500,
                                          12,
                                          1,
                                          TextAlign.center),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: CustomText.CustomMediumText(
                                          "20 sep 2022 17:48:36",
                                          myColors.grey_one,
                                          FontWeight.w400,
                                          12,
                                          1,
                                          TextAlign.center),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
