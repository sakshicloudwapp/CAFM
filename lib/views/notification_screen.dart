import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/model/models/GetNotificationWorkOrdersModel.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../global/my_string.dart';
import '../model/models/GetWorkModel.dart';
import '../widgets/custom_texts.dart';

class NotifiicationScreen extends StatefulWidget {
  List<GetNotificationWorkOrdersModel>? getworklist;
  NotifiicationScreen({Key? key, this.getworklist}) : super(key: key);

  @override
  _NotifiicationScreenState createState() => _NotifiicationScreenState();
}

class _NotifiicationScreenState extends State<NotifiicationScreen> {
  List<GetNotificationWorkOrdersModel> _searchResult = [];
  TextEditingController searchcontroller = TextEditingController();
  final searchfocus = FocusNode();

  @override
  void initState() {
    setdata();
    super.initState();
  }

  setdata(){
    widget.getworklist!.sort((a, b) {
      return b.securityInfoId.toString().toLowerCase().compareTo(a.securityInfoId.toString().toLowerCase());
    });
    if(widget.getworklist!.isNotEmpty){

    }
    this.setState(() {});
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
                                    MyString.Notifications,
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
              children: [
                //Notification view all................................................................................................................................................................................................
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(24, 24, 0, 0),
                      alignment: Alignment.topLeft,
                      child: CustomText.CustomBoldText(
                          MyString.Notifications,
                          myColors.grey_one,
                          FontWeight.w600,
                          16,
                          1,
                          TextAlign.center),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(24, 24, 16, 0),
                        alignment: Alignment.topLeft,
                        child: CustomText.CustomMediumText(
                            MyString.Clear_All,
                            myColors.dark_blue2,
                            FontWeight.w500,
                            13,
                            1,
                            TextAlign.center),
                      ),
                    ),
                  ],
                ),


                //Search...................................................................................................................
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  padding: EdgeInsets.fromLTRB(16, 7, 16, 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: myColors.bg_txtfield,
                  ),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 30,
                        child: SvgPicture.asset(
                          "assets/images/search.svg",
                        ),
                      ),

                      /// Search textfield.......
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: searchcontroller,
                          focusNode: searchfocus,
                          onChanged: onSearchTextChanged,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily:
                            'assets/fonts/DM_Sans/DMSans-Regular.ttf',
                            color: myColors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: MyString.Search,
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: myColors.txt_txtfield,
                                fontFamily:
                                "assets/fonts/DM_Sans/DMSans-Regular.ttf"),
                            counter: Offstage(),
                            isDense: true,
                            // this will remove the default content padding
                            contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                          ),
                          maxLines: 1,
                          cursorColor: myColors.black,
                        ),
                      ),
                    ],
                  ),
                ),


                //Notification list 2............................................................................................
               widget.getworklist!.isNotEmpty?
               Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child:
                    _searchResult.length != 0 || searchcontroller.text.isNotEmpty
                        ?
                    _searchResult.isNotEmpty ?
                    ListView.builder(
                        itemCount: _searchResult.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: listwidget(_searchResult[index], index),
                          );
                        })
                        :Container(
                      margin: EdgeInsets.only(top: mediaQuerryData.size.height * 0.13),
                      child: CustomLoader.SearchNotfound(),
                    )
                        :
                    ListView.builder(
                        itemCount: widget.getworklist!.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: listwidget(widget.getworklist![index], index),
                          );
                        }))
                : Container(
                 margin: EdgeInsets.only(top: mediaQuerryData.size.height * 0.15),
                 child: CustomLoader.nodata(),
               ),
              ],
            ),
          ),
        ));
  }



  listwidget(
      GetNotificationWorkOrdersModel model,
      int index) {
    return

      Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: myColors.grey_eight.withOpacity(0.30)),
            color: myColors.white,
            boxShadow: [
              BoxShadow(color: myColors.grey_eight, spreadRadius: 0.3)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText.CustomBoldText(
                      "# ${model.securityInfoId}",
                      myColors.app_theme,
                      FontWeight.w600,
                      14,
                      1,
                      TextAlign.start),
                  Row(
                    children: [
                      CustomText.CustomMediumText("Status", myColors.grey_30,
                          FontWeight.w500, 13, 1, TextAlign.start),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          //  border: Border.all(color: myColors.app_theme.withOpacity(0.30)),
                          color: myColors.app_theme,

                          boxShadow: [
                            BoxShadow(
                                color:
                                model.workStatusName.toString() == "Completed"? myColors.green:
                                model.workStatusName.toString() == "Started"? myColors.green:
                                model.workStatusName.toString() == "Rejected"? myColors.red:
                                model.workStatusName.toString() == "Viewed"? myColors.view_color:
                                myColors.app_theme,
                                spreadRadius: 0.3)
                          ],
                        ),
                        child: CustomText.CustomMediumText(
                            model.workStatusName.toString(),
                            myColors.white,
                            FontWeight.w500,
                            10,
                            1,
                            TextAlign.start),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            // currentindex = index;
                            //
                            // ishide[index] = !ishide[index];

                            setState(() {});
                          },
                          child: Container(
                              width: 30,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/images/ic_arrow_down_grey.svg",
                                ),
                              )))
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 4,
            ),

            Container(
              height: 1.5,
              decoration: BoxDecoration(color: myColors.grey_two),
            ),
            //ishide[index] == true ?
            SizedBox(
              height: 5,
            ),
            //:
            // visible:ishide[index],
            Container(),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // taskid = model.id.toString();
                // setState(() {});
                // updatetaskApi(model.id.toString(),widget.title == "Soft Services PM W/O" ?"${model.buildingName}" :"${model.buildingName}  |  ${model.floorName}  ${model.unitName} ${model.roomName} ",widget.title == "Soft Services PM W/O" ?"${model.buildingName}":"",model.workStatusId.toString());

              },
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    rowtext(
                        "Location : ",
                        "${model.buildingName}  |  ${model.floorName}  ${model.unitName} ${model.roomName}  ",
                        model.workStatusId.toString(),
                        model),
                    SizedBox(
                      height: 10,
                    ),
                    rowtext("Problem :  ", "${model.problem}",
                        model.workStatusId.toString(), model),
                    SizedBox(
                      height: 10,
                    ),

                    rowtext(
                        "Reported Date : ",
                        "${DateFormat.d().format(DateTime.parse(model.reportedDate.toString()))} ${DateFormat.yMMM().format(DateTime.parse(model.reportedDate.toString()))}, ${DateFormat("HH:mm:ss").format(DateTime.parse(model.reportedDate.toString()))}",
                        model.workStatusId.toString(),
                        model),
                    SizedBox(
                      height: 10,
                    ),
                    rowtext(
                        "Due Date : ",
                        "${DateFormat.d().format(DateTime.parse(model.dueDate.toString()))} ${DateFormat.yMMM().format(DateTime.parse(model.dueDate.toString()))}, ${DateFormat("HH:mm:ss").format(DateTime.parse(model.dueDate.toString()))}",
                        model.workStatusId.toString(),
                        model),
                    //

                  ],
                ),
              ),
            )
          ],
        ),
      );
  }

  rowtext(String title, String des, String workStatusId, GetNotificationWorkOrdersModel model) {
    return Container(
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.CustomMediumText(
              title, myColors.grey_30, FontWeight.w500, 12, 1, TextAlign.start),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                des,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: myColors.grey_eight,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  wordSpacing: 0.1,
                  fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }


  a_to_zFilter(){
    widget.getworklist!.sort((a, b) {
      return a.problem.toString().toLowerCase().compareTo(b.problem.toString().toLowerCase());
    });
    setState(() {});
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    print("text<<<${text}");
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _searchResult.clear();
    widget.getworklist!.forEach((userDetail) {
      print("text<<<${text}");
      print(
          "text<<<${userDetail.securityInfoId.toString().split(":")[1].toString()}");
      if (userDetail.securityInfoId
          .toString()
          .toUpperCase()
          .contains(text.toUpperCase()) ||
          userDetail.securityInfoId
              .toString()
              .toUpperCase()
              .contains(text.toUpperCase()) ||
          userDetail.securityInfoId
              .toString()
              .toUpperCase()
              .contains(text.toUpperCase()) ||
          userDetail.reportedDate
              .toString()
              .toUpperCase()
              .contains(text.toUpperCase()) ||
          userDetail.dueDate
              .toString()
              .toUpperCase()
              .contains(text.toUpperCase()) ||
          userDetail.buildingName
              .toString()
              .toUpperCase()
              .contains(text.toUpperCase()) ||
          userDetail.floorName
              .toString()
              .toUpperCase()
              .contains(text.toUpperCase()) ||
          userDetail.unitName
              .toString()
              .toUpperCase()
              .contains(text.toUpperCase()) ||
          userDetail.roomName
              .toString()
              .toUpperCase()
              .contains(text.toUpperCase())) _searchResult.add(userDetail);
    });
    print("_searchResult<<<${_searchResult.length}");
    setState(() {});
  }
}
///Notification 2 List............................................................................................................
class NotificationTwoList extends StatefulWidget {
  int index;

