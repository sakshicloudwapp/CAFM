import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/my_string.dart';
import '../../model/models/GetResourceModel.dart';
import '../../model/models/TaskInfoModel.dart';
import '../../widgets/custom_texts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PPM_Summary_Screen extends StatefulWidget {
  List<TaskResourcesModel> taskResourceslist;
  List<ResourcesModel> resourcesModel;
  List<TaskInfoModel> taskModel;
  Function onCallback;
  String tasklogId;
  String finishedDate;
  String title;
  String appbartitle;

  PPM_Summary_Screen({
    Key? key,
    required this.taskResourceslist,
    required this.resourcesModel,
    required this.taskModel,
    required this.onCallback,
    required this.tasklogId,
    required this.title,
    required this.finishedDate,
    required this.appbartitle,
  }) : super(key: key);

  @override
  _PPM_Summary_ScreenState createState() => _PPM_Summary_ScreenState();
}

class _PPM_Summary_ScreenState extends State<PPM_Summary_Screen> {
  String status_assigned = "";
  bool is_checked = false;
  TextEditingController controller = TextEditingController();
  final focusNode = FocusNode();
  List<String> summarylist = [];
  String summary = "";
  String finishdate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setdata();

  }
  setdata(){
    summarylist.clear();
    if (widget.taskModel.isNotEmpty) {
      print(
          "widget.taskModel.first.taskLogInfo!.summary.toString()${widget.taskModel.first.taskLogInfo!.summary.toString()}");
      widget.taskModel.first.taskLogInfo!.summary.toString() == "null"
          ? ""
          : summarylist
          .add(widget.taskModel.first.taskLogInfo!.summary.toString());

      summary = summarylist
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .toString();
      print("summary summary ${summary}");

      final split = summary.split(',');

      print("kv>>${split}");
      // final Map<String, String> pairs = {};
      summarylist.clear();
      setState(() {});
      for (int i = 0; i < split.length; i++) {
        summarylist.add(split[i]);
      }
      setState(() {});
    } else {}
    if( widget.taskResourceslist.isNotEmpty){
      finishdate = widget.taskResourceslist.first.finishedDate.toString();
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
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: myColors.app_theme,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
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
                                  "Summary",
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            focusNode.unfocus();
            setState(() {});
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: CustomText.CustomSemiBoldText(MyString.Summary,
                      myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
                ),

                //Summary Textfield............................................................................................
                Container(
                  height: 120,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: myColors.border_txtfield),
                    borderRadius: BorderRadius.circular(10),
                    color: myColors.bg_txtfield,
                  ),
                  child: TextField(
                    // readOnly: widget.finishedDate == "null" ? false:true ,
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    focusNode: focusNode,
                    onChanged: (String value) {
                      print("TAG" + value);
                      setState(() {});
                    },
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
                      color: myColors.txt_txtfield,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        // hintText: MyString.Summary,
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: myColors.txt_txtfield,
                            fontFamily:
                            "assets/fonts/Poppins/Poppins-Regular.ttf"),
                        counter: Offstage(),
                        isDense: true,
                        // this will remove the default content padding
                        contentPadding: EdgeInsets.fromLTRB(16, 8, 8, 0)),
                    maxLines: 5,
                    cursorColor: myColors.black,
                  ),
                ),

                ///Date Time...................................................
                /*   Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: CustomText.CustomSemiBoldText(MyString.Date_Time,
                      myColors.black, FontWeight.w400, 12, 1, TextAlign.center),
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: myColors.border_txtfield),
                    borderRadius: BorderRadius.circular(10),
                    color: myColors.bg_txtfield,
                  ),
                  child: CustomText.CustomSemiBoldText(
                      widget.taskModel.isNotEmpty
                          ? "${DateFormat.d().format(DateTime.parse(widget.taskModel.first.taskLogInfo!.reportedDate.toString()))}"
                          " ${DateFormat.yMMM().format(DateTime.parse(widget.taskModel.first.taskLogInfo!.reportedDate.toString()))}"
                          ", ${DateFormat("hh:mm:ss").format(DateTime.parse(widget.taskModel.first.taskLogInfo!.reportedDate.toString()))}"
                          : "",
                      myColors.grey_eighteen,
                      FontWeight.w400,
                      12,
                      1,
                      TextAlign.center),
                ),*/

                ///................................
                widget.taskResourceslist.isEmpty
                    ? Container()
                    : Visibility(
                  visible: false,
                  child: Container(
                      margin: EdgeInsets.only(
                          left: 0, right: 0, top: 30, bottom: 20),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          //  physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.taskResourceslist.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 10,
                                    bottom: 0),
                                child: Container(
                                  height: 148,
                                  padding:
                                  EdgeInsets.fromLTRB(12, 16, 12, 12),
                                  //  margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                      border: Border.all(
                                          color: myColors.orange),
                                      color: myColors.light_orange),
                                  child: Column(
                                    children: [
                                      ///User info...........
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 52,
                                            height: 52,
                                            child: CircleAvatar(
                                              maxRadius: 60,
                                              child: widget.resourcesModel
                                                  .isEmpty
                                                  ? ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      100),
                                                  child: Image.asset(
                                                    "assets/images/user_img.png",
                                                    fit: BoxFit.cover,
                                                    height: 100,
                                                  ))
                                                  : ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    100),
                                                child: widget
                                                    .resourcesModel
                                                    .first
                                                    .imageUrl ==
                                                    null
                                                    ? Image.asset(
                                                  "assets/images/user_img.png",
                                                  height: 100,
                                                )
                                                    : Image.network(
                                                  widget
                                                      .resourcesModel
                                                      .first
                                                      .imageUrl
                                                      .toString(),
                                                  fit: BoxFit
                                                      .cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  12, 0, 0, 0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Container(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child: CustomText
                                                          .CustomMediumText(
                                                          "${widget.taskResourceslist[index].resourceName.toString()}",
                                                          myColors
                                                              .dark_grey_txt,
                                                          FontWeight
                                                              .w500,
                                                          14,
                                                          1,
                                                          TextAlign
                                                              .center)),
                                                  Container(
                                                      padding: EdgeInsets
                                                          .fromLTRB(0, 5,
                                                          0, 0),
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child: CustomText
                                                          .CustomMediumText(
                                                          "${widget.taskResourceslist[index].designation.toString()}",
                                                          myColors
                                                              .app_theme,
                                                          FontWeight
                                                              .w500,
                                                          12,
                                                          1,
                                                          TextAlign
                                                              .center)),
                                                  Container(
                                                      padding: EdgeInsets
                                                          .fromLTRB(0, 3,
                                                          0, 0),
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child: CustomText.CustomMediumText(
                                                          widget.resourcesModel
                                                              .isNotEmpty
                                                              ? widget
                                                              .resourcesModel
                                                              .first
                                                              .email
                                                              .toString()
                                                              : "",
                                                          myColors
                                                              .grey_eight,
                                                          FontWeight.w400,
                                                          12,
                                                          1,
                                                          TextAlign
                                                              .center)),
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
                                                  decoration:
                                                  BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius
                                                            .circular(
                                                            50)),
                                                    color: myColors
                                                        .active_green,
                                                  ),
                                                ),
                                                Container(
                                                    width: 35,
                                                    padding:
                                                    EdgeInsets.only(
                                                        left: 4),
                                                    child: CustomText.CustomMediumText(
                                                        widget.resourcesModel
                                                            .isNotEmpty
                                                            ? widget
                                                            .resourcesModel[
                                                        0]
                                                            .status
                                                            .toString()
                                                            : "",
                                                        myColors
                                                            .active_green,
                                                        FontWeight.w500,
                                                        10,
                                                        1,
                                                        TextAlign
                                                            .center)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      ///Call whatsapp.......
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 12, left: 8, right: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: 28,
                                                        height: 28,
                                                        margin: EdgeInsets
                                                            .only(
                                                            left: 0,
                                                            top: 6),
                                                        padding:
                                                        EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .all(Radius
                                                              .circular(
                                                              5)),
                                                          border: Border.all(
                                                              color: myColors
                                                                  .app_theme),
                                                        ),
                                                        child: Image.asset(
                                                            "assets/images/img_whatsapp_theme.png"),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .only(top: 2),
                                                        child: CustomText
                                                            .CustomRegularText(
                                                            "sms",
                                                            myColors
                                                                .grey_fourteen,
                                                            FontWeight
                                                                .w400,
                                                            10,
                                                            1,
                                                            TextAlign
                                                                .center),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: 28,
                                                        height: 28,
                                                        margin: EdgeInsets
                                                            .only(
                                                            left: 4,
                                                            top: 6),
                                                        padding:
                                                        EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .all(Radius
                                                              .circular(
                                                              5)),
                                                          border: Border.all(
                                                              color: myColors
                                                                  .app_theme),
                                                        ),
                                                        child: Image.asset(
                                                            "assets/images/img_phone_theme.png"),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .only(
                                                            left: 4,
                                                            top: 2),
                                                        child: CustomText
                                                            .CustomRegularText(
                                                            "call",
                                                            myColors
                                                                .grey_fourteen,
                                                            FontWeight
                                                                .w400,
                                                            10,
                                                            1,
                                                            TextAlign
                                                                .center),
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
                                                          status_assigned =
                                                          "contact";
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          width: 28,
                                                          height: 28,
                                                          margin: EdgeInsets
                                                              .only(
                                                              left: 2,
                                                              top: 6),
                                                          padding:
                                                          EdgeInsets
                                                              .all(5),
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                            border: Border.all(
                                                                color: myColors
                                                                    .app_theme),
                                                            color: status_assigned ==
                                                                "contact"
                                                                ? myColors
                                                                .app_theme
                                                                : myColors
                                                                .blue_lightest,
                                                          ),
                                                          child:
                                                          Image.asset(
                                                            "assets/images/check_circle_white.png",
                                                            color: status_assigned ==
                                                                "contact"
                                                                ? myColors
                                                                .white
                                                                : myColors
                                                                .app_theme,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .only(top: 2),
                                                        child: CustomText
                                                            .CustomRegularText(
                                                            "contact",
                                                            myColors
                                                                .grey_fourteen,
                                                            FontWeight
                                                                .w400,
                                                            10,
                                                            1,
                                                            TextAlign
                                                                .center),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          status_assigned =
                                                          "start";
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          width: 28,
                                                          height: 28,
                                                          margin: EdgeInsets
                                                              .only(
                                                              left: 4,
                                                              top: 6),
                                                          padding:
                                                          EdgeInsets
                                                              .all(4),
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                            border: Border.all(
                                                                color: myColors
                                                                    .app_theme),
                                                            color: status_assigned ==
                                                                "start"
                                                                ? myColors
                                                                .app_theme
                                                                : myColors
                                                                .blue_lightest,
                                                          ),
                                                          child:
                                                          Image.asset(
                                                            "assets/images/img_play_theme.png",
                                                            color: status_assigned ==
                                                                "start"
                                                                ? myColors
                                                                .white
                                                                : myColors
                                                                .app_theme,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .only(
                                                            left: 4,
                                                            top: 2),
                                                        child: CustomText
                                                            .CustomRegularText(
                                                            "start",
                                                            myColors
                                                                .grey_fourteen,
                                                            FontWeight
                                                                .w400,
                                                            10,
                                                            1,
                                                            TextAlign
                                                                .center),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          status_assigned =
                                                          "finish";
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          width: 28,
                                                          height: 28,
                                                          margin: EdgeInsets
                                                              .only(
                                                              left: 4,
                                                              top: 6),
                                                          padding:
                                                          EdgeInsets
                                                              .all(4),
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                            border: Border.all(
                                                                color: myColors
                                                                    .app_theme),
                                                            color: status_assigned ==
                                                                "finish"
                                                                ? myColors
                                                                .app_theme
                                                                : myColors
                                                                .blue_lightest,
                                                          ),
                                                          child: Image.asset(status_assigned ==
                                                              "finish"
                                                              ? "assets/images/img_finished_white.png"
                                                              : "assets/images/img_finished_red.png"),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .only(
                                                            left: 4,
                                                            top: 2),
                                                        child: CustomText
                                                            .CustomRegularText(
                                                            "finish",
                                                            myColors
                                                                .grey_fourteen,
                                                            FontWeight
                                                                .w400,
                                                            10,
                                                            1,
                                                            TextAlign
                                                                .center),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          status_assigned =
                                                          "scan";
                                                          setState(() {});

                                                          /// comment.......
                                                          /* String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                                "#ff6666",
                                                'Cancel',
                                                true,
                                                ScanMode.QR);*/
                                                        },
                                                        child: Container(
                                                          width: 28,
                                                          height: 28,
                                                          margin: EdgeInsets
                                                              .only(
                                                              left: 4,
                                                              top: 6),
                                                          padding:
                                                          EdgeInsets
                                                              .all(6),
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                            border: Border.all(
                                                                color: myColors
                                                                    .app_theme),
                                                          ),
                                                          child: Image.asset(
                                                              "assets/images/img_scanner_blue.png"),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .only(
                                                            left: 4,
                                                            top: 2),
                                                        child: CustomText
                                                            .CustomRegularText(
                                                            "scan",
                                                            myColors
                                                                .grey_fourteen,
                                                            FontWeight
                                                                .w400,
                                                            10,
                                                            1,
                                                            TextAlign
                                                                .center),
                                                      ),
                                                    ],
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
                            );
                          })),
                ),

                SizedBox(
                  height: 20,
                ),
                summarylist.isEmpty ||
                    summary == "" ||
                    summary.isEmpty ||
                    summary.toString() == "null"
                    ? Container()
                    : Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(16, 10, 16, 20),
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: myColors.border_txtfield),
                      borderRadius: BorderRadius.circular(10),
                      color: myColors.bg_txtfield,
                    ),
                    child:
                    /*  Text(
                          summary,
                           style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily:
                            'assets/fonts/Poppins/Poppins-Regular.ttf',
                            color: myColors.txt_txtfield,
                          ),
                        ),*/
                    /* summarylist.isEmpty ? Container() :
                        ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: summarylist.length,
                            itemBuilder: (contex, int index) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                                child: Text(
                                  summarylist[index].trim()+",",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                        'assets/fonts/Poppins/Poppins-Regular.ttf',
                                    color: myColors.txt_txtfield,
                                  ),
                                ),
                              );
                            }),
                      )*/
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                      child: Text(
                        summary,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily:
                          'assets/fonts/Poppins/Poppins-Regular.ttf',
                          color: myColors.txt_txtfield,
                        ),
                      ),
                    )),
                //: Container(),

                ///Checkbox Update  to Customer...................
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: InkWell(
                    onTap:widget.finishedDate == "null"? (){
                      if (is_checked == true) {
                        is_checked = false;
                      } else {
                        is_checked = true;
                      }
                      setState(() {});
                    }:(){},
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            is_checked == true
                                ? "assets/new_images/check-box.png"
                                : "assets/new_images/unchecked.png",
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        CustomText.CustomRegularText(
                            MyString.Update_to_Customer,
                            myColors.black,
                            FontWeight.w400,
                            14,
                            1,
                            TextAlign.center)
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 150),
                  child: InkWell(
                    onTap:
                    finishdate == "null"? () async {
                      focusNode.unfocus();

                      print(
                          "summarylist${widget.taskModel.first.taskLogInfo!.assetName}");
                      if (controller.text.trim().isEmpty) {
                        CustomToast.showToast(msg: "Please enter summary");
                      } else {
                        if (is_checked == true) {
                          addcustomerEmailApi();
                        } else {}
                        setState(() {});
                        await RequestAddOrUpdateTaskLog(context,
                            widget.title == "Soft Services PM W/O" ? "schedule" : "");
                      }
                    }:(){},
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 70),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: myColors.app_theme,
                      ),
                      child: CustomText.CustomBoldText(MyString.UPDATE, myColors.white,
                          FontWeight.w700, 14, 1, TextAlign.center),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

       /* bottomNavigationBar: InkWell(
          onTap: () async {
            print("summary>>${summary}");
            print(
                "summarylist ${widget.taskModel.first.taskLogInfo!.assetName}");
            focusNode.unfocus();

            print(
                "summarylist${widget.taskModel.first.taskLogInfo!.assetName}");
            if (controller.text.trim().isEmpty) {
              CustomToast.showToast(msg: "Please enter summary");
            } else {
              if (is_checked == true) {
                addcustomerEmailApi();
              } else {}
              setState(() {});
              await RequestAddOrUpdateTaskLog(context,
                  widget.title == "Soft Services PM W/O" ? "schedule" : "");
            }
          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: myColors.app_theme,
            ),
            child: CustomText.CustomBoldText(MyString.UPDATE, myColors.white,
                FontWeight.w700, 14, 1, TextAlign.center),
          ),
        ),*/
      ),
    );
  }

  addcustomerEmailApi() async {
    await Webservices.RequestCustomerEmailNotificarion(
        context, false, widget.tasklogId, controller.text);
    setState(() {});
  }

  Future<void> RequestAddOrUpdateTaskLog(
      BuildContext context, String status) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    print(
        "urlhjhk  >>${status == "4" ? main_base_url + AllApiServices.scheduleapi + AllApiServices.AddOrUpdateTaskLog : main_base_url + AllApiServices.base_name_PPmApi + AllApiServices.AddOrUpdateTaskLog}");
    CustomLoader.showAlertDialog(context, true);
    DateTime dateTime = DateTime.now();
    var request = {};
    if (widget.taskModel.isEmpty) {
    } else {
      var date = DateFormat.d().format(DateTime.parse(
          dateTime.toUtc().add(Duration(hours: 4)).toString())) +
          "-" +
          DateFormat.MMM().format(DateTime.parse(
              dateTime.toUtc().add(Duration(hours: 4)).toString())) +
          "-" +
          DateFormat.y().format(DateTime.parse(
              dateTime.toUtc().add(Duration(hours: 4)).toString())) +
          " " +
          DateFormat("HH:mm").format(DateTime.parse(
              dateTime.toUtc().add(Duration(hours: 4)).toString()));
      setState(() {});

      var username = p.getString("name").toString() == "null" || p.getString("name").toString().trim().isEmpty ? p.getString("user_name") : p.getString("name");
      print(
          "username ${status} ${widget.taskModel.first.taskLogInfo!.summary}");
      setState(() {});

      summarylist
          .add(date + " : " + username.toString() + " - " + controller.text);
      if (widget.taskModel.first.taskLogInfo!.summary.toString() == "null") {
        summary = "${date + " : " + username.toString() + " (MOB)" + " - " + controller.text}";
      }else{
        summary = "${date +" : "+username.toString()+" (MOB)"+" - "+controller.text},\n${widget.taskModel.first.taskLogInfo!.summary}";
      }

      widget.taskModel.first.taskLogInfo!.summary = summary;
      summary = widget.taskModel.first.taskLogInfo!.summary.toString() == "null"
          ? ""
          : widget.taskModel.first.taskLogInfo!.summary.toString();

      setState(() {});
      try {
        final response = await http.post(
            Uri.parse(status == "4"
                ? main_base_url +
                AllApiServices.scheduleapi +
                AllApiServices.UpdateTaskLog
                : main_base_url +
                AllApiServices.base_name_PPmApi +
                AllApiServices.AddOrUpdateTaskLog
            ),
            body: convert.jsonEncode(widget.taskModel.first.taskLogInfo!),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${p.getString("access_token")}'
            });
        print('Request>>> : ${request}');
        print('AddOrUpdateTaskLog response : ${response.body}');

        if (response.statusCode == 200) {
          CustomLoader.showAlertDialog(context, false);
          print('AddOrUpdateTaskLog ${response.body}');
          controller.clear();
        }
      } catch (e) {
        CustomLoader.showAlertDialog(context, false);
        print(e);
        throw Exception('AddOrUpdateTaskLog error ${e.toString()}');
      }
      return;
    }
  }
}
