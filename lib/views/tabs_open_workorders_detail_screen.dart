import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';

import '../global/my_string.dart';
import '../widgets/custom_texts.dart';

class TabsOpenWQorkordersDetailScreen extends StatefulWidget {
  const TabsOpenWQorkordersDetailScreen({Key? key}) : super(key: key);

  @override
  _TabsOpenWQorkordersDetailScreenState createState() =>
      _TabsOpenWQorkordersDetailScreenState();
}

class _TabsOpenWQorkordersDetailScreenState
    extends State<TabsOpenWQorkordersDetailScreen> {
  String status_assigned = "";

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            backgroundColor: myColors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
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
                                      MyString.PPM,
                                      myColors.white,
                                      FontWeight.w700,
                                      16,
                                      1,
                                      TextAlign.center)),
                              flex: 1,
                            ),
                            Container(
                              height: 30,
                              width: 60,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    margin: EdgeInsets.only(bottom: 2),
                                    child: Center(
                                        child: Image.asset(
                                            "assets/images/check_circle_white.png")),
                                  ),
                                  CustomText.CustomSemiBoldText(
                                      "Complete",
                                      myColors.white,
                                      FontWeight.w500,
                                      10,
                                      1,
                                      TextAlign.center),
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
            ),
            body: body()));
  }

  body() {
    return Container(
      color: myColors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: CustomText.CustomSemiBoldText("W/O Details",
                  myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: CustomText.CustomSemiBoldText(
                        "# MMN14358  -",
                        myColors.black,
                        FontWeight.w600,
                        14,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    height: 25,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: myColors.sky_blue,
                      border: Border.all(color: myColors.sky_blue),
                    ),
                    child: CustomText.CustomSemiBoldText(
                        "P3 -Normal",
                        myColors.white,
                        FontWeight.w500,
                        12,
                        1,
                        TextAlign.center),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(16, 3, 16, 0),
              child: CustomText.CustomSemiBoldText("My Ac is Not Working",
                  myColors.grey_six, FontWeight.w400, 12, 1, TextAlign.center),
            ),

            ///Reported Date..................
            Container(
              padding: EdgeInsets.fromLTRB(16, 30, 6, 0),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 75,
                    child: CustomText.CustomSemiBoldText(
                        "Reported Dt.",
                        myColors.grey_eleven,
                        FontWeight.w600,
                        12,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 10,
                    child: CustomText.CustomSemiBoldText(
                        ":",
                        myColors.grey_eleven,
                        FontWeight.w600,
                        12,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 115,
                    padding: EdgeInsets.only(left: 2, right: 0),
                    child: CustomText.CustomSemiBoldText(
                        "20 sep 2022 17:48:36",
                        myColors.black,
                        FontWeight.w400,
                        11,
                        1,
                        TextAlign.center),
                  ),
                ],
              ),
            ),

            ///Due Date..................
            Container(
              padding: EdgeInsets.fromLTRB(16, 12, 6, 0),
              child: Row(
                children: [
                  Container(
                    width: 75,
                    alignment: Alignment.topLeft,
                    child: CustomText.CustomSemiBoldText(
                        "Due Date",
                        myColors.grey_eleven,
                        FontWeight.w600,
                        12,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 10,
                    child: CustomText.CustomSemiBoldText(
                        ":",
                        myColors.grey_eleven,
                        FontWeight.w600,
                        12,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 6, right: 6),
                    child: CustomText.CustomSemiBoldText(
                        "20 sep 2022 17:48:36",
                        myColors.black,
                        FontWeight.w400,
                        11,
                        1,
                        TextAlign.center),
                  ),
                ],
              ),
            ),

            ///Category..................
            Container(
              padding: EdgeInsets.fromLTRB(16, 12, 6, 0),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 75,
                    child: CustomText.CustomSemiBoldText(
                        "Category",
                        myColors.grey_eleven,
                        FontWeight.w600,
                        12,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 10,
                    child: CustomText.CustomSemiBoldText(
                        ":",
                        myColors.grey_eleven,
                        FontWeight.w600,
                        12,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 6, right: 6),
                    child: CustomText.CustomSemiBoldText(
                        "Electrical",
                        myColors.black,
                        FontWeight.w400,
                        11,
                        1,
                        TextAlign.center),
                  ),
                ],
              ),
            ),

            ///line..................
            Container(
              margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
              height: 1.2,
              color: myColors.grey_twelve,
            ),

            ///Asset Details..................
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: CustomText.CustomSemiBoldText(
                  MyString.Asset_Details,
                  myColors.dark_grey_txt,
                  FontWeight.w600,
                  14,
                  1,
                  TextAlign.center),
            ),
            ///Description..................
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: CustomText.CustomSemiBoldText(
                          "DXB111CDSHMSMA00001  -",
                          myColors.black,
                          FontWeight.w600,
                          12,
                          1,
                          TextAlign.center),
                    ),
                    Container(
                      width: 120,
                      child: CustomText.CustomSemiBoldText(
                          " Distribution board 10",
                          myColors.black,
                          FontWeight.w400,
                          12,
                          1,
                          TextAlign.center),
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 43,
                      width: 43,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: myColors.grey_border,
                        border: Border.all(color: myColors.grey_border),
                      ),
                      child: Center(
                          child: Image.asset(
                        "assets/images/img_qr.png",
                      )),
                    ),
                  ],
                ),
              ),
            ),

            ///line..................
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 1.2,
              color: myColors.grey_twelve,
            ),

            ///Location..................
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: CustomText.CustomSemiBoldText(
                  "Location",
                  myColors.dark_grey_txt,
                  FontWeight.w600,
                  14,
                  1,
                  TextAlign.center),
            ),

            ///Map........................
            Container(
                height: 200,
                margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Image.asset("assets/images/img_map.png")
                /*GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),*/
                ),

            ///Assigned Resource..................
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 22),
              child: CustomText.CustomSemiBoldText(
                  MyString.Assigned_Resource,
                  myColors.dark_grey_txt,
                  FontWeight.w600,
                  14,
                  1,
                  TextAlign.center),
            ),

            Container(
              height: 265,
              padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: myColors.orange),
                  color: myColors.light_orange),
              child: Column(
                children: [
                  ///User info...........
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        child: CircleAvatar(
                          maxRadius: 60,
                          backgroundImage:
                              AssetImage("assets/images/profle_men.png"),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(
                                      "Muhammad Sami uddin",
                                      myColors.dark_grey_txt,
                                      FontWeight.w500,
                                      14,
                                      1,
                                      TextAlign.center)),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(
                                      "Designation",
                                      myColors.app_theme,
                                      FontWeight.w500,
                                      12,
                                      1,
                                      TextAlign.center)),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(
                                      "sami@company.com",
                                      myColors.grey_eight,
                                      FontWeight.w400,
                                      12,
                                      1,
                                      TextAlign.center)),
                            ],
                          ),
                        ),
                      ),

                      //active.........
                      Container(
                        width: 47,
                        child: Row(
                          children: [
                            Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: myColors.active_green,
                              ),
                            ),
                            Container(
                                width: 35,
                                padding: EdgeInsets.only(left: 4),
                                child: CustomText.CustomMediumText(
                                    "Active",
                                    myColors.active_green,
                                    FontWeight.w500,
                                    10,
                                    1,
                                    TextAlign.center)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///Call whatsapp.......
                  Container(
                    padding: EdgeInsets.only(top: 12, left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    margin: EdgeInsets.only(left: 0, top: 6),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border:
                                          Border.all(color: myColors.app_theme),
                                    ),
                                    child: Image.asset(
                                        "assets/images/img_whatsapp_theme.png"),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: CustomText.CustomRegularText(
                                        "sms",
                                        myColors.grey_fourteen,
                                        FontWeight.w400,
                                        10,
                                        1,
                                        TextAlign.center),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    margin: EdgeInsets.only(left: 4, top: 6),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border:
                                          Border.all(color: myColors.app_theme),
                                    ),
                                    child: Image.asset(
                                        "assets/images/img_phone_theme.png"),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4, top: 2),
                                    child: CustomText.CustomRegularText(
                                        "call",
                                        myColors.grey_fourteen,
                                        FontWeight.w400,
                                        10,
                                        1,
                                        TextAlign.center),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      status_assigned = "contact";
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      margin: EdgeInsets.only(left: 2, top: 6),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: myColors.app_theme),
                                        color: status_assigned == "contact"
                                            ? myColors.app_theme
                                            : myColors.blue_lightest,
                                      ),
                                      child: Image.asset(
                                        "assets/images/check_circle_white.png",
                                        color: status_assigned == "contact"
                                            ? myColors.white
                                            : myColors.app_theme,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: CustomText.CustomRegularText(
                                        "contact",
                                        myColors.grey_fourteen,
                                        FontWeight.w400,
                                        10,
                                        1,
                                        TextAlign.center),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      status_assigned = "start";
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      margin: EdgeInsets.only(left: 4, top: 6),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: myColors.app_theme),
                                        color: status_assigned == "start"
                                            ? myColors.app_theme
                                            : myColors.blue_lightest,
                                      ),
                                      child: Image.asset(
                                        "assets/images/img_play_theme.png",
                                        color: status_assigned == "start"
                                            ? myColors.white
                                            : myColors.app_theme,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4, top: 2),
                                    child: CustomText.CustomRegularText(
                                        "start",
                                        myColors.grey_fourteen,
                                        FontWeight.w400,
                                        10,
                                        1,
                                        TextAlign.center),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      status_assigned = "finish";
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      margin: EdgeInsets.only(left: 4, top: 6),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: myColors.app_theme),
                                        color: status_assigned == "finish"
                                            ? myColors.app_theme
                                            : myColors.blue_lightest,
                                      ),
                                      child: Image.asset(status_assigned ==
                                              "finish"
                                          ? "assets/images/img_finished_white.png"
                                          : "assets/images/img_finished_red.png"),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4, top: 2),
                                    child: CustomText.CustomRegularText(
                                        "finish",
                                        myColors.grey_fourteen,
                                        FontWeight.w400,
                                        10,
                                        1,
                                        TextAlign.center),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      status_assigned = "scan";
                                      setState(() {});

                                      ///Comment....
                                     /* String barcodeScanRes =
                                          await FlutterBarcodeScanner
                                              .scanBarcode("#ff6666", 'Cancel',
                                                  true, ScanMode.QR);*/
                                    },
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      margin: EdgeInsets.only(left: 4, top: 6),
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: myColors.app_theme),
                                      ),
                                      child: Image.asset(
                                          "assets/images/img_scanner_blue.png"),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4, top: 2),
                                    child: CustomText.CustomRegularText(
                                        "scan",
                                        myColors.grey_fourteen,
                                        FontWeight.w400,
                                        10,
                                        1,
                                        TextAlign.center),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///1...........
                  Container(
                    height: 34,
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 4),
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: myColors.grey_white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Center(
                                    child: Image.asset(
                                  "assets/images/img_check_greeen.png",
                                  height: 16,
                                  width: 16,
                                )),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 8),
                                child: CustomText.CustomMediumText(
                                    "Contacted ",
                                    myColors.dark_grey_txt,
                                    FontWeight.w500,
                                    12,
                                    1,
                                    TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          child: CustomText.CustomMediumText(
                              " 03-july-2020 1:53 ",
                              myColors.dark_grey_txt,
                              FontWeight.w500,
                              12,
                              1,
                              TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  ///2...........
                  Container(
                    height: 34,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: myColors.grey_white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Center(
                                    child: Image.asset(
                                  "assets/images/img_play_green.png",
                                  height: 16,
                                  width: 16,
                                )),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 8),
                                child: CustomText.CustomMediumText(
                                    "Started",
                                    myColors.dark_grey_txt,
                                    FontWeight.w500,
                                    12,
                                    1,
                                    TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          child: CustomText.CustomMediumText(
                              " 03-july-2020 1:53 ",
                              myColors.dark_grey_txt,
                              FontWeight.w500,
                              12,
                              1,
                              TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  ///3...........
                  Container(
                    height: 34,
                    margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: myColors.grey_white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Center(
                                    child: Image.asset(
                                  "assets/images/img_finished_red.png",
                                  height: 16,
                                  width: 16,
                                )),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 8),
                                child: CustomText.CustomMediumText(
                                    "Finished",
                                    myColors.dark_grey_txt,
                                    FontWeight.w500,
                                    12,
                                    1,
                                    TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          child: CustomText.CustomMediumText(
                              " 03-july-2020 1:53 ",
                              myColors.dark_grey_txt,
                              FontWeight.w500,
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
    );
  }
}
