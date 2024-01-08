import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/model/models/GetWorkModel.dart';
import 'package:fm_pro/model/models/SuperViserdResourcesModel.dart';
import 'package:fm_pro/model/models/TaskInfoModel.dart';
import 'package:fm_pro/model/models/TransferWorkordersModel.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/views/tabs_open_workorders_detail_screen.dart';
import 'package:fm_pro/widgets/custom_texts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/my_string.dart';
import '../utils/customLoader.dart';
import 'PPM/ppm_detail_screen.dart';
import 'PPM/ppm_hesq_quitionaire.dart';
import 'PPM/wo_detail_screen.dart';

class TabPpmScreen extends StatefulWidget {
  String statusId;
  String serviceId;
  String title;
  String appbartitle;
  String isBack;
  Function onCallback;

  TabPpmScreen({
    Key? key,
    required this.statusId,
    required this.serviceId,
    required this.title,
    required this.appbartitle,
    required this.isBack,
    required this.onCallback,
  }) : super(key: key);

  @override
  _TabPpmScreenState createState() => _TabPpmScreenState();
}

class _TabPpmScreenState extends State<TabPpmScreen> {
  String selected_icon = "";
  int? currentindex;

  TextEditingController searchcontroller = TextEditingController();
  final searchfocus = FocusNode();

  List<bool> ishide = [false, false, false, false];
  bool loader = false;
  String taskid = "";
  String resourceId = "";
  int? actionId;
  String actionDate = "";
  String comments = "";
  List<TaskResourcesModel> taskResourceslist = [];
  List<GetWorkModel> getworklist = [];
  List<GetWorkModel> getwork_sort_list = [];
  List<HseqListItems> hseqlist = [];
  List<Questions> questionslist = [];
  String questionanswer = "";
  String isBlueCollar = "";

  List<SuperVisedResourcesModel> superviserdresourceslist = [];
  List<TransferWorkordersModel> transferworkorderslist = [];

  List<TaskInfoModel> taskModel = [];
  TaskLogInfo? taskloginfolist;

  @override
  void initState() {
    super.initState();
    getprefences();
    getApi(true);
  }

  getsupervisedResourcesApi() async {
    superviserdresourceslist.clear();
    await Webservices.RequestSuperVisedResources(
        context, superviserdresourceslist);
    setState(() {});
    print("superviserdresourceslist2222>>${superviserdresourceslist.length}");
  }

  onCallBack(String title) {
    _searchResult.clear();
    selected_icon = title;
    setState(() {});
  }

  getApi(bool load) async {
    _searchResult.clear();
    searchcontroller.clear();
    getworklist.clear();

    loader = false;

    setState(() {});
    await Webservices.RequestGetWorkOrders(
        context, getworklist, load, widget.serviceId, widget.statusId);
    loader = false;
    setState(() {});

    getworklist.sort((a, b) {
      return b.securityInfoId
          .toString()
          .toLowerCase()
          .compareTo(a.securityInfoId.toString().toLowerCase());
    });
    if (getworklist.isNotEmpty) {}
    this.setState(() {});
  }

  getApitaskdetail(bool load, String taskLogId, String ProjectId) async {
    print("fgjf");
    taskModel.clear();
    setState(() {});
    await Webservices.RequestGettaskinfodetail(
        context,
        taskModel,
        load,
        taskLogId,
        widget.serviceId,
        ProjectId,
        true,
        widget.title == "Soft Services PM W/O" ? "schedule" : "");
    if (taskModel.isEmpty) {
    } else {
      print("tettet");
      taskloginfolist =
          taskModel.isNotEmpty ? taskModel.first.taskLogInfo : null;
      taskModel.first.taskLogInfo!.onHoldReasonId == null
          ? ""
          : taskModel.first.taskLogInfo!.onHoldReasonId.toString();
      this.setState(() {});

      if (taskModel.first.taskLogInfo!.onHoldReasonId.toString() == "null") {
      } else {}
      setState(() {});
    }
  }

