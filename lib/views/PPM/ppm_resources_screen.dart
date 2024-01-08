import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/model/models/AssignedResourceModel.dart';
import 'package:fm_pro/model/models/GetAssignResources.dart';
import 'package:fm_pro/model/models/SuperViserdResourcesModel.dart';
import 'package:fm_pro/model/models/TaskInfoModel.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../global/my_string.dart';
import '../../model/models/GetResourceModel.dart';
import '../../model/models/TransferWorkordersModel.dart';
import '../../widgets/custom_texts.dart';
import '../Reactive/resources_assign_successfully_screen.dart';


List<String> assignedResList = [];


class PPM_Resources_Screen extends StatefulWidget {
  List<TaskResourcesModel> taskResourceslist;
  List<ResourcesModel> resourcesModel;
  List<TaskInfoModel> taskModel;
  List<Data> masterResourceslist;
  String title;
  String appbartitle;
  String taskLogId;
  String serviceId;


  PPM_Resources_Screen(
      {Key? key, required this.taskResourceslist, required this.taskModel, required this.resourcesModel, required this.masterResourceslist,required this.title,required this.appbartitle,required this.taskLogId,required this.serviceId})
      : super(key: key);

  @override
  _PPM_Resources_ScreenState createState() => _PPM_Resources_ScreenState();
}

