import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/global_theme_button.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/model/models/GetWorkModel.dart';
import 'package:fm_pro/model/models/ProjectModel.dart';
import 'package:fm_pro/model/models/TaskInfoModel.dart';
import 'package:fm_pro/model/updates_lst_model.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/views/PPM/ppm_hesq_quitionaire.dart';
import 'package:fm_pro/views/PPM/wo_resource_assigned_screen.dart';
import 'package:fm_pro/widgets/CustomDrawer.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../global/my_string.dart';
import '../../model/models/GetResourceModel.dart';
import '../../model/models/scanModel.dart';
import '../../widgets/custom_texts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

List<UpdatesListModel> updates_list = [];
final GlobalKey<ScaffoldState> _scaffoldkey1 = new GlobalKey<ScaffoldState>();

class WO_Detail_Screen extends StatefulWidget {
  String title;
  String appbar_title;
  String taskLogId;
  String serviceId;
  String loaction;
  String buildingname;
  Function OnCallback;
  String workStatusId;
  String statusId;
  String buildingName;
  String locationName;
  String unitName;
  String floorName;

  WO_Detail_Screen({
    Key? key,
    required this.taskLogId,
    required this.OnCallback,
    required this.serviceId,
    required this.loaction,
    required this.buildingname,
    required this.title,
    required this.appbar_title,
    required this.workStatusId,
    required this.statusId,
    required this.buildingName,
    required this.locationName,
    required this.floorName,
    required this.unitName
  }) : super(key: key);

  @override
  _WO_Detail_ScreenState createState() => _WO_Detail_ScreenState();
}

class _WO_Detail_ScreenState extends State<WO_Detail_Screen> {
  final commentController = TextEditingController();
  final comment_focus = FocusNode();
  bool status_toggle = false;
  String status_assigned = "";
  String status_assignedID = "";
  String onHoldReasoncomment = "";
  List<ScanModel> scanlist = [];
  Completer<GoogleMapController> _controller = Completer();
  List<TaskInfoModel> taskModel = [];
  List<Categories> categorylist = [];
  List<FaultCodes> faultcodelist = [];
  List<SubTaskStatuses> subtask_statuslist = [];
  List<TaskStatuses> task_statuslist = [];
  List<Priorities> prioritylist = [];
  List<Locs> loclist = [];
  TaskLogInfo? taskloginfolist;
  List<Locations>? locations = [];

  String select_onHold = "Select On Hold Reason";
  String select_onHold_Id = "";
  String categoryName = "";
  String faultcodeName = "";
  String faultcodeId = "";
  String categoryId = "";
  String serviceType = "";
  String subTaskStatusId = "";
  String priorityId = "";
  String subTaskStatusName = "";
  String priorityName = "";
  String locName = "";
  String locId = "";
  String task_statusID = "";
  String task_statusName = "";
  String resourceId = "";
  String TaskLogReasonId = "";
  String comment = "";
  String reasonId = "";
  String finish_date = "";
  String feedbackComment = "";
  String feedback_rating = "";
  String signatureUrl = "";
  String statusId = "";
  String on_Holdreason = "";
  double icon_width = 30;
  double icon_height = 30;
  double icon_fontsize = 12;
  String isBlueCollar = "";
  String asset_code = "";

  String questionanswer = "";
  String checklist_questionanswer = "";

  List<AdditionalInfoResponse> additionalInfoResponse =[];

  List<TaskResourcesModel> taskResourceslist = [];
  List<ImagesDetailModel> imageslist = [];
  List<Data> masterResourceslist = [];
  List<HseqListItems> hseqlist = [];
  HseqListItems? hseqListItems;
  List<Questions> questionslist = [];
  List<OnHoldReasons>? onHoldReasons = [];
  String compleated_date = "";
  String start_date = "";
  String containDate = "";
  String finishDate = "";
  String ProjectId = "";
  List<ProjectsModel> projectlist = [];

  List<CheckListItems> checklist = [];
  List<ChecklistQuestionAnswers> checkquestionAnswerlist = [];
  CheckListItems? checkListItems;

  final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  ///Scanner.............
  bool is_scan = false;
  bool is_hide = false;
  bool islocation_hide = false;

  List<ResourcesModel> resourceslist = [];
  List<GetWorkModel> getworklist = [];

  getResorce() async {
    resourceslist.clear();
    await Webservices.RequestGetResource(context, resourceId, resourceslist);
    setState(() {});
  }

  List<Map<String, String>> newFaultCode = [
    {"name": "Plumbing"},
    {"name": "Electrical"},
    {"name": "mechanical"},
  ];

  String title = "";
  String building_name = "";
  late int tappedIndex;
  String selectButtonYesNo = "yes";
  String feedBackComment = "";

  bool isSwitched = false;

  String selected_category = "";

  List<String> dropdownlist = ["one", 'two', 'three'];
  String? selected_country;

  @override
  void initState() {
    super.initState();
    commentController.clear();
    checkquestionAnswerlist.clear();
    checklist.clear();
    tappedIndex = 0;
    selectButtonYesNo = "yes";
    setState(() {});
    print("title>>${widget.title}");
    print("taskLogId.......>>${widget.taskLogId}");

    setTitle();
    setgridviewitem();
    // RequestWODetailScan(false);
    // Future.delayed(Duration.zero, () async {
    api();
    print("widget.workStatusId.toString()22>>${widget.workStatusId.toString()}");
  }
  api() async{
    await getprojectmasterdataapi(false);
  }

  setTitle() {
    if (widget.title == "PPM W/O") {
      title = "PPM W/O";
    } else if (widget.title == "Corrective W/O") {
      title = "Corrective W/O";
    } else if (widget.title == "Reactive W/O") {
      title = "Reactive W/O";
    } else if (widget.title == "Soft Services PM W/O") {
      title = "Soft Services PM W/O";
    }
    setState(() {});
  }

  toggleDrawer() async {
    if (_scaffoldkey1.currentState!.isDrawerOpen) {
      _scaffoldkey1.currentState!.openEndDrawer();
    } else {
      _scaffoldkey1.currentState!.openDrawer();
    }
  }

  OnCallback() {
    print("fbnbgf");
    additionolinfo();
    setState(() {});
  }