  OnCallBack() {
    _searchResult.clear();
    setState(() {});
    print("dfhjfg");
    getApi(true);
  }

  updatetaskApi(
      String taskId2,
      String location,
      String buildingname,
      String workStatusId,
      String building,
      String roomname,
      String floorname,
      String unitname) async {
    String title = widget.title == "Corrective W/O"
        ? "Corrective W/O"
        : widget.title == "PPM W/O"
            ? "PPM W/O"
            : widget.title == "Reactive W/O"
                ? "Reactive W/O"
                : widget.title == "Soft Services PM W/O"
                    ? "Soft Services PM W/O"
                    : "Soft Services PM W/O";

    if (taskId2 == "") {
    } else {
      await Webservices.RequestUpdateWorkOrders(context, false, taskId2,
          widget.title == "Soft Services PM W/O" ? "schedule" : "");
      // getApi();
      print("getworklist>>>>${widget.serviceId}");

      //Navigator.push(context, MaterialPageRoute(builder: (_) => PPM_HESQ_Quitionaire_Screen(taskId: taskid, onCallback: OnCallBack,)));
    }

    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: WO_Detail_Screen(
        taskLogId: taskId2,
        OnCallback: OnCallback,
        serviceId: widget.serviceId,
        loaction: location,
        buildingname: buildingname,
        title: title,
        workStatusId: workStatusId,
        statusId: widget.statusId,
        appbar_title: widget.appbartitle,
        buildingName: building,
        locationName: roomname,
        floorName: floorname,
        unitName: unitname,
      ),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.fade,
    );
    setState(() {});
  }

  getprefences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isBlueCollar = preferences.getString("isBlueCollar").toString();
    print("isBlueCollar>>${isBlueCollar}");
    setState(() {});
  }

  OnCallback() {
    getApi(false);
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: data,
      child: Scaffold(
        appBar: appbar(),
        body: loader == true
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: CircularProgressIndicator(
                  color: myColors.app_theme,
                )),
              )
            : bodyWidget(),
      ),
    );
  }

  bodyWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 13, bottom: 0),
            child: CustomText.CustomBoldText(
                "All", myColors.black, FontWeight.w600, 15, 1, TextAlign.start),
          ),
          Container(
            margin: EdgeInsets.only(top: 38, bottom: 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  getworklist.isNotEmpty
                      ? _searchResult.length != 0 ||
                              searchcontroller.text.isNotEmpty
                          ?_searchResult.isNotEmpty ?
                  ListView.builder(
                              itemCount: _searchResult.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, int index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child:
                                      listwidget(_searchResult[index], index),
                                );
                              }) : SearchNotfound()

                          : ListView.builder(
                              itemCount: getworklist.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, int index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: listwidget(getworklist[index], index),
                                );
                              })
                      : Container(
                    padding: EdgeInsets.only(top: 150),
                    alignment: Alignment.center,
                          child: Text(
                            "No Workorders",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SearchNotfound(){
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          hsized40,
          Image.asset("assets/images/search_not_found.gif"),

          Text("NO RESULTS",style: TextStyle(color: myColors.app_theme,fontFamily: "PlusJakartaSansBold",fontSize: 16),),
          hsized5,
          Text("We din’t find any search results",style: TextStyle(color: myColors.grey_27,fontFamily: "PlusJakartaSansBold",fontSize: 16),),
        ],
      ),
    );
  }

  listwidget(GetWorkModel model, int index) {
    return
        // model.workStatusName.toString() == "Completed" ||  model.workStatusName.toString() == "Rejected"? Container() :
        Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: myColors.active_twelve),
          color: myColors.white,
          boxShadow: [
            BoxShadow(
                color: myColors.active_twelve,
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 1))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              taskid = model.id.toString();
              updatetaskApi(
                  model.id.toString(),
                  "${model.buildingName}  |  ${model.floorName}  ${model.unitName} ${model.roomName} ",
                  "${model.buildingName}",
                  model.workStatusId.toString(),
                  model.buildingName.toString(),
                  model.roomName.toString(),
                  model.unitName.toString(),
                  model.floorName.toString());
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText.CustomBoldText(
                      "# ${model.securityInfoId}"
                      "",
                      myColors.app_theme,
                      FontWeight.w600,
                      14,
                      1,
                      TextAlign.start),
                  Spacer(),
                  Row(
                    children: [
                      CustomText.CustomMediumText("Status", myColors.grey_30,
                          FontWeight.w500, 13, 1, TextAlign.start),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 80,
                        padding: EdgeInsets.fromLTRB(5, 6, 5, 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            //  border: Border.all(color: myColors.app_theme.withOpacity(0.30)),
                            color: model.workStatusName.toString() ==
                                    "Completed"
                                ? myColors.green_accept
                                : model.workStatusName.toString() == "Started"
                                    ? myColors.green
                                    : model.workStatusName.toString() ==
                                            "Rejected"
                                        ? myColors.red_3
                                        : model.workStatusName.toString() ==
                                                "Viewed"
                                            ? myColors.view_color
                                            : model.workStatusName.toString() ==
                                                    "Accepted"
                                                ? myColors.cyan
                                                : model.workStatusName
                                                            .toString() ==
                                                        "Finished"
                                                    ? myColors.green_accept
                                                    : model.workStatusName
                                                                .toString() ==
                                                            "On Hold"
                                                        ? myColors.onhold_color
                                                        : myColors.app_theme,
                            // model.workStatusId == 2
                            //     ? myColors.green
                            //     : model.workStatusId == 1
                            //         ? model.hasResourceViewed.toString() == "false"
                            //             ? myColors.app_theme
                            //             : myColors.view_color
                            //         : model.workStatusId == 4
                            //             ? myColors.green
                            //             : model.workStatusId == 3
                            //                 ? myColors.red
                            //                 : model.workStatusId == 5
                            //                     ? myColors.green
                            //                     : myColors.view_color,
                            boxShadow: [
                              BoxShadow(
                                color: model.workStatusName.toString() ==
                                        "Completed"
                                    ? myColors.green_accept
                                    : model.workStatusName.toString() ==
                                            "Started"
                                        ? myColors.green
                                        : model.workStatusName.toString() ==
                                                "Rejected"
                                            ? myColors.red_3
                                            : model.workStatusName.toString() ==
                                                    "Viewed"
                                                ? myColors.view_color
                                                : model.workStatusName
                                                            .toString() ==
                                                        "Accepted"
                                                    ? myColors.cyan
                                                    : model.workStatusName
                                                                .toString() ==
                                                            "Finished"
                                                        ? myColors.green_accept
                                                        : model.workStatusName
                                                                    .toString() ==
                                                                "On Hold"
                                                            ? myColors
                                                                .onhold_color
                                                            : myColors
                                                                .app_theme,
                                // spreadRadius: 0.3)
                              )
                            ]),
                        child: CustomText.CustomMediumText(

                            //
                            // model.hasResourceViewed == false ?
                            // model.workStatusId.toString() == "1"?
                            // "New" : model.workStatusId.toString() == "2"? "Accepted" :  model.hasResourceViewed == true ?  model.workStatusId.toString() == "2"? "Accepted" : "" :"" :""
                            //  model.hasResourceViewed == true ?
                            //   model.workStatusId == "2" ?"Accepted":
                            //    model.workStatusId == "1" ?
                            //       // :model.workStatusId == "2" ? "Rejected"
                            // // :  model.workStatusId == "4" ?"Started"
                            //
                            //        "Viewed": "":"" :""

                            // model.hasResourceViewed.toString() == "false"
                            //     ? model.workStatusId == 2
                            //         ? "Accepted"
                            //         : model.workStatusId == 1
                            //             ? "New"
                            //             : model.workStatusId == 4
                            //                 ? "Started"
                            //                 : model.workStatusId == 3
                            //                     ? "Rejected"
                            //                     : model.workStatusId == 5
                            //                         ? "Completed"
                            //                         : ""
                            //     : model.hasResourceViewed.toString() == "true"
                            //         ? model.workStatusId == 2
                            //             ? "Accepted"
                            //             : model.workStatusId == 1
                            //                 ? "Viewed"
                            //                 : model.workStatusId == 4
                            //                     ? "Started"
                            //                     : model.workStatusId == 3
                            //                         ? "Rejected"
                            //                         : model.workStatusId == 5
                            //                             ? "Completed"
                            //                             : ""
                            //         : "",
                            model.workStatusName.toString(),
                            myColors.white,
                            FontWeight.w500,
                            10,
                            1,
                            TextAlign.center),
                      ),
                      SizedBox(
                        width: 2,
                      ),

                      /// Drop down button for expand or collapse

                      /*GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            currentindex = index;

                            model.isHide = !model.isHide ;

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
                              )))*/
                    ],
                  )
                ],
              ),
            ),
          ),
          Visibility(
            // visible: model.isHide,
            child: Column(
              children: [
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
                    taskid = model.id.toString();
                    setState(() {});
                    updatetaskApi(
                        model.id.toString(),
                        "${model.buildingName}  |  ${model.floorName}  ${model.unitName} ${model.roomName} ",
                        "${model.buildingName}",
                        model.workStatusId.toString(),
                        model.buildingName.toString(),
                        model.roomName.toString(),
                        model.unitName.toString(),
                        model.floorName.toString());
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 0, bottom: 10),
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
                            "",
                            // "${DateFormat.d().format(DateTime.parse(model.dueDate.toString()))} ${DateFormat.yMMM().format(DateTime.parse(model.dueDate.toString()))}, ${DateFormat("HH:mm:ss").format(DateTime.parse(model.dueDate.toString()))}",
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  requestContainer(Color color, IconData icon, String status) {
    return Column(
      children: [
        Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Icon(
            icon,
            color: myColors.white,
            size: 19,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        CustomText.CustomSemiBoldText(
            status, color, FontWeight.w600, 12, 1, TextAlign.center),
      ],
    );
  }

  rowtext(String title, String des, String workStatusId, GetWorkModel model) {
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
          title == "Due Date : "
              ? Container(
                  child: Row(
                    children: [
                      /// Accept Button......................
                      workStatusId == "1"
                          ? GestureDetector(
                              onTap: () {
                                taskid = model.id.toString();
                                print("fghjfvj${taskid}");
                                actionId = 2;
                                resourceId = model.resourceId.toString();
                                setState(() {});
                                // print("fghjfvj${actionId}");
                                Future.delayed(Duration.zero, () {
                                  additionalInfoApiCall(false);
                                  setState(() {});
                                });
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/accepctNew_icon.png",
                                      height: 24,
                                      width: 24,
                                    ),
                                    Text(
                                      "Accept",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          fontFamily:
                                              "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                          color: myColors.green_accept),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),

                      SizedBox(
                        width: 0,
                      ),

                      /// Transfer Button.....................
                      /* isBlueCollar == "false" ?
                      workStatusId == "1"
                          ? GestureDetector(
                        onTap: () {
                          taskid = model.id.toString();
                          actionId = 3;
                          resourceId = model.resourceId.toString();
                          setState(() {});

                          CustomLoader.RejectDialog(
                              context: context,
                              title: "Select SupervisedResources",
                              haeding: "Transfer",
                              onCallback: OnCallBackTransfer,
                              onTapofYes: () {},
                              controller: commentController);
                        },
                        child: requestContainer(
                            myColors.orange, Icons.transform_rounded, MyString.Transfer),
                      )
                          : Container(): Container(),*/

                      SizedBox(
                        width: 14,
                      ),

                      /// Reject Button...............
                      workStatusId == "1"
                          ? GestureDetector(
                              onTap: () {
                                taskid = model.id.toString();
                                print("fghjfvj${taskid}");
                                actionId = 3;
                                resourceId = model.resourceId.toString();
                                CustomLoader.RejectDialog(
                                    context: context,
                                    title: model.securityInfoId,
                                    haeding: "Reject",
                                    onCallback: OnCallBackcomment,
                                    onTapofYes: () {
                                      Navigator.pop(context);
                                    },
                                    controller: commentController);
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/img_reject_red.png",
                                      height: 24,
                                      width: 24,
                                    ),
                                    Text(
                                      "Reject",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          fontFamily:
                                              "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                          color: myColors.red_3),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  final commentController = TextEditingController();

  OnCallBackcomment(String Comment) {
    commentController.text = Comment;
    print("fghjfvj${commentController.text}");
    setState(() {});
    additionalInfoApiCall(true);
    // acceptRejectApiCall();
  }

  OnCallBackTransfer(String Comment, String superresourceId) {
    commentController.text = Comment;
    print("fghjfvj ${commentController.text}");
    print("superresourceId ${superresourceId}");
    setState(() {});
    transferworkorderApi(commentController.text, superresourceId);
    setState(() {});
  }

  transferworkorderApi(String commnt, String superresourceId) async {
    await Webservices.RequestTransferWorkOrders(context, transferworkorderslist,
        taskid, commnt, superresourceId, widget.serviceId.toString(), true);
    setState(() {});
    if (transferworkorderslist.isNotEmpty) {
      if (transferworkorderslist.first.isSuccess.toString() == "true") {
        getApi(true);
      }
    }
  }

  acceptRejectApiCall(bool isFromMobile) async {
    DateTime dateTime = DateTime.now();
    await Webservices.RequestAcceptReject(
        context,
        true,
        int.parse(taskid.toString()),
        int.parse(resourceId.toString()),
        actionId!,
        commentController.text,
        dateTime.toUtc(),
        widget.title == "Soft Services PM W/O" ? "schedule" : "",
        1);
    getApi(true);
  }

  additionalInfoApiCall(bool isFromMobile) async {
    await Webservices.RequestAdditionolInfo(
        context,
        true,
        taskid.toString(),
        taskResourceslist,
        hseqlist);

    if (resourceId.isEmpty || resourceId == "") {
      Fluttertoast.showToast(msg: "Resource Id is null");
    } else {
      acceptRejectApiCall(isFromMobile);
    }

    if (hseqlist.isEmpty) {
    } else {
      questionanswer = hseqlist.first.questions == null
          ? ""
          : hseqlist.first.questions.toString();
      questionslist = hseqlist.first.questions!;
      setState(() {});
    }

    // getApi(true);
  }

  appbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(170),
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          alignment: Alignment.center,
          child: SafeArea(
            child: Column(
              children: [
                //Header......................................................................................................................
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 40,
                      child: widget.isBack == "true"
                          ? widget.title == "Corrective W/O" ||
                                  widget.title == "PPM W/O" ||
                                  widget.title == 'Reactive W/O' ||
                                  widget.title == "Soft Services PM W/O"
                              ? GestureDetector(
                                  onTap: () {
                                    // Navigator.pop(context);
                                    widget.onCallback("dash_home");
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                  ))
                              : Container()
                          : Container(),
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: CustomText.CustomBoldTextDM(
                              widget.appbartitle,
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

                //Search...................................................................................................................
                Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
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
                                // flex: 3,
                                // width: 230,
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
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  ),
                                  maxLines: 1,
                                  cursorColor: myColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Row(
                          children: [
                            ///Arrow Down.................
                            InkWell(
                              onTap: () {
                                selected_icon = "arrow_down";
                                setState(() {});
                                a_to_zFilter();
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selected_icon == "arrow_down"
                                      ? myColors.cyan
                                      : myColors.app_theme,
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                  "assets/images/ic_down_white.svg",
                                  height: 16,
                                  width: 16,
                                  fit: BoxFit.fill,
                                )),
                              ),
                            ),

                            ///Refresh....................
                            InkWell(
                              onTap: () {
                                selected_icon = "refresh";
                                setState(() {});
                                print("bdhjhjjfkd");
                                getApi(true);
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selected_icon == "refresh"
                                      ? myColors.cyan
                                      : myColors.app_theme,
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                  "assets/images/refresh_ccw.svg",
                                  height: 16,
                                  width: 16,
                                  fit: BoxFit.fill,
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //After Search...............................................................................................................
                /*   Visibility(
                  visible: false,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      children: [
                        ///Filter.....................
                        InkWell(
                          onTap: () {
                            selected_icon = "filter";

                            //Open Bottomsheet Filter......................................................................................
                            showModalBottomSheet<void>(
                              enableDrag: false,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40)),
                                      color: myColors.white,
                                    ),
                                    child: BottomSheetFilterUI(
                                      callback: onCallBack,
                                    ));
                              },
                            );

                            setState(() {});
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selected_icon == "filter"
                                  ? myColors.cyan
                                  : myColors.app_theme,
                            ),
                            child: Center(
                                child: SvgPicture.asset(
                              "assets/images/ic_filter_white.svg",
                              height: 16,
                              width: 16,
                              fit: BoxFit.fill,
                            )),
                          ),
                        ),

                        ///Arrow Down.................
                        InkWell(
                          onTap: () {
                            selected_icon = "arrow_down";
                            setState(() {});
                            a_to_zFilter();
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selected_icon == "arrow_down"
                                  ? myColors.cyan
                                  : myColors.app_theme,
                            ),
                            child: Center(
                                child: SvgPicture.asset(
                              "assets/images/ic_down_white.svg",
                              height: 16,
                              width: 16,
                              fit: BoxFit.fill,
                            )),
                          ),
                        ),

                        ///Refresh....................
                        InkWell(
                          onTap: () {
                            selected_icon = "refresh";
                            setState(() {});
                            print("bdhjhjjfkd");
                            getApi(false);
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selected_icon == "refresh"
                                  ? myColors.cyan
                                  : myColors.app_theme,
                            ),
                            child: Center(
                                child: SvgPicture.asset(
                              "assets/images/refresh_ccw.svg",
                              height: 16,
                              width: 16,
                              fit: BoxFit.fill,
                            )),
                          ),
                        ),

                        Expanded(child: Container()),

                        ///Select Date................
                        InkWell(
                          onTap: () {
                            selected_icon = "calender";
                            setState(() {});
                            //Open Bottomsheet Calender......................................................................................
                            showModalBottomSheet<void>(
                              enableDrag: false,
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40)),
                                      color: myColors.white,
                                    ),
                                    height: 470,
                                    child: BottomSheetCalenderUI(
                                      callback: onCallBack,
                                    ));
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: CustomText.CustomBoldTextDM(
                                      MyString.Select_Date,
                                      myColors.white,
                                      FontWeight.w700,
                                      12,
                                      1,
                                      TextAlign.center),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 4),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: selected_icon == "calender"
                                        ? myColors.cyan
                                        : myColors.app_theme,
                                  ),
                                  child: Center(
                                      child: SvgPicture.asset(
                                    "assets/images/ic_calender_white.svg",
                                    height: 16,
                                    width: 16,
                                    fit: BoxFit.fill,
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  a_to_zFilter() {
    getworklist.sort((a, b) {
      return a.problem
          .toString()
          .toLowerCase()
          .compareTo(b.problem.toString().toLowerCase());
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
    getworklist.forEach((userDetail) {
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
          userDetail.reporteddate
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

  List<GetWorkModel> _searchResult = [];
}