class _PPM_Resources_ScreenState extends State<PPM_Resources_Screen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int tab_index = 0;
  List<String> productlistmain = <String>[];
  List<AssignedResourcesModel> resourcelist = [];
  String typeId = "";
  String subTypeId = "";
  String taskLogId = "";
  String ProjectId = "";
  List<Data> masterResourceslist = [];
  List<SuperVisedResourcesModel> superviserdresourceslist = [];
  List<GetAssignResourcesData> assignsourceslist = [];
  SuperVisedResourcesModel? superVisedResourcesModel;
  String resourceId = "";
  String resourcename = "Select Resources";
  TextEditingController searchController = TextEditingController();
  bool is_selected = false;
  String superresourceId = "";
  String comment = "";
  List<TransferWorkordersModel> transferworkorderslist = [];


  final commentController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // assignedResList.clear();
    _tabController = TabController(length: 2, vsync: this);
    setdata();
    Future.delayed(Duration.zero,(){

      getsupervisedResourcesApi();
      getAssignedResourcesApi();
    });


    ///Tabs listener.................................................................................................
    _tabController.addListener(() {
      tab_index = _tabController.index;
      setState(() {

      });
    });

    super.initState();

    if (widget.taskModel.isEmpty) {

    } else {
      typeId = widget.taskModel.first.taskLogInfo!.typeId.toString() == "null"
          ? ""
          : widget.taskModel.first.taskLogInfo!.typeId.toString();
      subTypeId =
      widget.taskModel.first.taskLogInfo!.subTypeId.toString() == "null"
          ? ""
          : widget.taskModel.first.taskLogInfo!.subTypeId.toString();
      taskLogId =
      widget.taskModel.first.taskLogInfo!.id.toString() == "null" ? "" : widget
          .taskModel.first.taskLogInfo!.id.toString();
      ProjectId =
      widget.taskModel.first.taskLogInfo!.projectId.toString() == "null"
          ? ""
          : widget.taskModel.first.taskLogInfo!.projectId.toString();
      setState(() {});
      print(
          "typeId>> ${widget.taskModel.first.taskLogInfo!.typeId.toString()}");
      print("subtypeId>> ${widget.taskModel.first.taskLogInfo!.subTypeId
          .toString()}");
      print("tashlogId>> ${widget.taskModel.first.taskLogInfo!.id.toString()}");
      print("ProjectId>> ${widget.taskModel.first.taskLogInfo!.projectId
          .toString()}");

      getallResources();
    }
  }


  getallResources() async {
    resourcelist.clear();
    setState(() {});

    if (typeId.isEmpty) {
      Fluttertoast.showToast(msg: "Type id is null");
    }
    else if (subTypeId.isEmpty) {
      Fluttertoast.showToast(msg: "LogType id is null");
    }
    else if (taskLogId.isEmpty) {
      Fluttertoast.showToast(msg: "LogType id is null");
    }
    else if (ProjectId.isEmpty) {
      Fluttertoast.showToast(msg: "LogType id is null");
    } else {
      await Webservices.RequestGetResourcesByReporterType(
        context,
        true,
        typeId,
        subTypeId,
        taskLogId,
        ProjectId,
        widget.appbartitle == "Soft Services PM W/O" ? "schedule" :"",
        resourcelist,

      );
      setState(() {});
    }
  }

  setdata() {
    masterResourceslist.clear();
    setState(() {});

    for (int i = 0; i < widget.masterResourceslist.length; i++) {
      for (int j = 0; j < widget.taskResourceslist.length; j++) {
        if (widget.masterResourceslist[i].id.toString() !=
            widget.taskResourceslist[j].resourceId.toString()) {
          masterResourceslist.add(widget.masterResourceslist[i]);
          print("widget.masterResourceslist>>${masterResourceslist.length}");
        }
      }
      setState(() {});
    }
  }

  getsupervisedResourcesApi() async{
    superviserdresourceslist.clear();
    await Webservices.RequestSuperVisedResources
      (context, superviserdresourceslist);
    setState(() {});
    print("superviserdresourceslist>>${superviserdresourceslist.length}");
  }

  getAssignedResourcesApi() async{
    // assignsourceslist.clear();
    await Webservices.RequestAssignResources(context, assignsourceslist,ProjectId,taskLogId,widget.serviceId);
    setState(() {});
  }


  OnCallBackTransfer(bool is_selectedd, String superresourceIdd){
    is_selected = is_selectedd;
    superresourceId = superresourceIdd.toString();
    setState(() {});
  }

  OnCallBackAssign(String Comment) {
    commentController.text = Comment;
    setState(() {});
    transferworkorderApi();
    setState(() {});
  }
  String status = "";

  OnCallBackReassign(String res_status ){
    status = res_status;
    setState(() {});
  }


  transferworkorderApi() async{
    if(resourceId.trim().isEmpty) {
      CustomToast.showToast(msg: "Please select first any resorce");
    }else{
      await Webservices.RequestReassignWorkOrder(context, widget.taskLogId.toString(),resourceId,commentController.text,OnCallBackReassign);
    }
    setState(() {});
    if(status == "true"){
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: ResourcesAssignSuccessfullyScreen(),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.fade,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: myColors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(240),
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
                                print("tuuuuyu${widget.title}");
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
                                      widget.title.toString() == "null" ? "" : widget.title,
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
                            ),
                          ],
                        ),

                        //Search...................................................................................................................
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 18),
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
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (String value) {
                                    print("TAG" + value);
                                    setState(() {});
                                  },
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
                                    contentPadding: EdgeInsets.fromLTRB(
                                        0, 4, 0, 0),
                                  ),
                                  maxLines: 1,
                                  cursorColor: myColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 107,
                          width: mediaQuerryData.size.width,
                          color: myColors.white,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                                child: CustomText.CustomSemiBoldText(
                                    MyString.Resources,
                                    myColors.black, FontWeight.w600, 16, 1,
                                    TextAlign.center),
                              ),

                              ///Tabbar..............................
                              Container(
                                margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
                                height: 44,
                                width: mediaQuerryData.size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),),
                                  color: myColors.light_blue,
                                ),
                                child: TabBar(
                                  controller: _tabController,
                                  indicator: BoxDecoration(
                                    color: myColors.app_theme,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),),
                                  ),
                                  labelColor: Colors.white,
                                  unselectedLabelColor: myColors.app_theme,
                                  isScrollable: true,
                                  physics: BouncingScrollPhysics(),
                                  onTap: (tab_index) {
                                    print('Tab $tab_index is tapped');
                                    //   _tabController.index = tab_index;
                                    tab_index = tab_index;
                                    resourceId = "";
                                    is_selected = false;
                                    setState(() {

                                    });
                                  },

                                  enableFeedback: true,

                                  tabs: [
                                    Tab(
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomRight: Radius.circular(
                                                    10)
                                            )
                                        ),
                                        width: mediaQuerryData.size.width /2.6 ,
                                        child: Text(MyString.Assigned,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "assets/fonts/Poppins/Poppins-Bold.ttf"
                                          ),),
                                      ),
                                    ),
                                    // second tab
                                    Tab(
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight: Radius.circular(
                                                    10))
                                        ),
                                        width: mediaQuerryData.size.width / 2.6,
                                        child: Text(MyString.Assign,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "assets/fonts/Poppins/Poppins-Bold.ttf"
                                          ),),
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
                widget.taskResourceslist.isEmpty ? Container() :
                assignedUi(),

                // Comment second tab bar view widget

                assignUi(),
              ],
            ),

            bottomNavigationBar: tab_index == 1 ? InkWell(
              onTap: () {
                transferworkorderApi();
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: is_selected  ==  true
                      ? myColors.app_theme
                      : myColors.light_blue,
                ),
                child: CustomText.CustomBoldText(
                    MyString.DONE, myColors.white, FontWeight.w700, 14, 1,
                    TextAlign.center),
              ),
            ) : null,
          ),
        ));
  }

  assignUi() {
    return Container(

        child: ListView.builder(
          //  physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: assignsourceslist.length,
            itemBuilder: (context, int index) {
              return InkWell(
                onTap: () {
                  resourceId = assignsourceslist[index].id.toString();
                  setState(() {});
                  is_selected = true;
                  setState(() {});
                  OnCallBackTransfer(is_selected,resourceId);
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: AssignResourcesList(index: assignsourceslist[0].id.toString(),
                    assignsourceslist: assignsourceslist[index],
                    resourceslist: widget.resourcesModel, OnCallBackTransfer: OnCallBackTransfer, resourceId: resourceId,),
                ),
              );
            }));
  }

  assignedUi() {

    return Container(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.taskResourceslist.length,
            itemBuilder: (context, int index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: AssignedResourcesList(index: index,
                    model: widget.taskResourceslist[index],
                    resourceslist: widget.resourcesModel,),
                ),
              );
            }));
  }




}