  Onupdategeralapi() {
    additionolinfo();
    getApi(false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
      //   key: _scaffoldkey ,
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            key: _scaffoldkey1,
            drawer: CustomDrawerScreen(
              title: widget.appbar_title,
              taskLogId: widget.taskLogId,
              serviceId: widget.serviceId,
              // // taskloginfolist:  taskloginfolist!,
              loaction: widget.loaction,
              projectID: ProjectId,
              // taskResourceslist: taskResourceslist,
              // resourceslist: resourceslist,
              OnCallback: OnCallback,
            ),
            backgroundColor: myColors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: myColors.app_theme,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light, // For iOS (dark icons)
                ),
                automaticallyImplyLeading: false,
                backgroundColor: myColors.white,
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    this.widget.OnCallback();
                    // UpdatesMenuScreen();
                  },
                  icon: Container(
                    padding: EdgeInsets.only(left: 0),
                    alignment: Alignment.center,
                    height: 60,
                    width: 40,
                    child: SvgPicture.asset(
                      "assets/images/ic_arrow_previous.svg",
                      height: 16,
                      width: 16,
                    ),
                  ),
                ),
                title: Container(
                    padding: EdgeInsets.only(left: 5),
                    alignment: Alignment.center,
                    child: CustomText.CustomBoldTextDM(
                        widget.appbar_title,
                        myColors.black,
                        FontWeight.w700,
                        16,
                        1,
                        TextAlign.center
                    )),
                actions: [
                  compleated_date.toString() == "null"
                      ? Container()
                      :
                  GestureDetector(
                    onTap: () {
                      print(
                          "widget.serviceId>>${widget.serviceId}");
                      UpdateTaskLogStatusApi(
                          "3", widget.serviceId);
                    },
                    child: Container(
                      alignment: Alignment.center,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.only(bottom: 2),
                            child: Center(
                                child: Image.asset(
                                    "assets/images/color_CheckCircle-img.png")),
                          ),
                          Text(
                            "Complete",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: myColors.app_theme,
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 15,),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap:  () {
                        toggleDrawer();
                      },
                      child: Image.asset(
                        "assets/icons/ic_menu.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ],
                /*   flexibleSpace: Container(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  //alignment: Alignment.centerLeft,
                  child: SafeArea(
                    child: Column(
                      children: [
                        //Header..............................................................................................................
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                this.widget.OnCallback();
                                // UpdatesMenuScreen();
                              },
                              icon: Container(
                                padding: EdgeInsets.only(left: 10),
                                alignment: Alignment.center,
                                height: 60,
                                width: 40,
                                child: SvgPicture.asset(
                                  "assets/images/ic_arrow_previous.svg",
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: CustomText.CustomBoldTextDM(
                                    widget.appbar_title,
                                    myColors.black,
                                    FontWeight.w700,
                                    16,
                                    1,
                                    TextAlign.center
                                )),
                            Spacer(),

                            Row(
                              children: [
                                compleated_date.toString() != "null"
                                    ? Container()
                                    :
                                GestureDetector(
                                  onTap: () {
                                    print(
                                        "widget.serviceId>>${widget.serviceId}");
                                    UpdateTaskLogStatusApi(
                                        "3", widget.serviceId);
                                  },
                                  child: Container(

                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          margin: EdgeInsets.only(bottom: 2),
                                          child: Center(
                                              child: Image.asset(
                                                  "assets/images/color_CheckCircle-img.png")),
                                        ),
                                        Text(
                                          "Complete",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: myColors.app_theme,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(width: 15,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleDrawer();
                                    },
                                    child: Image.asset(
                                      "assets/icons/ic_menu.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),*/
              ),
            ),
            body: body()));
  }

  body() {
    return GestureDetector(
        onTap: () {
          comment_focus.unfocus();
          setState(() {});
        },
        child: Container(
          color: myColors.white,
          child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Stack(
                      children: [

                        /// Hide.....
                        Visibility(
                          visible: false,
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child:
                            Image.asset(
                                "assets/images/PmDetailpage_bg_img.png"),
                          ),
                        ),
                        Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                "assets/images/mapNew_img.png",
                                height: 50,
                                width: 50,
                              ),
                            ))
                      ],
                    ),
                  ),

                  /// priorityName......................
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: CustomText.CustomSemiBoldText(
                            taskloginfolist != null
                                ? "# ${taskloginfolist!.securityInfoId}"
                                : "",
                            myColors.black,
                            FontWeight.w600,
                            15,
                            1,
                            TextAlign.center),
                      ),
                      Spacer(),
                      priorityName.isEmpty || priorityName == ""
                          ? Container()
                          : Container(
                        margin: EdgeInsets.only(right: 10, top: 24),
                        height: 25,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: myColors.sky_blue,
                          border: Border.all(color: myColors.sky_blue),
                        ),
                        child: CustomText.CustomSemiBoldText(
                            priorityName,
                            myColors.white,
                            FontWeight.w500,
                            14,
                            1,
                            TextAlign.center),
                      ),
                    ],
                  ),

                  /// ------------CTGT-PM

                  /* Container(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: CustomText.CustomSemiBoldText(
                          taskloginfolist != null
                              ? "${taskloginfolist!.securityInfoId}"
                              : "",
                          myColors.black,
                          FontWeight.w600,
                          13,
                          1,
                          TextAlign.center),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(16, 3, 16, 0),
                child: CustomText.CustomSemiBoldText(
                    taskloginfolist != null ? "${taskloginfolist!.title}" : "",
                    myColors.grey_six,
                    FontWeight.w400,
                    13,
                    1,
                    TextAlign.center),
              ),*/

                  ///Reported Date..................
                  Container(
                    padding: EdgeInsets.fromLTRB(14, 15, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          // width: 75,
                          child: CustomText.CustomSemiBoldText(
                              "Reported Dt. ",
                              myColors.black,
                              FontWeight.w600,
                              13,
                              1,
                              TextAlign.center),
                        ),
                        Spacer(),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            //  width: 115,
                            padding: EdgeInsets.only(right: 5),
                            child: CustomText.CustomSemiBoldText(
                                taskloginfolist != null
                                    ? "${DateFormat.d().format(DateTime.parse(
                                    taskloginfolist!.reportedDate
                                        .toString()))} ${DateFormat.yMMM()
                                    .format(DateTime.parse(
                                    taskloginfolist!.reportedDate
                                        .toString()))}, ${DateFormat("HH:mm:ss")
                                    .format(DateTime.parse(
                                    taskloginfolist!.reportedDate.toString()))}"
                                    : "",
                                myColors.black,
                                FontWeight.w400,
                                13,
                                1,
                                TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Reported No..................
                  /*  widget.title == "PPM W/O" ? Container() : Container(
                padding: EdgeInsets.fromLTRB(14, 10, 6, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      // width: 75,
                      child: CustomText.CustomSemiBoldText(
                          "Reporter No. :",
                          myColors.grey_eleven,
                          FontWeight.w600,
                          13,
                          1,
                          TextAlign.center),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        //  width: 115,
                        padding: EdgeInsets.only(left: 2, right: 0),
                        child: CustomText.CustomSemiBoldText(
                            taskloginfolist != null
                                ? taskloginfolist!.reporterTypeId.toString()
                                : "",
                            myColors.black,
                            FontWeight.w400,
                            13,
                            1,
                            TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),*/

                  ///Due Date..................
                  Container(
                    padding: EdgeInsets.fromLTRB(14, 15, 10, 0),
                    child: Row(
                      children: [
                        Container(
                          child: CustomText.CustomSemiBoldText(
                              "Due Dt.",
                              myColors.black,
                              FontWeight.w600,
                              13,
                              1,
                              TextAlign.center),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 5),
                          child: CustomText.CustomSemiBoldText(
                              taskloginfolist != null
                                  ? "${DateFormat.d().format(DateTime.parse(
                                  taskloginfolist!.dueDate
                                      .toString()))} ${DateFormat.yMMM().format(
                                  DateTime.parse(taskloginfolist!.dueDate
                                      .toString()))}, ${DateFormat("HH:mm:ss")
                                  .format(DateTime.parse(
                                  taskloginfolist!.dueDate.toString()))}"
                                  : "",
                              myColors.black,
                              FontWeight.w400,
                              13,
                              1,
                              TextAlign.center),
                        ),
                      ],
                    ),
                  ),


                  ///Building..................
                  Container(
                    padding: EdgeInsets.fromLTRB(14, 15, 10, 0),
                    child: Row(
                      children: [
                        Container(
                          child: CustomText.CustomSemiBoldText(
                              "Building",
                              myColors.black,
                              FontWeight.w600,
                              13,
                              1,
                              TextAlign.center),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 5),
                          child: CustomText.CustomSemiBoldText(
                              widget.buildingname,
                              myColors.black,
                              FontWeight.w400,
                              13,
                              1,
                              TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  ///location Store..................
                  Container(
                    padding: EdgeInsets.fromLTRB(14, 15, 10, 0),
                    child: Row(
                      children: [
                        Container(
                          child: CustomText.CustomSemiBoldText(
                              "location Store",
                              myColors.black,
                              FontWeight.w600,
                              13,
                              1,
                              TextAlign.center),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 5),
                          child: CustomText.CustomSemiBoldText(
                              widget.locationName,
                              myColors.black,
                              FontWeight.w400,
                              13,
                              1,
                              TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  ///Unit..................
                  Container(
                    padding: EdgeInsets.fromLTRB(14, 15, 10, 0),
                    child: Row(
                      children: [
                        Container(
                          child: CustomText.CustomSemiBoldText(
                              "Unit",
                              myColors.black,
                              FontWeight.w600,
                              13,
                              1,
                              TextAlign.center),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 5),
                          child: CustomText.CustomSemiBoldText(
                              widget.unitName,
                              myColors.black,
                              FontWeight.w400,
                              13,
                              1,
                              TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  ///Floor..................
                  Container(
                    padding: EdgeInsets.fromLTRB(14, 15, 10, 0),
                    child: Row(
                      children: [
                        Container(
                          child: CustomText.CustomSemiBoldText(
                              "Floor",
                              myColors.black,
                              FontWeight.w600,
                              13,
                              1,
                              TextAlign.center),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(right: 5),
                          child: CustomText.CustomSemiBoldText(
                              widget.floorName,
                              myColors.black,
                              FontWeight.w400,
                              13,
                              1,
                              TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  /// Title.......
                  Container(
                    padding: EdgeInsets.fromLTRB(14, 15, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CustomText.CustomSemiBoldText(
                              "Title",
                              myColors.black,
                              FontWeight.w600,
                              13,
                              1,
                              TextAlign.center),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          taskloginfolist != null
                              ? "${taskloginfolist!.title}"
                              : "",
                          style: TextStyle(
                              fontFamily:
                              MyString.PlusJakartaSansmedium,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),


                  /// Category name.......
                  categoryName == "" || categoryName == "null" ?
                  Container() :
                  Container(
                    padding: EdgeInsets.fromLTRB(14, 15, 14, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CustomText.CustomSemiBoldText(
                              "Category",
                              myColors.black,
                              FontWeight.w600,
                              13,
                              1,
                              TextAlign.center),
                        ),

                        hsized15,
                        Container(
                          decoration: BoxDecoration(
                              color: myColors.app_theme,
                              borderRadius: BorderRadius.circular(100)),
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 11, bottom: 11),
                          child: CustomText.CustomSemiBoldText(
                              categoryName,
                              myColors.white,
                              FontWeight.w400,
                              13,
                              1,
                              TextAlign.center),

                        ),
                      ],
                    ),
                  ),

                  ///Reported Name..................
                  /*  widget.title == "PPM W/O" || widget.title == "Soft Services PM W/O"? Container() :   Container(
                padding: EdgeInsets.fromLTRB(14, 10, 6, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      // width: 75,
                      child: CustomText.CustomSemiBoldText(
                          "Reporter :",
                          myColors.grey_eleven,
                          FontWeight.w600,
                          13,
                          1,
                          TextAlign.center),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        //  width: 115,
                        padding: EdgeInsets.only(left: 2, right: 0),
                        child: CustomText.CustomSemiBoldText(
                            taskloginfolist != null
                                ? taskloginfolist!.reportedByName.toString()
                                : "",
                            myColors.black,
                            FontWeight.w400,
                            13,
                            1,
                            TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),*/

                  ///Contact ..................
                  /*  widget.title == "PPM W/O" || widget.title == "Soft Services PM W/O"? Container() :   Container(
                padding: EdgeInsets.fromLTRB(14, 10, 6, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      // width: 75,
                      child: CustomText.CustomSemiBoldText(
                          "Contact# :",
                          myColors.grey_eleven,
                          FontWeight.w600,
                          13,
                          1,
                          TextAlign.center),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        //  width: 115,
                        padding: EdgeInsets.only(left: 2, right: 0),
                        child: CustomText.CustomSemiBoldText(
                            taskloginfolist != null
                                ? taskloginfolist!.mobileNo.toString()
                                : "",
                            myColors.black,
                            FontWeight.w400,
                            13,
                            1,
                            TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),*/

                  ///Refrence ..................
                  /*   Container(
                padding: EdgeInsets.fromLTRB(14, 10, 6, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      // width: 75,
                      child: CustomText.CustomSemiBoldText(
                          "Reference :",
                          myColors.grey_eleven,
                          FontWeight.w600,
                          13,
                          1,
                          TextAlign.center),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        //  width: 115,
                        padding: EdgeInsets.only(left: 2, right: 0),
                        child: CustomText.CustomSemiBoldText(
                            taskloginfolist != null
                                ? taskloginfolist!.refNumber.toString()
                                : "",
                            myColors.black,
                            FontWeight.w400,
                            13,
                            1,
                            TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),*/

                  ///Refrence ..................
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(14, 10, 6, 0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         alignment: Alignment.topLeft,
                  //         // width: 75,
                  //         child: CustomText.CustomSemiBoldText(
                  //             "PPM ID :",
                  //             myColors.grey_eleven,
                  //             FontWeight.w600,
                  //             13,
                  //             1,
                  //             TextAlign.center),
                  //       ),
                  //       Expanded(
                  //         child: Container(
                  //           alignment: Alignment.topLeft,
                  //           //  width: 115,
                  //           padding: EdgeInsets.only(left: 2, right: 0),
                  //           child: CustomText.CustomSemiBoldText(
                  //               taskloginfolist != null
                  //                   ? taskloginfolist!.mobileNo.toString()
                  //                   : "",
                  //               myColors.black,
                  //               FontWeight.w400,
                  //               13,
                  //               1,
                  //               TextAlign.center),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  ///Refrence ..................
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(14, 10, 6, 0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         alignment: Alignment.topLeft,
                  //         // width: 75,
                  //         child: CustomText.CustomSemiBoldText(
                  //             "Parent Wo :",
                  //             myColors.grey_eleven,
                  //             FontWeight.w600,
                  //             13,
                  //             1,
                  //             TextAlign.center),
                  //       ),
                  //       Expanded(
                  //         child: Container(
                  //           alignment: Alignment.topLeft,
                  //           //  width: 115,
                  //           padding: EdgeInsets.only(left: 2, right: 0),
                  //           child: CustomText.CustomSemiBoldText(
                  //               taskloginfolist != null
                  //                   ? taskloginfolist!.mobileNo.toString()
                  //                   : "",
                  //               myColors.black,
                  //               FontWeight.w400,
                  //               13,
                  //               1,
                  //               TextAlign.center),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),


                  /// Fault code hide.....
                  Visibility(
                    visible: false,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: CustomText.CustomSemiBoldText(
                                "Fault Code ",
                                myColors.black,
                                FontWeight.w600,
                                13,
                                1,
                                TextAlign.center),
                          ),
                          /*  Container(
                        padding: EdgeInsets.only(left: 6, right: 6),
                        child: CustomText.CustomSemiBoldText(
                            faultcodeName,
                            myColors.black,
                            FontWeight.w400,
                            13,
                            1,
                            TextAlign.center),
                      ),*/
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                    visible: false,
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 0),
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: newFaultCode.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                    tappedIndex = index;
                                    print("tappedIndex......$tappedIndex");
                                  },
                                  child: Container(
                                    // height: 50,
                                      decoration: BoxDecoration(
                                          color: tappedIndex == index
                                              ? myColors.app_theme
                                              : myColors.grey_border,
                                          // color: AppColors.appContainer,
                                          borderRadius: BorderRadius.circular(
                                              10)),
                                      child: Center(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(12),
                                            child: Text(
                                                newFaultCode[index]["name"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "PlusJakartaSansregular",
                                                    color: tappedIndex == index
                                                        ? myColors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight
                                                        .w600),
                                                textAlign: TextAlign.center),
                                          ))),
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(
                    height: 20,
                  ),


                  /// DescrDescription..........

                  taskModel.isNotEmpty ?
                  taskModel.first.taskLogInfo!
                      .assetDescription.toString() == "null" ?
                  Container() :
                  Container(
                    margin: EdgeInsets.fromLTRB(14, 15, 14, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              fontFamily: "PlusJakartaSansregular",
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${taskModel.isNotEmpty ? taskModel.first.taskLogInfo!
                              .assetDescription.toString() == "null"
                              ? ""
                              : taskModel.first.taskLogInfo!
                              .assetDescription : ""} ",
                          //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.30,
                              fontFamily: "PlusJakartaSansregular",
                              color: Colors.black),
                        ),
                      ],
                    ),
                  )
                      : Container(),

                  ///line..................
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    height: 1.2,
                    color: myColors.grey_twelve,
                  ),

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 12, 6, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Asset Details",
                                      style: TextStyle(
                                          fontFamily:
                                          "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Bold.ttf",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      "Do you have asset ",
                                      style: TextStyle(
                                          fontFamily:
                                          "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Bold.ttf",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: myColors.black),
                                    ),
                                  ],
                                ),
                              ), Row(
                                children: [
                                  GestureDetector(
                                    onTap: finish_date != "null"?(){} :() {
                                      selectButtonYesNo = "yes";
                                      print(
                                          "selectButtonYesNo....$selectButtonYesNo");
                                      setState(() {});
                                    },
                                    child: Container(
                                        height: 26,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: selectButtonYesNo == "yes"
                                                ? myColors.app_theme
                                                : myColors.grey_bar1,
                                            borderRadius: BorderRadius.circular(
                                                20)),
                                        child: Center(
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                fontFamily:
                                                MyString.PlusJakartaSansregular,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: selectButtonYesNo ==
                                                    "yes"
                                                    ? myColors.white
                                                    : myColors.black,
                                              ),
                                            ))),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap:   finish_date != "null" ?(){} :() {
                                      selectButtonYesNo = "No";
                                      print(
                                          "selectButtonYesNo....$selectButtonYesNo");
                                      setState(() {});
                                    },
                                    child: Container(
                                        height: 26,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: selectButtonYesNo == "yes"
                                                ? myColors.grey_bar1
                                                : myColors.app_theme,
                                            borderRadius: BorderRadius.circular(
                                                20)),
                                        child: Center(
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                fontFamily:
                                                MyString.PlusJakartaSansregular,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: selectButtonYesNo ==
                                                    "yes"
                                                    ? myColors.black
                                                    : myColors.white,
                                              ),
                                            ))),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        ///line..................
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          height: 1.2,
                          color: myColors.grey_twelve,
                        ),

                        /// QR Code..........

                        selectButtonYesNo == "yes" ?
                        taskModel.isNotEmpty
                            ? taskModel.first.taskLogInfo!.hasAsset == true
                            ? taskModel.first.taskLogInfo!.assetId.toString() !=
                            "null" ?
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 25, 20, 10),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: myColors.bg_bottom,
                                    border: Border.all(color: myColors.grey_23),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "${taskModel.isNotEmpty ? taskModel.first
                                          .taskLogInfo!.assetCode : ""}  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          fontFamily:
                                          MyString.PlusJakartaSansregular,
                                          color: myColors.black),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  var code = taskModel
                                      .first.taskLogInfo!.assetCode
                                      .toString();
                                  print("jfjf${code}");
                                  await Webservices.Requestscan(
                                      context, true, code, scanlist);
                                  setState(() {});
                                },
                                child: Image.asset(
                                  "assets/images/qr_img.png",
                                  height: 45,
                                  width: 45,
                                ),
                              )
                            ],
                          ),
                        )
                            : Container(
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          alignment: Alignment.center,
                          child: CustomText.CustomSemiBoldText(
                              "No assets",
                              myColors.grey_22,
                              FontWeight.w400,
                              13,
                              1,
                              TextAlign.center),
                        )
                            : Container(
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          alignment: Alignment.center,
                          child: CustomText.CustomSemiBoldText(
                              "No assets",
                              myColors.grey_22,
                              FontWeight.w400,
                              13,
                              1,
                              TextAlign.center),
                        )
                            :Container(
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          alignment: Alignment.center,
                          child: CustomText.CustomSemiBoldText(
                              "No assets",
                              myColors.grey_22,
                              FontWeight.w400,
                              13,
                              1,
                              TextAlign.center),
                        ) : Container(
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          alignment: Alignment.center,
                          child: CustomText.CustomSemiBoldText(
                              "No assets",
                              myColors.grey_22,
                              FontWeight.w400,
                              13,
                              1,
                              TextAlign.center),
                        ),

                        ///line..................
                        // finishDate.toString() != "null" || finishDate.trim().isNotEmpty  taskModel.first.taskLogInfo!.assetId.toString() ==  "null"?
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        //   alignment: Alignment.center,
                        //   child: CustomText.CustomSemiBoldText(
                        //       "No assets",
                        //       myColors.grey_22,
                        //       FontWeight.w400,
                        //       13,
                        //       1,
                        //       TextAlign.center),
                        // ) : Container(),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          height: 1.2,
                          color: myColors.grey_twelve,
                        ),
                      ],
                    ),
                  ),

                  /// Building name.......
                  /* widget.title != "Soft Services PM W/O" ?
              Container():
              Container(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 14),
                      child: CustomText.CustomSemiBoldText(
                          "Building name :",
                          myColors.grey_eleven,
                          FontWeight.w600,
                          13,
                          1,
                          TextAlign.center),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 6, right: 6),
                      child: CustomText.CustomSemiBoldText(
                          widget.buildingname,
                          myColors.black,
                          FontWeight.w400,
                          13,
                          1,
                          TextAlign.center),
                    ),
                  ],
                ),
              ),*/

                  ///Location..................
                  /*  Container(
                padding: EdgeInsets.only(left: 14, right: 16, top: 16),
                child: Row(
                  children: [
                    CustomText.CustomSemiBoldText(
                        "Location",
                        myColors.grey_eleven,
                        FontWeight.w600,
                        13,
                        1,
                        TextAlign.center),

                    widget.title == "Soft Services PM W/O" &&  locations == null ?      Container(
                      padding: EdgeInsets.only(left: 6),
                      child: Text(
                        " : ${widget.loaction}",
                        style: TextStyle(
                          color: myColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          wordSpacing: 0.1,
                          height: 1.3,
                          fontFamily: "assets/fonts/Poppins/Poppins-SemiBold.ttf",
                        ),
                      ),
                    ):Container(),
                  ],
                ),


              ),


              GestureDetector(
                onTap: (){
                  print("widget.title>>${widget.title}");
                  if(widget.title == "Soft Services PM W/O"){
                    islocation_hide =  !islocation_hide;
                    print("islocation_hide>>${islocation_hide}");
                    setState(() {});
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(left: 14, right: 16, top: 5),
                  child: Row(
                    children: [
                      widget.title == "Soft Services PM W/O" &&  locations == null ?  Container(): Expanded(
                        child: Text(
                          "${widget.loaction}",
                          style: TextStyle(
                            color: myColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            wordSpacing: 0.1,
                            height: 1.3,
                            fontFamily: "assets/fonts/Poppins/Poppins-SemiBold.ttf",
                          ),
                        ),
                      ),
                      widget.title == "Soft Services PM W/O" ? locations == null ?  Container():  Padding(
                        padding:  EdgeInsets.only(top: 3.0,left: 1),
                        child: Icon(Icons.arrow_drop_down),
                      ):Container()
                    ],
                  ),
                ),
              ),

              islocation_hide == true ? widget.title == "Soft Services PM W/O" ?
              locations == null ?
              Container():
              Container(
               // height: 250,
                margin: EdgeInsets.only(
                    left: 10, right: 10, top: 15),
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(10),
                    border: Border.all(
                        color: myColors.grey_two
                            .withOpacity(0.20))),
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: locations!.length,
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                        onTap: () {
                          islocation_hide = false;
                         widget.loaction =  locations!.isEmpty ? "" : locations![index].floorName.toString() +" | " +locations![index].unitName.toString()+" | "+locations![index].roomName.toString();
                          setState(() {});
                          print(
                              "is_selectOnHold${islocation_hide}");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(
                                  10)),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Container(
                                  padding: EdgeInsets
                                      .symmetric(
                                      horizontal:
                                      10,
                                      vertical: 4),
                                  child: Text(locations!.isEmpty ? "" : locations![index].floorName.toString() +" | " +locations![index].unitName.toString()+" | "+locations![index].roomName.toString()
                                  )),
                              Divider()
                            ],
                          ),
                        ),
                      );
                    }),
              )
                  :Container()
                  :Container(),*/

                  ///Map........................
                  // Container(
                  //     height: 200,
                  //     margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  //     child:
                  //     Image.asset("assets/images/img_map.png")
                  //     /*GoogleMap(
                  //           mapType: MapType.hybrid,
                  //           initialCameraPosition: _kGooglePlex,
                  //           onMapCreated: (GoogleMapController controller) {
                  //             _controller.complete(controller);
                  //           },
                  //         ),*/
                  //     ),


                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [



                        /*   Text(
                      "Level of Completion",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: myColors.dark_grey_txt,
                          fontFamily:
                          "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "In Progress",
                          style: TextStyle(
                              fontFamily:
                              "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: myColors.black),
                        ),

                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: myColors.grey_23)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: Text(
                          "No Selection",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: myColors.grey_21,
                              fontFamily:
                              "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                        ),
                      ),
                    ),*/
                        Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: CustomText.CustomSemiBoldText(
                                    MyString.Level_of_Completion,
                                    myColors.dark_grey_txt,
                                    FontWeight.w600,
                                    13,
                                    1,
                                    TextAlign.center),
                              ),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: CustomText.CustomRegularText(
                                    locName,
                                    myColors.dark_grey_txt,
                                    FontWeight.w600,
                                    13,
                                    1,
                                    TextAlign.center),
                              ),

                              // Container(
                              //   child: CustomText.CustomSemiBoldText(
                              //       MyString.In_Progress,
                              //       myColors.dark_grey_txt,
                              //       FontWeight.w600,
                              //       12,
                              //       1,
                              //       TextAlign.center),
                              // ),
                            ],
                          ),
                        ),
                        widget.workStatusId.toString() == "1" ||
                            widget.workStatusId.toString() == "3" ?
                        Container() :
                        Container(
                          child: Column(
                            children: [

                              Container(
                                margin: EdgeInsets.fromLTRB(14, 15, 14, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Container(
                                      //
                                      child: CustomText.CustomRegularText(
                                          "On Hold",
                                          myColors.black,
                                          FontWeight.w600,
                                          12,
                                          1,
                                          TextAlign.center),
                                    ),


                                    ///Toggle....................................
                                  /*  Container(
                                      padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                                      alignment: Alignment.centerRight,
                                      child: FlutterSwitch(
                                        width: 35.0,
                                        height: 18.0,
                                        inactiveSwitchBorder: Border.all(
                                          color: myColors.grey_ten,
                                          width: 1.0,
                                        ),
                                        inactiveToggleColor: myColors.white,
                                        inactiveColor: myColors.grey_ten,
                                        //  inactiveToggleBorder: BoxBorder.,
                                        activeColor: myColors.orange_light,
                                        activeToggleColor: myColors.orange,
                                        valueFontSize: 0.0,
                                        toggleSize: 18.0,
                                        value: status_toggle == null
                                            ? false
                                            : status_toggle,
                                        borderRadius: 18.0,
                                        padding: 0.0,
                                        showOnOff: true,
                                        onToggle: finish_date != "null" ? (val) {} :
                                            (val) {
                                          print(
                                              "taskModel.first.taskLogInfo!.statusId.toString()>>${taskModel
                                                  .first.taskLogInfo!.statusId
                                                  .toString()}");
                                          if (reasonId
                                              .trim()
                                              .isNotEmpty &&
                                              taskModel.first.taskLogInfo!.statusId
                                                  .toString() != "2" &&
                                              taskModel.first.taskLogInfo!.statusId
                                                  .toString() != "1") {
                                            CustomLoader.RemoveOnHoldDialog(
                                              context: context,
                                              title: "Are you sure remove on-hold ?",
                                              haeding: "On-Hold",
                                              val: true,
                                              onCallback: onCallupdatetasklog,
                                              onTapofYes: () {
                                                UpdateTaskLogStatusApi("5", widget.serviceId);},
                                            );
                                          } else {
                                            setState(() {
                                              status_toggle = val;
                                            });
                                          }
                                        },
                                      ),
                                    ),*/

                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      alignment: Alignment.centerRight,
                                      child: FlutterSwitch(
                                        width: 35.0,
                                        height: 18.0,
                                        inactiveSwitchBorder: Border.all(
                                          color: myColors.grey_ten,
                                          width: 1.0,
                                        ),
                                        inactiveToggleColor: myColors.white,
                                        inactiveColor: myColors.grey_ten,
                                        //  inactiveToggleBorder: BoxBorder.,
                                        activeColor: myColors.app_theme,
                                        activeToggleColor: myColors.grey_38,
                                        valueFontSize: 0.0,
                                        toggleSize: 18.0,
                                        value: status_toggle == null
                                            ? false
                                            : status_toggle,
                                        borderRadius: 18.0,
                                        padding: 0.0,
                                        showOnOff: true,
                                        onToggle: finish_date != "null" ? (val) {} : (val) {

                                          print("finish_date......${finish_date}");
                                          if (reasonId
                                              .trim()
                                              .isNotEmpty &&
                                              taskModel.first.taskLogInfo!.statusId
                                                  .toString() != "2" &&
                                              taskModel.first.taskLogInfo!.statusId
                                                  .toString() != "1") {
                                            CustomLoader.RemoveOnHoldDialog(
                                              context: context,
                                              title: "Are you sure remove on-hold ?",
                                              haeding: "On-Hold",
                                              val: true,
                                              onCallback: onCallupdatetasklog,
                                              onTapofYes: () {
                                                UpdateTaskLogStatusApi("5", widget.serviceId);},
                                            );
                                          } else {
                                            setState(() {
                                              status_toggle = val;
                                            });
                                          }

                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              status_toggle == false
                                  ? Container()
                                  : Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          14, 15, 14, 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [

                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: widget.workStatusId
                                                    .toString() ==
                                                    "1" ||
                                                    widget.workStatusId
                                                        .toString() == "3" || finish_date != "null"
                                                    ? () {}
                                                    : () {
                                                  is_hide = !is_hide;
                                                  print(
                                                      "is_selectOnHold${is_hide}");
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width,
                                                  //  margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                                                  padding: EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: myColors
                                                            .border_txtfield),
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    // color: myColors.bg_txtfield,
                                                  ),
                                                  child: CustomText
                                                      .CustomRegularText(
                                                      select_onHold,
                                                      myColors.dark_grey_txt,
                                                      FontWeight.w400,
                                                      13,
                                                      1,
                                                      TextAlign.center),
                                                ),
                                              ),

                                              is_hide == true
                                                  ? Container(
                                                height: 250,
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 38, 0, 10),
                                                padding: EdgeInsets.only(
                                                    top: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    border: Border.all(
                                                        color: myColors.grey_two
                                                            .withOpacity(
                                                            0.20))),
                                                child: ListView.builder(
                                                    physics: AlwaysScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: taskModel
                                                        .first
                                                        .configuration!
                                                        .onHoldReasons!
                                                        .length,
                                                    itemBuilder: (context,
                                                        int index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          is_hide = false;
                                                          select_onHold =
                                                              taskModel
                                                                  .first
                                                                  .configuration!
                                                                  .onHoldReasons![index]
                                                                  .name
                                                                  .toString();
                                                          select_onHold_Id =
                                                              taskModel
                                                                  .first
                                                                  .configuration!
                                                                  .onHoldReasons![index]
                                                                  .id
                                                                  .toString();

                                                          comment = taskModel
                                                              .first
                                                              .configuration!
                                                              .onHoldReasons![index]
                                                              .name
                                                              .toString();
                                                          setState(() {});
                                                          print(
                                                              "is_selectOnHold${is_hide}");
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10,
                                                                      vertical: 4),
                                                                  child: Text(
                                                                      taskModel
                                                                          .first
                                                                          .configuration!
                                                                          .onHoldReasons![
                                                                      index]
                                                                          .name
                                                                          .toString())),
                                                              Divider()
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              )
                                                  : Container()
                                              //: Container(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // height: 80,
                                      margin: EdgeInsets.fromLTRB(
                                          14, 15, 14, 10),
                                      padding: EdgeInsets.fromLTRB(
                                          16, 0, 16, 0),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: myColors.border_txtfield),
                                        borderRadius: BorderRadius.circular(10),
                                        //color: myColors.bg_txtfield,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10,),
                                          // onHoldReasoncomment.toString() =="null"?Container():    Text(onHoldReasoncomment,style: TextStyle(
                                          //   fontSize: 13,
                                          //   fontWeight: FontWeight.w400,
                                          //   fontFamily:
                                          //   'assets/fonts/Poppins/Poppins-Regular.ttf',
                                          //   color: myColors.black,
                                          // ),),
                                          TextField(
                                            enabled: widget.workStatusId
                                                .toString() == "1" ||
                                                widget.workStatusId
                                                    .toString() == "3" || finish_date != "null"
                                                ? false
                                                : true,
                                            controller: commentController,
                                            focusNode: comment_focus,
                                            keyboardType: TextInputType
                                                .multiline,
                                            textInputAction: TextInputAction
                                                .newline,
                                            onChanged: (String value) {
                                              print("TAG" + value);
                                              setState(() {});
                                            },
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              fontFamily:
                                              'assets/fonts/Poppins/Poppins-Regular.ttf',
                                              color: myColors.black,
                                            ),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter comment",
                                                hintStyle: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: myColors.grey_six,
                                                    fontFamily:
                                                    "assets/fonts/Poppins/Poppins-Regular.ttf"),
                                                counter: Offstage(),
                                                isDense: true,
                                                // this will remove the default content padding
                                                contentPadding:
                                                EdgeInsets.fromLTRB(0, 8, 0, 0)
                                            ),
                                            maxLines: 2,
                                            cursorColor: myColors.black,
                                          ),
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              ),
                              //Save Button..................................................................................................
                              status_toggle == false ? Container() :
                              taskModel.isEmpty ? Container() : taskModel.first
                                  .taskLogInfo!.completionDate.toString() !=
                                  "null" ?
                              Container() :
                              commentController.text.isEmpty
                                  ? Container()
                                  : InkWell(
                                onTap:
                                // locName == "Work In Progress"
                                //     ? () {}
                                //     :
                                    () {
                                  if (widget.taskLogId
                                      .toString()
                                      .isEmpty ||
                                      widget.taskLogId.toString() == "" ||
                                      widget.taskLogId.toString() == "null") {
                                    CustomToast.showToast(
                                        msg: "tasklog Id is null ");
                                  }
                                  else if (select_onHold_Id.toString() == "" ||
                                      select_onHold_Id
                                          .toString()
                                          .isEmpty) {
                                    CustomToast.showToast(
                                        msg: "Please select on hold reason");
                                  }
                                  // else if(commentController.text.trim().isEmpty){
                                  //   CustomToast.showToast(msg: "Please enter comment");
                                  // }
                                  else {
                                    OnholdReasonapiCall();
                                  }

                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 14, right: 16, top: 30, bottom: 0),
                                  child: GlobalThemeButton(
                                    buttonName: taskModel.isEmpty ||
                                        taskModel.first.taskLogInfo!
                                            .onHoldReason
                                            .toString() ==
                                            "null" ? MyString.SAVE : "Update",
                                    buttonColor: myColors.app_theme,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),

                        ///line..................
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          height: 1.2,
                          color: myColors.grey_twelve,
                        ),

                        /// Save button................
                        /*  Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                        color: myColors.app_theme,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            fontFamily:
                            "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),*/

                        ///Updates Cooment..................
                        // locName == "Work In Progress"
                        //     ? Container()
                        //:
                        /* Container(
                padding: EdgeInsets.only(left: 15, right: 16, top: 8),
                child: CustomText.CustomSemiBoldText(
                    "Updates",
                    myColors.dark_grey_txt,
                    FontWeight.w600,
                    14,
                    1,
                    TextAlign.center),
              ),*/

                        ///Updates list Grid....................
                        // locName == "Work In Progress"
                        //     ? Container()
                        //     :

                        //   widget.title == "PPM W/O" ?
                        /* Container(
                padding: EdgeInsets.fromLTRB(10, 16, 16, 0),
                child: GridView.count(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 3,
                    childAspectRatio: 2 / 2.4,
                    children: List.generate(updates_list.length, (index) {
                      return InkWell(
                        onTap: () {
                          print("updates_list[index].title>${updates_list[index]
                              .title}");

                          ///Resources...........................................
                          if (updates_list[index].title == "Resources") {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PPM_Resources_Screen(
                                taskResourceslist: taskResourceslist,
                                taskModel: taskModel,
                                resourcesModel: resourceslist,
                                masterResourceslist: masterResourceslist,
                                title: title,
                                appbartitle: widget.title == "Soft Services PM W/O" ? "schedule" :"",
                                taskLogId: widget.taskLogId, serviceId: widget.serviceId.toString(),),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                              PageTransitionAnimation.fade,
                            );
                            setState(() {});
                          }

                          ///Checklist...........................................
                          else if (updates_list[index].title == MyString.Checklist) {
                            print("hjbhdj${start_date.toString()}");
                            // if (checklist_questionanswer.toString() != "null") {
                            //   Fluttertoast.showToast(
                            //       msg: "CheckListItem Already submit");
                            // } else
                            if (start_date.toString() == "null" || start_date
                                .toString()
                                .isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please first start date");
                            }
                            else {
                              print("checklist${checklist.length}");
                              print("checklist.first.questions!>>${checklist.first.questions}");

                              checklist.isEmpty  ||  checklist.toString() == "null"
                                  ? null
                                  : PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: PPM_Checklist_Screen(
                                  taskId: widget
                                      .taskLogId,
                                  onCallback: OnCallback,
                                  checkListItems: checklist[0],
                                  //  Oncallback: OnCallback,
                                  categoryName: categoryName == "null" ||
                                      categoryName.isEmpty ? "" : categoryName,
                                  title: taskloginfolist!.title.toString() ==
                                      "null" || taskloginfolist!.title!.isEmpty
                                      ? ""
                                      : taskloginfolist!.title.toString(),
                                  isquestionanswer: checklist_questionanswer,
                                  checkquestionAnswerlist: checkquestionAnswerlist,
                                  screent_title: title, appbartitle: widget.title == "Soft Services PM W/O" ? "schedule" :"",
                                ),
                                withNavBar: false,
                                // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                              );
                            }


                            setState(() {});
                          }

                          ///Summary...........................................
                          else if (updates_list[index].title == "Summary") {
                            print("resourcesModel>${resourceslist.length}");
                            print("resourcesModelid>${resourceId}");
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PPM_Summary_Screen(
                                taskResourceslist: taskResourceslist,
                                resourcesModel: resourceslist,
                                taskModel: taskModel,
                                onCallback: OnCallback,
                                tasklogId: widget.taskLogId,
                                title: title, appbartitle: widget.title,),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                              PageTransitionAnimation.fade,
                            );
                            setState(() {});
                          }

                          ///Document...........................................
                          else if (updates_list[index].title == "Documents") {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PPM_Documents_Screen(
                                tasklogId: widget.taskLogId,
                                title: widget.title, appbartitle: widget.title == "Soft Services PM W/O" ? "schedule" :"",),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                              PageTransitionAnimation.fade,
                            );
                            setState(() {});
                          }

                          ///Images...........................................
                          else if (updates_list[index].title == "Images") {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PPM_Images_Screen(
                                task_logId: widget.taskLogId,
                                title: widget.title,appbartitle: widget.title == "Soft Services PM W/O" ? "schedule" :""),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                              PageTransitionAnimation.fade,
                            );
                            setState(() {});
                          }

                          ///New MR...........................................
                          else if (updates_list[index].title == "New MR") {
                            print("widget.serviceId>>${widget.serviceId}");
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PPM_MR_View(title: widget.title, taskLogId: widget.taskLogId, taskTypeId: widget.serviceId, projectId: taskloginfolist!.projectId.toString() == "null" ?"": taskloginfolist!.projectId.toString() ,),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.fade,
                            );

                            setState(() {});
                          }

                          ///Meter Readings...........................................
                          else if (updates_list[index].title == "Meter Readngs") {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PPM_Meter_Reading_Screen(),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                              PageTransitionAnimation.fade,
                            );
                            setState(() {});
                          }

                          ///New Workorder...........................................
                          else if (updates_list[index].title == "New W/O") {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PPM_New_Workorder_Screen(title: widget.title,
                                  appbartitle: widget.title == "Soft Services PM W/O" ? "schedule" :"",
                                  assetcode: taskModel
                                  .first.taskLogInfo!.assetCode
                                  .toString(), ServiceId: "3", ppmId:  taskloginfolist != null
                                  ? "${taskloginfolist!.securityInfoId}"
                                  : "", parentId: taskloginfolist != null ? int.parse(taskloginfolist!.id.toString())  : 0),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                              PageTransitionAnimation.fade,
                            );
                            setState(() {});
                          }

                          ///Evaluation...........................................
                          else if (updates_list[index].title == "Evaluation") {
                            print("feedbackComment.toString()>>${feedbackComment.toString()}");
                            if(feedbackComment.toString() == "null"){
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: PPM_Evaluation_Screen(TasklogId: widget.taskLogId.toString(), oncallback: Onupdategeralapi,),
                                withNavBar: false,
                                // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                              );
                            }else{

                            }

                            setState(() {});
                          }
                        },
                        child:   UpdatesListGrid(
                          index: index, feedbackcomment: feedbackComment,
                        ),
                      );
                    })),
              ),*/
                        //  :Container(),

                        /// Comment Accept Reject Button...........................
                        /*     widget.workStatusId.toString() != "1" ?Container():
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 130,
                      child: ElevatedButton(
                          onPressed: (){
                            print("resourceId${resourceId}");
                            acceptRejectApiCall(int.parse(resourceId), 2);
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(onPrimary: Colors.white,primary: myColors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text("Accept",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily:
                            'assets/fonts/DM_Sans/DMSans-Regular.ttf',
                            color: myColors.white,
                          ),)),
                    ),

                    SizedBox(width: 30,),

                    Container(
                      width: 130,
                      height: 50,
                      child: ElevatedButton(onPressed: (){

                        acceptRejectApiCall(int.parse(resourceId), 3);
                        CustomLoader.RejectDialog(context: context,title:" model.securityInfoId",haeding:"Reject",onCallback: OnCallBackcomment,onTapofYes: (){

                        }, controller: commentController);
                        setState(() {});
                      },
                          style: ElevatedButton.styleFrom(onPrimary: Colors.white,primary: myColors.red,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          child: Text("Reject",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily:
                            'assets/fonts/DM_Sans/DMSans-Regular.ttf',
                            color: myColors.white,
                          ),)),
                    )
                  ],
                ),
              ),
*/

                        ///

                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),

                  /// Asssign Resources Listview...........
                  taskResourceslist.isEmpty
                      ? Container()
                      : Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: taskResourceslist.length,
                        itemBuilder: (context, int index) {
                          return Container(
                              child: AssignResorcesUicardui(index));
                        }),
                  ),

                  hsized50

                ],
              )
          ),
        )
    );
  }




  /// Building Dropdown....................
  buildingdropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Building",
            style: TextStyle(
                fontSize: 12,
                color: myColors.black,
                fontFamily: "PlusJakartaSansBold",
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            //  margin: EdgeInsets.only(left: 25,right: 25),
            child: DropdownButtonHideUnderline(
              child: IgnorePointer(
                ignoring: true,
                child: DropdownButton2<String>(
                  isExpanded: true,
                  iconStyleData: IconStyleData(
                    icon: SvgPicture.asset(
                      "assets/images/dropDown.svg",
                      color: myColors.grey_five,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.yellow,
                    iconDisabledColor: Colors.grey,
                  ),
                  // barrierColor: MyColor.app_theme.withOpacity(0.60),
                  style: TextStyle(
                      color: myColors.grey_five,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: "PlusJakartaSansSemibold"),
                  //
                  hint: Text(
                    widget.buildingname,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: "PlusJakartaSansSemibold",
                      fontWeight: FontWeight.w400,
                      color: myColors.black,
                    ),
                  ),
                  items: dropdownlist
                      .map((String item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          widget.buildingname,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "PlusJakartaSansSemibold",
                            fontWeight: FontWeight.w400,
                            color: myColors.black,
                          ),
                        ),
                      )
                  )
                      .toList(),
                  dropdownStyleData: DropdownStyleData(
                    // width: 120,

                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: myColors.white,
                    ),
                    offset: const Offset(5, 4),
                  ),
                  value: selected_country,
                  onChanged: (String? value) {
                    setState(() {
                      selected_country = value.toString();
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Location Store Dropdown....................
  location_store_dropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location / Store",
            style: TextStyle(
                fontSize: 12,
                color: myColors.grey_five,
                fontFamily: "PlusJakartaSansBold",
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 45.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            //  margin: EdgeInsets.only(left: 25,right: 25),
            child: DropdownButtonHideUnderline(
              child: IgnorePointer(
                ignoring: true,
                child: DropdownButton2<String>(
                  isExpanded: true,
                  iconStyleData: IconStyleData(
                    icon: SvgPicture.asset(
                      "assets/images/dropDown.svg",
                      color: myColors.grey_five,
                    ),
                    iconSize: 14,

                  ),
                  // barrierColor: MyColor.app_theme.withOpacity(0.60),
                  style: TextStyle(
                      color: myColors.grey_five,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: "PlusJakartaSansSemibold"),
                  //
                  hint: Text(
                    widget.loaction,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: "PlusJakartaSansSemibold",
                      fontWeight: FontWeight.w400,
                      color: myColors.black,
                    ),
                  ),
                  items: dropdownlist
                      .map((String item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          widget.locationName,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "PlusJakartaSansSemibold",
                            fontWeight: FontWeight.w400,
                            color: myColors.black,
                          ),
                        ),
                      ))
                      .toList(),
                  dropdownStyleData: DropdownStyleData(
                    // width: 120,
                    // padding:  EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: myColors.white,
                    ),
                    offset: const Offset(5, 4),
                  ),
                  value: selected_country,
                  onChanged: (String? value) {
                    setState(() {
                      selected_country = value.toString();
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40
                    ,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Unit Dropdown....................
  unitdropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Unit",
            style: TextStyle(
                fontSize: 12,
                color: myColors.grey_five,
                fontFamily: "PlusJakartaSansBold",
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            //  margin: EdgeInsets.only(left: 25,right: 25),
            child: DropdownButtonHideUnderline(
              child: IgnorePointer(
                ignoring: true,
                child: DropdownButton2<String>(
                  isExpanded: true,
                  iconStyleData: IconStyleData(
                    icon: SvgPicture.asset(
                      "assets/images/dropDown.svg",
                      color: myColors.grey_five,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.yellow,
                    iconDisabledColor: Colors.grey,
                  ),
                  // barrierColor: MyColor.app_theme.withOpacity(0.60),
                  style: TextStyle(
                      color: myColors.grey_five,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: "PlusJakartaSansSemibold"),
                  //
                  hint: Text(
                    widget.unitName,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: "PlusJakartaSansSemibold",
                      fontWeight: FontWeight.w400,
                      color: myColors.black,
                    ),
                  ),
                  items: dropdownlist
                      .map((String item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          widget.unitName,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "PlusJakartaSansSemibold",
                            fontWeight: FontWeight.w400,
                            color: myColors.black,
                          ),
                        ),
                      ))
                      .toList(),
                  dropdownStyleData: DropdownStyleData(
                    // width: 120,

                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: myColors.white,
                    ),
                    offset: const Offset(5, 4),
                  ),
                  value: selected_country,
                  onChanged: (String? value) {
                    setState(() {
                      selected_country = value.toString();
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Floor Dropdown....................
  floordropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Floor",
            style: TextStyle(
                fontSize: 12,
                color: myColors.grey_five,
                fontFamily: "PlusJakartaSansBold",
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            //  margin: EdgeInsets.only(left: 25,right: 25),
            child: DropdownButtonHideUnderline(
              child: IgnorePointer(
                ignoring: true,
                child: DropdownButton2<String>(
                  isExpanded: true,
                  iconStyleData: IconStyleData(
                    icon: SvgPicture.asset(
                      "assets/images/dropDown.svg",
                      color: myColors.grey_five,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.yellow,
                    iconDisabledColor: Colors.grey,
                  ),
                  // barrierColor: MyColor.app_theme.withOpacity(0.60),
                  style: TextStyle(
                      color: myColors.grey_five,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: "PlusJakartaSansSemibold"),
                  //
                  hint: Text(
                    widget.floorName,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: "PlusJakartaSansSemibold",
                      fontWeight: FontWeight.w400,
                      color: myColors.black,
                    ),
                  ),
                  items: dropdownlist
                      .map((String item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          widget.floorName,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "PlusJakartaSansSemibold",
                            fontWeight: FontWeight.w400,
                            color: myColors.black,
                          ),
                        ),
                      ))
                      .toList(),
                  dropdownStyleData: DropdownStyleData(
                    // width: 120,

                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: myColors.white,
                    ),
                    offset: const Offset(5, 4),
                  ),
                  value: selected_country,
                  onChanged: (String? value) {
                    setState(() {
                      selected_country = value.toString();
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AssignResorcesUicardui(int index) {
    return Container(
      child: Container(
        alignment: Alignment.center,
        //  height: 290,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        margin: EdgeInsets.fromLTRB(16, 10, 16, 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: myColors.newBar_1),
            color: myColors.purple_2.withOpacity(0.40)),
        child: Column(
          children: [

            ///User info...........
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  margin: EdgeInsets.only(top: 8),
                  child: CircleAvatar(
                    maxRadius: 80,
                    child: resourceslist.isEmpty
                        ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/user_img.png",
                          fit: BoxFit.cover,
                          height: 100,
                        ))
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: resourceslist.first.imageUrl == null
                          ? Image.asset(
                        "assets/images/user_img.png",
                        height: 100,
                      )
                          : Image.network(
                        resourceslist.first.imageUrl.toString(),
                        fit: BoxFit.cover,
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
                            height: 120,
                            width: 100,
                          );
                        },
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(12, 8, 0, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(
                                taskResourceslist[index].resourceName == null
                                    ? ""
                                    : taskResourceslist[index]
                                    .resourceName
                                    .toString(),
                                myColors.dark_grey_txt,
                                FontWeight.w500,
                                14,
                                1,
                                TextAlign.start)),
                        taskResourceslist[index].resourceName == null
                            ? Container()
                            : Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(
                                taskResourceslist[index]
                                    .designation
                                    .toString(),
                                myColors.app_theme,
                                FontWeight.w500,
                                12,
                                1,
                                TextAlign.center)),
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(
                                resourceslist.isNotEmpty
                                    ? resourceslist.first.email.toString()
                                    : "",
                                myColors.grey_eight,
                                FontWeight.w400,
                                12,
                                1,
                                TextAlign.center)),
                      ],
                    ),
                  ),
                ),
                /* GestureDetector(
                  onTap: () {
                    CustomNavigator.pushNavigate(
                        context, ResourceAssignedScreen());
                  },
                  child: Container(
                    padding:  EdgeInsets.all(10.0),
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        color: myColors.app_theme,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "View Details",
                      style: TextStyle(
                          fontFamily:
                          "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )*/

                //active.........
                /*  Container(
                  alignment: Alignment.centerRight,
                  // width: 100,
                  child: Row(
                    children: [
                      Container(
                        height: 9,
                        width: 9,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50)),
                          color: myColors.active_green,
                        ),
                      ),
                      Container(
                        //  width: 35,
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          resourceslist.isNotEmpty
                              ? resourceslist[0].status
                              .toString()
                              : "",
                          style: TextStyle(
                            color: myColors.active_green,
                            fontWeight: FontWeight.w500,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),

            ///Call whatsapp.......
            Container(
              padding: EdgeInsets.only(
                  top: 12, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [


                        ///SMS.............................
                        Column(
                          children: [
                            Container(
                              width: icon_width,
                              height: icon_width,
                              margin:
                              EdgeInsets.only(left: 0, top: 6),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                                border: Border.all(
                                    color: myColors.app_theme),
                              ),
                              child: Image.asset(
                                  "assets/images/img_whatsapp_theme.png",color: myColors.app_theme,),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: CustomText
                                  .CustomRegularText(
                                  "sms",
                                  myColors.grey_fourteen,
                                  FontWeight.w400,
                                  icon_fontsize,
                                  1,
                                  TextAlign.center),
                            ),
                          ],
                        ),

                        /// Call.........................
                        Column(
                          children: [
                            Container(
                              width: icon_width,
                              height: icon_height,
                              margin:
                              EdgeInsets.only(left: 8, top: 6),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                                border: Border.all(
                                    color: myColors.app_theme),
                              ),
                              child: Image.asset(
                                  "assets/icons/img_phone_theme.png",color: myColors.app_theme,),
                            ),
                            Container(
                              margin:
                              EdgeInsets.only(left: 4, top: 2),
                              child: CustomText
                                  .CustomRegularText(
                                  "call",
                                  myColors.grey_fourteen,
                                  FontWeight.w400,
                                  icon_fontsize,
                                  1,
                                  TextAlign.center),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  /// Right side icon...............
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [

                          /// Contact..........................
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  status_assigned = "contact";
                                  status_assignedID =
                                      taskResourceslist[index].id
                                          .toString();
                                  setState(() {});
                                },
                                child: Container(
                                  width: icon_width,
                                  height: icon_width,
                                  margin: EdgeInsets.only(
                                      left: 0, top: 6),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                        color: myColors
                                            .app_theme),
                                    color: taskResourceslist[index]
                                        .assignedDate
                                        .toString() != "null" ||
                                        taskResourceslist[index]
                                            .assignedDate
                                            .toString()
                                            .isNotEmpty ?

                                    myColors.app_theme :
                                    status_assignedID ==
                                        taskResourceslist[index]
                                            .id.toString() &&
                                        status_assigned ==
                                            "contact"
                                        ? myColors.white
                                        : myColors.blue_lightest,
                                  ),
                                  child: Image.asset(
                                    "assets/images/check_circle_white.png",
                                    color:
                                    taskResourceslist[index]
                                        .assignedDate
                                        .toString() != "null" ||
                                        taskResourceslist[index]
                                            .assignedDate
                                            .toString()
                                            .isNotEmpty ?

                                    myColors.white :
                                    status_assignedID ==
                                        taskResourceslist[index]
                                            .id.toString() &&
                                        status_assigned ==
                                            "contact"
                                        ? myColors.white
                                        : myColors.app_theme,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: CustomText
                                    .CustomRegularText(
                                    "contact",
                                    myColors.grey_fourteen,
                                    FontWeight.w400,
                                    icon_fontsize,
                                    1,
                                    TextAlign.center),
                              ),
                            ],
                          ),


                          /// Start ...............
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .center,
                            children: [
                              InkWell(
                                onTap: () {
                                  AcceptRejectFunction("start",
                                      taskResourceslist[index].resourceId
                                          .toString(),"","");
                                },
                                /* widget.workStatusId ==
                                    "1" || widget.workStatusId
                                    .toString() == "3" ? () {
                                  Fluttertoast.showToast(
                                      msg: "Please first accept workorder");
                                } : start_date.toString() !=
                                    "null" ? () {
                                  Fluttertoast.showToast(
                                      msg: "Already start workorder");
                                } : () {
                                  print("bhbfh>>${start_date}");
                                  print(
                                      "hseqlist>>${hseqlist.first
                                          .questions!.length}");
                                  status_assigned = "start";
                                  setState(() {});
                                  if (hseqlist.isEmpty) {

                                  } else {
                                    if (questionanswer ==
                                        "null") {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  PPM_HESQ_Quitionaire_Screen(
                                                    taskId: widget
                                                        .taskLogId,
                                                    onCallback: OnCallback,
                                                    hseqlist: hseqlist[0],
                                                    Oncallback: OnCallback,
                                                  title:widget.title ,)));
                                    } else {
                                      acceptRejectApiCall(
                                          int.parse(
                                              taskResourceslist[index]
                                                  .resourceId
                                                  .toString()),
                                          4);
                                    }
                                  }
                                },*/
                                child: Container(
                                  width: icon_width,
                                  height: icon_width,
                                  margin: EdgeInsets.only(
                                      left: 6, top: 6),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                        color: myColors
                                            .app_theme),
                                    color:

                                    taskResourceslist[index]
                                        .startedDate
                                        .toString() != "null"
                                        ? myColors.app_theme :
                                    status_assignedID ==
                                        taskResourceslist[index]
                                            .id.toString() &&
                                        status_assigned == "start"
                                        ?
                                    myColors.app_theme
                                        : myColors.blue_lightest,
                                  ),
                                  child: Image.asset(
                                    "assets/icons/img_play_theme.png",
                                    color: taskResourceslist[index]
                                        .startedDate
                                        .toString() != "null"
                                        ? myColors.white :
                                    status_assignedID ==
                                        taskResourceslist[index]
                                            .id.toString() &&
                                        status_assigned == "start"
                                        ? myColors.white
                                        : myColors.app_theme,
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(left: 8, top: 2),
                                child: CustomText
                                    .CustomRegularText(
                                    "start",
                                    myColors.grey_fourteen,
                                    FontWeight.w400,
                                    icon_fontsize,
                                    1,
                                    TextAlign.center),
                              ),
                            ],
                          ),


                          /// Contain ...............
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .center,
                            children: [
                              InkWell(
                                onTap: (){
                                  AcceptRejectFunction("contain", taskResourceslist[index].resourceId.toString(),taskResourceslist[index].startedDate.toString(),"null");
                                         },
                               /* widget.workStatusId ==
                                    "1" || widget.workStatusId
                                    .toString() == "3" ? () {
                                  Fluttertoast.showToast(
                                      msg: "Please first accept workorder");
                                } : containDate.toString() !=
                                    "null" ? () {
                                  Fluttertoast.showToast(
                                      msg: "Already Contain workorder");
                                } : () {
                                  status_assigned = "contain";
                                  setState(() {});
                                  if (start_date ==
                                      "null") {
                                    CustomToast.showToast(
                                        msg: "Please first start workorder");
                                  } else {
                                    acceptRejectApiCall(
                                        int.parse(
                                            taskResourceslist[index]
                                                .resourceId
                                                .toString()),
                                        6);
                                  }
                                },*/
                                child: Container(
                                  width: icon_width,
                                  height: icon_width,
                                  margin: EdgeInsets.only(
                                      left: 6, top: 6),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                        color: myColors
                                            .app_theme),
                                    color:

                                    taskResourceslist[index]
                                        .containDate
                                        .toString() != "null"
                                        ? myColors.app_theme :
                                    status_assignedID ==
                                        taskResourceslist[index]
                                            .id.toString() &&
                                        status_assigned == "contain"
                                        ?
                                    myColors.app_theme
                                        : myColors.blue_lightest,
                                  ),
                                  child: Image.asset(
                                    "assets/images/contain_icon.png",
                                    // color: taskResourceslist[index]
                                    //     .containDate
                                    //     .toString() != "null"
                                    //     ? myColors.white :
                                    // status_assignedID ==
                                    //     taskResourceslist[index]
                                    //         .id.toString() &&
                                    //     status_assigned == "contain"
                                    //     ? myColors.white
                                    //     : null,
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(left: 8, top: 2),
                                child: CustomText
                                    .CustomRegularText(
                                    "Contain",
                                    myColors.grey_fourteen,
                                    FontWeight.w400,
                                    icon_fontsize,
                                    1,
                                    TextAlign.center),
                              ),
                            ],
                          ),


                          /// Finish..................
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .center,
                            children: [
                              InkWell(
                                onTap: () {
                                  AcceptRejectFunction("finish",
                                      taskResourceslist[index].resourceId
                                          .toString(), taskResourceslist[index].startedDate.toString(),taskResourceslist[index].containDate.toString());
                                },
                                // widget.workStatusId ==
                                //     "1" || widget.workStatusId
                                //     .toString() == "3"
                                //     ? () {}
                                //     : compleated_date
                                //     .toString() != "null" ? () {
                                //   Fluttertoast.showToast(
                                //       msg: "Already Finsih workorder");
                                // } : () {
                                //   status_assigned = "finish";
                                //   print(
                                //       "taskResourceslist[index].startedDate.toString()${taskResourceslist[index]
                                //           .startedDate
                                //           .toString()}");
                                //   setState(() {});
                                //   if (taskResourceslist[index]
                                //       .startedDate.toString() ==
                                //       "null") {
                                //     Fluttertoast.showToast(
                                //         msg: "Please first start");
                                //   }else if(taskResourceslist[index]
                                //       .containDate.toString() ==
                                //       "null"){
                                //     Fluttertoast.showToast(
                                //         msg: "Please first Contain");
                                //   }
                                //   else{
                                //    if(widget.title == "PPM W/O" || widget.title == "Soft Services PM W/O"){
                                //   if(checklist.first.questions != null && checklist.first.answers != null){
                                //
                                //   if(checklist_questionanswer.toString() == "null" || checklist_questionanswer.isEmpty || checklist_questionanswer == ""){
                                //   Fluttertoast.showToast(
                                //   msg: "PPm checklist question should have atleast one answers.");
                                //   }else{
                                //     acceptRejectApiCall(int.parse(
                                //         taskResourceslist[index]
                                //             .resourceId
                                //             .toString()), 5);
                                //     setState(() {});
                                //   }
                                //
                                //   }else{
                                //      acceptRejectApiCall(int.parse(
                                //          taskResourceslist[index]
                                //              .resourceId
                                //              .toString()), 5);
                                //      setState(() {});
                                //    }}else{
                                //      acceptRejectApiCall(int.parse(
                                //          taskResourceslist[index]
                                //              .resourceId
                                //              .toString()), 5);
                                //      setState(() {});
                                //    }
                                //
                                //   }
                                // },
                                child: Container(
                                  width: icon_width,
                                  height: icon_width,
                                  margin: EdgeInsets.only(
                                      left: 8, top: 6),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                        color: myColors
                                            .app_theme),
                                    color: compleated_date
                                        .toString() != "null" &&
                                        compleated_date
                                            .isNotEmpty &&
                                        compleated_date != "" ?
                                    myColors.app_theme :
                                    status_assignedID ==
                                        taskResourceslist[index]
                                            .id.toString() &&
                                        status_assigned ==
                                            "finish"
                                        ? myColors.app_theme
                                        : myColors.blue_lightest,
                                  ),
                                  child: Image.asset(
                                      status_assignedID ==
                                          taskResourceslist[index]
                                              .id.toString() &&
                                          status_assigned ==
                                              "finish"
                                          ? "assets/images/img_finished_white.png"
                                          : "assets/images/img_finished_red.png"),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin:
                                EdgeInsets.only(left: 8, top: 2),
                                child: CustomText
                                    .CustomRegularText(
                                    "finish",
                                    myColors.grey_fourteen,
                                    FontWeight.w400,
                                    icon_fontsize,
                                    1,
                                    TextAlign.center),
                              ),
                            ],
                          ),

                          /// Scan......................
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  print("fjkbfg");

                                  if (taskResourceslist[index].startedDate.toString() == "null" || taskResourceslist[index].containDate.toString() == "null" || taskResourceslist[index].finishedDate.toString() == "null") {
                                  var  res = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const SimpleBarcodeScannerPage(
                                            lineColor: "#ff6666",
                                            isShowFlashIcon: true,
                                            scanType: ScanType.barcode,
                                            centerTitle: false,
                                          ),
                                        ));

                                    setState(() async {
                                      if (res is String) {
                                        asset_code = res;
                                        if (res.toString() == "false") {
                                          CustomToast.showToast(
                                              msg: "Invalid Asset Code");
                                        } else {
                                          RequestWODetailScan(true,taskResourceslist[index].resourceId.toString(),taskResourceslist[index].startedDate
                                              .toString(),taskResourceslist[index].containDate
                                              .toString(),taskResourceslist[index].finishedDate
                                              .toString());

                                        }
                                      }
                                    });
                                  }
                                   else {

                                  }

                                  setState(() {});
                                },
                                child: Container(
                                  width: icon_width,
                                  height: icon_width,
                                  margin: EdgeInsets.only(
                                      left: 8, top: 6),
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                        color: myColors
                                            .app_theme),
                                  ),
                                  child:
                                  Image.asset(
                                      "assets/images/img_scanner_blue.png"),
                                ),
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(left: 6, top: 2),
                                child: CustomText
                                    .CustomRegularText(
                                    "scan",
                                    myColors.grey_fourteen,
                                    FontWeight.w400,
                                    icon_fontsize,
                                    1,
                                    TextAlign.center),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///1  Contacted ...........
            Container(
              height: 34,
              margin: EdgeInsets.fromLTRB(0, 12, 0, 4),
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(5)),
                  color: myColors.white.withOpacity(0.90)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
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
                        taskResourceslist[index].assignedDate
                            .toString() == "null"
                            ? taskResourceslist[index]
                            .assignedDate.toString()
                            : DateFormat.d().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .assignedDate.toString())) +
                            "-" + DateFormat.MMM().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .assignedDate.toString())) +
                            "-" + DateFormat.y().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .assignedDate.toString())) +
                            " " + DateFormat("HH:mm").format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .assignedDate.toString())),
                        myColors.dark_grey_txt,
                        FontWeight.w500,
                        12,
                        1,
                        TextAlign.center),
                  ),
                ],
              ),
            ),

            ///2  Started ...........
            Container(
              height: 34,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(5)),
                  color: myColors.white.withOpacity(0.90)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
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
                        taskResourceslist[index].startedDate
                            .toString() == "null"
                            ? "N/A"
                            : DateFormat.d().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .startedDate.toString())) +
                            "-" + DateFormat.MMM().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .startedDate.toString())) +
                            "-" + DateFormat.y().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .startedDate.toString())) +
                            " " + DateFormat("HH:mm").format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .startedDate.toString())),
                        myColors.dark_grey_txt,
                        FontWeight.w500,
                        12,
                        1,
                        TextAlign.center),
                  ),
                ],
              ),
            ),

            /// 3 Contained ...........
            Container(
              height: 34,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(5)),
                  color: myColors.white.withOpacity(0.90)
                  // color: myColors.grey_white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Center(
                              child: Image.asset(
                                "assets/images/contain_icon.png",
                                height: 16,
                                width: 16,
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 8),
                          child: CustomText.CustomMediumText(
                              "Contained",
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
                        taskResourceslist[index].containDate
                            .toString() == "null"
                            ? "N/A"
                            : DateFormat.d().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .containDate.toString())) +
                            "-" + DateFormat.MMM().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .containDate.toString())) +
                            "-" + DateFormat.y().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .containDate.toString())) +
                            " " + DateFormat("HH:mm").format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .containDate.toString())),
                        myColors.dark_grey_txt,
                        FontWeight.w500,
                        12,
                        1,
                        TextAlign.center),
                  ),
                ],
              ),
            ),

            ///4  Finished ...........
            Container(
              height: 34,
              margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(5)),
                  color: myColors.white.withOpacity(0.90)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
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
                        taskResourceslist[index].finishedDate
                            .toString() == "null"
                            ? "N/A"
                            : DateFormat.d().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .finishedDate.toString())) +
                            "-" + DateFormat.MMM().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .finishedDate.toString())) +
                            "-" + DateFormat.y().format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .finishedDate.toString())) +
                            " " + DateFormat("HH:mm").format(
                            DateTime.parse(
                                taskResourceslist[index]
                                    .finishedDate.toString())),
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
    );
  }

  setgridviewitem() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isBlueCollar = preferences.getString("isBlueCollar").toString();
    print("isBlueCollar>>${isBlueCollar}");
    setState(() {});
    if (isBlueCollar == "true") {
      if (widget.title == "PPM W/O") {
        updates_list = [
          UpdatesListModel(MyString.Checklist, "assets/icons/ic_book.svg"),
          UpdatesListModel("Summary", "assets/icons/ic_firstline.svg"),
          UpdatesListModel("Documents", "assets/icons/ic_document_download.svg"),
          UpdatesListModel("Images", "assets/icons/ic_gallery.svg"),
          UpdatesListModel("New MR", "assets/icons/ic_mouse_square.svg"),
          UpdatesListModel("New W/O", "assets/icons/ic_document_text.svg"),
        ];
      } else if (widget.title == "Soft Services PM W/O") {
        updates_list = [
          UpdatesListModel(MyString.Checklist, "assets/icons/ic_book.svg"),
          UpdatesListModel("Summary", "assets/icons/ic_firstline.svg"),
          UpdatesListModel(
              "Documents", "assets/icons/ic_document_download.svg"),
          UpdatesListModel("Images", "assets/icons/ic_gallery.svg"),
          UpdatesListModel("New MR", "assets/icons/ic_mouse_square.svg"),
        ];
      } else if (widget.title == "Reactive W/O") {
        updates_list = [
          UpdatesListModel("Summary", "assets/icons/ic_firstline.svg"),
          UpdatesListModel(
              "Documents", "assets/icons/ic_document_download.svg"),
          UpdatesListModel("Images", "assets/icons/ic_gallery.svg"),
          UpdatesListModel("Evaluation", "assets/icons/ic_emoji_normal.svg"),
          UpdatesListModel("New MR", "assets/icons/ic_mouse_square.svg"),
        ];
      } else {
        updates_list = [
          UpdatesListModel("Summary", "assets/icons/ic_firstline.svg"),
          UpdatesListModel(
              "Documents", "assets/icons/ic_document_download.svg"),
          UpdatesListModel("Images", "assets/icons/ic_gallery.svg"),
          UpdatesListModel("New MR", "assets/icons/ic_mouse_square.svg"),
          //UpdatesListModel("Meter Readngs", "assets/icons/ic_radar.svg"),
          //  UpdatesListModel("New W/O", "assets/icons/ic_document_text.svg"),
          // UpdatesListModel("Evaluation", "assets/icons/ic_emoji_normal.svg"),
        ];
      }
    } else {
      if (widget.title == "PPM W/O") {
        updates_list = [
          UpdatesListModel("Resources", "assets/icons/ic_people.svg"),
          UpdatesListModel(MyString.Checklist, "assets/icons/ic_book.svg"),
          UpdatesListModel("Summary", "assets/icons/ic_firstline.svg"),
          UpdatesListModel(
              "Documents", "assets/icons/ic_document_download.svg"),
          UpdatesListModel("Images", "assets/icons/ic_gallery.svg"),
          UpdatesListModel("New MR", "assets/icons/ic_mouse_square.svg"),

          /// test
          UpdatesListModel("Meter Readngs", "assets/icons/ic_radar.svg"),
          UpdatesListModel("New W/O", "assets/icons/ic_document_text.svg"),
          // UpdatesListModel("Evaluation", "assets/icons/ic_emoji_normal.svg"),
        ];
      } else if (widget.title == "Soft Services PM W/O") {
        updates_list = [
          UpdatesListModel("Resources", "assets/icons/ic_people.svg"),
          UpdatesListModel(MyString.Checklist, "assets/icons/ic_book.svg"),
          UpdatesListModel("Summary", "assets/icons/ic_firstline.svg"),
          UpdatesListModel(
              "Documents", "assets/icons/ic_document_download.svg"),
          UpdatesListModel("Images", "assets/icons/ic_gallery.svg"),
          UpdatesListModel("New MR", "assets/icons/ic_mouse_square.svg"),

          /// test
          UpdatesListModel("Meter Readngs", "assets/icons/ic_radar.svg"),
          //UpdatesListModel("New W/O", "assets/icons/ic_document_text.svg"),
          // UpdatesListModel("Evaluation", "assets/icons/ic_emoji_normal.svg"),
        ];
      } else if (widget.title == "Reactive W/O") {
        updates_list = [
          UpdatesListModel("Resources", "assets/icons/ic_people.svg"),
          UpdatesListModel("Summary", "assets/icons/ic_firstline.svg"),
          UpdatesListModel(
              "Documents", "assets/icons/ic_document_download.svg"),
          UpdatesListModel("Images", "assets/icons/ic_gallery.svg"),
          UpdatesListModel("Evaluation", "assets/icons/ic_emoji_normal.svg"),
          UpdatesListModel("New MR", "assets/icons/ic_mouse_square.svg"),
        ];
      } else {
        updates_list = [
          UpdatesListModel("Resources", "assets/icons/ic_people.svg"),
          UpdatesListModel("Summary", "assets/icons/ic_firstline.svg"),
          UpdatesListModel(
              "Documents", "assets/icons/ic_document_download.svg"),
          UpdatesListModel("Images", "assets/icons/ic_gallery.svg"),
          UpdatesListModel("New MR", "assets/icons/ic_mouse_square.svg"),

          ///test
          UpdatesListModel("Meter Readngs", "assets/icons/ic_radar.svg"),
          //  UpdatesListModel("New W/O", "assets/icons/ic_document_text.svg"),
          // UpdatesListModel("Evaluation", "assets/icons/ic_emoji_normal.svg"),
        ];
      }
    }
  }

  getAllworkApi(bool load) async {
    getworklist.clear();
    setState(() {});
    await RequestGetWorkOrders(context, load, widget.serviceId, widget.statusId,
        widget.title == "Soft Services PM W/O" ? "schedule" : "");
    print("getworklist>>>>${widget.statusId}");
    setState(() {});
  }

  /// /// scan  Api call....
  RequestWODetailScan(bool load,String resourceId,String startdate,String containdate,String finishdate) async {
    setState(() {});
    await Webservices.RequestWODetailScreenscan(
        context, false, widget.taskLogId, asset_code, onUpdateacceptReject,resourceId,startdate,containdate,finishdate);
    setState(() {});
  }

  onUpdateacceptReject(String status,String resourceId,String startdate,String containdate,String finishdate) {
    getprojectmasterdataapi(false);
    if(status.toString() == "true"){
      if(startdate.trim().isEmpty || startdate.toString() == "null"){
        AcceptRejectFunction("start",resourceId,startdate,containdate);
      }else if(containdate.trim().isEmpty || containdate.toString() == "null"){
        AcceptRejectFunction("contain",resourceId,startdate,containdate);
      }else if(finishdate.trim().isEmpty || finishdate.toString() == "null"){
        AcceptRejectFunction("finish",resourceId,startdate,containdate);
      }
    }
  }


  AcceptRejectFunction(String status, String resourceId, String startedDate,
      String containDate) async {
    if (status == "start") {
      if (widget.workStatusId == "1" || widget.workStatusId.toString() == "3") {
        Fluttertoast.showToast(msg: "Please first Start Work order");

      } else if (start_date.toString() != "null") {

        Fluttertoast.showToast(msg: "Already start workorder");
      } else {
        status_assigned = "start";
        setState(() {});
        if (hseqlist.isEmpty) {
          Fluttertoast.showToast(msg: "Please Answer HSE Questions.");
        }
        else {
          if (questionanswer == "null" || questionanswer
              .trim()
              .isEmpty) {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) =>
                        PPM_HESQ_Quitionaire_Screen(
                          taskId: widget.taskLogId,
                          onCallback: OnCallback,
                          hseqlist: hseqlist.first,
                          Oncallback: OnCallback,
                          title: widget.title,
                          questionanswer: questionanswer,)));
          } else {
            acceptRejectApiCall(
                int.parse(
                    resourceId.toString()), 4);
          }
        }
      }
    }

    else if (status == "contain") {
      if (widget.workStatusId == "1" || widget.workStatusId.toString() == "3") {
        Fluttertoast.showToast(msg: "Please first Accept Work order");
      } else if (containDate.toString() != "null") {
        Fluttertoast.showToast(msg: "Already Contain workorder");
      } else {
        status_assigned = "contain";
        setState(() {});
        if (start_date ==
            "null") {
          CustomToast.showToast(
              msg: "Please first Start Work order");
        } else {
          acceptRejectApiCall(
              int.parse(resourceId), 6);
        }
      }
    }

    else if (status == "finish") {
      if (widget.workStatusId == "1" ||
          widget.workStatusId.toString() == "3") {} else
      if (compleated_date.toString() != "null") {
        Fluttertoast.showToast(msg: "Already Finsih work Order");
      } else {
        status_assigned = "finish";
        setState(() {});
        if (startedDate == "null") {
          Fluttertoast.showToast(msg: "Please first Start Work order");
        } else if (containDate == "null") {
          Fluttertoast.showToast(msg: "Please first Contain Work order");
        }
        else {
          if (widget.title == "PPM W/O" || widget.title == "Soft Services PM W/O") {
            if (checklist.first.questions != null &&
                checklist.first.answers != null) {
              if (checklist_questionanswer.toString() == "null" || checklist_questionanswer.trim().isEmpty ) {
                Fluttertoast.showToast(msg: "Please Answer Checklist.");
              }else if(checklist.first.questions!.length != checklist.first.questionAnswers!.length){
                Fluttertoast.showToast(msg: "Please Answer All Checklist.");
              }
              else {
                acceptRejectApiCall(int.parse(resourceId), 5);
                setState(() {});
              }
            } else {
              acceptRejectApiCall(int.parse(resourceId), 5);
              setState(() {});
            }
          } else {
            acceptRejectApiCall(int.parse(resourceId), 5);
            setState(() {});
          }
        }
      }
    }
  }

