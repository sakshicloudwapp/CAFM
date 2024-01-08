import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';

import '../../global/my_string.dart';
import '../../widgets/custom_texts.dart';

class PPM_Meter_Reading_Screen extends StatefulWidget {

  const PPM_Meter_Reading_Screen({Key? key}) : super(key: key);

  @override
  _PPM_Meter_Reading_ScreenState createState() => _PPM_Meter_Reading_ScreenState();
}

class _PPM_Meter_Reading_ScreenState extends State<PPM_Meter_Reading_Screen> {
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
                                  MyString.Meter_Readings,
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

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: CustomText.CustomSemiBoldText(MyString.Meter_Readings,
                    myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
              ),

              ///Form 1.............................................
              Container(
                height: 145,
                margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: myColors.app_theme),
                  color: myColors.bg,
                ),
                child: Column(
                  children: [
                    ///Meter No...........................................
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(MyString.Meter_No, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height:25,
                                  margin: EdgeInsets.only(top: 10),
                                  alignment: Alignment.topLeft,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    onChanged: (String value) {
                                      print("TAG" + value);
                                      setState(() {});
                                    },
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,
                                      color: myColors.grey_27,
                                    ),

                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "12345",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: myColors.grey_27,
                                            fontFamily:
                                            MyString.PlusJakartaSansregular,),
                                        isDense: true,
                                        // this will remove the default content padding
                                        contentPadding:
                                        EdgeInsets.fromLTRB(16, 1, 8, 0)),
                                    maxLines: 1,
                                    cursorColor: myColors.grey_26,
                                  ),
                                ),

                                Container(
                                  height: 1,
                                  margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                  color: myColors.grey_27,
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: 27,
                            child: Center(child: Image.asset("assets/images/img_scanner.png",height: 22,width: 26,)),
                          ),
                        ],
                      ),
                    ),

                    ///Meter Type...........................................
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(MyString.Meter_Type, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height:25,
                                  margin: EdgeInsets.only(top: 10),
                                  alignment: Alignment.topLeft,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    onChanged: (String value) {
                                      print("TAG" + value);
                                      setState(() {});
                                    },
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,
                                      color: myColors.grey_27,
                                    ),

                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Water meter",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: myColors.grey_27,
                                            fontFamily:
                                            MyString.PlusJakartaSansregular,),
                                        isDense: true,
                                        // this will remove the default content padding
                                        contentPadding:
                                        EdgeInsets.fromLTRB(16, 1, 0, 0)),
                                    maxLines: 1,
                                    cursorColor: myColors.grey_26,
                                  ),
                                ),

                                Container(
                                  height: 1,
                                  margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                  color: myColors.grey_27,
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: 27,
                          ),
                        ],
                      ),
                    ),

                    ///Location...........................................
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(MyString.Location, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height:25,
                                  margin: EdgeInsets.only(top: 10),
                                  alignment: Alignment.topLeft,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    onChanged: (String value) {
                                      print("TAG" + value);
                                      setState(() {});
                                    },
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,
                                      color: myColors.grey_27,
                                    ),

                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Building name   |  Cooman area",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: myColors.grey_27,
                                            fontFamily:
                                            MyString.PlusJakartaSansregular,),
                                        isDense: true,
                                        // this will remove the default content padding
                                        contentPadding:
                                        EdgeInsets.fromLTRB(16, 1, 0, 0)),
                                    maxLines: 1,
                                    cursorColor: myColors.grey_26,
                                  ),
                                ),

                                Container(
                                  height: 1,
                                  margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                  color: myColors.grey_27,
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: 27,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

              ///Form 2.............................................
              Container(
                height: 145,
                margin: EdgeInsets.fromLTRB(16, 0, 16,0),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: myColors.app_theme),
                  color: myColors.bg,
                ),
                child: Column(
                  children: [
                    ///Prev Readings...........................................
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 95,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(MyString.Prev_Readings, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height:25,
                                  margin: EdgeInsets.only(top: 10),
                                  alignment: Alignment.topLeft,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    onChanged: (String value) {
                                      print("TAG" + value);
                                      setState(() {});
                                    },
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,
                                      color: myColors.grey_27,
                                    ),

                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "12345",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: myColors.grey_27,
                                            fontFamily:
                                            MyString.PlusJakartaSansregular,),
                                        isDense: true,
                                        // this will remove the default content padding
                                        contentPadding:
                                        EdgeInsets.fromLTRB(12, 1, 0, 0)),
                                    maxLines: 1,
                                    cursorColor: myColors.grey_26,
                                  ),
                                ),

                                Container(
                                  height: 1,
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  color: myColors.grey_27,
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: 27,
                          ),
                        ],
                      ),
                    ),

                    ///Current Readings...........................................
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 95,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(MyString.Current_Readings, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height:25,
                                  margin: EdgeInsets.only(top: 10),
                                  alignment: Alignment.topLeft,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    onChanged: (String value) {
                                      print("TAG" + value);
                                      setState(() {});
                                    },
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,
                                      color: myColors.grey_27,
                                    ),

                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Water meter",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: myColors.grey_27,
                                            fontFamily:
                                            MyString.PlusJakartaSansregular,),
                                        isDense: true,
                                        // this will remove the default content padding
                                        contentPadding:
                                        EdgeInsets.fromLTRB(12, 1, 0, 0)),
                                    maxLines: 1,
                                    cursorColor: myColors.grey_26,
                                  ),
                                ),

                                Container(
                                  height: 1,
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  color: myColors.grey_27,
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: 27,
                          ),
                        ],
                      ),
                    ),

                    ///Date Time...........................................
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 95,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(MyString.date_Time, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height:25,
                                  margin: EdgeInsets.only(top: 10),
                                  alignment: Alignment.topLeft,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    onChanged: (String value) {
                                      print("TAG" + value);
                                      setState(() {});
                                    },
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,
                                      color: myColors.grey_27,
                                    ),

                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "27 Aug  2022 , 00:00:00:00",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: myColors.grey_27,
                                            fontFamily:
                                            MyString.PlusJakartaSansregular,),
                                        isDense: true,
                                        // this will remove the default content padding
                                        contentPadding:
                                        EdgeInsets.fromLTRB(12, 1, 0, 0)),
                                    maxLines: 1,
                                    cursorColor: myColors.grey_26,
                                  ),
                                ),

                                Container(
                                  height: 1,
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  color: myColors.grey_27,
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: 27,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(16, 50, 16, 16),
                child: Image.asset("assets/images/img_mr.png",width: 180,height: 120,),
              ),
            ],
          ),
        ),

        bottomNavigationBar:  InkWell(
          onTap: (){

          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: myColors.app_theme,
            ),
            child: CustomText.CustomBoldText(MyString.SUBMIT, myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
          ),
        ),
      ),
    );
  }
}