/// Assign Resources List.................................................................................................................
class AssignResourcesList extends StatefulWidget {
  String index;
  //SuperVisedResourcesModel superResourceslist;
  GetAssignResourcesData assignsourceslist;
  // Data masterResourceslist;

  // AssignedResourcesModel resourcemodel;
  List<ResourcesModel> resourceslist;
  Function OnCallBackTransfer;
  String resourceId;


  //ResourcesModel model;
  // ,required this.model

  /*AssignResourcesList(
      {Key? key, required this.index, *//*required this.superResourceslist ,*//*required this.assignsourceslist,*//* required this.masterResourceslist,*//* required this.resourceslist,required this.OnCallBackTransfer,required this.resourceId})
      : super(key: key);*/
  AssignResourcesList(
      {Key? key, required this.index,required this.assignsourceslist,required this.resourceslist,required this.OnCallBackTransfer,required this.resourceId})
      : super(key: key);


  @override
  _AssignResourcesListState createState() => _AssignResourcesListState();
}

class _AssignResourcesListState extends State<AssignResourcesList> {
  String resourceId = "";
  String id = "";
  bool is_selected = false;
  List<GetAssignResourcesData> assignsourceslist = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 130,
      padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(
            color: widget.resourceId.toString() == widget.assignsourceslist.id.toString()  ? myColors
                .orange : myColors.app_theme),
        color: widget.resourceId.toString()  == widget.assignsourceslist.id.toString()? myColors
            .light_orange : myColors.light_blue.withOpacity(0.30),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                child: CircleAvatar(
                  maxRadius: 60,
                  child: widget.resourceslist.isEmpty
                      ? ClipRRect(
                      borderRadius:
                      BorderRadius
                          .circular(100),
                      child: Image.asset(
                        "assets/images/user_img.png",
                        fit: BoxFit.cover,
                        height: 100,
                      ))
                      : ClipRRect(
                    borderRadius:
                    BorderRadius
                        .circular(100),
                    child: widget
                        .resourceslist
                        .first
                        .imageUrl ==
                        null
                        ? Image.asset(
                      "assets/images/user_img.png",
                      height: 100,
                    )
                        : Image.network(
                      widget
                          .resourceslist
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
                  padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          child: CustomText.CustomMediumText(
                              widget.assignsourceslist.name.toString(),
                              widget.resourceId.toString() == widget.assignsourceslist.id.toString()
                                  ? myColors.orange
                                  : myColors.black,
                              FontWeight.w500,
                              14,
                              1,
                              TextAlign.center)),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          alignment: Alignment.topLeft,
                          child: CustomText.CustomMediumText(
                              widget.assignsourceslist.code.toString(),
                              myColors.app_theme,
                              FontWeight.w500,
                              12,
                              1,
                              TextAlign.center)),

                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 6),
                          child: CustomText.CustomMediumText(
                            // "Present",
                              assignsourceslist.isNotEmpty ?     assignsourceslist
                                  .first
                                  .email.toString() : "",
                              myColors.app_theme,
                              FontWeight.w500,
                              10,
                              1,
                              TextAlign.center)),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50)),
                                color: myColors.active_green,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 6),
                                child: CustomText.CustomMediumText(
                                    "Present",
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
                ),
              ),

              //checkbox Icon.........
              /*    GestureDetector(
                onTap: () {
                  print("fhhjfj");
                },
                child: Container(
                  width: 50,
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 28),
                    child: Image.asset(
                      resourceId == widget.superResourceslist.id.toString() && is_selected == true
                          ? "assets/images/checkbox1_check.png"
                          : "assets/images/checkbox1_uncheck.png",
                      width: 20,
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),*/
            ],
          ),

          Container(
            padding: EdgeInsets.only(top: 12),
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
                                "assets/images/img_whatsapp_theme.png",color: myColors.app_theme,),
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
                                "assets/icons/img_phone_theme.png",color: myColors.app_theme,),
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
                          Container(
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  "Total Assigned",
                                  myColors.active_ten,
                                  FontWeight.w400,
                                  11,
                                  1,
                                  TextAlign.center)),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  "Workorders",
                                  myColors.app_theme,
                                  FontWeight.w600,
                                  14,
                                  1,
                                  TextAlign.center)),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: CustomText.CustomMediumText(
                            "",
                            // widget.resourcemodel..toString(),
                            myColors.active_eleven,
                            FontWeight.w600,
                            18,
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
    );
  }
}