/*  AcceptRejectFunction(String status, String resourceId,String startedDate,String containDate) async {
    print("status>${status}");
    print("containDate>${containDate}");
    print("startedDate>${startedDate}");
    if (status == "start") {
      print("hseqlist>>${hseqlist.first.questions!.length}");
      if (widget.workStatusId == "1" || widget.workStatusId.toString() == "3") {
        Fluttertoast.showToast(
            msg: "Please first accept workorder");
      } else if (start_date.toString() != "null") {
        Fluttertoast.showToast(msg: "Already start workorder");
      } else {
        status_assigned = "start";
        setState(() {});
        if (hseqlist.isEmpty) {
          Fluttertoast.showToast(msg: "HSEQ questions empty");
        }
        else {
          if (questionanswer == "null") {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) =>
                        PPM_HESQ_Quitionaire_Screen(
                          taskId: widget
                              .taskLogId,
                          onCallback: OnCallback,
                          hseqlist: hseqlist[0],
                          Oncallback: OnCallback,
                          title: widget.title,)));
          } else {
            acceptRejectApiCall(
                int.parse(
                    resourceId.toString()), 4);
          }
        }
      }
    }
    else if(status == "contain"){
      if( widget.workStatusId == "1" || widget.workStatusId.toString() == "3"){
        Fluttertoast.showToast(msg: "Please first accept workorder");
      }else if(containDate.toString() != "null"){
        Fluttertoast.showToast(msg: "Already Contain workorder");
      }else {
        status_assigned = "contain";
        setState(() {});
        if (start_date ==
            "null") {
          CustomToast.showToast(
              msg: "Please first start workorder");
        } else {
          acceptRejectApiCall(
              int.parse(resourceId), 6);
        }
      }
    }
    else if(status == "finish"){
      if( widget.workStatusId == "1" || widget.workStatusId.toString() == "3"){
      }else if(compleated_date.toString() != "null"){
        Fluttertoast.showToast(msg: "Already Finsih workorder");
      }else {
        status_assigned = "finish";
        setState(() {});
        if (startedDate == "null") {
          Fluttertoast.showToast(
              msg: "Please first start");
        }else if(containDate == "null"){
          Fluttertoast.showToast(msg: "Please first Contain");
        }
        else{
          if(widget.title == "PPM W/O" || widget.title == "Soft Services PM W/O"){
            if(checklist.first.questions != null && checklist.first.answers != null){
              if(checklist_questionanswer.toString() == "null" || checklist_questionanswer.isEmpty || checklist_questionanswer == ""){
                Fluttertoast.showToast(
                    msg: "PPm checklist question should have atleast one answers.");
              }else{
                acceptRejectApiCall(int.parse(resourceId), 5);
                setState(() {});
              }
            }else{
              acceptRejectApiCall(int.parse(resourceId), 5);
              setState(() {});
            }}else{
            acceptRejectApiCall(int.parse(resourceId), 5);
            setState(() {});
          }

        }
      }
    }
  }*/

  /// GetProjectsMasterData Api call....
  getprojectmasterdataapi(bool load) async {
    projectlist.clear();
    setState(() {});
    await Webservices.RequestGetProjectsMasterData(
        context, widget.taskLogId, projectlist, load);
    if (projectlist.isNotEmpty) {
      print("ProjectId>>${projectlist.length}");
      ProjectId = projectlist.first.id.toString();
      setState(() {});
    }
    additionolinfo();
    getApi(true);
    updatetaskApi();
    setState(() {});
  }

  getApi(bool load) async {
    taskModel.clear();
    setState(() {});
    await Webservices.RequestGettaskinfodetail(
        context,
        taskModel,
        load,
        widget.taskLogId,
        widget.serviceId,
        ProjectId,
        true,
        widget.title == "Soft Services PM W/O" ? "schedule" : "");
    if (taskModel.isNotEmpty) {
      taskloginfolist =
      taskModel.isNotEmpty ? taskModel.first.taskLogInfo : null;
      categorylist =
      taskModel.first.configuration!.categories == null ? [] : taskModel.first
          .configuration!.categories!;
      faultcodelist =
      taskModel.first.configuration!.faultCodes == null ? [] : taskModel.first
          .configuration!.faultCodes!;
      subtask_statuslist =
      taskModel.first.configuration!.subTaskStatuses == null ? [] : taskModel
          .first.configuration!.subTaskStatuses!;
      prioritylist =
      taskModel.first.configuration!.priorities == null ? [] : taskModel.first
          .configuration!.priorities!;
      loclist =
      taskModel.first.configuration!.locs == null ? [] : taskModel.first
          .configuration!.locs!;
      onHoldReasons = taskModel.first.configuration!.onHoldReasons!;
      onHoldReasoncomment =
          taskModel.first.taskLogInfo!.onHoldReason.toString();
      task_statuslist = taskModel.first.configuration!.taskStatuses!;
      categoryId = taskModel.first.taskLogInfo!.categoryId.toString();
      faultcodeId = taskModel.first.taskLogInfo!.faultCodeId.toString();
      subTaskStatusId = taskModel.first.taskLogInfo!.statusId.toString();
      priorityId = taskModel.first.taskLogInfo!.priorityId.toString();
      locId = taskModel.first.taskLogInfo!.locId.toString();
      feedbackComment =
          taskModel.first.taskLogInfo!.feedbackComments.toString();
      feedback_rating = taskModel.first.taskLogInfo!.ratingId.toString();
      signatureUrl = taskModel.first.taskLogInfo!.signatureUrl.toString();
      select_onHold_Id =
      taskModel.first.taskLogInfo!.onHoldReasonId == null ? "" : taskModel.first
          .taskLogInfo!.onHoldReasonId.toString();
      reasonId =
      taskModel.first.taskLogInfo!.onHoldReasonId == null ? "" : taskModel.first
          .taskLogInfo!.onHoldReasonId.toString();
      statusId =
      taskModel.first.taskLogInfo!.statusId == null ? "" : taskModel.first
          .taskLogInfo!.statusId.toString();
      on_Holdreason =
      taskModel.first.taskLogInfo!.onHoldReason == null ? "" : taskModel.first
          .taskLogInfo!.onHoldReason.toString();

      print("on_Holdreason>>${taskModel.first
          .taskLogInfo!.onHoldReason.toString()}");
      if(taskModel.first.taskLogInfo!.assetId.toString() != "null" ){
        selectButtonYesNo = "yes";
      }else{
        selectButtonYesNo = "No";
      }
      this.setState(() {});
      if (taskModel.first.taskLogInfo!.onHoldReasonId.toString() == "null")
      {

      }
      else if (reasonId
          .trim()
          .isNotEmpty &&
          taskModel.first.taskLogInfo!.statusId.toString() == "1" || reasonId
          .trim()
          .isNotEmpty &&
          taskModel.first.taskLogInfo!.statusId.toString() == "2") {
        status_toggle = false;
        setState(() {});
      }
      else {
        status_toggle = true;
        for (int i = 0; i < onHoldReasons!.length; i++) {
          if (reasonId.toString() == onHoldReasons![i].id.toString()) {
            select_onHold = onHoldReasons![i].name.toString();

            setState(() {

            });
          }
        }

        setState(() {});
      }


      setState(() {});


      /// check priority  ......
      for (int i = 0; i < prioritylist.length; i++) {
        if (priorityId == prioritylist[i].id.toString()) {
          priorityName = prioritylist[i].name.toString();
          break;
        }
      }

      /// check category.....
      for (int i = 0; i < categorylist.length; i++) {
        if (categoryId.toString() == categorylist[i].id.toString()) {
          categoryName = categorylist[i].name.toString();
          break;
        }
      }

      /// check faultcode
      for (int i = 0; i < faultcodelist.length; i++) {
        if (faultcodeId == faultcodelist[i].id.toString()) {
          faultcodeName = faultcodelist[i].name.toString();
          break;
        }
      }

      /// check subtask ......
      for (int i = 0; i < subtask_statuslist.length; i++) {
        if (subTaskStatusId == subtask_statuslist[i].id.toString()) {
          subTaskStatusName = subtask_statuslist[i].name.toString();
          break;
        }
      }


      /// check LocList  ......
      for (int i = 0; i < loclist.length; i++) {
        if (locId == loclist[i].id.toString()) {
          locName = loclist[i].name.toString();
          break;
        }
      }
    }

    locations =
    taskModel.first.taskLogInfo == null ? [] : taskModel.first.taskLogInfo!
        .locations == null ? null : taskModel.first.taskLogInfo!.locations;
    widget.loaction = locations == null ? widget.loaction : locations!.isEmpty
        ? widget.loaction
        : locations!.first.floorName.toString() + " | " +
        locations!.first.unitName.toString() + " | " +
        locations!.first.roomName.toString();
    setState(() {});

  }

  getApi1(bool load) async {
    print("fgjf");
    taskModel.clear();
    setState(() {});
    await Webservices.RequestGettaskinfodetail(
        context,
        taskModel,
        load,
        widget.taskLogId,
        widget.serviceId,
        ProjectId,
        true,
        widget.title == "Soft Services PM W/O" ? "schedule" : "");
    if (taskModel.isEmpty) {} else {
      print("tettet");
      taskloginfolist =
      taskModel.isNotEmpty ? taskModel.first.taskLogInfo : null;
      categorylist = taskModel.first.configuration!.categories == null
          ? []
          : taskModel.first.configuration!.categories!;
      faultcodelist = taskModel.first.configuration!.faultCodes == null
          ? []
          : taskModel.first.configuration!.faultCodes!;
      subtask_statuslist =
      taskModel.first.configuration!.subTaskStatuses == null
          ? []
          : taskModel.first.configuration!.subTaskStatuses!;
      prioritylist = taskModel.first.configuration!.priorities == null
          ? []
          : taskModel.first.configuration!.priorities!;
      loclist = taskModel.first.configuration!.locs == null
          ? []
          : taskModel.first.configuration!.locs!;
      onHoldReasons = taskModel.first.configuration!.onHoldReasons!;
      onHoldReasoncomment =
          taskModel.first.taskLogInfo!.onHoldReason.toString();
      //   commentController.text = onHoldReasoncomment.toString();
      task_statuslist = taskModel.first.configuration!.taskStatuses!;
      categoryId = taskModel.first.taskLogInfo!.categoryId.toString();
      faultcodeId = taskModel.first.taskLogInfo!.faultCodeId.toString();
      subTaskStatusId = taskModel.first.taskLogInfo!.statusId.toString();
      priorityId = taskModel.first.taskLogInfo!.priorityId.toString();
      locId = taskModel.first.taskLogInfo!.locId.toString();
      feedbackComment =
          taskModel.first.taskLogInfo!.feedbackComments.toString();
      select_onHold_Id = taskModel.first.taskLogInfo!.onHoldReasonId == null
          ? ""
          : taskModel.first.taskLogInfo!.onHoldReasonId.toString();
      reasonId = taskModel.first.taskLogInfo!.onHoldReasonId == null
          ? ""
          : taskModel.first.taskLogInfo!.onHoldReasonId.toString();
      feedBackComment = taskModel.first.taskLogInfo!.feedbackComments.toString();
      //  questionanswer =taskModel.first.taskLogInfo! == null ? "" : taskModel.first.taskLogInfo!.onHoldReasonId.toString();
     if(taskModel.first.taskLogInfo!.assetId.toString() != "null" ){
       selectButtonYesNo = "yes";
     }else{
       selectButtonYesNo = "No";
     }
      if (taskModel.first.taskLogInfo!.onHoldReasonId.toString() == "null") {

      } else {
        status_toggle = true;
        for (int i = 0; i < onHoldReasons!.length; i++) {
          if (reasonId.toString() == onHoldReasons![i].id.toString()) {
            select_onHold = onHoldReasons![i].name.toString();

            setState(() {

            });
          }
        }
      }

      setState(() {});

      /// check priority  ......
      for (int i = 0; i < prioritylist.length; i++) {
        if (priorityId == prioritylist[i].id.toString()) {
          priorityName = prioritylist[i].name.toString();
          break;
        }
      }

      /// check category.....
      for (int i = 0; i < categorylist.length; i++) {
        if (categoryId.toString() == categorylist[i].id.toString()) {
          categoryName = categorylist[i].name.toString();
          break;
        }
      }

      /// check faultcode
      for (int i = 0; i < faultcodelist.length; i++) {
        if (faultcodeId == faultcodelist[i].id.toString()) {
          faultcodeName = faultcodelist[i].name.toString();
          break;
        }
      }

      /// check subtask ......
      for (int i = 0; i < subtask_statuslist.length; i++) {
        if (subTaskStatusId == subtask_statuslist[i].id.toString()) {
          subTaskStatusName = subtask_statuslist[i].name.toString();
          break;
        }
      }

      /// check LocList  ......
      for (int i = 0; i < loclist.length; i++) {
        if (locId == loclist[i].id.toString()) {
          locName = loclist[i].name.toString();
          break;
        }
      }
    }

    locations = taskModel.first.taskLogInfo == null
        ? []
        : taskModel.first.taskLogInfo!.locations == null
        ? null
        : taskModel.first.taskLogInfo!.locations;
    widget.loaction = locations == null
        ? widget.loaction
        : locations!.isEmpty
        ? widget.loaction
        : locations!.first.floorName.toString() +
        " | " +
        locations!.first.unitName.toString() +
        " | " +
        locations!.first.roomName.toString();
    // building_name = locations == null ? "" : locations!.first.
    // }

    setState(() {});
  }

  additionolinfo() async {
    taskResourceslist.clear();
    hseqlist.clear();
    checkquestionAnswerlist.clear();
    checklist.clear();
    setState(() {});

    Future.delayed(Duration.zero,() async{
      await Webservices.RequestAdditionolInfoo(context, true, additionalInfoResponse, widget.taskLogId);
      setState(() {});

      if (additionalInfoResponse.isNotEmpty) {
        taskResourceslist = additionalInfoResponse.first.taskResources!;
        checkListItems = additionalInfoResponse.first.checkListItems;
        hseqListItems = additionalInfoResponse.first.hseqListItems;

        imageslist = additionalInfoResponse.first.images == null ? [] : additionalInfoResponse.first.images!;
        print("imageslist...........${imageslist.length}");

       /// TaskResources...................
        if (taskResourceslist.isNotEmpty) {
          for(int i =0; i < taskResourceslist.length;i++){
            resourceId = taskResourceslist[i].resourceId.toString();
          }
        }

        if (taskResourceslist.isNotEmpty){
          resourceId = taskResourceslist.first.resourceId!.toString();
          task_statusID = taskResourceslist.first.workStatusId!.toString();
          setState(() {});

          /// check Task Statuses ......
          for (int i = 0; i < task_statuslist.length; i++) {
            if (subTaskStatusId == task_statuslist[i].id.toString()) {
              break;
            }
          }
        }

        /// Checklist................
        if(checkListItems != null){
          checklist.add(checkListItems!);
          checklist_questionanswer = checkListItems!.questionAnswers.toString();

          if (checklist_questionanswer != "null") {
            checkquestionAnswerlist.clear();
            setState(() {});

            for(int i =0; i < checkListItems!.questionAnswers!.length;i++){
              checkquestionAnswerlist.add(checkListItems!.questionAnswers![i]);
            }
            setState(() {});
          }
        }

        /// HseqListItems................
        if(hseqListItems != null){
          hseqlist.add(hseqListItems!);
          questionanswer = hseqListItems!.questionAnswers.toString();

          if (hseqlist.isNotEmpty){
            questionslist = hseqlist.first.questions!;
            setState(() {});
          }
          if (questionanswer != "null") {
          }
        }


        /// check finish date........
        for (int i = 0; i < taskResourceslist.length; i++) {
          start_date = taskResourceslist[i].startedDate.toString();
          finish_date = taskResourceslist[i].finishedDate.toString();
          containDate = taskResourceslist[i].containDate.toString();
          setState(() {});

          if (taskResourceslist[i].finishedDate.toString() != "null") {
            compleated_date = taskResourceslist[i].finishedDate.toString();
            break;
          } else {
            compleated_date = taskResourceslist[i].finishedDate.toString();

            setState(() {});
          }
          setState(() {});
        }
        setState(() {});
        print("finish_date3333.............${finish_date}");
      } else {
        print("additionalInfoResponse is null");
      }
    });

   /* Future.delayed(Duration.zero, () async {
      await RequestAdditionolInfo(context, true, widget.taskLogId.toString(),
          widget.title == "Soft Services PM W/O" ? "schedule" : "");
      setState(() {});
    });*/


    if (resourceId.isEmpty) {} else {
      getResorce();
      setState(() {});
    }
  }

  /// Accept Reject ........
  Future<void> RequestAdditionolInfo(BuildContext context, bool load,
      String taskLogId, String status
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);

    print("ur........${status == "schedule"
        ? main_base_url +
        AllApiServices.scheduleapi +
        AllApiServices.task_log_additionol_info +
        taskLogId.toString()
        : main_base_url +
        AllApiServices.base_name_PPmApi +
        AllApiServices.task_log_additionol_info +
        taskLogId.toString()}");
    try {
      final response = await http.get(
          Uri.parse(status == "schedule"
              ? main_base_url +
              AllApiServices.scheduleapi +
              AllApiServices.task_log_additionol_info +
              taskLogId.toString()
              : main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.task_log_additionol_info +
              taskLogId.toString()),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

      CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      taskResourceslist.clear();
      if (response.statusCode == 200) {
         var taskresources = jsonResponse['taskResources'];
        // var masterResources = jsonResponse['masterResources']['data'];
        var images = jsonResponse['images'];

        var hseq_question = jsonResponse['hseqListItems'];
        var checklist_question = jsonResponse['checkListItems'];
        var checklist_questionanswer2 =
        jsonResponse['checkListItems']['questionAnswers'];

       /* if (taskresources != null) {
          taskresources.forEach((e) {
            TaskResourcesModel model = TaskResourcesModel.fromJson(e);
            resourceId = model.resourceId.toString();
            taskResourceslist.add(model);
          });

          if (masterResources != null) {
            masterResources.forEach((e) {
              Data model = Data.fromJson(e);
              masterResourceslist.add(model);
            });
          }

          /// check finish date........
          for (int i = 0; i < taskResourceslist.length; i++) {
            start_date = taskResourceslist[i].startedDate.toString();
            containDate = taskResourceslist[i].containDate.toString();
            finishDate = taskResourceslist[i].finishedDate.toString();
            setState(() {});
            if (taskResourceslist[i].finishedDate.toString() != "null") {
              compleated_date = taskResourceslist[i].finishedDate.toString();
              break;
            } else {
              compleated_date = taskResourceslist[i].finishedDate.toString();

              setState(() {});
            }
            setState(() {});
          }
          setState(() {});
        } else {}*/

        CheckListItems model3 = CheckListItems.fromJson(checklist_question);
        checklist.add(model3);
        checklist_questionanswer = model3.questionAnswers.toString();

        if (checklist_questionanswer2 == null) {} else {
          checklist_questionanswer2.forEach((e) {
            ChecklistQuestionAnswers model4 =
            ChecklistQuestionAnswers.fromJson(e);
            checkquestionAnswerlist.add(model4);
          });
          setState(() {});
        }
        if (images != null) {
          images.forEach((e) {
            ImagesDetailModel model = ImagesDetailModel.fromJson(e);
            imageslist.add(model);
          });
          setState(() {});
        }

        HseqListItems model2 = HseqListItems.fromJson(hseq_question);
        hseqlist.add(model2);

        questionanswer = model2.questionAnswers.toString();

        setState(() {});
        String json = jsonEncode(model2.questionAnswers);
        checklist_questionanswer = model3.questionAnswers.toString();
        setState(() {});
      } else {
        print(response.reasonPhrase);
        CustomLoader.showAlertDialog(context, false);
      }
    } catch (e) {
      print(e);
      throw Exception('errorr>>>>> ${e.toString()}');
    }
    return;
  }


  updatetaskApi() async {
    if (widget.taskLogId == "") {
      Fluttertoast.showToast(msg: "Please select taskId");
    } else {
      await Webservices.RequestUpdateWorkOrders(
          context,
          false,
          widget.taskLogId,
          widget.title == "Soft Services PM W/O" ? "schedule" : "");
    }

    setState(() {});
  }

  onCallupdatetasklog() async {
    UpdateTaskLogStatusApi("5", widget.serviceId);
  }

  UpdateTaskLogStatusApi(String statusId, String serviceTypeId) async {
    if (widget.taskLogId == "") {
      Fluttertoast.showToast(msg: "Please select taskId");
    } else {
      await Webservices.RequestUpdateTaskLogStatus(
          context,
          false,
          widget.taskLogId.toString(),
          statusId,
          serviceTypeId,
          widget.OnCallback,
          widget.title == "Soft Services PM W/O" ? "schedule" : "");

      setState(() {
        status_toggle = false;
      });
      statusId.toString() == "3"
          ? widget.OnCallback()
          : Future.delayed(Duration(seconds: 0), () {
        additionolinfo();
        getApi(true);
        setState(() {});
      });
    }
  }

  Future<void> RequestGetWorkOrders(BuildContext context, bool load,
      String serviceId, String statusId, String status) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    load == true ? CustomLoader.showAlertDialog(context, true) : null;

    var request = {};


    try {
      final response = await http.get(
          Uri.parse(status == "schedule"
              ? main_base_url +
              AllApiServices.scheduleapi +
              AllApiServices.GetWorkOrdersByTypeNStatus +
              serviceId +
              "/" +
              statusId
              : main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.GetWorkOrdersByTypeNStatus +
              serviceId +
              "/" +
              statusId),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });
      print('UIC PDF response : ${response.body}');

      getworklist.clear();
      if (response.statusCode == 200) {
        load == true ? CustomLoader.showAlertDialog(context, false) : null;
        final jsonData = json.decode(response.body.toString());
        jsonData.forEach((jsonModel) {
          GetWorkModel model = GetWorkModel.fromJson(jsonModel);
          getworklist.add(model);
          setState(() {});
        });

        setState(() {});
        if (getworklist.isNotEmpty) {
          for (int i = 0; i < getworklist.length; i++) {
            if (widget.taskLogId.toString() == getworklist[i].id.toString()) {
              widget.workStatusId = getworklist[i].workStatusId.toString();
              setState(() {});
            }
          }
        } else {
        }
      }
    } catch (e) {
      load == true ? CustomLoader.showAlertDialog(context, false) : null;
      print(e);
      throw Exception('Download PDF Fail! ${e.toString()}');
    }
    return;
  }

  OnholdReasonapiCall() async {
    await Webservices.RequestSaveTaskLogOnHoldReason(
        context,
        int.parse(widget.taskLogId.toString()),
        select_onHold_Id.toString(),
        commentController.text,
        widget.title == "Soft Services PM W/O" ? "schedule" : "");
    setState(() {
      commentController.clear();
    });

    Future.delayed(Duration(seconds: 0), () {
      getApi(true);
      additionolinfo();
      setState(() {});
    });
  }

  OnCallBackcomment(String Comment) {
    commentController.text = Comment;
    setState(() {});
    acceptRejectApiCall(int.parse(resourceId), 3);
  }

  acceptRejectApiCall(int resourceId, int actionId) async {
    DateTime dateTime = DateTime.now();

    await Webservices.RequestAcceptReject(
        context,
        true,
        int.parse(widget.taskLogId.toString()),
        resourceId,
        actionId,
        "comment",
        dateTime.toUtc(),
        widget.title == "Soft Services PM W/O" ? "schedule" : "",
        1); // false
    Future.delayed(Duration(seconds: 0), () {
      setState(() {});
      getApi(false);
      additionolinfo();
      setState(() {});
    });
  }
}

