import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:fm_pro/widgets/custom_texts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/models/AnnoucementsResponse.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  bool is_nodata = false;
  String status = "Notice";
  int? current_index;
  List<AnnouncementModel> announcementlist = [];

  List<String> titlelist = ["Important notice", "Reminder", "Notice"];

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getannouncementApi();
    });
  }

  getannouncementApi() async {
    announcementlist.clear();
    setState(() {});
    await Webservices.RequestAnnouncements(context, false, announcementlist);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MediaQuery(
        data: data.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              backgroundColor: myColors.app_theme,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  if (status == "Notice Detail") {
                    status = "Notice";
                    setState(() {});
                  } else if (status == "Pay") {
                    status = "Notice Detail";
                  } else if (status == "Warning") {
                    status = "Pay";
                  }
                  else {
                    CustomNavigator.popNavigate(context);
                  }
                },
                icon: Container(
                    child: Icon(
                      Icons.arrow_back_ios, color: myColors.white, size: 23,)
                  //SvgPicture.asset("assets/icons/arrow_left.svg",color: myColors.white,)
                ),
              ),
              title: Text(
                "Announcements",
                style: TextStyle(
                    color: myColors.white,
                    fontSize: 15,
                    fontFamily: MyString.PlusJakartaSansBold,
                    fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 28,
                      width: 28,
                      child: SvgPicture.asset("assets/icons/search.svg")),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 28,
                      width: 28,
                      child:
                      SvgPicture.asset("assets/icons/horizontal_filter.svg")),
                )
              ],
            ),
          ),
          body: Container(
            child: SingleChildScrollView(
              child:  announcementlist.isEmpty?Container(
                margin: EdgeInsets.only(top: 30),
                child: Center(
                  child: Text("No Data Found"),
                ),
              ):
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: List.generate(
                            announcementlist.length,
                                (index) => Container(
                              padding: EdgeInsets.only(right: 10),
                              margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                              width: MediaQuery.of(context).size.width,
                              child: NotificationList(
                                index: index,
                                model:
                                announcementlist[index],
                              ),
                            )),
                      ))),
                ///  old Design Notices...........
              /*Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  is_nodata != true ?
                  status == "Notice"
                      ? noticelistwidget()
                      :
                  status == "Reminder" || status == "Warning" ||
                      status == "Payment reminder" ?
                  reminder(titlelist[current_index!])
                      : noticeDetail(titlelist[current_index!])
                      :
                  nodatafoundui()
                ],
              ),*/
            ),
          ),
          bottomSheet: status == "Warning" ||
              status == "Payment reminder" ? Container(
            height: 50,
            margin: EdgeInsets.only(left: 25, right: 25, bottom: 50),
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  status = "Pay";
                  if (status == "Pay") {
                    status = "Warning";
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),

                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: myColors.app_theme,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: myColors.app_theme)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(status == "Pay" || status == "Warning"
                          ? "Contact Support "
                          : "Pay", style: TextStyle(color: myColors.white,
                          fontSize: 14,
                          fontFamily: MyString.PlusJakartaSansBold),),
                    ],
                  ),
                ),
              ),
            ),
          )
              : Container(height: 0,),
        )
    );
  }

  noticelistwidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hsized10,
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Dont_forget".tr,
              style: TextStyle(
                  color: myColors.black,
                  fontSize: 14,
                  fontFamily: MyString.PlusJakartaSansBold,
                  fontWeight: FontWeight.w700),
            ),
          ),
          hsized15,
          ListView.builder(
              itemCount: titlelist.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, int index) {
                return GestureDetector(
                  onTap: () {
                    status = "Notice Detail";
                    current_index = index;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child:
                    listWidgetui(titlelist[index], "assets/icons/ic_timer.svg"),
                  ),
                );
              })
        ],
      ),
    );
  }

  listWidgetui(String title, String img) {
    return Container(
      decoration: BoxDecoration(
          color: myColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: myColors.app_theme, width: 0.4),
          boxShadow: [BoxShadow(color: myColors.white, spreadRadius: 2)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title == "Notice"
              ? Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hsized15,
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    "Notice history",
                    style: TextStyle(
                        color: myColors.black,
                        fontFamily: MyString.PlusJakartaSansSemibold,
                        fontSize: 16),
                  ),
                ),
                hsized15,
                Container(
                  height: 0.4,
                  color: myColors.grey_one,
                ),
              ],
            ),
          )
              : Container(),
          hsized15,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Row(
              children: [
                title == "Notice"
                    ? Container()
                    : Material(
                  elevation: 1,
                  color: myColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200)),
                  child: Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: myColors.light_orange2,
                          boxShadow: [
                            BoxShadow(
                                color: myColors.grey_one, spreadRadius: 0.2)
                          ]),
                      child: SvgPicture.asset(img, height: 20,
                        width: 20,
                        color: myColors.dark_orange,)),
                ),
                title == "Notice"
                    ? Container()
                    : SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: myColors.black,
                          fontFamily: MyString.PlusJakartaSansSemibold,
                          fontSize: 13),
                    ),
                    hsized5,
                    Text("3:45 PM",
                        style: TextStyle(
                            color: myColors.grey_one,
                            fontFamily: MyString.PlusJakartaSansSemibold,
                            fontSize: 12)),
                  ],
                )
              ],
            ),
          ),
          hsized15,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: TextStyle(
                  color: myColors.black,
                  fontFamily: MyString.PlusJakartaSanslight,
                  letterSpacing: 0.2,
                  fontSize: 12.30),
            ),
          ),
          hsized15,
          title == "Notice"
              ? Container()
              : Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Text(
              "More",
              style: TextStyle(
                  color: myColors.dark_orange,
                  fontFamily: MyString.PlusJakartaSansSemibold,
                  fontSize: 12),
            ),
          ),
          hsized5,
        ],
      ),
    );
  }

  nodatafoundui() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/images/frame.png",
              height: 369,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 100),
              alignment: Alignment.center,
              child: Text(
                "There are no new Notices",
                style: TextStyle(
                    color: myColors.black,
                    fontSize: 15,
                    fontFamily: MyString.PlusJakartaSansmedium),
              ))
        ],
      ),
    );
  }

  noticeDetail(String title) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //hsized15,
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: myColors.light_orange3,
            ),
            child: title == "Reminder"
                ? Container(
              height: 250,
              width: double.infinity,
              child: Image.asset(
                "assets/new_images/tree_img.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            )
                : Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Notice",
                    style: TextStyle(
                        color: myColors.black,
                        fontSize: 24,
                        fontFamily: MyString.PlusJakartaSansSemibold),
                  ),
                  hsized15,
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: myColors.grey_one,
                        fontSize: 12,
                        letterSpacing: 0.1,
                        height: 1.4,
                        fontFamily: MyString.PlusJakartaSanslight),
                  )
                ],
              ),
            ),
          ),
          title != "Reminder"
              ? Container()
              : Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Text(
              "Happy Birthday!",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: myColors.black,
                  fontSize: 20,
                  letterSpacing: 0.1,
                  height: 1.4,
                  fontFamily: MyString.PlusJakartaSansBold),
            ),
          ),
          //

          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: myColors.grey_one,
                  fontSize: 12,
                  letterSpacing: 0.1,
                  height: 1.4,
                  fontFamily: MyString.PlusJakartaSansregular),
            ),
          ),

          hsized30,
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                status = "Reminder";
                setState(() {

                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: myColors.light_blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: myColors.app_theme)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/ic_document_download.svg",
                      color: myColors.app_theme,),
                    SizedBox(width: 20,),
                    Text("DOWNLOAD PDF",
                      style: TextStyle(color: myColors.app_theme),),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  reminder(String title) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  hsized30,
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(status == "Payment reminder"
                    ? "assets/icons/ic_payment_reminder.svg"
                    : status == "Pay" || status == "Warning"
                    ? "assets/icons/ic_red_info.svg"
                    : "assets/icons/ic_refresh.svg", height: 35, width: 35,),

                SizedBox(width: 8,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status == "Payment reminder"
                          ? "Payment reminder"
                      :
                      status == "Pay"?
                           "Violation warning" :
                      status == "Warning" ? "Warning": "Reminder",
                      style: TextStyle(
                          color: myColors.black,
                          fontSize: 20,
                          fontFamily: "PlusJakartaSansSemibold"),
                    ),
                    Text(
                      "3:45 PM",
                      style: TextStyle(
                          color: myColors.grey_two,
                          fontSize: 10,
                          fontFamily: MyString.PlusJakartaSansSemibold,),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: myColors.grey_one,
                  fontSize: 12,
                  letterSpacing: 0.1,
                  height: 1.4,
                  fontFamily: MyString.PlusJakartaSansregular),
            ),
          ),

          hsized100,
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (status == "Reminder") {
                  status = "Payment reminder";
                  setState(() {});
                }else if(status =="Payment reminder"){
                  status = "Violation warning";
                  setState(() {});
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: myColors.light_blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: myColors.app_theme)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/ic_document_download.svg",
                      color: myColors.app_theme,),
                    SizedBox(width: 20,),
                    Text("DOWNLOAD PDF",
                      style: TextStyle(color: myColors.app_theme),),
                  ],
                ),
              ),
            ),
          ),

          hsized70,

        ],
      ),
    );
  }
}