/// Assgned Resources List..............................................................................................
class AssignedResourcesList extends StatefulWidget {
  int index;
  TaskResourcesModel model;
  List<ResourcesModel> resourceslist;

  AssignedResourcesList(
      {Key? key, required this.index, required this.model, required this.resourceslist})
      : super(key: key);

  @override
  _AssignedResourcesListState createState() => _AssignedResourcesListState();
}

class _AssignedResourcesListState extends State<AssignedResourcesList> {
  String status_assigned = "";
  String status_assigned_popup = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 240,
      padding: EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: myColors.newBar_1),
          color: myColors.purple_2.withOpacity(0.30)),
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
                  child: widget
                      .resourceslist.isEmpty
                      ? ClipRRect(
                      borderRadius:
                      BorderRadius
                          .circular(100),
                      child: Image.asset(
                        "assets/images/user_img.png",
                        fit: BoxFit.cover,
                        height: 100,
                      ))
                      : ClipRRect(
                    borderRadius:
                    BorderRadius
                        .circular(100),
                    child: widget
                        .resourceslist
                        .first
                        .imageUrl ==
                        null
                        ? Image.asset(
                      "assets/images/user_img.png",
                      height: 100,
                    )
                        : Image.network(
                      widget
                          .resourceslist
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
                  padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          child: CustomText.CustomMediumText(
                              "${widget.model.resourceName.toString()}",
                              myColors.dark_grey_txt,
                              FontWeight.w500,
                              14,
                              1,
                              TextAlign.center)),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          alignment: Alignment.topLeft,
                          child: CustomText.CustomMediumText(
                              "${widget.model
                                  .designation.toString()}",
                              myColors.app_theme,
                              FontWeight.w500,
                              12,
                              1,
                              TextAlign.center)),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                          alignment: Alignment.topLeft,
                          child: CustomText.CustomMediumText(
                              "${widget.model.resourceName.toString()}",
                              myColors.grey_eight,
                              FontWeight.w400,
                              12,
                              1,
                              TextAlign.center)),
                    ],
                  ),
                ),
              ),

              //Present.........
              Container(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                            width: 45,
                            padding: EdgeInsets.only(left: 4),
                            child: CustomText.CustomMediumText(
                                "Present",
                                myColors.active_green,
                                FontWeight.w500,
                                10,
                                1,
                                TextAlign.center)),
                      ],
                    ),

                    InkWell(
                      onTap: () {
                        popupUnAssign();
                      },
                      child: Container(
                        height: 24,
                        width: 75,
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        decoration: BoxDecoration(
                          border: Border.all(color: myColors.app_theme),
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
                          color: myColors.light,
                        ),
                        child: CustomText.CustomMediumText(
                            MyString.Un_Assign, myColors.black, FontWeight.w500,
                            12, 1, TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          ///Call whatsapp.......
          Container(
            padding: EdgeInsets.only(top: 6, left: 8, right: 8),
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
                              "assets/images/img_whatsapp_theme.png",color: myColors.app_theme,),
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
                              "assets/icons/img_phone_theme.png",color: myColors.app_theme,
                            ),
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
                              child: Image.asset("assets/icons/img_phone_theme.png",
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
                                "assets/icons/img_play_theme.png",
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

                              /// Comment...
                              /*  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                  "#ff6666",
                                  'Cancel',
                                  true,
                                  ScanMode.QR);*/
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
            height: 32,
            margin: EdgeInsets.fromLTRB(0, 13, 0, 0),
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: myColors.white.withOpacity(0.90)),
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
                      widget.model.assignedDate
                          .toString() == "null"
                          ? "N/A"
                          : DateFormat.d().format(
                          DateTime.parse(
                              widget.model
                                  .assignedDate.toString())) +
                          "-" + DateFormat.MMM().format(
                          DateTime.parse(
                              widget.model
                                  .assignedDate.toString())) +
                          "-" + DateFormat.y().format(
                          DateTime.parse(
                              widget.model
                                  .assignedDate.toString())) +
                          " " + DateFormat("HH:mm").format(
                          DateTime.parse(
                              widget.model
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

          ///2...........
          Container(
            height: 32,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: myColors.white.withOpacity(0.90)),
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
                      widget.model.startedDate
                          .toString() == "null"
                          ? "N/A"
                          : DateFormat.d().format(
                          DateTime.parse(
                              widget.model
                                  .startedDate.toString())) +
                          "-" + DateFormat.MMM().format(
                          DateTime.parse(
                              widget.model
                                  .startedDate.toString())) +
                          "-" + DateFormat.y().format(
                          DateTime.parse(
                              widget.model
                                  .startedDate.toString())) +
                          " " + DateFormat("HH:mm").format(
                          DateTime.parse(
                              widget.model
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

          ///3...........
          Container(
            height: 32,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: myColors.white.withOpacity(0.90)),
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
                      widget.model.finishedDate
                          .toString() == "null"
                          ? "N/A"
                          : DateFormat.d().format(
                          DateTime.parse(
                              widget.model
                                  .finishedDate.toString())) +
                          "-" + DateFormat.MMM().format(
                          DateTime.parse(
                              widget.model
                                  .finishedDate.toString())) +
                          "-" + DateFormat.y().format(
                          DateTime.parse(
                              widget.model
                                  .finishedDate.toString())) +
                          " " + DateFormat("HH:mm").format(
                          DateTime.parse(
                              widget.model
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
    );
  }

  ///Popup Un Assign resources..................................................................................................
  Future popupUnAssign() {
    return showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            content: Container(
              padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: myColors.orange),
                color: myColors.light_orange,
              ),
              height: 365,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ///User info...........
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          maxRadius: 60,
                          backgroundImage:
                          AssetImage("assets/images/profle_men.png"),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(
                                      "Muhammad Sami uddin",
                                      myColors.dark_grey_txt,
                                      FontWeight.w500,
                                      12,
                                      1,
                                      TextAlign.center)),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(
                                      "Designation",
                                      myColors.app_theme,
                                      FontWeight.w500,
                                      11,
                                      1,
                                      TextAlign.center)),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(
                                      "sami@company.com",
                                      myColors.grey_eight,
                                      FontWeight.w400,
                                      11,
                                      1,
                                      TextAlign.center)),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),

                  ///Call whatsapp.......
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 8, right: 8),
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
                                        "assets/icons/img_phone_theme.png"),
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
                                      status_assigned_popup = "contact";
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      margin: EdgeInsets.only(left: 2, top: 6),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: myColors.app_theme),
                                        color: status_assigned_popup ==
                                            "contact"
                                            ? myColors.app_theme
                                            : myColors.blue_lightest,
                                      ),
                                      child: Image.asset(
                                        "assets/images/check_circle_white.png",
                                        color: status_assigned_popup ==
                                            "contact"
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
                                      status_assigned_popup = "start";
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      margin: EdgeInsets.only(left: 4, top: 6),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: myColors.app_theme),
                                        color: status_assigned_popup == "start"
                                            ? myColors.app_theme
                                            : myColors.blue_lightest,
                                      ),
                                      child: Image.asset(
                                        "assets/images/img_play_theme.png",
                                        color: status_assigned_popup == "start"
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
                                      status_assigned_popup = "finish";
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      margin: EdgeInsets.only(left: 4, top: 6),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: myColors.app_theme),
                                        color: status_assigned_popup == "finish"
                                            ? myColors.app_theme
                                            : myColors.blue_lightest,
                                      ),
                                      child: Image.asset(
                                          status_assigned_popup ==
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
                                      status_assigned_popup = "scan";
                                      setState(() {});

                                      /// Comment........
                                      /*  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                      "#ff6666",
                                      'Cancel',
                                      true,
                                      ScanMode.QR);*/
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
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

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      dashPattern: [3, 3],
                      color: myColors.grey_sixteen,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          height: 90,
                          color: myColors.grey_fifteen,
                          child: TextField(
                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              print("TAG" + value);
                              setState(() {});
                            },
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily:
                              'assets/fonts/Poppins/Poppins-Regular.ttf',
                              color: myColors.grey_seventeen,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: MyString.Enter_Reason_to_Un_Assign,
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: myColors.grey_seventeen,
                                    fontFamily:
                                    "assets/fonts/Poppins/Poppins-Regular.ttf"),
                                counter: Offstage(),
                                isDense: true,
                                // this will remove the default content padding
                                contentPadding:
                                EdgeInsets.fromLTRB(16, 8, 8, 0)),
                            maxLines: 5,
                            cursorColor: myColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30,),

                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // passing false
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        alignment: Alignment.center,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: myColors.app_theme,
                        ),
                        child: CustomText.CustomBoldText(
                            MyString.DONE, myColors.white, FontWeight.w700, 14,
                            1, TextAlign.center)
                    ),
                  ),
                  //   SizedBox(height: 50,)
                ],
              ),
            ),
          ),
    );
  }
}