///updates list grid.........................................................................................................
class UpdatesListGrid extends StatefulWidget {
  int index;
  String feedbackcomment;

  UpdatesListGrid(
      {Key? key, required this.index, required this.feedbackcomment})
      : super(key: key);

  @override
  _UpdatesListGridState createState() => _UpdatesListGridState();
}

class _UpdatesListGridState extends State<UpdatesListGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                  color: updates_list[widget.index].title == "Evaluation" &&
                      widget.feedbackcomment.toString() != "null"
                      ? myColors.grey_six
                      : myColors.app_theme),
              color: updates_list[widget.index].title == "Evaluation" &&
                  widget.feedbackcomment.toString() != "null"
                  ? myColors.grey_six
                  : myColors.bg_light_blue,
            ),
            child: Container(
              height: 38,
              width: 38,
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(60)),
                color: myColors.white,
              ),
              child: Center(
                  child: Image.asset(updates_list[widget.index].image,
                      color: updates_list[widget.index].title == "Evaluation" &&
                          widget.feedbackcomment.toString() != "null"
                          ? myColors.grey_six
                          : null)),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
            child: CustomText.CustomMediumText(
                updates_list[widget.index].title,
                updates_list[widget.index].title == "Evaluation" &&
                    widget.feedbackcomment.toString() != "null"
                    ? myColors.grey_six
                    : myColors.black,
                FontWeight.w400,
                11,
                2,
                TextAlign.center),
          ),
        ],
      ),
    );
  }
}