  NotificationTwoList({Key? key, required this.index}) : super(key: key);

  @override
  _NotificationTwoListState createState() => _NotificationTwoListState();
}

class _NotificationTwoListState extends State<NotificationTwoList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 60,
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Container(
                  child: CustomText.CustomLightText("12", myColors.grey_one,
                      FontWeight.w400, 30, 1, TextAlign.center),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: CustomText.CustomLightText("sep", myColors.grey_one,
                      FontWeight.w300, 12, 1, TextAlign.center),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: myColors.bg_border_blue),
                color: myColors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: myColors.bg_grey),
                        child: Image.asset(
                          "assets/images/img_notification2.png",
                          height: 20,
                          width: 22,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: CustomText.CustomSemiBoldText(
                                    "Status Update",
                                    myColors.grey_one,
                                    FontWeight.w600,
                                    12,
                                    1,
                                    TextAlign.center),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: CustomText.CustomRegularText(
                                    "3:45 PM",
                                    myColors.grey_two,
                                    FontWeight.w400,
                                    10,
                                    1,
                                    TextAlign.center),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                    child: CustomText.CustomLightText(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do dolor sit amet, consectetur adipiscing elit, sed do .",
                        myColors.grey_one,
                        FontWeight.w300,
                        12,
                        2,
                        TextAlign.center),
                  ),

                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}