///Notification List.....................................................................................................................
class NotificationList extends StatefulWidget {
  int index;
  AnnouncementModel model;

  NotificationList({required this.index, required this.model});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
      margin: EdgeInsets.only(bottom: 8, left: 0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            color: Color.fromRGBO(0, 0, 0, 0.15),
          )
        ],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: myColors.bg_border_blue.withOpacity(0.40)),
        color: myColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: CustomText.CustomSemiBoldText(
                            widget.model.title.toString(),
                            myColors.blue_1,
                            FontWeight.w500,
                            14,
                            1,
                            TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: CustomText.CustomRegularText(
                            widget.model.issueDate.toString() == "null"
                                ? ""
                                : DateFormat('EEEE MMM dd, yyyy')
                                .format(DateTime.parse(widget.model.issueDate.toString())),
                            // "Monday Jan 20 , 2020",
                            myColors.blue_1,
                            FontWeight.w400,
                            10,
                            1,
                            TextAlign.center),
                      ),
                    ],
                  )),
            ],
          ),
          widget.model.content.toString() == "null" ? Container(
            height: 8,
          ):
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
              child: Html(
                shrinkWrap: true,
                data: widget.model.content.toString().trim(),
                style: {
                  "html":Style(
                    // textAlign: TextAlign.left,
                    //  whiteSpace: WhiteSpace.pre,
                      color: myColors.grey_six,
                      fontSize:FontSize.small,
                      fontFamily: "PlusJakartaSansregular"
                  ),
                },
              )
            // CustomText.CustomLightText(
            //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare pretium placerat ut platea. Purus blandit integer sagittis massa vel est hac. ",
            //     myColors.grey_six,
            //     FontWeight.w400,
            //     10,
            //     3,
            //     TextAlign.start),
          ),
        ],
      ),
    );
  }
}