///   old design

/*
 ///Level of Completion................................................................
                Container(
                padding: EdgeInsets.only(left: 14, right: 16, top: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: CustomText.CustomSemiBoldText(
                          MyString.Level_of_Completion,
                          myColors.dark_grey_txt,
                          FontWeight.w600,
                          13,
                          1,
                          TextAlign.center),
                    ),


                    Container(
                      alignment: Alignment.centerLeft,
                      child: CustomText.CustomRegularText(
                          locName,
                          myColors.dark_grey_txt,
                          FontWeight.w600,
                          13,
                          1,
                          TextAlign.center),
                    ),

                    // Container(
                    //   child: CustomText.CustomSemiBoldText(
                    //       MyString.In_Progress,
                    //       myColors.dark_grey_txt,
                    //       FontWeight.w600,
                    //       12,
                    //       1,
                    //       TextAlign.center),
                    // ),
                  ],
                ),
              ),

              widget.workStatusId.toString() == "1" ||
                  widget.workStatusId.toString() == "3" ?
              Container() :
              Container(
                child: Column(
                  children: [

                    Container(
                      margin: EdgeInsets.fromLTRB(14, 16, 16, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                            //
                            child: CustomText.CustomRegularText(
                                "On Hold",
                                myColors.dark_grey_txt,
                                FontWeight.w600,
                                13,
                                1,
                                TextAlign.center),
                          ),


                          ///Toggle....................................
                          Container(
                            padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                            alignment: Alignment.centerRight,
                            child: FlutterSwitch(
                              width: 35.0,
                              height: 18.0,
                              /* switchBorder: Border.all(
                            color: Mycolors.white_color,
                            width: 6.0,
                          ),*/
                              /*  toggleBorder: Border.all(
                                color: myColors.white,
                                width: 0.0,
                              ),*/
                              inactiveSwitchBorder: Border.all(
                                color: myColors.grey_ten,
                                width: 1.0,
                              ),
                              inactiveToggleColor: myColors.white,
                              inactiveColor: myColors.grey_ten,
                              //  inactiveToggleBorder: BoxBorder.,
                              activeColor: myColors.orange_light,
                              activeToggleColor: myColors.orange,
                              valueFontSize: 0.0,
                              toggleSize: 18.0,
                              value: status_toggle == null
                                  ? false
                                  : status_toggle,
                              borderRadius: 18.0,
                              padding: 0.0,
                              showOnOff: true,
                              onToggle:
                                  (val) {
                                print(
                                    "taskModel.first.taskLogInfo!.onHoldReasonId.toString()>${taskModel
                                        .first.taskLogInfo!.onHoldReasonId
                                        .toString()}");
                                print("reasonId>${reasonId}");
                                // if(taskModel.first.taskLogInfo!.onHoldReasonId.toString() != "null" ){
                                //     CustomLoader.RemoveOnHoldDialog(
                                //       context: context,
                                //       title: "Are you sure remove on-hold ?",
                                //       haeding: "On-Hold",
                                //       onCallback: onCallupdatetasklog,
                                //       onTapofYes: () {
                                //         UpdateTaskLogStatusApi("5", widget.serviceId);
                                //       },
                                //     );
                                // }else{
                                print("value>>${val}");
                                setState(() {
                                  status_toggle = val;
                                });
                                // }

                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // taskloginfolist == null
                    //     ? Container()
                    //     : taskloginfolist!.onHoldReasonId == null && locName != "" && locName.isNotEmpty
                    status_toggle == false
                        ? Container()
                        : Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: widget.workStatusId.toString() ==
                                          "1" ||
                                          widget.workStatusId.toString() == "3"
                                          ? () {}
                                          : () {
                                        is_hide = !is_hide;
                                        print("is_selectOnHold${is_hide}");
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 40,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        margin: EdgeInsets.fromLTRB(14, 0, 16, 0),
                                        padding: EdgeInsets.fromLTRB(
                                            16, 0, 16, 0),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: myColors.border_txtfield),
                                          borderRadius: BorderRadius.circular(10),
                                          color: myColors.bg_txtfield,
                                        ),
                                        child: CustomText.CustomRegularText(
                                            select_onHold,
                                            myColors.dark_grey_txt,
                                            FontWeight.w400,
                                            13,
                                            1,
                                            TextAlign.center),
                                      ),
                                    ),

                                    is_hide == true
                                        ? Container(
                                      height: 250,
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 35),
                                      padding: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: myColors.grey_two
                                                  .withOpacity(0.20))),
                                      child: ListView.builder(
                                          physics: AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: taskModel
                                              .first
                                              .configuration!
                                              .onHoldReasons!
                                              .length,
                                          itemBuilder: (context, int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                is_hide = false;
                                                select_onHold = taskModel
                                                    .first
                                                    .configuration!
                                                    .onHoldReasons![index]
                                                    .name
                                                    .toString();
                                                select_onHold_Id = taskModel
                                                    .first
                                                    .configuration!
                                                    .onHoldReasons![index]
                                                    .id
                                                    .toString();

                                                comment = taskModel
                                                    .first
                                                    .configuration!
                                                    .onHoldReasons![index]
                                                    .name
                                                    .toString();
                                                setState(() {});
                                                print(
                                                    "is_selectOnHold${is_hide}");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10,
                                                            vertical: 4),
                                                        child: Text(taskModel
                                                            .first
                                                            .configuration!
                                                            .onHoldReasons![
                                                        index]
                                                            .name
                                                            .toString())),
                                                    Divider()
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                        : Container()
                                    //: Container(),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Container(
                           // height: 80,
                            margin: EdgeInsets.fromLTRB(14, 15, 16, 0),
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: myColors.border_txtfield),
                              borderRadius: BorderRadius.circular(10),
                              color: myColors.bg_txtfield,
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                // onHoldReasoncomment.toString() =="null"?Container():    Text(onHoldReasoncomment,style: TextStyle(
                                //   fontSize: 13,
                                //   fontWeight: FontWeight.w400,
                                //   fontFamily:
                                //   'assets/fonts/Poppins/Poppins-Regular.ttf',
                                //   color: myColors.black,
                                // ),),
                                TextField(
                                  enabled: widget.workStatusId.toString() == "1" ||
                                      widget.workStatusId.toString() == "3"
                                      ? false
                                      : true,
                                  controller: commentController,
                                  focusNode: comment_focus,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  onChanged: (String value) {
                                    print("TAG" + value);
                                    setState(() {});
                                  },
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                    'assets/fonts/Poppins/Poppins-Regular.ttf',
                                    color: myColors.black,
                                  ),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter comment",
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: myColors.dark_grey_txt,
                                          fontFamily:
                                          "assets/fonts/Poppins/Poppins-Regular.ttf"),
                                      counter: Offstage(),
                                      isDense: true,
                                      // this will remove the default content padding
                                      contentPadding:
                                      EdgeInsets.fromLTRB(0, 8, 0, 0)),
                                  maxLines: 2,
                                  cursorColor: myColors.black,
                                ),
                              ],
                            ),
                          )

                        ],
                      ),
                    ),

                    //Save Button..................................................................................................
                    status_toggle == false ?  Container() :
                    taskModel.isEmpty ?Container(): taskModel.first.taskLogInfo!.completionDate.toString() !=
                        "null" ?
                    Container() :
                    commentController.text.isEmpty ?Container(): InkWell(
                      onTap:
                                             // locName == "Work In Progress"
                      //     ? () {}
                      //     :
                          () {
                        if(widget.taskLogId.toString().isEmpty || widget.taskLogId.toString() =="" || widget.taskLogId.toString() == "null"){
                          CustomToast.showToast(msg: "tasklog Id is null ");
                        }
                        else if(select_onHold_Id.toString() == "" ||  select_onHold_Id.toString().isEmpty){
                          CustomToast.showToast(msg: "Please select on hold reason");
                        }
                        // else if(commentController.text.trim().isEmpty){
                        //   CustomToast.showToast(msg: "Please enter comment");
                        // }
                        else{
                          OnholdReasonapiCall();
                        }

                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 14, right: 16),
                        child: GlobalThemeButton(
                          buttonName: taskModel.isEmpty ||
                              taskModel.first.taskLogInfo!.onHoldReason
                                  .toString() ==
                                  "null" ? MyString.SAVE : "Update",
                          buttonColor:  myColors.app_theme,
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              ///Assigned Resource..................
              locName == "Work In Progress"
                  ? Container()
                  :
              Container(
                padding: EdgeInsets.only(left: 15, right: 16, top: 15),
                child: CustomText.CustomSemiBoldText(MyString.Resource_Assigned,
                    myColors.black, FontWeight.w600, 13, 1, TextAlign.center),
              ),

              // locName == "Work In Progress"
              //     ? Container()
              //:

 */