import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/model/AssignToResponse.dart';
import 'package:fm_pro/model/models/ProjectModel.dart';
import 'package:fm_pro/model/models/getLocationResourceMasterModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/views/PPM/sucessWorkOrderScreen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'dart:convert' as convert;

import '../../global/my_string.dart';
import '../../model/models/AdditionolInfoModel.dart';
import '../../model/models/AssignedResourceModel.dart';
import '../../model/models/GetResourceModel.dart';
import '../../model/models/TaskInfoModel.dart';
import '../../model/models/scanModel.dart';
import '../../utils/customToast.dart';
import '../../widgets/custom_texts.dart';
import 'dart:async';

class PPM_New_Workorder_Screen extends StatefulWidget {
  String title;
  String appbartitle;
  String assetcode;
  String ServiceId;
  String ppmId;
  int parentId;

  PPM_New_Workorder_Screen(
      {Key? key,
        required this.title,
        required this.appbartitle,
        required this.assetcode,
        required this.ServiceId,
        required this.ppmId,required this.parentId})
      : super(key: key);

  @override
  _PPM_New_Workorder_ScreenState createState() =>
      _PPM_New_Workorder_ScreenState();
}

class _PPM_New_Workorder_ScreenState extends State<PPM_New_Workorder_Screen> {
  TextEditingController desController = TextEditingController();
  TextEditingController ppmIdController = TextEditingController();
  TextEditingController asset_codeController = TextEditingController();
  TextEditingController asset_IdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController projectController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController floreController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController subtypeController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController callsourceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController ReporternameController = TextEditingController();
  TextEditingController reporter_emailController = TextEditingController();
  TextEditingController reporter_mobilenoController = TextEditingController();

  final summaryfocus = FocusNode();
  final titlefocus = FocusNode();
  final reportednamefocus = FocusNode();
  final reportedemailfocus = FocusNode();
  final reportedmobilefocus = FocusNode();
  final asssetcodefocus = FocusNode();
  final assetdesfocus = FocusNode();

  SharedPreferences? p;
  String name = "";
  String username = "";
  String mobileno = "";
  String mobile_countrycode = "";

  bool load = false;
  String categoryId = "";
  String categoryName = "";
  String dropdownValue = "";
  String asset_code = "";
  String barcode = "";
  String mobilecode = "";
  var duedate = "";
  late int tappedIndex;

  String genderType = "";
  final _picker = ImagePicker();

  bool is_country = true;
  bool is_before_image = true;
  bool is_after_image = false;
  bool isbefor_aftercheck = true;
  final ImagePicker imagePicker = ImagePicker();
  File? _image;
  List<File> imagefilelist = [];
  String img = "";
  File? image;

  // final ImagePicker imagePicker = ImagePicker();
  // File? _image;
  // List<File> imagefilelist = [];
  // String img = "";
  List<ScanModel> scanlist = [];

  List<TaskInfoModel> taskModel = [];
  List<Categories> categorylist = [];
  List<AssignToModel> assigntolist = [];
  TaskLogInfo? taskloginfolist;
  String summary = "";
  String selectedtaskinstruction = "";
  String selectedtaskinstructionID = "";
  List<TaskInstructions>? taskInstructions = [];
  List<Locs>? loclist = [];
  String locID = "";
  String loccode = "";
  String locname = "";
  String faultcodeId = "";
  String faultname = "";
  String faultcode = "";
  bool is_taskinstruction = false;
  bool is_asset = false;

  List<Buildings>? buildingslist = [];
  List<Buildings>? buildingslist1 = [];
  List<FloorsModel> floorlist = [];
  List<Units>? unitslist = [];
  List<Rooms>? roomslist = [];
  List<Resources>? Resourceslist = [];
  List<Channels>? channellist = [];
  List<ReporterTypes>? reporterTypeslist = [];
  List<ReporterSubTypes>? reporterSubTypeslist = [];
  List<CountryCodes>? countryCodeslist = [];

  List<Types> typeslist = [];
  List<SubTypes> subTypeslist = [];
  List<SubTypes> subTypeslist1 = [];
  List<Channels> channelslist = [];
  List<Locs> locslist = [];
  List<Priorities> prioritieslist = [];

  List<TaskStatuses>? taskStatuses;
  List<FaultCodes> faultCodes = [];
  List<SubTaskTypes>? subTaskTypes;
  List<SubTaskStatuses>? subTaskStatuses;
  List<OnHoldReasons>? onHoldReasons;

  List<TaskResourcesModel> taskResourceslist = [];
  List<Data> masterResourceslist = [];

  List<ProjectsModel> projectlist = [];
  List<AssetScanModel> assetscanlist = [];
  List<ResourcesModel> resourceslist = [];
  List<AssignedResourcesModel> assignresourcelist = [];

  List<Map<String, String>> newFaultCode = [
    {"name": "Category 1"},
    {"name": "Category 2"},
    {"name": "Category 3"},
  ];


  /// Create models objects..
  Categories? catemodel;
  ProjectsModel? projectmodel;
  Buildings? buildingModel;
  Units? unitsModel;
  FloorsModel? floorModel;
  // Resources? ResourcesmainModel;
  AssignToModel? ResourcesmainModel;
  Rooms? roomModel;
  Types? typeModel;
  SubTypes? subtypeModel;
  Priorities? prioritiesModel;
  ResourcesModel? resourceModel;
  AssignedResourcesModel? assignresourceModel;

  /// Id Strings.....
  String buildingId = "";
  String projectId = "0";
  String unitId = "";
  String floorId = "";
  String roomId = "";
  String typeId = "";
  String subtypeId = "";
  String priorityId = "";
  String RecorcesId = "";
  String reportrecorcesId = "";
  String Recorcesname = "";
  String channelName = "";
  String channelcode = "";
  String? channelID;
  String user_name = "";
  String serviceTypeId = "";
  String repoterTypeId = "";
  String reporterSubTypesId = "";
  String reporterRecorcesId = "";
  String MobileCode = "";
  bool is_reporter_resource = false;
  bool is_ServiceType = false;

  SharedPreferences? pre;

  //List<ImagesDetailModel> imageslist = [];
  int currentIndex = 0;
  late PageController _controller;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
    getSharedprefences();
    print("title>>${widget.title}");

    tappedIndex = 0;
    ppmIdController.text = widget.ppmId;
    setState(() {});
    getprefences();
    Future.delayed(Duration.zero, () {
      getallApi();
      setState(() {});
    });
  }

  getSharedprefences() async{
    pre = await SharedPreferences.getInstance();
    user_name = pre!.getString("user_name").toString();
    serviceTypeId =  pre!.getString("resourceSubTypeId").toString();
    setState((){});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    summaryfocus.unfocus();
    _controller.dispose();
    unfocusTextfield();
  }
  unfocusTextfield(){
    titlefocus.unfocus();
    asssetcodefocus.unfocus();
    assetdesfocus.unfocus();
    reportedmobilefocus.unfocus();
    reportedemailfocus.unfocus();
  }

  getallApi() {
    asset_code = widget.assetcode.toString();
    if (widget.title == "PPM W/O") {
      GetLocationDetailsByAssetCodeapi();
      Requestscan(false);
      getprojectmasterdataapi(false);
      setassetdata();
      getResorce();
    } else {
      getResorce();
      RequestAdditionolInfo(context, false, "0");
      getprojectmasterdataapi(true);
      gettaskgenralinfo(true, widget.ServiceId);
    }
  }

  getResorce() async {
    resourceslist.clear();
    await Webservices.RequestGetResource(context, "2", resourceslist);
    setState(() {});
    print("resourceslist>>>${resourceslist.length}");
  }

  getprefences() async {
    p = await SharedPreferences.getInstance();
    name = p!.getString("user_name").toString();
    username = p!.getString("name").toString();
    mobile_countrycode =  p!.getString("mobileCode").toString();
    mobileno =  p!.getString("mobileNo").toString();
    emailController.text =  p!.getString("email").toString();

    //p!.getString("designation");

    setState(() {});
    // p!.getString("user_profile");
    // p!.getString("designation");
  }

  gettaskgenralinfo1(bool load, ServiceId) async {
    categorylist.clear();
    typeslist.clear();
    subTypeslist1.clear();
    prioritieslist.clear();

    setState(() {});
    await Webservices.RequestGettaskinfodetail(
        context, taskModel, load, "0", ServiceId, projectId, load,widget.title);
    // catemodel = Categories(id: 0, name: "Select Category", code: "");
    // categorylist.add(catemodel!);

    typeModel = Types(id: 0, name: "Select Type", code: "");
    typeslist.add(typeModel!);

    subtypeModel = SubTypes(id: 0, name: "Select SubType", code: "");
    subTypeslist.add(subtypeModel!);

    prioritiesModel = Priorities(id: 0, name: "Select Priority", code: "");
    prioritieslist.add(prioritiesModel!);

    setState(() {});

    if (taskModel.isEmpty) {
      print("if>>");
    } else {
      print("else>>");
      taskloginfolist = taskModel.first.taskLogInfo;
      taskInstructions = taskModel.first.configuration!.taskInstructions == null
          ? []
          : taskModel.first.configuration!.taskInstructions!;


      // categorylist = taskModel.first.configuration!.categories == null
      //         ? []
      //         : taskModel.first.configuration!.categories!;

      /// Category add list.....
      if (taskModel.first.configuration!.categories != null) {
        for (int i = 0;
        i < taskModel.first.configuration!.categories!.length;
        i++) {
          categorylist.add(taskModel.first.configuration!.categories![i]);
        }
      }

      /// check category.....
      for (int i = 0; i < categorylist.length; i++) {
        print(
            "categorylist[i].id.toString()>>${categorylist[i].id.toString()}");
        print(
            "categorylist[i].name.toString()>>${categorylist[i].name.toString()}");
        if (categoryId.toString() == categorylist[i].id.toString()) {
          categoryName = categorylist[i].name.toString();
          if (categoryId == categorylist[i].id.toString()) {
            tappedIndex = i;
            swapitems(tappedIndex);
            tappedIndex = 0;
          }
          break;
        }
      }


      /// Type list add
      if (taskModel.first.configuration!.types != null) {
        for (int i = 0; i < taskModel.first.configuration!.types!.length; i++) {
          typeslist.add(taskModel.first.configuration!.types![i]);
        }
      }

      /// Type list add
      if (taskModel.first.configuration!.subTypes != null) {
        print("typeslist>>${typeslist.length}");
        print("typeslist>>${taskModel.first.configuration!.subTypes!.length}");
        for (int i = 0;
        i < taskModel.first.configuration!.subTypes!.length;
        i++) {
          print("typeId>>>> ${taskModel.first.configuration!.subTypes![i].typeId.toString()}");
          print("typeId 333>>>> ${typeId.toString()}");
          //   for(int j = 0; j < typeslist.length; j++){


          subTypeslist1.add(taskModel.first.configuration!.subTypes![i]);
          //  }
        }

        print("subTypeslist.l${subTypeslist1.length}");

        //  }
      }

      if (taskModel.first.configuration!.priorities != null) {
        for (int i = 0;
        i < taskModel.first.configuration!.priorities!.length;
        i++) {
          prioritieslist.add(taskModel.first.configuration!.priorities![i]);
        }
      }

      if (taskModel.first.configuration!.channels != null) {
        for (int i = 0;
        i < taskModel.first.configuration!.channels!.length;
        i++) {
          channellist!.add(taskModel.first.configuration!.channels![i]);
          print(
              "channelname >>> ${taskModel.first.configuration!.channels![i].name.toString()}");
          if (taskModel.first.configuration!.channels![i].code.toString() ==
              "MOB") {
            channelID =
                taskModel.first.configuration!.channels![i].id.toString();
            channelName =
                taskModel.first.configuration!.channels![i].name.toString();
            channelcode =
                taskModel.first.configuration!.channels![i].code.toString();
            setState(() {});
            print("channelID>>${channelID}");
            print("channelName>>${channelName}");
            print("channelcode>>${channelcode}");
          }
        }
      }

      categoryName =
      categorylist.isNotEmpty ? categorylist.first.name.toString() : "";

      // typeslist = taskModel.first.configuration!.types == null
      //     ? []
      //     : taskModel.first.configuration!.types!;
      // subTypeslist = taskModel.first.configuration!.subTypes == null
      //     ? []
      //     : taskModel.first.configuration!.subTypes!;

      // prioritieslist = taskModel.first.configuration!.priorities == null
      //     ? []
      //     : taskModel.first.configuration!.priorities!;

      typeController.text =
      typeslist.isNotEmpty ? typeslist.first.name.toString() : "";
      subtypeController.text =
      subTypeslist.isNotEmpty ? subTypeslist.first.name.toString() : "";
      priorityController.text =
      prioritieslist.isNotEmpty ? prioritieslist.first.name.toString() : "";

      this.setState(() {});
    }
  }

  gettaskgenralinfo(bool load, ServiceId) async {
    categorylist.clear();
    typeslist.clear();
    subTypeslist1.clear();
    prioritieslist.clear();

    setState(() {});
    await Webservices.RequestGettaskinfodetail(context, taskModel, load, "0",
        ServiceId, projectId, load, widget.title);
    // catemodel = Categories(id: 0, name: "Select Category", code: "");
    // categorylist.add(catemodel!);

    typeModel = Types(id: 0, name: "Select Type", code: "");
    typeslist.add(typeModel!);

    subtypeModel = SubTypes(id: 0, name: "Select SubType", code: "");
    subTypeslist.add(subtypeModel!);

    prioritiesModel = Priorities(id: 0, name: "Select Priority", code: "");
    prioritieslist.add(prioritiesModel!);

    setState(() {});

    if (taskModel.isEmpty) {
      print("if>>");
    } else {
      print("else>>");
      taskloginfolist = taskModel.first.taskLogInfo;

      // categorylist = taskModel.first.configuration!.categories == null
      //         ? []
      //         : taskModel.first.configuration!.categories!;

      /// Category add list.....
      if (taskModel.first.configuration!.categories != null) {
        for (int i = 0;
        i < taskModel.first.configuration!.categories!.length;
        i++) {
          categorylist.add(taskModel.first.configuration!.categories![i]);
        }
      }

      /// Type list add
      if (taskModel.first.configuration!.types != null) {
        for (int i = 0; i < taskModel.first.configuration!.types!.length; i++) {
          typeslist.add(taskModel.first.configuration!.types![i]);
        }
      }

      /// Type list add
      if (taskModel.first.configuration!.subTypes != null) {
        print("typeslist>>${typeslist.length}");
        print("typeslist>>${taskModel.first.configuration!.subTypes!.length}");
        for (int i = 0;
        i < taskModel.first.configuration!.subTypes!.length;
        i++) {
          print(
              "typeId>>>> ${taskModel.first.configuration!.subTypes![i].typeId.toString()}");
          print("typeId 333>>>> ${typeId.toString()}");
          //   for(int j = 0; j < typeslist.length; j++){

          subTypeslist1.add(taskModel.first.configuration!.subTypes![i]);
          //  }
        }

        print("subTypeslist.l${subTypeslist1.length}");

        //  }
      }

      if (taskModel.first.configuration!.priorities != null) {
        for (int i = 0;
        i < taskModel.first.configuration!.priorities!.length;
        i++) {
          prioritieslist.add(taskModel.first.configuration!.priorities![i]);
        }
      }

      if (taskModel.first.configuration!.channels != null) {
        for (int i = 0;
        i < taskModel.first.configuration!.channels!.length;
        i++) {
          channellist!.add(taskModel.first.configuration!.channels![i]);
          print(
              "channelname >>> ${taskModel.first.configuration!.channels![i].code.toString()}");
          if (taskModel.first.configuration!.channels![i].code.toString() ==
              "MOB") {
            channelID =
                taskModel.first.configuration!.channels![i].id.toString();
            channelName =
                taskModel.first.configuration!.channels![i].name.toString();
            channelcode =
                taskModel.first.configuration!.channels![i].code.toString();
            setState(() {});
            print("channelID>>${channelID}");
            print("channelName>>${channelName}");
            print("channelcode>>${channelcode}");
          }
        }
      }
      if (taskModel.first.configuration!.locs != null) {
        for (int i = 0;
        i < taskModel.first.configuration!.locs!.length;
        i++) {
          loclist!.add(taskModel.first.configuration!.locs![i]);
          print(
              "locID >>> ${taskModel.first.configuration!.locs![i].name.toString()}");
          if (taskModel.first.configuration!.locs![i].name.toString() ==
              "Open") {
            locID =
                taskModel.first.configuration!.locs![i].id.toString();
            locname =
                taskModel.first.configuration!.locs![i].name.toString();
            loccode =
                taskModel.first.configuration!.locs![i].code.toString();
            setState(() {});
            print("locID>>${locID}");
            print("locName>>${locname}");
            print("loccode>>${loccode}");
          }
        }
      }

      if (taskModel.first.configuration!.faultCodes != null) {
        for (int i = 0;
        i < taskModel.first.configuration!.faultCodes!.length;
        i++) {
          faultCodes.add(taskModel.first.configuration!.faultCodes![i]);
          // print(
          //     "locID >>> ${taskModel.first.configuration!.locs![i].name.toString()}");
          // if (taskModel.first.configuration!.locs![i].name.toString() ==
          //     "Open") {
          faultcodeId =
              taskModel.first.configuration!.faultCodes![i].id.toString();
          faultname =
              taskModel.first.configuration!.faultCodes![i].name.toString();
          faultcode =
              taskModel.first.configuration!.faultCodes![i].code.toString();
          setState(() {});
          print("faultcodeId>>${faultcodeId}");
          print("faultname>>${faultname}");
          print("faultcode>>${faultcode}");
          // }
        }
      }

      categoryName =
      categorylist.isNotEmpty ? categorylist.first.name.toString() : "";

      // typeslist = taskModel.first.configuration!.types == null
      //     ? []
      //     : taskModel.first.configuration!.types!;
      // subTypeslist = taskModel.first.configuration!.subTypes == null
      //     ? []
      //     : taskModel.first.configuration!.subTypes!;

      // prioritieslist = taskModel.first.configuration!.priorities == null
      //     ? []
      //     : taskModel.first.configuration!.priorities!;

      typeController.text = typeslist.isNotEmpty ? typeslist.first.name.toString() : "";
      subtypeController.text = subTypeslist.isNotEmpty ? subTypeslist.first.name.toString() : "";
      priorityController.text = prioritieslist.isNotEmpty ? prioritieslist.first.name.toString() : "";

      this.setState(() {});
    }
  }

  unfocustextfild() {
    summaryfocus.unfocus();
    titlefocus.unfocus();
  }

  setassetdata() {
    if (scanlist.isNotEmpty) {
      desController.text = scanlist.first.description.toString() == "null"? "": scanlist.first.description.toString();
      asset_codeController.text = scanlist.first.code.toString() == "null"  ?"" : scanlist.first.code.toString();
      asset_IdController.text = scanlist.first.id.toString() == "null" ? "" : scanlist.first.id.toString();
      setState(() {});
    }
  }

  setassetscandata() async{
    print("unitId>>${unitId}");
    print("unitId>>${unitController.text}");
    if (assetscanlist.isNotEmpty) {
      projectController.text = assetscanlist.first.projectName.toString();
      buildingController.text = assetscanlist.first.buildingName.toString();
      floreController.text = assetscanlist.first.floorName.toString();
      roomController.text = assetscanlist.first.roomName.toString();
      locationController.text = assetscanlist.first.roomName.toString();
      unitController.text = assetscanlist.first.unitName.toString() == "null" ? "" : assetscanlist.first.unitName.toString();

      projectId = assetscanlist.first.projectId.toString();
      buildingId = assetscanlist.first.buildingId.toString();
      floorId = assetscanlist.first.floorId.toString();
      roomId = assetscanlist.first.roomId.toString();
      unitId = assetscanlist.first.unitId.toString() == "null" ?"" : assetscanlist.first.unitId.toString();

      print("unitId>>${projectId}");
      setState(() {});
      if(projectId == "0" || projectId.trim().isEmpty){
        CustomToast.showToast(msg: "Asset detail not found");
        assetscanlist.clear();
        cleardata();
        setState(() {});
      }
      RequestAssignToApi();
      await Requestfloor(context, "0", projectId, "scan");
    }
  }
  cleardata(){
    floorModel =
    floorlist.isNotEmpty ? floorlist.first : null;
    problemController.text = "";
    roomslist!.clear();
    floorlist.clear();
    buildingslist!.clear();
    unitslist!.clear();
    Resourceslist!.clear();
    reporterTypeslist!.clear();
    reporterSubTypeslist!.clear();
    buildingId = "";
    floorId = "";
    unitId = "";
    roomId = "";
    repoterTypeId = "";
    reporterSubTypesId = "";
    RecorcesId = "";
    projectId = "";
    projectController.text = "";


    assetscanlist.clear();
    setState(() {});
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
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            automaticallyImplyLeading: false,
            backgroundColor: myColors.white,
            elevation: 0,
            flexibleSpace: Container(
              padding: EdgeInsets.fromLTRB(10, 12, 0, 5),
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
                            child: Image.asset(
                              "assets/icons/ic_newBack.png",
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: CustomText.CustomBoldText(
                                  widget.title,
                                  myColors.black,
                                  FontWeight.w700,
                                  16,
                                  1,
                                  TextAlign.center)),
                          flex: 2,
                        ),
                        Container(
                          height: 30,
                          width: 50,
                          child: InkWell(
                            onTap: () {
                              if (projectId.trim().isEmpty ||
                                  projectId == "" ||
                                  projectId == "null") {
                                CustomToast.showToast(
                                    msg: "Please select Project name");
                              } else if (buildingId.trim().isEmpty ||
                                  buildingId == "" ||
                                  buildingId == "null") {
                                CustomToast.showToast(
                                    msg: "Please select Building name");
                              }
                              else if (priorityId.trim().isEmpty ||
                                  priorityId == "" ||
                                  priorityId == "null") {
                                CustomToast.showToast(
                                    msg: "Please select Priority name");
                              }
                              else if (problemController.text.trim().isEmpty ||
                                  problemController.text == "" ||
                                  problemController.text == "null") {
                                CustomToast.showToast(msg: "Please enter Title");
                              }
                              else {
                                getallResources("0", typeId, subtypeId, projectId);
                              }
                            },
                            child: Image.asset("assets/images/color_CheckCircle-img.png",height: 35,width: 35,),
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
        body: GestureDetector(
          onTap: () {
            unfocustextfild();
          },
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Add Photo................

                Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(color: myColors.grey_38),
                  child: Stack(
                    children: [
                      Container(
                        height: 230,
                        child: PageView.builder(
                            controller: _controller,
                            itemCount: imagefilelist.length + 1,
                            onPageChanged: (int index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            itemBuilder: (_, i) {
                              return i == 0
                                  ? GestureDetector(
                                onTap: () {
                                  _handleimagepicker();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 230,
                                  decoration: BoxDecoration(
                                      color: myColors.grey_38),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/camera.svg"),
                                      hsized10,
                                      Text(
                                        "Add a photo",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily:
                                            "PlusJakartaSansSemibold"),
                                      )
                                    ],
                                  ),
                                ),
                              )
                                  : imagefilelist.length > 0
                                  ? Container(
                                height: mediaQuerryData.size.height,
                                width: mediaQuerryData.size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(
                                            imagefilelist[i - 1]
                                                .path
                                                .toString())),
                                        fit: BoxFit.fitWidth)),
                              )
                                  : Container(
                                height: mediaQuerryData.size.height,
                                width: mediaQuerryData.size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/image.png"),
                                        fit: BoxFit.fitWidth)),
                              );
                            }),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              imagefilelist.length + 1,
                                  (index) => buildDot(index, context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Visibility(
                  visible: false,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 16, 16, 0),
                      child: Row(
                        children: [
                          CustomText.CustomSemiBoldText("Job no -  14358",
                              myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.fromLTRB(15,10,15,10),
                            decoration: BoxDecoration(
                                color: myColors.app_theme,
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: Text("P3- Normal",
                              style: TextStyle(
                                  fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: myColors.white
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )

                  ),
                ),


                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  // padding: EdgeInsets.only(right: 20),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        //  width: 32,
                          child: Text(
                            MyString.Date_,
                            style: TextStyle(
                              color:myColors.black,
                              fontWeight:  FontWeight.w600,
                              fontSize: 12,
                              fontFamily: MyString.PlusJakartaSansBold,
                            ),
                          )),
                      Spacer(),
                      Container(
                        //  width: 72,
                        child: CustomText.CustomRegularText(
                            "${DateFormat.d().format(DateTime.parse(DateTime.now().toString()))} ${DateFormat.yMMM().format(DateTime.parse(DateTime.now().toString()))}",
                            // "05 Sep 2020",
                            myColors.black,
                            FontWeight.w400,
                            12,
                            1,
                            TextAlign.center),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  // padding: EdgeInsets.only(right: 20),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        //  width: 32,
                          child: Text(
                            "Name :",
                            style: TextStyle(
                              color:myColors.black,
                              fontWeight:  FontWeight.w600,
                              fontSize: 12,
                              fontFamily: MyString.PlusJakartaSansBold,
                            ),
                          )),
                      Spacer(),
                      Container(
                        //  width: 72,
                        child: CustomText.CustomRegularText(
                            "${name}",
                            // "05 Sep 2020",
                            myColors.black,
                            FontWeight.w400,
                            12,
                            1,
                            TextAlign.center),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  // padding: EdgeInsets.only(right: 20),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        //  width: 32,
                          child: Text(
                            "Email : ",
                            style: TextStyle(
                              color:myColors.black,
                              fontWeight:  FontWeight.w600,
                              fontSize: 12,
                              fontFamily: MyString.PlusJakartaSansBold,
                            ),
                          )),
                      Spacer(),
                      Container(
                        //  width: 72,
                        child: CustomText.CustomRegularText(
                            "${emailController.text}",
                            // "05 Sep 2020",
                            myColors.black,
                            FontWeight.w400,
                            12,
                            1,
                            TextAlign.center),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  // padding: EdgeInsets.only(right: 20),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        //  width: 32,
                          child: Text(
                            "Mobile : ",
                            style: TextStyle(
                              color:myColors.black,
                              fontWeight:  FontWeight.w600,
                              fontSize: 12,
                              fontFamily: MyString.PlusJakartaSansBold,
                            ),
                          )),
                      Spacer(),
                      Container(
                        //  width: 72,
                        child: CustomText.CustomRegularText(
                            "+${mobile_countrycode} ${mobileno}",
                            // "05 Sep 2020",
                            myColors.black,
                            FontWeight.w400,
                            12,
                            1,
                            TextAlign.center),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  // padding: EdgeInsets.only(right: 20),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        //  width: 32,
                          child: Text(
                            "Call Source : ",
                            style: TextStyle(
                              color:myColors.black,
                              fontWeight:  FontWeight.w700,
                              fontSize: 12,
                              fontFamily: MyString.PlusJakartaSansBold,
                            ),
                          )),
                      Spacer(),
                      Container(
                        //  width: 72,
                        child: CustomText.CustomRegularText(
                            "Mobile",
                            // "05 Sep 2020",
                            myColors.black,
                            FontWeight.w400,
                            12,
                            1,
                            TextAlign.center),
                      ),
                    ],
                  ),
                ),

                ///Form 1.............................................
                /*Container(
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
                      ///Job No.............................................
                      Container(
                        padding: EdgeInsets.fromLTRB(12, 4, 12, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  MyString.Job_No,
                                  myColors.black,
                                  FontWeight.w700,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Container(
                              width: 5,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  ":",
                                  myColors.black,
                                  FontWeight.w700,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 24,
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      enabled: false,
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
                                            'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                                        color: myColors.grey_27,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_27,
                                              fontFamily:
                                                  "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
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
                              width: 32,
                              child: CustomText.CustomBoldText(
                                  MyString.Date_,
                                  myColors.black,
                                  FontWeight.w700,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Container(
                              width: 72,
                              child: CustomText.CustomBoldText(
                                  "${DateFormat.d().format(DateTime.parse(DateTime.now().toString()))} ${DateFormat.yMMM().format(DateTime.parse(DateTime.now().toString()))}",
                                  // "05 Sep 2020",
                                  myColors.black,
                                  FontWeight.w400,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                          ],
                        ),
                      ),

                      ///Name...........................................
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 2, 16, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  MyString.Name,
                                  myColors.black,
                                  FontWeight.w500,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Container(
                              width: 5,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  ":",
                                  myColors.black,
                                  FontWeight.w700,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 24,
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      enabled: false,
                                      controller: nameController,
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
                                            'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                                        color: myColors.grey_27,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "${name}",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_27,
                                              fontFamily:
                                                  "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
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
                              width: 9,
                              height: 9,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: myColors.active_green,
                              ),
                            ),
                            Container(
                              width: 35,
                              margin: EdgeInsets.only(left: 2),
                              child: CustomText.CustomMediumText(
                                  "present",
                                  myColors.active_green,
                                  FontWeight.w500,
                                  9,
                                  1,
                                  TextAlign.center),
                            ),
                          ],
                        ),
                      ),

                      ///Email...........................................
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 2, 16, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  MyString.Email_,
                                  myColors.black,
                                  FontWeight.w500,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Container(
                              width: 5,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  ":",
                                  myColors.black,
                                  FontWeight.w700,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 24,
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      enabled: false,
                                      controller: emailController,
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
                                            'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                                        color: myColors.grey_27,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "mail@companyname.com",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_27,
                                              fontFamily:
                                                  "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
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

                      ///Mobile...........................................
                        Container(
                        padding: EdgeInsets.fromLTRB(16, 2, 16, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  MyString.Mobile,
                                  myColors.black,
                                  FontWeight.w500,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Container(
                              width: 5,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  ":",
                                  myColors.black,
                                  FontWeight.w700,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 24,
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      enabled: false,
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
                                            'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                                        color: myColors.grey_27,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_27,
                                              fontFamily:
                                                  "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
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
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),*/

                ///Form 2.............................................
                // Container(
                //   margin: EdgeInsets.fromLTRB(16, 20, 16, 16),
                //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                //   alignment: Alignment.centerLeft,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(5)),
                //     border: Border.all(color: myColors.app_theme),
                //     color: myColors.bg,
                //   ),
                //   child: Column(
                //     children: [
                //       ///Asset_Code...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(12, 6, 12, 0),
                //         child: Row(
                //           children: [
                //             Container(
                //               width: 80,
                //               alignment: Alignment.topLeft,
                //               child: CustomText.CustomMediumText(
                //                   MyString.Asset_Code,
                //                   myColors.black,
                //                   FontWeight.w500,
                //                   12,
                //                   1,
                //                   TextAlign.center),
                //             ),
                //             Container(
                //               width: 5,
                //               alignment: Alignment.topLeft,
                //               child: CustomText.CustomMediumText(
                //                   ":",
                //                   myColors.black,
                //                   FontWeight.w700,
                //                   12,
                //                   1,
                //                   TextAlign.center),
                //             ),
                //             Expanded(
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     margin: EdgeInsets.only(top: 10,bottom: 6),
                //                     padding: EdgeInsets.only(left: 15),
                //                     alignment: Alignment.topLeft,
                //                     child:
                //                     Text(asset_codeController.text,style: TextStyle(
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.w500,
                //                       decoration: TextDecoration.none,
                //                       fontFamily:
                //                       'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                       color: myColors.grey_27,
                //                     ),)
                //
                //                  /*   TextField(
                //                       controller: asset_codeController,
                //                       enabled: asset_codeController.text.isEmpty ? true :false,
                //                       keyboardType: TextInputType.text,
                //                       onChanged: (String value) {
                //                         print("TAG" + value);
                //                         setState(() {});
                //                       },
                //                       style: TextStyle(
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w500,
                //                         decoration: TextDecoration.none,
                //                         fontFamily:
                //                             'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                         color: myColors.grey_27,
                //                       ),
                //                       decoration: InputDecoration(
                //                           border: InputBorder.none,
                //                           hintText: "",
                //                           hintStyle: TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.w500,
                //                               color: myColors.grey_27,
                //                               fontFamily:
                //                                   "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                //                           isDense: true,
                //                           // this will remove the default content padding
                //                           contentPadding:
                //                               EdgeInsets.fromLTRB(5, 1, 8, 6)),
                //                       cursorColor: myColors.grey_26,
                //                     ),*/
                //                   ),
                //                   Container(
                //                     height: 1,
                //                     margin: EdgeInsets.fromLTRB(12, 0, 6, 0),
                //                     color: myColors.grey_27,
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             widget.title == "PPM W/O"
                //                 ? Container()
                //                 : Column(
                //                   children: [
                //                     GestureDetector(
                //                         onTap: () async {
                //                           var res = await Navigator.push(
                //                               context,
                //                               MaterialPageRoute(
                //                                 builder: (context) =>
                //                                 const SimpleBarcodeScannerPage(
                //                                   lineColor: "#ff6666",
                //                                   isShowFlashIcon: true,
                //                                   scanType: ScanType.barcode,
                //                                   centerTitle: false,
                //                                 ),
                //                               ));
                //                           setState(() async {
                //                             if (res is String) {
                //                               asset_code = res;
                //                               print("res>>${res}");
                //                               if(res.toString() == "-1"){
                //                                 CustomToast.showToast(msg: "Failled");
                //                               }else{
                //                                 GetLocationDetailsByAssetCodeapi();
                //                                 Requestscan(false);
                //                                 getprojectmasterdataapi(false);
                //                                 setassetdata();
                //
                //                               }
                //                             }
                //                           });
                //                           setState(() {});
                //                         },
                //                         child: Container(
                //                           padding: EdgeInsets.only(top: 5),
                //                           width: 27,
                //                           child: Center(
                //                               child: Image.asset(
                //                             "assets/images/img_scanner.png",
                //                             height: 22,
                //                             width: 26,
                //                           )),
                //                         ),
                //                       ),
                //
                //                     GestureDetector(
                //                       onTap: () async {
                //                        if(asset_codeController.text.trim().isEmpty){
                //                          CustomToast.showToast(msg: "Please enter Asset code");
                //                        }
                //                        else{
                //                          GetLocationDetailsByAssetCodeapi();
                //                          Requestscan(false);
                //                          getprojectmasterdataapi(false);
                //                          setassetdata();
                //                          await  Requestfloor(context, "0", projectId, "scan");
                //                        }
                //                       },
                //                       child: Container(
                //                         padding: EdgeInsets.only(top: 5),
                //                         child: Center(
                //                             child: Text("Scan",style: TextStyle(color: myColors.black,fontWeight: FontWeight.w600,fontSize: 13),)),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //           ],
                //         ),
                //       )
                //           ])
                //       ),



                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 6, 0),
                        child: Text(
                          "Asset Details",
                          style: TextStyle(
                              fontFamily:
                              MyString.PlusJakartaSansBold,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),


                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 6, 0),
                        child: Text("Code",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              fontFamily: MyString.PlusJakartaSansBold,
                              color: myColors.black
                          ),
                        ),
                      ),

                      /// QR Code..........
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(20, 14, 20, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: myColors.grey_38)),
                                    alignment: Alignment.centerLeft,
                                    child: TextField(
                                      controller: asset_codeController,
                                      // enabled: is_assetcode,
                                      //asset_codeController.text.isEmpty ? true :false,
                                      keyboardType: TextInputType.text,
                                      onChanged: (String value) {},
                                      onSubmitted: (value){
                                        asset_code = value;
                                        setState(() {});
                                        GetLocationDetailsByAssetCodeapi();
                                        Requestscan(false);
                                        getprojectmasterdataapi(false);
                                        setassetdata();
                                      },
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.none,
                                        fontFamily: MyString.PlusJakartaSansmedium,
                                        color:myColors.black,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Code",
                                          hintStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_27,
                                              fontFamily: MyString.PlusJakartaSansmedium),
                                          isDense: true,
                                          // this will remove the default content padding
                                          contentPadding:
                                          EdgeInsets.fromLTRB(5, 1, 8, 6)),
                                      cursorColor: myColors.grey_26,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /* Expanded(
                              child: Container(

                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: myColors.grey_38)),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  asset_codeController.text
                                      .trim()
                                      .isEmpty
                                      ? "Code"
                                      : asset_codeController.text,
                                  style: TextStyle(
                                      color: asset_codeController
                                          .text
                                          .trim()
                                          .isEmpty
                                          ? myColors.grey_27
                                          : Colors.black,
                                      fontSize: asset_codeController
                                          .text
                                          .trim()
                                          .isEmpty
                                          ? 13
                                          : 13,

                                      fontWeight:
                                      asset_codeController.text
                                          .trim()
                                          .isEmpty
                                          ? FontWeight.w500
                                          : FontWeight.w500,
                                      fontFamily:
                                      MyString.PlusJakartaSansmedium),
                                ),
                              ),
                            ),*/
                            // Spacer(),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var res = await Navigator.push(
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
                                        print("res>>${res}");
                                        if (res.toString() == "-1") {
                                          CustomToast.showToast(msg: "Failled");
                                        }else if(res.contains("https")){
                                          CustomToast.showToast(msg: "Invalid Asset Code");
                                        }else if(res.contains("http")){
                                          CustomToast.showToast(msg: "Invalid Asset Code");
                                        }
                                        else {
                                          GetLocationDetailsByAssetCodeapi();
                                          Requestscan(false);
                                          getprojectmasterdataapi(false);
                                          setassetdata();
                                        }
                                      }
                                    });
                                    setState(() {});
                                  },
                                  child: Image.asset(
                                    "assets/images/qr_img.png",
                                    height: 32,
                                    width: 32,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () async {
                                    if(asset_codeController.text.trim().isEmpty){
                                      CustomToast.showToast(msg: "Please enter Asset code");
                                    }
                                    else{
                                      GetLocationDetailsByAssetCodeapi();
                                      Requestscan(false);
                                      getprojectmasterdataapi(false);
                                      setassetdata();
                                      await  Requestfloor(context, "0", projectId, "scan");
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: myColors.app_theme,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    padding: EdgeInsets.all( 5),
                                    margin: EdgeInsets.only(top: 5),
                                    child: Center(
                                        child: Text("Scan",style: TextStyle(color: myColors.white,fontWeight: FontWeight.w600,fontSize: 13),)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),


                      ///Description ...........................................
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  fontFamily: MyString.PlusJakartaSansBold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 14,
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: myColors.grey_38)),
                                    alignment: Alignment.centerLeft,
                                    child: TextField(
                                      controller: desController,
                                      // enabled: is_assetcode,
                                      //asset_codeController.text.isEmpty ? true :false,
                                      keyboardType: TextInputType.text,
                                      onChanged: (String value) {},
                                      onSubmitted: (value){
                                        // asset_code = value;
                                        // setState(() {});
                                        // GetLocationDetailsByAssetCodeapi();
                                        // Requestscan(false);
                                        // getprojectmasterdataapi(false);
                                        // setassetdata();
                                      },
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.none,
                                        fontFamily: MyString.PlusJakartaSansmedium,
                                        color:myColors.black,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Description",
                                          hintStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_27,
                                              fontFamily: MyString.PlusJakartaSansmedium),
                                          isDense: true,
                                          // this will remove the default content padding
                                          contentPadding:
                                          EdgeInsets.fromLTRB(5, 1, 8, 6)),
                                      cursorColor: myColors.grey_26,
                                    ),
                                  ),
                                ),
                                //   Text(
                                //   asset_codeController.text,
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.w400,
                                //       fontSize: 12,
                                //       fontFamily: "PlusJakartaSansregular",
                                //       color: Colors.black),
                                // ),
                              ],
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 10, vertical: 15),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10),
                            //       border: Border.all(color: myColors.grey_38)),
                            //   alignment: Alignment.centerLeft,
                            //   child:
                            //   Text(
                            //     desController.text
                            //         .trim()
                            //         .isEmpty
                            //         ? "Description"
                            //         : desController.text,
                            //     style: TextStyle(
                            //         color: desController
                            //             .text
                            //             .trim()
                            //             .isEmpty
                            //             ? myColors.grey_27
                            //             : Colors.black,
                            //         fontSize: desController
                            //             .text
                            //             .trim()
                            //             .isEmpty
                            //             ? 13
                            //             : 13,
                            //
                            //         fontWeight:
                            //         desController.text
                            //             .trim()
                            //             .isEmpty
                            //             ? FontWeight.w400
                            //             : FontWeight.w400,
                            //         fontFamily:
                            //         MyString.PlusJakartaSansregular),
                            //   ),
                            // ),

                          ],
                        ),
                      ),

                      ///line..................
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      //   height: 1.2,
                      //   color: myColors.grey_twelve,
                      // ),



                      ///PPm Id ...........................................
                      widget.title == "PPM W/O"
                          ? Container(
                        padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  MyString.ppmId,
                                  myColors.black,
                                  FontWeight.w500,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Container(
                              width: 5,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  ":",
                                  myColors.black,
                                  FontWeight.w700,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 25,
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      enabled: false,
                                      controller: ppmIdController,
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
                                          hintText: "",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_27,
                                              fontFamily:
                                              MyString.PlusJakartaSansregular),
                                          isDense: true,
                                          // this will remove the default content padding
                                          contentPadding:
                                          EdgeInsets.fromLTRB(
                                              16, 1, 0, 0)),
                                      maxLines: 1,
                                      cursorColor: myColors.grey_26,
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    margin:
                                    EdgeInsets.fromLTRB(12, 0, 0, 0),
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
                      )
                          : Container(),

                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),

                ///Form 3..(Contract)...........................................

                /// Project
                Container(
                  padding: EdgeInsets.fromLTRB(20, 6, 20, 0),
                  child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomBoldText(
                                  "Contract",
                                  myColors.black,
                                  FontWeight.w700,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: myColors.grey_38)
                          ),
                          padding: EdgeInsets.fromLTRB(10,5,15,5),
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.topLeft,
                          child: assetscanlist.isEmpty
                              ? projectdropdown()
                              : Container(
                            // padding: EdgeInsets.only(left: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(projectController.text,style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                              fontFamily:
                              MyString.PlusJakartaSansregular,
                              color: myColors.grey_27,
                            ),),
                          )

                        // TextField(
                        //         enabled: false,
                        //         controller: projectController,
                        //         keyboardType: TextInputType.text,
                        //         onChanged: (String value) {
                        //           print("TAG" + value);
                        //           setState(() {});
                        //         },
                        //         style: TextStyle(
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w500,
                        //           decoration: TextDecoration.none,
                        //           fontFamily:
                        //               'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                        //           color: myColors.grey_27,
                        //         ),
                        //         decoration: InputDecoration(
                        //             border: InputBorder.none,
                        //             hintText: "CAFM-LMG",
                        //             hintStyle: TextStyle(
                        //                 fontSize: 12,
                        //                 fontWeight: FontWeight.w500,
                        //                 color: myColors.grey_27,
                        //                 fontFamily:
                        //                     "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                        //             isDense: true,
                        //             // this will remove the default content padding
                        //             contentPadding:
                        //                 EdgeInsets.fromLTRB(
                        //                     15, 1, 0, 6)),
                        //         maxLines: 1,
                        //         cursorColor: myColors.grey_26,
                        //       ),
                      ),
                    ],
                  ),
                ),

                /// Problem......
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Problem",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFamily: MyString.PlusJakartaSansBold,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: myColors.grey_38),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(
                          enabled: true,
                          controller: problemController,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            print("TAG" + value);
                            setState(() {});
                          },
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                            fontFamily:
                            MyString.PlusJakartaSansregular,
                            color: myColors.black,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    is_taskinstruction =
                                    !is_taskinstruction;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.text_snippet,
                                    size: 18,
                                  )),
                              border: InputBorder.none,
                              hintText: "Enter problem",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: myColors.grey_27,
                                fontFamily:
                                MyString.PlusJakartaSansregular,),
                              isDense: true,
                              // this will remove the default content padding
                              contentPadding:
                              EdgeInsets.fromLTRB(
                                  10, 12, 10, 0)),
                          cursorColor: myColors.black,
                        ),
                      ),

                      taskInstructions!.isEmpty
                          ? Container()
                          : Visibility(
                        visible: is_taskinstruction,
                        child: Container(
                          height: 250,
                          margin: EdgeInsets.only(top: 0),
                          padding: EdgeInsets.symmetric(
                              horizontal: 0, vertical: 1),
                          decoration: BoxDecoration(
                              color: myColors.white,
                              borderRadius:
                              BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: myColors.light_blue,
                                    spreadRadius: 2)
                              ]),
                          child: Material(
                            color: myColors.white,
                            shadowColor:myColors.grey_28,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: ListView.builder(
                                physics:
                                AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: taskInstructions!.length,
                                itemBuilder: (context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      categoryId =
                                          taskInstructions![index]
                                              .categoryId
                                              .toString();
                                      setState(() {});
                                      problemController.text =
                                          taskInstructions![index]
                                              .name
                                              .toString();
                                      selectedtaskinstruction =
                                          taskInstructions![index]
                                              .name
                                              .toString();
                                      selectedtaskinstructionID =
                                          taskInstructions![index]
                                              .id
                                              .toString();
                                      is_taskinstruction = false;
                                      setState(() {});
                                      gettaskgenralinfo(true,widget.ServiceId);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 0, bottom: 0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          hsized5,
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20,right: 20),
                                            child: Text(
                                              taskInstructions![index]
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily:
                                                MyString.PlusJakartaSansregular,),
                                            ),
                                          ),
                                          hsized10,
                                          Container(
                                            height: 1,
                                            color:myColors.grey_38,
                                          ),
                                          hsized10,
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                /// Summary........
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Summary",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFamily: MyString.PlusJakartaSansBold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: myColors.grey_38),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(
                          enabled: true,
                          maxLines: null,
                          controller: summaryController,
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            print("TAG" + value);
                            setState(() {});
                          },
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                            fontFamily:
                            MyString.PlusJakartaSansregular,
                            color: myColors.black,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter summary",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: myColors.grey_27,
                                fontFamily:
                                MyString.PlusJakartaSansregular,),
                              isDense: true,
                              // this will remove the default content padding
                              contentPadding:
                              EdgeInsets.fromLTRB(
                                  10, 1, 10, 6)),
                          cursorColor: myColors.black,
                        ),
                      )
                    ],
                  ),
                ),


                /// Building..........
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20,top:20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomBoldText(
                                  "Building",
                                  myColors.black,
                                  FontWeight.w700,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: myColors.grey_38)
                          ),
                          height: 50.0,
                          padding: EdgeInsets.fromLTRB(10,0,10,0),
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.topLeft,
                          child: assetscanlist.isEmpty
                              ? buildingdropdown()
                              : Container(
                            // padding: EdgeInsets.only(left: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(buildingController.text,style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                              fontFamily:
                              MyString.PlusJakartaSansregular,
                              color: myColors.grey_27,
                            ),),
                          )

                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Column(
                        children: [
                          Container(
                            // padding: EdgeInsets.fromLTRB(15,5,15,5),
                              alignment: Alignment.topLeft,
                              child: floordropdown()
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                /// Unit and Floor .....................
                Container(
                  padding: EdgeInsets.only(left: 20, right: 10,top: 20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // flex: 1,
                          child:  unitdropdown()),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // flex: 1,
                          child: Container(child:
                          location_store_dropdown()
                          )
                      )
                    ],
                  ),
                ),


                /// Type and Subtype .....................
                Container(
                  padding: EdgeInsets.only(left: 20, right: 10,top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // flex: 1,
                        child: Container(child:typedropdown()
                          //Text("Building"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // flex: 1,
                        child: Container(child: subtypedropdown()
                          //Text("Building"),
                        ),
                      )
                    ],
                  ),
                ),

                /// priority .....................
                Container(
                  padding: EdgeInsets.only(left: 20, right: 10,top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // flex: 1,
                        child: Container(child:prioritydropdown()
                          //Text("Building"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // flex: 1,
                        child: Container(child: Resourcesdropdown()
                          //Text("Building"),
                        ),
                      )
                    ],
                  ),
                ),


                /// Category..............
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 0),
                        child: CustomText.CustomBoldText(
                            "Category",
                            myColors.black,
                            FontWeight.w700,
                            12,
                            1,
                            TextAlign.center),
                      ),
                    ],
                  ),
                ),

                categorylist.isNotEmpty ?

                SizedBox(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              categorylist.length,
                                  (index) {
                                return Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      categoryId = categorylist[index].id.toString();
                                      print("selected_category>${categoryId}");
                                      tappedIndex = index;
                                      swapitems(tappedIndex);
                                      tappedIndex = 0;
                                      setState(() {});
                                      print("tappedIndex......$tappedIndex");
                                    },
                                    child: Container(
                                      // height: 50,
                                        margin: EdgeInsets.fromLTRB(0,5,0,5),
                                        padding: EdgeInsets.fromLTRB(20,10,20,10),
                                        decoration: BoxDecoration(
                                            color: categoryId == categorylist[index].id.toString()
                                                ? myColors.app_theme
                                                : myColors.grey_border,
                                            // color: AppColors.appContainer,
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Center(
                                            child: Text(
                                                categorylist[index].name.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: MyString.PlusJakartaSansregular,
                                                    color: categoryId == categorylist[index].id.toString()
                                                        ? myColors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.center))),
                                  ),
                                );
                              }),
                        ),
                      )

                  ),
                )
                    : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      height: 1.2,
                      color: myColors.grey_twelve,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20,bottom: 10),
                        alignment: Alignment.center,
                        child: Text("No Category")
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      height: 1.2,
                      color: myColors.grey_twelve,
                    ),

                  ],
                ),


                /// Reported by............................
                Visibility(
                  visible: false,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: myColors.app_theme),
                      color: myColors.bg,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Reported by text..............
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: CustomText.CustomMediumText(
                                  "Reported by",
                                  myColors.app_theme,
                                  FontWeight.w700,
                                  15,
                                  1,
                                  TextAlign.center),
                            ),

                            Image.asset("assets/images/img_user_plus_theme.png",height: 23,width: 23,)

                          ],
                        ),


                        reporterTypeslist!.isEmpty?
                        Container():
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),

                              ///ReporterType  ...........................................
                              Container(
                                //   padding: EdgeInsets.fromLTRB(12, 6, 12, 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: List.generate(
                                          reporterTypeslist!.length, (index) {
                                        //    repoterTypeId = reporterTypeslist!.first.id.toString();
                                        return GestureDetector(
                                          onTap: () async {
                                            reporterSubTypeslist!.clear();
                                            reporterSubTypesId = "";
                                            setState(() {});
                                            repoterTypeId =
                                                reporterTypeslist![index].id.toString();
                                            setState(() {});
                                            await Requestfloor(context, "0", projectId,
                                                "SubReporterType");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 10),
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                color: repoterTypeId ==
                                                    reporterTypeslist![index]
                                                        .id
                                                        .toString()
                                                    ? myColors.app_theme
                                                    : myColors.grey_two,
                                                borderRadius: BorderRadius.circular(30)),
                                            //  width: 80,
                                            alignment: Alignment.topLeft,
                                            child: CustomText.CustomMediumText(
                                                "${reporterTypeslist![index].name.toString()}",
                                                repoterTypeId ==
                                                    reporterTypeslist![index]
                                                        .id
                                                        .toString()
                                                    ? myColors.white
                                                    : Colors.black,
                                                FontWeight.w500,
                                                13,
                                                1,
                                                TextAlign.center),
                                          ),
                                        );
                                      })),
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),

                              ///ReporterSubType  ...........................................

                              Container(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: List.generate(
                                          reporterSubTypeslist!.length, (index) {
                                        return GestureDetector(
                                          onTap: () async{
                                            assignresourcelist.clear();
                                            reporterSubTypesId =
                                                reporterSubTypeslist![index]
                                                    .id
                                                    .toString();
                                            assignresourcelist.clear();
                                            setState(() {});
                                            await Webservices.RequestGetResourcesByReporterType(
                                              context,
                                              true,
                                              repoterTypeId,
                                              reporterSubTypesId,
                                              "0",
                                              projectId,
                                              widget.title == "Soft Services PM W/O" ? "schedule" : "",
                                              assignresourcelist,
                                            );
                                            setState(() {});
                                            print(
                                                "reporterSubTypesId>>${reporterSubTypesId}");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 10),
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                color: reporterSubTypesId ==
                                                    reporterSubTypeslist![index]
                                                        .id
                                                        .toString()
                                                    ? myColors.dark_grey_txt
                                                    : myColors.grey_two,
                                                borderRadius: BorderRadius.circular(30)),
                                            alignment: Alignment.topLeft,
                                            child: CustomText.CustomMediumText(
                                                "${reporterSubTypeslist![index].name.toString()}",
                                                reporterSubTypesId ==
                                                    reporterSubTypeslist![index]
                                                        .id
                                                        .toString()
                                                    ? myColors.white
                                                    : Colors.black,
                                                FontWeight.w500,
                                                13,
                                                1,
                                                TextAlign.center),
                                          ),
                                        );
                                      })),
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),

                              /// ....
                              reporterSubTypesId == "4" ?
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Reporter Name ...........................................
                                    Container(
                                      padding:
                                      EdgeInsets.fromLTRB(12, 6, 12, 0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            alignment: Alignment.topLeft,
                                            child: CustomText.CustomMediumText(
                                                MyString.Name,
                                                myColors.black,
                                                FontWeight.w500,
                                                12,
                                                1,
                                                TextAlign.center),
                                          ),
                                          Container(
                                            width: 5,
                                            alignment: Alignment.topLeft,
                                            child: CustomText.CustomMediumText(
                                                ":",
                                                myColors.black,
                                                FontWeight.w700,
                                                12,
                                                1,
                                                TextAlign.center),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10, bottom: 6),
                                                  padding:
                                                  EdgeInsets.only(left: 15),
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
                                                    controller:
                                                    ReporternameController,
                                                    keyboardType:
                                                    TextInputType.text,
                                                    focusNode:
                                                    reportednamefocus,
                                                    textInputAction:
                                                    TextInputAction.done,
                                                    onChanged:
                                                        (String value) {},
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      decoration:
                                                      TextDecoration.none,
                                                      fontFamily:
                                                      MyString.PlusJakartaSansregular,
                                                      color: myColors.grey_27,
                                                    ),
                                                    decoration: InputDecoration(
                                                        border:
                                                        InputBorder.none,
                                                        hintText: "",
                                                        hintStyle: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            color: myColors
                                                                .grey_27,
                                                            fontFamily:
                                                            MyString.PlusJakartaSansregular),
                                                        isDense: true,
                                                        // this will remove the default content padding
                                                        contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 1, 8, 6)),
                                                    cursorColor:
                                                    myColors.grey_26,
                                                  ),
                                                ),
                                                Container(
                                                  height: 1,
                                                  margin: EdgeInsets.fromLTRB(
                                                      12, 0, 6, 0),
                                                  color: myColors.grey_27,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///Reporter Email ...........................................
                                    Container(
                                      padding:
                                      EdgeInsets.fromLTRB(12, 6, 12, 0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            alignment: Alignment.topLeft,
                                            child: CustomText.CustomMediumText(
                                                MyString.Email,
                                                myColors.black,
                                                FontWeight.w500,
                                                12,
                                                1,
                                                TextAlign.center),
                                          ),
                                          Container(
                                            width: 5,
                                            alignment: Alignment.topLeft,
                                            child: CustomText.CustomMediumText(
                                                ":",
                                                myColors.black,
                                                FontWeight.w700,
                                                12,
                                                1,
                                                TextAlign.center),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10, bottom: 6),
                                                  padding:
                                                  EdgeInsets.only(left: 15),
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
                                                    controller:
                                                    reporter_emailController,
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    textInputAction:
                                                    TextInputAction.done,
                                                    focusNode:
                                                    reportedemailfocus,
                                                    onChanged:
                                                        (String value) {},
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      decoration:
                                                      TextDecoration.none,
                                                      fontFamily:
                                                      MyString.PlusJakartaSansregular,
                                                      color: myColors.grey_27,
                                                    ),
                                                    decoration: InputDecoration(
                                                        border:
                                                        InputBorder.none,
                                                        hintText: "",
                                                        hintStyle: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            color: myColors
                                                                .grey_27,
                                                            fontFamily:
                                                            MyString.PlusJakartaSansregular),
                                                        isDense: true,
                                                        // this will remove the default content padding
                                                        contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 1, 8, 6)),
                                                    cursorColor:
                                                    myColors.grey_26,
                                                  ),
                                                ),
                                                Container(
                                                  height: 1,
                                                  margin: EdgeInsets.fromLTRB(
                                                      12, 0, 6, 0),
                                                  color: myColors.grey_27,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///Reporter Mobile ...........................................
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                          EdgeInsets.fromLTRB(12, 6, 12, 0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 80,
                                                alignment: Alignment.topLeft,
                                                child:
                                                CustomText.CustomMediumText(
                                                    MyString.Mobile,
                                                    myColors.black,
                                                    FontWeight.w500,
                                                    12,
                                                    1,
                                                    TextAlign.center),
                                              ),
                                              Container(
                                                width: 5,
                                                alignment: Alignment.topLeft,
                                                child:
                                                CustomText.CustomMediumText(
                                                    ":",
                                                    myColors.black,
                                                    FontWeight.w700,
                                                    12,
                                                    1,
                                                    TextAlign.center),
                                              ),
                                              SizedBox(width: 10,),
                                              GestureDetector(
                                                onTap: (){
                                                  is_country = !is_country;
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: myColors.app_theme,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Text(
                                                    MobileCode,
                                                    style: TextStyle(
                                                        color: myColors.white),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10, bottom: 6),
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      alignment:
                                                      Alignment.topLeft,
                                                      child: TextField(
                                                        controller:
                                                        reporter_mobilenoController,
                                                        keyboardType:
                                                        TextInputType
                                                            .number,
                                                        textInputAction:
                                                        TextInputAction
                                                            .done,
                                                        focusNode:
                                                        reportedmobilefocus,
                                                        onChanged:
                                                            (String value) {},
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          decoration:
                                                          TextDecoration
                                                              .none,
                                                          fontFamily:
                                                          MyString.PlusJakartaSansregular,
                                                          color:
                                                          myColors.grey_27,
                                                        ),
                                                        decoration:
                                                        InputDecoration(
                                                            border:
                                                            InputBorder
                                                                .none,
                                                            hintText: "",
                                                            hintStyle: TextStyle(
                                                                fontSize:
                                                                12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: myColors
                                                                    .grey_27,
                                                                fontFamily:
                                                                MyString.PlusJakartaSansregular),
                                                            isDense: true,
                                                            // this will remove the default content padding
                                                            contentPadding:
                                                            EdgeInsets
                                                                .fromLTRB(
                                                                5,
                                                                1,
                                                                8,
                                                                6)),
                                                        cursorColor:
                                                        myColors.grey_26,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      margin:
                                                      EdgeInsets.fromLTRB(
                                                          12, 0, 6, 0),
                                                      color: myColors.grey_27,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),



                                        SizedBox(height: 10,),

                                        /// Country code listview................................
                                        Visibility(
                                          visible: is_country,
                                          child: Row(
                                            children: [

                                              SizedBox(width: 100,),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: myColors.white,
                                                      borderRadius: BorderRadius.circular(8)
                                                  ),
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.zero,
                                                      itemCount:
                                                      countryCodeslist!.length,
                                                      itemBuilder:
                                                          (context, int index) {
                                                        return GestureDetector(
                                                          onTap: (){
                                                            MobileCode = countryCodeslist![index].mobileCode.toString();
                                                            is_country = false;
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            width: double.infinity,
                                                            padding: EdgeInsets.only(top: 7,bottom: 7),
                                                            child: Text(
                                                              countryCodeslist![index]
                                                                  .name
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: myColors.view_color,
                                                                  fontFamily: MyString.PlusJakartaSansregular,
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                                  : Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Assign Resources ...........................................
                                    Container(
                                      padding:
                                      EdgeInsets.fromLTRB(12, 6, 12, 0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: CustomText
                                                        .CustomMediumText(
                                                        MyString.Resources,
                                                        myColors.black,
                                                        FontWeight.w500,
                                                        12,
                                                        1,
                                                        TextAlign.center),
                                                  ),
                                                  Container(
                                                    width: 5,
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: CustomText
                                                        .CustomMediumText(
                                                        ":",
                                                        myColors.black,
                                                        FontWeight.w700,
                                                        12,
                                                        1,
                                                        TextAlign.center),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap:assignresourcelist.isNotEmpty? (){}: (){
                                                    is_reporter_resource = !is_reporter_resource;
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    // height: 35,
                                                    margin:
                                                    EdgeInsets.only(top: 3),
                                                    alignment: Alignment.topLeft,
                                                    child: ReporterResourcesdropdown(),
                                                  ),
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
                                    Row(
                                      children: [
                                        SizedBox(width: 100,),
                                        Expanded(
                                          child: Visibility(
                                              visible: is_reporter_resource,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: myColors.white,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                alignment: Alignment.center,
                                                height: 50,
                                                child: Text("No data found",style: TextStyle(color: myColors.grey_two),),
                                              )),
                                        ),
                                      ],
                                    ),

                                    ///Reporter Email ...........................................
                                    Container(
                                      padding:
                                      EdgeInsets.fromLTRB(12, 6, 12, 0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            alignment: Alignment.topLeft,
                                            child: CustomText.CustomMediumText(
                                                MyString.Email,
                                                myColors.black,
                                                FontWeight.w500,
                                                12,
                                                1,
                                                TextAlign.center),
                                          ),
                                          Container(
                                            width: 5,
                                            alignment: Alignment.topLeft,
                                            child: CustomText.CustomMediumText(
                                                ":",
                                                myColors.black,
                                                FontWeight.w700,
                                                12,
                                                1,
                                                TextAlign.center),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10, bottom: 6),
                                                  padding:
                                                  EdgeInsets.only(left: 15),
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
                                                    enabled: false,
                                                    controller:
                                                    reporter_emailController,
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    textInputAction:
                                                    TextInputAction.done,
                                                    focusNode:
                                                    reportedemailfocus,
                                                    onChanged:
                                                        (String value) {},
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      decoration:
                                                      TextDecoration.none,
                                                      fontFamily:
                                                      MyString.PlusJakartaSansregular,
                                                      color: myColors.grey_27,
                                                    ),
                                                    decoration: InputDecoration(
                                                        border:
                                                        InputBorder.none,
                                                        hintText: "",
                                                        hintStyle: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            color: myColors
                                                                .grey_27,
                                                            fontFamily:
                                                            MyString.PlusJakartaSansregular),
                                                        isDense: true,
                                                        // this will remove the default content padding
                                                        contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 1, 8, 6)),
                                                    cursorColor:
                                                    myColors.grey_26,
                                                  ),
                                                ),
                                                Container(
                                                  height: 1,
                                                  margin: EdgeInsets.fromLTRB(
                                                      12, 0, 6, 0),
                                                  color: myColors.grey_27,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///Reporter Mobile ...........................................
                                    Container(
                                      padding:
                                      EdgeInsets.fromLTRB(12, 6, 12, 0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            alignment: Alignment.topLeft,
                                            child:
                                            CustomText.CustomMediumText(
                                                MyString.Mobile,
                                                myColors.black,
                                                FontWeight.w500,
                                                12,
                                                1,
                                                TextAlign.center),
                                          ),
                                          Container(
                                            width: 5,
                                            alignment: Alignment.topLeft,
                                            child:
                                            CustomText.CustomMediumText(
                                                ":",
                                                myColors.black,
                                                FontWeight.w700,
                                                12,
                                                1,
                                                TextAlign.center),
                                          ),

                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10, bottom: 6),
                                                  padding: EdgeInsets.only(
                                                      left: 15),
                                                  alignment:
                                                  Alignment.topLeft,
                                                  child: TextField(
                                                    enabled: false,
                                                    controller:
                                                    reporter_mobilenoController,
                                                    keyboardType:
                                                    TextInputType
                                                        .number,
                                                    textInputAction:
                                                    TextInputAction
                                                        .done,
                                                    focusNode:
                                                    reportedmobilefocus,
                                                    onChanged:
                                                        (String value) {},
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      decoration:
                                                      TextDecoration
                                                          .none,
                                                      fontFamily:
                                                      MyString.PlusJakartaSansregular,
                                                      color:
                                                      myColors.grey_27,
                                                    ),
                                                    decoration:
                                                    InputDecoration(
                                                        border:
                                                        InputBorder
                                                            .none,
                                                        hintText: "",
                                                        hintStyle: TextStyle(
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            color: myColors
                                                                .grey_27,
                                                            fontFamily:
                                                            MyString.PlusJakartaSansregular),
                                                        isDense: true,
                                                        // this will remove the default content padding
                                                        contentPadding:
                                                        EdgeInsets
                                                            .fromLTRB(
                                                            5,
                                                            1,
                                                            8,
                                                            6)),
                                                    cursorColor:
                                                    myColors.grey_26,
                                                  ),
                                                ),
                                                Container(
                                                  height: 1,
                                                  margin:
                                                  EdgeInsets.fromLTRB(
                                                      12, 0, 6, 0),
                                                  color: myColors.grey_27,
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
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),


                SizedBox(
                  height: 50,
                ),





                ///.......................... OLD DESIGN..............................





                // Container(
                //   //  height: 145,
                //   margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                //   alignment: Alignment.centerLeft,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(5)),
                //     border: Border.all(color: myColors.app_theme),
                //     color: myColors.bg,
                //   ),
                //   child: Column(
                //     children: [
                //       ///Project...........................................
                //
                //
                //       ///Building...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                //         child: Row(
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           MyString.Building,
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                     Container(
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     height: 35,
                //                     margin: EdgeInsets.only(top: 3),
                //                     alignment: Alignment.topLeft,
                //                     child: assetscanlist.isEmpty
                //                         ? buildingdropdown()
                //                         : Container(
                //                       // padding: EdgeInsets.only(left: 5),
                //                       alignment: Alignment.centerLeft,
                //                       child: Text(buildingController.text,style: TextStyle(
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w500,
                //                         decoration: TextDecoration.none,
                //                         fontFamily:
                //                         'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                         color: myColors.grey_27,
                //                       ),),
                //                     )
                //
                //                    /* TextField(
                //                             enabled: false,
                //                             controller: buildingController,
                //                             keyboardType: TextInputType.text,
                //                             onChanged: (String value) {
                //                               print("TAG" + value);
                //                               setState(() {});
                //                             },
                //                             style: TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.w500,
                //                               decoration: TextDecoration.none,
                //                               fontFamily:
                //                                   'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                               color: myColors.grey_27,
                //                             ),
                //                             decoration: InputDecoration(
                //                                 border: InputBorder.none,
                //                                 hintText: "Building",
                //                                 hintStyle: TextStyle(
                //                                     fontSize: 12,
                //                                     fontWeight: FontWeight.w500,
                //                                     color: myColors.grey_27,
                //                                     fontFamily:
                //                                         "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                //                                 isDense: true,
                //                                 // this will remove the default content padding
                //                                 contentPadding:
                //                                 EdgeInsets.fromLTRB(
                //                                     17, 1, 0, 6)),
                //                             maxLines: 1,
                //                             cursorColor: myColors.grey_26,
                //                           ),*/
                //                   ),
                //                   // Container(
                //                   //   height: 1,
                //                   //   margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //                   //   color: myColors.grey_27,
                //                   // ),
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       ///Floore...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                //         child: Row(
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           "Floor",
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                     Container(
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     height: 35,
                //                     margin: EdgeInsets.only(top: 3),
                //                     alignment: Alignment.topLeft,
                //                     child: assetscanlist.isEmpty
                //                         ? floordropdown()
                //                         : Container(
                //                       // padding: EdgeInsets.only(left: 5),
                //                       alignment: Alignment.centerLeft,
                //                       child: Text(floreController.text,style: TextStyle(
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w500,
                //                         decoration: TextDecoration.none,
                //                         fontFamily:
                //                         'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                         color: myColors.grey_27,
                //                       ),),
                //                     )
                //                   )
                //                   //   TextField(
                //                   //           enabled: false,
                //                   //           controller: floreController,
                //                   //           keyboardType: TextInputType.text,
                //                   //           onChanged: (String value) {
                //                   //             print("TAG" + value);
                //                   //             setState(() {});
                //                   //           },
                //                   //           style: TextStyle(
                //                   //             fontSize: 12,
                //                   //             fontWeight: FontWeight.w500,
                //                   //             decoration: TextDecoration.none,
                //                   //             fontFamily:
                //                   //                 'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                   //             color: myColors.grey_27,
                //                   //           ),
                //                   //           decoration: InputDecoration(
                //                   //               border: InputBorder.none,
                //                   //               hintText: "Floor",
                //                   //               hintStyle: TextStyle(
                //                   //                   fontSize: 12,
                //                   //                   fontWeight: FontWeight.w500,
                //                   //                   color: myColors.grey_27,
                //                   //                   fontFamily:
                //                   //                       "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                //                   //               isDense: true,
                //                   //               // this will remove the default content padding
                //                   //               contentPadding:
                //                   //               EdgeInsets.fromLTRB(
                //                   //                   15, 1, 0, 6)),
                //                   //           maxLines: 1,
                //                   //           cursorColor: myColors.grey_26,
                //                   //         ),
                //                   // ),
                //                   // Container(
                //                   //   height: 1,
                //                   //   margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //                   //   color: myColors.grey_27,
                //                   // ),
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       ///Unit...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           "Unit",
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //
                //                     Container(
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Column(
                //                 children: [
                //                   Container(
                //
                //                     height: 35,
                //                     margin: EdgeInsets.only(top: 3),
                //                     alignment: Alignment.topLeft,
                //                     child: assetscanlist.isEmpty
                //                         ? unitdropdown()
                //                         : Container(
                //                       // padding: EdgeInsets.only(left: 5),
                //                       alignment: Alignment.centerLeft,
                //                       child: Text(unitController.text,style: TextStyle(
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w500,
                //                         decoration: TextDecoration.none,
                //                         fontFamily:
                //                         'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                         color: myColors.grey_27,
                //                       ),),
                //                     )
                //                     // TextField(
                //                     //         enabled: false,
                //                     //         controller: unitController,
                //                     //         keyboardType: TextInputType.text,
                //                     //         onChanged: (String value) {
                //                     //           print("TAG" + value);
                //                     //           setState(() {});
                //                     //         },
                //                     //         style: TextStyle(
                //                     //           fontSize: 12,
                //                     //           fontWeight: FontWeight.w500,
                //                     //           decoration: TextDecoration.none,
                //                     //           fontFamily:
                //                     //               'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                     //           color: myColors.grey_27,
                //                     //         ),
                //                     //         decoration: InputDecoration(
                //                     //             border: InputBorder.none,
                //                     //             hintText: "",
                //                     //             hintStyle: TextStyle(
                //                     //                 fontSize: 12,
                //                     //                 fontWeight: FontWeight.w500,
                //                     //                 color: myColors.grey_27,
                //                     //                 fontFamily:
                //                     //                     "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                //                     //             isDense: true,
                //                     //             // this will remove the default content padding
                //                     //             contentPadding:
                //                     //             EdgeInsets.fromLTRB(
                //                     //                 15, 1, 0, 6)),
                //                     //         maxLines: 1,
                //                     //         cursorColor: myColors.grey_26,
                //                     //       ),
                //                   ),
                //
                //                   // floorId.toString() == "null" || floorId == "" || floorId.isEmpty ?
                //                   //     Text("Enter valid floor",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 10),)
                //                   // :Container(),
                //                   // Container(
                //                   //   height: 1,
                //                   //   margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //                   //   color: myColors.grey_27,
                //                   // ),
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       ///Room...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                //         child: Row(
                //     //      crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           "Room",
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //
                //                     Container(
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     height: 35,
                //                     margin: EdgeInsets.only(top: 3),
                //                     alignment: Alignment.topLeft,
                //                     child: assetscanlist.isEmpty
                //                         ? roomdropdown()
                //                         :  Container(
                //                       // padding: EdgeInsets.only(left: 5),
                //                       alignment: Alignment.centerLeft,
                //                       child: Text(roomController.text,style: TextStyle(
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w500,
                //                         decoration: TextDecoration.none,
                //                         fontFamily:
                //                         'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                         color: myColors.grey_27,
                //                       ),),
                //                     )
                //
                //                     // TextField(
                //                     //         enabled: false,
                //                     //         controller: roomController,
                //                     //         keyboardType: TextInputType.text,
                //                     //         onChanged: (String value) {
                //                     //           print("TAG" + value);
                //                     //           setState(() {});
                //                     //         },
                //                     //         style: TextStyle(
                //                     //           fontSize: 12,
                //                     //           fontWeight: FontWeight.w500,
                //                     //           decoration: TextDecoration.none,
                //                     //           fontFamily:
                //                     //               'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                     //           color: myColors.grey_27,
                //                     //         ),
                //                     //         decoration: InputDecoration(
                //                     //             border: InputBorder.none,
                //                     //             hintText: "",
                //                     //             hintStyle: TextStyle(
                //                     //                 fontSize: 12,
                //                     //                 fontWeight: FontWeight.w500,
                //                     //                 color: myColors.grey_27,
                //                     //                 fontFamily:
                //                     //                     "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                //                     //             isDense: true,
                //                     //             // this will remove the default content padding
                //                     //             contentPadding:
                //                     //             EdgeInsets.fromLTRB(
                //                     //                 15, 1, 0, 6)),
                //                     //         maxLines: 1,
                //                     //         cursorColor: myColors.grey_26,
                //                     //       ),
                //                   ),
                //                   // Container(
                //                   //   height: 1,
                //                   //   margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //                   //   color: myColors.grey_27,
                //                   // ),
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       SizedBox(
                //         height: 10,
                //       )
                //     ],
                //   ),
                // ),
                //
                // ///Form 4.............................................
                // Container(
                //   // height: 145,
                //   margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                //   alignment: Alignment.centerLeft,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(5)),
                //     border: Border.all(color: myColors.app_theme),
                //     color: myColors.bg,
                //   ),
                //   child: Column(
                //     children: [
                //       ///Type...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                //         child: Row(
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           "Type",
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //
                //                     Container(
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Column(
                //                 children: [
                //                   Container(
                //
                //                     height: 40,child:  typedropdown(),),
                //
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       ///Sub Type...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                //         child: Row(
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           "Sub Type",
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //
                //                     Container(
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Column(
                //                 children: [
                //        Container(height: 40,child:  subtypedropdown(),),
                //
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       ///Category ...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(12, 6, 12, 0),
                //         child: Row(
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           MyString.Category,
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                     Container(
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Container(
                //                // / width: 150,
                //                 alignment: Alignment.centerLeft,
                //                 child: Column(
                //                   children: [
                //                     /* Container(
                //                       height:25,
                //                       margin: EdgeInsets.only(top: 10),
                //                       alignment: Alignment.topLeft,
                //                       child: TextField(
                //                         keyboardType: TextInputType.text,
                //                         onChanged: (String value) {
                //                           print("TAG" + value);
                //                           setState(() {});
                //                         },
                //                         style: TextStyle(
                //                           fontSize: 12,
                //                           fontWeight: FontWeight.w500,
                //                           decoration: TextDecoration.none,
                //                           fontFamily:
                //                           'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                           color: myColors.grey_27,
                //                         ),
                //
                //                         decoration: InputDecoration(
                //                             border: InputBorder.none,
                //                             hintText: "Category",
                //                             hintStyle: TextStyle(
                //                                 fontSize: 12,
                //                                 fontWeight: FontWeight.w500,
                //                                 color: myColors.grey_27,
                //                                 fontFamily:
                //                                 "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                //                             isDense: true,
                //                             // this will remove the default content padding
                //                             contentPadding:
                //                             EdgeInsets.fromLTRB(12, 1, 0, 0)),
                //                         maxLines: 1,
                //                         cursorColor: myColors.grey_26,
                //                       ),
                //                     ),*/
                //
                //                     Container(
                //                       alignment: Alignment.centerLeft,
                //                       height: 40,child:  categorydropdown(),),
                //
                //                    // categorydropdown(),
                //                    //  Container(
                //                    //    height: 1,
                //                    //    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //                    //    color: myColors.grey_27,
                //                    //  ),
                //
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       ///Problem...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(12, 15, 12, 0),
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           MyString.Title,
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //
                //                     Container(
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Column(
                //                 children: [
                //                   Container(
                //                    // width: 180,
                //                   //  height: 18,
                //                    // margin: EdgeInsets.only(top: 14),
                //                     alignment: Alignment.topLeft,
                //                     child: TextField(
                //                       controller: problemController,
                //                       focusNode: titlefocus,
                //                       keyboardType: TextInputType.text,
                //                       //maxLength: 50,
                //                       onChanged: (String value) {
                //                         print("TAG" + value);
                //                         setState(() {});
                //                       },
                //                       style: TextStyle(
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w500,
                //                         decoration: TextDecoration.none,
                //                         fontFamily:
                //                             'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                         color: myColors.grey_27,
                //                       ),
                //                       decoration: InputDecoration(
                //                           border: InputBorder.none,
                //                           hintText: "Enter problem",
                //                           hintStyle: TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.w500,
                //                               color: myColors.grey_27,
                //                               fontFamily:
                //                                   "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                //                           isDense: true,
                //                           // this will remove the default content padding
                //                           contentPadding:
                //                               EdgeInsets.fromLTRB(1, 1, 0, 0)
                //                       ),
                //                       maxLines: 1,
                //                       cursorColor: myColors.grey_26,
                //                     ),
                //                   ),
                //                   Container(
                //                     height: 1,
                //                     margin: EdgeInsets.fromLTRB(1, 10, 0, 0),
                //                     color: myColors.grey_27,
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       ///Summary...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(16, 15, 16, 0),
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       padding: EdgeInsets.only(top: 10),
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           MyString.Summary,
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //
                //                     Container(
                //                       padding: EdgeInsets.only(top: 10),
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     // height: 25,
                //                     margin: EdgeInsets.only(top: 10),
                //                     alignment: Alignment.topLeft,
                //                     child: TextField(
                //                       controller: summaryController,
                //                       focusNode: summaryfocus,
                //                       keyboardType: TextInputType.multiline,
                //                       textInputAction: TextInputAction.newline,
                //                       maxLength: 400,
                //                       onChanged: (String value) {
                //                         print("TAG" + value);
                //                         setState(() {});
                //                       },
                //                       style: TextStyle(
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w500,
                //                         decoration: TextDecoration.none,
                //                         fontFamily:
                //                             'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //                         color: myColors.grey_27,
                //                       ),
                //                       decoration: InputDecoration(
                //                           border: InputBorder.none,
                //                           hintText: "Enter summary",
                //                           hintStyle: TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.w500,
                //                               color: myColors.grey_27,
                //                               fontFamily:
                //                                   "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf"),
                //                           isDense: true,
                //                           // this will remove the default content padding
                //                           contentPadding:
                //                               EdgeInsets.fromLTRB(1, 1, 0, 0)),
                //                       maxLines: 10,
                //                       cursorColor: myColors.grey_26,
                //                     ),
                //                   ),
                //                   Container(
                //                     height: 1,
                //                     margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //                     color: myColors.grey_27,
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       SizedBox(
                //         height: 10,
                //       )
                //     ],
                //   ),
                // ),
                //
                // ///Form 5.............................................
                // Container(
                //   //height: 107,
                //   margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                //   alignment: Alignment.centerLeft,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(5)),
                //     border: Border.all(color: myColors.app_theme),
                //     color: myColors.bg,
                //   ),
                //   child: Column(
                //     children: [
                //       ///Priority ...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(12, 6, 12, 0),
                //         child: Row(
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           MyString.Priority,
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //
                //                     Container(
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     height: 35,
                //                     margin: EdgeInsets.only(top: 3),
                //                     alignment: Alignment.topLeft,
                //                     child: prioritydropdown(),
                //                   ),
                //                   // Container(
                //                   //   height: 1,
                //                   //   margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //                   //   color: myColors.grey_27,
                //                   // ),
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       ///Loc...........................................
                //       // Container(
                //       //   padding: EdgeInsets.fromLTRB(12, 8, 12, 0),
                //       //   child: Row(
                //       //     children: [
                //       //       Container(
                //       //         width: 95,
                //       //         alignment: Alignment.topLeft,
                //       //         child: CustomText.CustomMediumText(
                //       //             MyString.Call_Source,
                //       //             myColors.black,
                //       //             FontWeight.w500,
                //       //             12,
                //       //             1,
                //       //             TextAlign.center),
                //       //       ),
                //       //       Container(
                //       //         width: 5,
                //       //         alignment: Alignment.topLeft,
                //       //         child: CustomText.CustomMediumText(
                //       //             ":",
                //       //             myColors.black,
                //       //             FontWeight.w700,
                //       //             12,
                //       //             1,
                //       //             TextAlign.center),
                //       //       ),
                //       //       Expanded(
                //       //         child: Column(
                //       //           children: [
                //       //             Container(
                //       //                 height: 25,
                //       //                 margin: EdgeInsets.only(top: 10),
                //       //                 padding: EdgeInsets.only(left: 10),
                //       //                 alignment: Alignment.topLeft,
                //       //                 child: Text(
                //       //                   "Mobile APP",
                //       //                   style: TextStyle(
                //       //                     fontSize: 12,
                //       //                     fontWeight: FontWeight.w500,
                //       //                     decoration: TextDecoration.none,
                //       //                     fontFamily:
                //       //                         'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //       //                     color: myColors.grey_27,
                //       //                   ),
                //       //                 )
                //       //
                //       //                 // TextField(
                //       //                 //   keyboardType: TextInputType.text,
                //       //                 //   onChanged: (String value) {
                //       //                 //     print("TAG" + value);
                //       //                 //     setState(() {});
                //       //                 //   },
                //       //                 //   style: TextStyle(
                //       //                 //     fontSize: 12,
                //       //                 //     fontWeight: FontWeight.w500,
                //       //                 //     decoration: TextDecoration.none,
                //       //                 //     fontFamily:
                //       //                 //         'assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf',
                //       //                 //     color: myColors.grey_27,
                //       //                 //   ),
                //       //                 ),
                //       //             Container(
                //       //               height: 1,
                //       //               margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //       //               color: myColors.grey_27,
                //       //             ),
                //       //           ],
                //       //         ),
                //       //       ),
                //       //       Container(
                //       //         width: 27,
                //       //       ),
                //       //     ],
                //       //   ),
                //       // ),
                //
                //       SizedBox(
                //         height: 10,
                //       )
                //     ],
                //   ),
                // ),
                //
                //
                //
                // /// Form 6......
                // Container(
                //   //height: 107,
                //   margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                //   alignment: Alignment.centerLeft,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(5)),
                //     border: Border.all(color: myColors.app_theme),
                //     color: myColors.bg,
                //   ),
                //   child: Column(
                //     children: [
                //       ///Assign Resources ...........................................
                //       Container(
                //         padding: EdgeInsets.fromLTRB(12, 6, 12, 0),
                //         child: Row(
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: Container(
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       width: 80,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           MyString.Resources,
                //                           myColors.black,
                //                           FontWeight.w500,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //                     Container(
                //                       width: 5,
                //                       alignment: Alignment.topLeft,
                //                       child: CustomText.CustomMediumText(
                //                           ":",
                //                           myColors.black,
                //                           FontWeight.w700,
                //                           12,
                //                           1,
                //                           TextAlign.center),
                //                     ),
                //
                //                   ],
                //                 ),
                //               ),
                //             ),
                //
                //             Expanded(
                //               flex: 2,
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     height: 35,
                //                     margin: EdgeInsets.only(top: 3),
                //                     alignment: Alignment.topLeft,
                //                     child: Resourcesdropdown(),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               width: 27,
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       SizedBox(
                //         height: 10,
                //       )
                //     ],
                //   ),
                // ),
                //
                // Row(
                //   children: [
                //     /// Clear All Button.....
                //     Expanded(
                //       flex: 1,
                //       child: InkWell(
                //         onTap: () {
                //           unfocustextfild();
                //           if (widget.title == "PPM W/O") {
                //             print("nfkgf");
                //             catemodel = categorylist.isNotEmpty
                //                 ? categorylist.first
                //                 : null;
                //             prioritiesModel = prioritieslist.isNotEmpty
                //                 ? prioritieslist.first
                //                 : null;
                //             assignresourceModel = assignresourcelist.isNotEmpty
                //                 ? assignresourcelist.first
                //                 : null;
                //             problemController.text = "";
                //             summaryController.clear();
                //             setState(() {});
                //           } else {
                //             if (assetscanlist.isNotEmpty) {
                //               assetscanlist.clear();
                //               asset_codeController.clear();
                //               asset_IdController.clear();
                //               desController.clear();
                //               scanlist.clear();
                //               problemController.clear();
                //               summaryController.clear();
                //               setState(() {});
                //             } else {
                //               asset_codeController.clear();
                //               asset_IdController.clear();
                //               desController.clear();
                //               print("else nfkgf");
                //               projectmodel = projectlist.isNotEmpty
                //                   ? projectlist.first
                //                   : null;
                //               buildingModel = buildingslist!.isNotEmpty
                //                   ? buildingslist!.first
                //                   : null;
                //               floorModel =
                //                   floorlist.isNotEmpty ? floorlist.first : null;
                //               unitsModel = unitslist!.isNotEmpty
                //                   ? unitslist!.first
                //                   : null;
                //               roomModel = roomslist!.isNotEmpty
                //                   ? roomslist!.first
                //                   : null;
                //               typeModel =
                //                   typeslist.isNotEmpty ? typeslist.first : null;
                //               subtypeModel = subTypeslist.isNotEmpty
                //                   ? subTypeslist.first
                //                   : null;
                //               catemodel = categorylist.isNotEmpty
                //                   ? categorylist.first
                //                   : null;
                //               prioritiesModel = prioritieslist.isNotEmpty
                //                   ? prioritieslist.first
                //                   : null;
                //               ResourcesmainModel =
                //               Resourceslist!.isNotEmpty
                //                       ? Resourceslist!.first
                //                       : null;
                //               problemController.text = "";
                //               summaryController.clear();
                //               setState(() {});
                //             }
                //           }
                //         },
                //         child: Container(
                //           alignment: Alignment.center,
                //           height: 50,
                //           margin: EdgeInsets.fromLTRB(16, 20, 16, 8),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(10)),
                //             color: myColors.app_theme,
                //           ),
                //           child: CustomText.CustomBoldText(
                //               MyString.Clear_All,
                //               myColors.white,
                //               FontWeight.w700,
                //               14,
                //               1,
                //               TextAlign.center),
                //         ),
                //       ),
                //     ),
                //
                //     /// Save Button.....
                //     Expanded(
                //       flex: 1,
                //       child: InkWell(
                //         onTap: () {
                //           if (projectId.trim().isEmpty ||
                //               projectId == "" ||
                //               projectId == "null") {
                //             CustomToast.showToast(
                //                 msg: "Please select Project name");
                //           } else if (buildingId.trim().isEmpty ||
                //               buildingId == "" ||
                //               buildingId == "null") {
                //             CustomToast.showToast(
                //                 msg: "Please select Building name");
                //           } else if (priorityId.trim().isEmpty ||
                //               priorityId == "" ||
                //               priorityId == "null") {
                //             CustomToast.showToast(
                //                 msg: "Please select Priority name");
                //           } else if (problemController.text.trim().isEmpty ||
                //               problemController.text == "" ||
                //               problemController.text == "null") {
                //             CustomToast.showToast(msg: "Please enter Title");
                //           }
                //           else if (RecorcesId.trim().isEmpty ||
                //               RecorcesId == "" ||
                //               RecorcesId == "null") {
                //             CustomToast.showToast(
                //                 msg: "Please select Resorce name");
                //           }
                //           else {
                //             getallResources("0", "2", "1", projectId);
                //
                //
                //            }
                //         },
                //         child: Container(
                //           alignment: Alignment.center,
                //           height: 50,
                //           margin: EdgeInsets.fromLTRB(16, 20, 16, 8),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(10)),
                //             color: myColors.app_theme,
                //           ),
                //           child: CustomText.CustomBoldText(
                //               MyString.Save,
                //               myColors.white,
                //               FontWeight.w700,
                //               14,
                //               1,
                //               TextAlign.center),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //
                // SizedBox(
                //   height: 40,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void swapitems(int index) {
    Categories? temp;
    temp = categorylist[index];
    categorylist[index] = categorylist[0];
    categorylist[0] = temp;
  }

  RequestAssignToApi() async{
    assigntolist.clear();
    setState(() {});
    ResourcesmainModel =
        AssignToModel(id: 0, name: "Select Resources", code: "");
    assigntolist.add(ResourcesmainModel!);
    await Webservices.RequestAssignTo(context, assigntolist,projectId,"0",widget.ServiceId);
    setState(() {});

  }

  /// Pick image mathod......
  Future pickImage(BuildContext context, imageSource) async {
    if (!kIsWeb) {
      var image = await imagePicker.pickImage(
        source: imageSource,
        imageQuality: 10,
      );

      if (image == null) {
        Navigator.pop(context);
      } else {
        setState(() {
          _image = File(image!.path);
          img = _image!.path.toString();
          imagefilelist.add(File(image!.path));
          image = null;
        });
        setState(() {});
      }
    } else if (kIsWeb) {
      var image =
      await imagePicker.pickImage(source: imageSource, imageQuality: 10);
      if (image == null) {
        Navigator.pop(context);
      } else {
        setState(() {
          _image = File(image!.path);
          imagefilelist.add(File(image!.path));
          img = _image!.path.toString();
          image = null;
        });
        Navigator.pop(context);
      }
      setState(() {});
    }

    // print("lemmnhfhg>${checkListadd.length}");
  }

  Future<void> showImagePickerOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () async{
                      pickImage(context, ImageSource.camera);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(context, ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future pickImage2(BuildContext context, imageSource) async {
    if (!kIsWeb) {
      var image = await imagePicker.pickImage(
        source: imageSource,
        imageQuality: 10,
      );

      if (image == null) {
        Navigator.pop(context);
      } else {
        setState(() {
          _image = File(image!.path);
          img = _image!.path.toString();
          imagefilelist.add(File(image!.path));
          image = null;
        });
        setState(() {});
      }


    } else if (kIsWeb) {
      var image =
      await imagePicker.pickImage(source: imageSource, imageQuality: 10);
      if (image == null) {
        Navigator.pop(context);
      } else {
        setState(() {
          _image = File(image!.path);
          imagefilelist.add(File(image!.path));
          img = _image!.path.toString();
          image = null;
        });
        Navigator.pop(context);
      }
      setState(() {});
    }

    // print("lemmnhfhg>${checkListadd.length}");
  }

  /// GetProjectsMasterData Api call....
  getprojectmasterdataapi(bool load) async {
    projectlist.clear();
    setState(() {});
    projectmodel = ProjectsModel(id: 0, name: "Select Project", code: "");
    projectlist.add(projectmodel!);

    await Webservices.RequestGetProjectsMasterData(
        context, "0", projectlist, load);
  }

  /// /// GetLocationDetailsByAssetCode  Api call....
  GetLocationDetailsByAssetCodeapi() async {
    projectlist.clear();
    setState(() {});
    await Webservices.RequestGetLocationDetailsByAssetCode(
        context, false, asset_code, assetscanlist);
    setassetscandata();
    gettaskgenralinfo(false, widget.ServiceId);
    // setassetdata();
  }


  /// /// scan  Api call....
  Requestscan(bool load) async {
    projectlist.clear();
    setState(() {});
    await Webservices.Requestscan(context, load, asset_code, scanlist);
    setState(() {});
    setassetdata();
  }

  /// Project Dropdown.....
  projectdropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<ProjectsModel>(
        isExpanded: true,
        hint: Text(
          'Select project',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            fontFamily: 'PlusJakartaSansSemibold',
            color: myColors.grey_27,
          ),
        ),
        onChanged: (value) async {
          roomslist!.clear();
          floorlist.clear();
          buildingslist!.clear();
          unitslist!.clear();
          Resourceslist!.clear();
          reporterTypeslist!.clear();
          reporterSubTypeslist!.clear();
          buildingId = "";
          floorId = "";
          unitId = "";
          roomId = "";
          repoterTypeId = "";
          reporterSubTypesId = "";
          RecorcesId = "";
          setState(() {});

          // This is called when the user selects an item.
          if (value!.name.toString() == "Select Project") {
            projectmodel = value;
            projectId = "";
            projectController.text = "";
          } else {
            projectId = value.id.toString();
            projectController.text = value.name.toString();
            projectmodel = value;
            gettaskgenralinfo(true, widget.ServiceId);

            /// ttt
            await RequestGetLocationAndResourceMasterData(
                context, "0", projectId);
            RequestAssignToApi();
            setState(() {});
          }
        },
        selectedItemBuilder: (BuildContext context) {
          return projectlist.map((e) {
            return Container(
              //  padding: EdgeInsets.only(left: 6.0),
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(minWidth: 100),
              child: Text(
                e.code.toString() == "null" || e.code.toString() == ""
                    ? e.name.toString()
                    : e.code.toString() + " - " + e.name.toString(),
                style: const TextStyle(
                    color: myColors.grey_27,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            );
          }).toList();
        },
        items: projectlist
            .map((value) => DropdownMenuItem(
          value: value,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                projectId == value.id.toString()
                    ? Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.check,
                    size: 15,
                  ),
                )
                    : Container(),
                Expanded(
                  child: Text(
                    value.name.toString() == "Select Units"
                        ? value.name.toString()
                        : value.code.toString() +
                        " - " +
                        value.name.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      fontFamily:
                      'PlusJakartaSansSemibold',
                      color: value.name.toString() == "Select Units"
                          ? myColors.grey_27
                          : myColors.grey_one.withOpacity(0.90),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ))
            .toList(),
        value: projectmodel,

        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 1),
          height: 40,
          width: 400,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          maxHeight: 400,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: categoryController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: categoryController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontFamily: 'PlusJakartaSansSemibold',
                  color: myColors.grey_27,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value!.name
                .toString()
                .toLowerCase()
                .contains(searchValue) ||
                item.value!.name.toString().toUpperCase().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            categoryController.clear();
          }
        },
      ),
    );

  }

  ///Repoter  Resources Dropdown..............
  ReporterResourcesdropdown() {
    return
      DropdownButtonHideUnderline(
        child: DropdownButton<AssignedResourcesModel>(
          isExpanded: true,
          value: assignresourceModel,
          hint: Padding(
            padding: EdgeInsets.only(left: 1.0),
            child: Text(
              "Select ${MyString.Resources}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
                fontFamily: MyString.PlusJakartaSansregular,
                color: myColors.grey_27,
              ),
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down_sharp),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (AssignedResourcesModel? value) {
            if (value!.name.toString() != "Select ${MyString.Resources}") {
              setState(() {
                reporterRecorcesId = value.id.toString();
                ReporternameController.text = value.name.toString();
                MobileCode = value.mobileCode.toString();
                reporter_mobilenoController.text = value.mobileNo.toString();
                reporter_emailController.text = value.email.toString();
                assignresourceModel = value;
              });
            } else {
              setState(() {
                reporterRecorcesId = "";
                assignresourceModel = value;
              });
            }
          },
          selectedItemBuilder: (BuildContext context) {
            return assignresourcelist.map((e) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  e.name.toString(),
                  style: const TextStyle(
                      color: myColors.grey_27,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              );
            }).toList();
          },
          items:
          assignresourcelist.map<DropdownMenuItem<AssignedResourcesModel>>((AssignedResourcesModel value) {
            return DropdownMenuItem<AssignedResourcesModel>(
              value: value,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    RecorcesId == value.id.toString()
                        ? Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.check,
                        size: 15,
                      ),
                    )
                        : Container(),
                    Expanded(
                      child: Text(
                        value.name.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                          fontFamily: MyString.PlusJakartaSansregular,
                          color: value.name.toString() !=
                              "Select ${MyString.Resources}"
                              ? myColors.black.withOpacity(0.90)
                              : myColors.grey_27,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
  }

  /// Building Dropdown.....
  buildingdropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Buildings>(
        isExpanded: true,
        hint: Text(
          'Select buildings',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            fontFamily: 'PlusJakartaSansSemibold',
            color: myColors.grey_27,
          ),
        ),
        onChanged: (value) {
          // This is called when the user selects an item.
          if (value!.name.toString() != "Select Building") {
            setState(() {
              buildingId = value.id.toString();
              buildingController.text = value.name.toString();
              buildingModel = value;

              floorlist.clear();
              unitslist!.clear();
              roomslist!.clear();
              // Resourceslist!.clear();
              floorId = "";
              unitId = "";
              roomId = "";
              //RecorcesId = "";
              setState(() {});
              unitsModel = Units(id: 0, name: "Select Units", code: "");
              unitslist!.add(unitsModel!);

              roomModel = Rooms(id: 0, name: "Select Rooms", code: "");
              roomslist!.add(roomModel!);

              floorModel = FloorsModel(id: 0, name: "Select Floor", code: "");
              floorlist.add(floorModel!);

              // ResourcesmainModel = Resources(id: 0, name: "Select Resources", code: "");
              // Resourceslist!.add(ResourcesmainModel!);
              setState(() {});
            });
            Requestfloor(context, "0", projectId, "building");
          } else {
            buildingId = "";
            buildingModel = value;
            setState(() {});
          }
        },
        selectedItemBuilder: (BuildContext context) {
          return buildingslist!.map((e) {
            return Container(
              //    padding: EdgeInsets.only(left: 8.0),
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(minWidth: 100),
              child: Text(
                e.code.toString() == "null" || e.code.toString() == ""
                    ? e.name.toString()
                    : e.code.toString() + " - " + e.name.toString(),
                style: const TextStyle(
                    color: myColors.grey_27,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            );
          }).toList();
        },
        items: buildingslist!
            .map((value) => DropdownMenuItem(
          value: value,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                buildingId == value.id.toString()
                    ? Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.check,
                    size: 15,
                  ),
                )
                    : Container(),
                Expanded(
                  child: Text(
                    value.name.toString() == "Select Units"
                        ? value.name.toString()
                        : value.code.toString() +
                        " - " +
                        value.name.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      fontFamily:
                      'PlusJakartaSansSemibold',
                      color: value.name.toString() == "Select Units"
                          ? myColors.grey_27
                          : myColors.grey_one.withOpacity(0.90),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ))
            .toList(),
        value: buildingModel,

        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 1),
          height: 40,
          width: 400,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          maxHeight: 400,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: categoryController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: categoryController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontFamily: 'PlusJakartaSansSemibold',
                  color: myColors.grey_27,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value!.name
                .toString()
                .toLowerCase()
                .contains(searchValue) ||
                item.value!.name.toString().toUpperCase().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            categoryController.clear();
          }
        },
      ),
    );
  }

  /// Floor Dropdown.....
  floordropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.CustomMediumText(
            "Floor",
            myColors.black,
            FontWeight.w700,
            12,
            1,
            TextAlign.center),

        hsized13,
        assetscanlist.isEmpty ?
        Container(
          height: 50.0,
          // width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: myColors.grey_38),
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<FloorsModel>(
              isExpanded: true,
              hint: Text(
                'Select floor',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontFamily: MyString.PlusJakartaSansregular,
                  color: myColors.grey_27,
                ),
              ),
              onChanged: (value) {
                // This is called when the user selects an item.
                if (value!.name.toString() == "Select Floor") {
                  floorModel = value;
                  floorId = "";
                  setState(() {});
                }
                else {
                  setState(() {
                    floorId = value.id.toString();
                    floreController.text = value.name.toString();
                    floorModel = value;
                  });
                  unitslist!.clear();
                  roomslist!.clear();
                  unitId = "";
                  roomId = "";
                  setState(() {});
                  unitsModel = Units(id: 0, name: "Select Units", code: "");
                  unitslist!.add(unitsModel!);

                  roomModel = Rooms(id: 0, name: "Select Rooms", code: "");
                  roomslist!.add(roomModel!);
                  setState(() {});

                  Requestfloor(context, "0", projectId, "floor");
                }
              },
              selectedItemBuilder: (BuildContext context) {
                return floorlist.map((e) {
                  return Container(
                    //  padding: EdgeInsets.only(left: 8.0),
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(minWidth: 100),
                    child: Text(
                      e.code.toString() == "null" || e.code.toString() == ""?
                      e.name.toString():
                      e.code.toString() +" - "+ e.name.toString(),
                      style: const TextStyle(
                          color: myColors.grey_27, fontWeight: FontWeight.w500,fontSize: 12),
                    ),
                  );
                }).toList();
              },
              items: floorlist
                  .map((value) => DropdownMenuItem(
                value: value,
                child:Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      floorId == value.id.toString() ?
                      Padding(
                        padding:  EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.check,size: 15,),
                      ):
                      Container(),

                      Expanded(
                        child: Text(
                          value.name.toString() == "Select Units"?
                          value.name.toString():
                          value.code.toString() + " - " + value.name.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                            fontFamily: MyString.PlusJakartaSansregular,
                            color:value.name.toString() == "Select Units" ? myColors.grey_27 : myColors.grey_one.withOpacity(0.90),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
                  .toList(),
              value: floorModel,

              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 1),
                height: 40,
                width: 400,
              ),
              dropdownStyleData:  DropdownStyleData(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                maxHeight: 400,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: categoryController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: categoryController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an item...',
                      hintStyle:  TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                        fontFamily: MyString.PlusJakartaSansregular,
                        color: myColors.grey_27,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value!.name.toString().toLowerCase().contains(searchValue) ||  item.value!.name.toString().toUpperCase().contains(searchValue);
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  categoryController.clear();
                }
              },
            ),
          ),
        )
            : Container(
          height: 50.0,
          // width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: myColors.grey_38),
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.centerLeft,
          child: Text(floreController.text,style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none,
            fontFamily:
            MyString.PlusJakartaSansregular,
            color: myColors.grey_27,
          ),),
        ),
      ],
    );
  }

  /// Unit Dropdown....................
  unitdropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.CustomMediumText(
              "Unit",
              myColors.black,
              FontWeight.w700,
              12,
              1,
              TextAlign.center),

          hsized13,

          assetscanlist.isEmpty ?
          Container(
              height: 50.0,
              //width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  border: Border.all(color:myColors.grey_38),
                  color: Colors.white.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(10)),
              //  margin: EdgeInsets.only(left: 25,right: 25),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<Units>(
                  isExpanded: true,
                  hint: Text(
                    'Select units',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      fontFamily: MyString.PlusJakartaSansregular,
                      color: myColors.grey_27,
                    ),
                  ),
                  onChanged: (Units? value) {
                    if( value!.name.toString() != "Select Units"){
                      setState(() {
                        unitId = value.id.toString();
                        unitController.text = value.name.toString();
                        unitsModel = value;
                      });

                      roomslist!.clear();
                      roomId = "";
                      setState(() {});

                      roomModel = Rooms(id: 0, name: "Select Rooms", code: "");
                      roomslist!.add(roomModel!);
                      setState(() {});

                      Requestfloor(context, "0", projectId, "unit");
                    }else{
                      setState(() {
                        unitId = "";
                        unitsModel = value;
                      });
                    }

                  },
                  selectedItemBuilder: (BuildContext context) {
                    return unitslist!.map((e) {
                      return Container(
                        padding: EdgeInsets.only(left: 6.0),
                        alignment: Alignment.centerLeft,
                        constraints: const BoxConstraints(minWidth: 100),
                        child: Text(
                          e.code.toString() == "null" || e.code.toString() == ""?
                          e.name.toString():
                          e.code.toString() +" - "+ e.name.toString(),
                          style: const TextStyle(
                              color: myColors.grey_27, fontWeight: FontWeight.w500,fontSize: 12),
                        ),
                      );
                    }).toList();
                  },
                  items: unitslist!
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child:Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: [
                          unitId == value.id.toString() ?
                          Padding(
                            padding:  EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.check,size: 15,),
                          ):
                          Container(),

                          Expanded(
                            child: Text(
                              value.name.toString() == "Select Units"?
                              value.name.toString():
                              value.code.toString() + " - " + value.name.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                                fontFamily: MyString.PlusJakartaSansregular,
                                color:value.name.toString() == "Select Units" ? myColors.grey_27 : myColors.grey_one.withOpacity(0.90),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                      .toList(),
                  value: unitsModel,

                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    height: 40,
                    width: 400,
                  ),
                  dropdownStyleData:  DropdownStyleData(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    maxHeight: 400,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                  dropdownSearchData: DropdownSearchData(
                    searchController: categoryController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        controller: categoryController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Search for an item...',
                          hintStyle:  TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                            fontFamily: MyString.PlusJakartaSansregular,
                            color: myColors.grey_27,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return item.value!.name.toString().toLowerCase().contains(searchValue) ||  item.value!.name.toString().toUpperCase().contains(searchValue);
                    },
                  ),
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      categoryController.clear();
                    }
                  },
                ),
              )
          )
              : Container(
            height: 50.0,
            // width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color:myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.centerLeft,
            child: Text(unitController.text,style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
              fontFamily:
              MyString.PlusJakartaSansregular,
              color: myColors.grey_27,
            ),),
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
          Container(
            alignment: Alignment.topLeft,
            child: CustomText.CustomMediumText(
                "Location Store",
                myColors.black,
                FontWeight.w700,
                12,
                1,
                TextAlign.center),
          ),
          hsized13,

          assetscanlist.isEmpty ?
          Container(
              height: 50.0,
              // width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: myColors.grey_38),
                  color: Colors.white.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(10)),
              //  margin: EdgeInsets.only(left: 25,right: 25),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<Rooms>(
                  isExpanded: true,
                  hint: Text(
                    'Select room',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      fontFamily: MyString.PlusJakartaSansregular,
                      color: myColors.grey_27,
                    ),
                  ),
                  onChanged: (Rooms? value) {
                    if(value!.name.toString() != "Select Rooms"){
                      setState(() {
                        roomController.text = value.name.toString();
                        roomModel = value;
                        roomId = value.id.toString();
                      });
                    }else{
                      setState(() {
                        roomId = "";
                        roomModel = value;
                      });
                    }

                  },
                  selectedItemBuilder: (BuildContext context) {
                    return roomslist!.map((e) {
                      return Container(
                        // padding: EdgeInsets.only(left: 6.0),
                        alignment: Alignment.centerLeft,
                        constraints: const BoxConstraints(minWidth: 100),
                        child: Text(
                          e.code.toString() == "null" || e.code.toString() == ""?
                          e.name.toString():
                          e.code.toString() +" - "+ e.name.toString(),
                          style: const TextStyle(
                              color: myColors.grey_27, fontWeight: FontWeight.w500,fontSize: 12),
                        ),
                      );
                    }).toList();
                  },
                  items: roomslist!
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child:Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: [
                          roomId == value.id.toString() ?
                          Padding(
                            padding:  EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.check,size: 15,),
                          ):
                          Container(),

                          Expanded(
                            child: Text(
                              value.name.toString() == "Select Units"?
                              value.name.toString():
                              value.code.toString() + " - " + value.name.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                                fontFamily: MyString.PlusJakartaSansregular,
                                color:value.name.toString() == "Select Units" ? myColors.grey_27 : myColors.grey_one.withOpacity(0.90),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                      .toList(),
                  value: roomModel,

                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    height: 40,
                    width: 400,
                  ),
                  dropdownStyleData:  DropdownStyleData(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    maxHeight: 400,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                  dropdownSearchData: DropdownSearchData(
                    searchController: categoryController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        controller: categoryController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Search for an item...',
                          hintStyle:  TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                            fontFamily: MyString.PlusJakartaSansregular,
                            color: myColors.grey_27,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return item.value!.name.toString().toLowerCase().contains(searchValue) ||  item.value!.name.toString().toUpperCase().contains(searchValue);
                    },
                  ),
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      categoryController.clear();
                    }
                  },
                ),
              )
          )
              : Container(
            height: 50.0,
            // width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.centerLeft,
            child: Text(roomController.text,style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
              fontFamily:
              MyString.PlusJakartaSansregular,
              color: myColors.grey_27,
            ),),

            //Text("Building"),
          ),
        ],
      ),
    );
  }


  /// Type Dropdown........
  typedropdown() {
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.CustomMediumText(
              "Type",
              myColors.black,
              FontWeight.w700,
              12,
              1,
              TextAlign.center),

          hsized13,
          Container(
            height: 50.0,
            //width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color:myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<Types>(
                isExpanded: true,
                hint: Text(
                  'Select type',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                    fontFamily: MyString.PlusJakartaSansregular,
                    color: myColors.grey_27,
                  ),
                ),
                onChanged: (value) {
                  if(value!.name.toString() != "Select Type"){
                    setState(() {
                      typeId = value.id.toString();
                      typeController.text = value.name.toString();
                      typeModel = value;
                    });
                    subTypeslist.clear();
                    subtypeModel = SubTypes(id: 0, name: "Select SubType", code: "");
                    subTypeslist.add(subtypeModel!);
                    setState(() {});
                    for(int i =0; i < subTypeslist1.length; i++){
                      if(typeId.toString() == subTypeslist1[i].typeId.toString()){
                        subTypeslist.add(subTypeslist1[i]);
                        setState(() {});

                      }}
                    print("subTypeslist1>>${subTypeslist1.length}");
                    print("subTypeslist>>${subTypeslist.length}");
                  }else{
                    setState(() {
                      typeId = "";
                      typeModel = value;
                    });
                  }

                },
                selectedItemBuilder: (BuildContext context) {
                  return typeslist.map((e) {
                    return Container(
                      //   padding: EdgeInsets.only(left: 6.0),
                      alignment: Alignment.centerLeft,
                      constraints: const BoxConstraints(minWidth: 100),
                      child: Text(
                        e.code.toString() == "null" || e.code.toString() == ""?
                        e.name.toString():
                        e.code.toString() +" - "+ e.name.toString(),
                        style: const TextStyle(
                            color: myColors.grey_27, fontWeight: FontWeight.w500,fontSize: 12),
                      ),
                    );
                  }).toList();
                },
                items: typeslist
                    .map((value) => DropdownMenuItem(
                  value: value,
                  child:Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        typeId == value.id.toString() ?
                        Padding(
                          padding:  EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.check,size: 15,),
                        ):
                        Container(),

                        Expanded(
                          child: Text(
                            value.name.toString() == "Select Units"?
                            value.name.toString():
                            value.code.toString() + " - " + value.name.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                              fontFamily:MyString.PlusJakartaSansregular,
                              color:value.name.toString() == "Select Units" ? myColors.grey_27 : myColors.grey_one.withOpacity(0.90),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
                    .toList(),
                value: typeModel,

                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal:1),
                  height: 40,
                  width: 400,
                ),
                dropdownStyleData:  DropdownStyleData(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  maxHeight: 400,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: categoryController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: categoryController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle:  TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                          fontFamily: MyString.PlusJakartaSansregular,
                          color: myColors.grey_27,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value!.name.toString().toLowerCase().contains(searchValue) ||  item.value!.name.toString().toUpperCase().contains(searchValue);
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    categoryController.clear();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );

  }

  /// Sub Type DropDown........
  subtypedropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.CustomMediumText(
            "SubType",
            myColors.black,
            FontWeight.w700,
            12,
            1,
            TextAlign.center),

        hsized13,
        Container(
          height: 50.0,
          //width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color:myColors.grey_38),
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<SubTypes>(
              isExpanded: true,
              hint: Text(
                'Select subtype',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontFamily: MyString.PlusJakartaSansregular,
                  color: myColors.grey_27,
                ),
              ),
              selectedItemBuilder: (BuildContext context) {
                return subTypeslist.map((e) {
                  return Container(
                    // padding: EdgeInsets.only(left: 3.0),
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(minWidth: 100),
                    child: Text(
                      e.code.toString() == "null" || e.code.toString() == ""?
                      e.name.toString():
                      e.code.toString() +" - "+ e.name.toString(),
                      style: const TextStyle(
                          color: myColors.grey_27, fontWeight: FontWeight.w500,fontSize: 12),
                    ),
                  );
                }).toList();
              },
              items: subTypeslist
                  .map((value) => DropdownMenuItem(
                value: value,
                child:Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      subtypeId == value.id.toString() ?
                      Padding(
                        padding:  EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.check,size: 15,),
                      ):
                      Container(),

                      Expanded(
                        child: Text(
                          value.name.toString() == "Select Units"?
                          value.name.toString():
                          value.code.toString() + " - " + value.name.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                            fontFamily: MyString.PlusJakartaSansregular,
                            color:value.name.toString() == "Select Units" ? myColors.grey_27 : myColors.grey_one.withOpacity(0.90),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
                  .toList(),
              value: subtypeModel,
              onChanged: (SubTypes? value) {
                if(value!.name.toString() != "Select SubType"){
                  setState(() {
                    subtypeId = value.id.toString();
                    subtypeController.text = value.name.toString();
                    subtypeModel = value;
                  });
                }else{
                  setState(() {
                    subtypeId = "";
                    subtypeModel = value;
                  });
                }

              },

              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 1),
                height: 40,
                width: 400,
              ),
              dropdownStyleData:  DropdownStyleData(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)
                ),
                maxHeight: 400,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: categoryController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: categoryController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an item...',
                      hintStyle:  TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                        fontFamily: MyString.PlusJakartaSansregular,
                        color: myColors.grey_27,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value!.name.toString().toLowerCase().contains(searchValue) ||  item.value!.name.toString().toUpperCase().contains(searchValue);
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  categoryController.clear();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  /// category Dropdown........
  categorydropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Categories>(
        isExpanded: true,
        hint: Text(
          'Select category',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            fontFamily: MyString.PlusJakartaSansregular,
            color: myColors.grey_27,
          ),
        ),
        selectedItemBuilder: (BuildContext context) {
          return categorylist.map((e) {
            return Container(

              //padding: EdgeInsets.only(right:2.0),
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(minWidth: 100),
              child: Text(
                e.code.toString() == "null" || e.code.toString() == ""?
                e.name.toString():
                e.code.toString() +" - "+ e.name.toString(),
                style: const TextStyle(
                    color: myColors.grey_27, fontWeight: FontWeight.w500,fontSize: 12),
              ),
            );
          }).toList();
        },
        items: categorylist
            .map((value) => DropdownMenuItem(
          value: value,
          child:Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                categoryId == value.id.toString() ?
                Padding(
                  padding:  EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.check,size: 15,),
                ):
                Container(),

                Expanded(
                  child: Text(
                    value.name.toString() == "Select Category"?
                    value.name.toString():
                    value.code.toString() + " - " + value.name.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      fontFamily: MyString.PlusJakartaSansregular,
                      color:value.name.toString() == "Select Units" ? myColors.grey_27 : myColors.grey_one.withOpacity(0.90),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ))
            .toList(),
        value: catemodel,
        onChanged: (value) {
          if(value!.name.toString() != "Select Category"){
            setState(() {
              categoryId = value.id.toString();
              categoryName = value.name.toString();
              catemodel = value;
            });
          }else{
            setState(() {
              categoryId = "";
              catemodel = value;
            });
          }
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 0),
          height: 40,
          width: 400,
        ),
        dropdownStyleData:  DropdownStyleData(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          maxHeight: 400,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: categoryController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: categoryController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle:  TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontFamily: MyString.PlusJakartaSansregular,
                  color: myColors.grey_27,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value!.name.toString().toLowerCase().contains(searchValue) ||  item.value!.name.toString().toUpperCase().contains(searchValue);
          },
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            categoryController.clear();
          }
        },
      ),
    );
  }


  /// Priority Dropdown..............
  prioritydropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.CustomMediumText(
            "Priority",
            myColors.black,
            FontWeight.w700,
            12,
            1,
            TextAlign.center),

        hsized13,
        Container(
          height: 50.0,
          //width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color:myColors.grey_38),
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Priorities>(
              isExpanded: true,
              value: prioritiesModel,
              hint: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Select Priority",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                    fontFamily: MyString.PlusJakartaSansregular,
                    color: myColors.grey_27,
                  ),
                ),
              ),
              icon: const Icon(Icons.arrow_drop_down_sharp),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (Priorities? value) {
                if(value!.name.toString() != "Select Priority"){
                  setState(() {
                    priorityId = value.id.toString();
                    priorityController.text = value.name.toString();
                    prioritiesModel = value;
                  });
                }else{
                  setState(() {
                    priorityId = "";
                    prioritiesModel = value;
                  });
                }

              },

              selectedItemBuilder: (BuildContext context) {
                return prioritieslist.map((e) {
                  return Container(
                    //  padding: EdgeInsets.only(left: 15.0),
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(minWidth: 100),
                    child: Text(
                      e.code.toString() == "null" || e.code.toString() == ""?
                      e.name.toString():
                      e.code.toString() +" - "+ e.name.toString(),
                      style: const TextStyle(
                          color: myColors.grey_27, fontWeight: FontWeight.w500,fontSize: 12),
                    ),
                  );
                }).toList();
              },
              items: prioritieslist
                  .map<DropdownMenuItem<Priorities>>((Priorities value) {
                return DropdownMenuItem<Priorities>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child:Row(
                      children: [
                        priorityId == value.id.toString() ?
                        Padding(
                          padding:  EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.check,size: 15,),
                        ):
                        Container(),

                        Expanded(
                          child: Text(
                            value.name.toString() != "Select Priority"?
                            value.code.toString() +" - "+value.name.toString():
                            value.name.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                              fontFamily: MyString.PlusJakartaSansregular,
                              color: value.name.toString() != "Select Priority"? myColors.black.withOpacity(0.90) :myColors.grey_27,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  /// Resources Dropdown..............
  Resourcesdropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.CustomMediumText(
            "Resources",
            myColors.black,
            FontWeight.w700,
            12,
            1,
            TextAlign.center),

        hsized13,
        Container(
          height: 50.0,
          //width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color:myColors.grey_38),
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AssignToModel>(
              isExpanded: true,
              value: ResourcesmainModel,
              hint: Padding(
                padding: EdgeInsets.only(left: 1.0),
                child: Text(
                  "Select ${MyString.Resources}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                    fontFamily: MyString.PlusJakartaSansregular,
                    color: myColors.grey_27,
                  ),
                ),
              ),
              icon: const Icon(Icons.arrow_drop_down_sharp),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (AssignToModel? value) {
                if (value!.name.toString() != "Select ${MyString.Resources}") {
                  print("RecorcesId>>${value.id.toString()}");
                  setState(() {
                    RecorcesId = value.id.toString();
                    Recorcesname = value.name.toString();
                    mobilecode = value.mobileCode.toString();
                    mobileController.text = value.mobileNo.toString();
                    ResourcesmainModel = value;
                  });
                  setState(() {
                  });
                } else {
                  setState(() {
                    RecorcesId = "";
                    ResourcesmainModel = value;
                  });
                }
              },
              selectedItemBuilder: (BuildContext context) {
                return assigntolist.map((e) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      e.code.toString() == "null" || e.code.toString() == ""?
                      e.name.toString():
                      e.code.toString() +" - "+ e.name.toString(),
                      style: const TextStyle(
                          color: myColors.grey_27, fontWeight: FontWeight.w500,fontSize: 12),
                    ),
                  );
                }).toList();
              },
              items: assigntolist.map<DropdownMenuItem<AssignToModel>>(
                      (AssignToModel value) {
                    return DropdownMenuItem<AssignToModel>(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child:Row(
                          children: [
                            RecorcesId == value.id.toString() ?
                            Padding(
                              padding:  EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.check,size: 15,),
                            )
                                :
                            Container(),

                            Expanded(
                              child: Text(
                                value.name.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                  fontFamily: MyString.PlusJakartaSansregular,
                                  color: value.name.toString() != "Select ${MyString.Resources}"? myColors.black.withOpacity(0.90) :myColors.grey_27,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  ///GetResourcesByReporterType ...
  getallResources(String tasklogId, String typeid, String subtypeId,
      String projectid) async {
    assignresourcelist.clear();
    assignresourceModel = AssignedResourcesModel(
        id: 0,
        name: "Select ${MyString.Resources}",
        designation: "",
        email: "",
        mobileCode: "",
        mobileNo: "",
        isChecked: false);
    assignresourcelist.add(assignresourceModel!);

    setState(() {});
    if (roomId.isEmpty) {
      CustomToast.showToast(msg: "Room id is null");
    }
    else if (typeid.isEmpty) {
      CustomToast.showToast(msg: "Type id is null");
    } else if (subtypeId.isEmpty) {
      CustomToast.showToast(msg: "SubType id is null");
    }

    else if (tasklogId.isEmpty) {
      CustomToast.showToast(msg: "Task Log id is null");
    } else if (projectid.isEmpty) {
      CustomToast.showToast(msg: "Project id is null");
    } else if (summaryController.text.isEmpty) {
      CustomToast.showToast(msg: "Please enter summery");
    } else if (projectController.text.isEmpty) {
      CustomToast.showToast(msg: "Please enter title");
    }
    else if (RecorcesId.trim().isEmpty ||
        RecorcesId == "" ||
        RecorcesId == "null") {
      CustomToast.showToast(
          msg: "Please select Resorce name");
    }

    else {
      await Webservices.RequestGetResourcesByReporterType(
        context,
        true,
        typeid,
        subtypeId,
        tasklogId,
        projectid,
        widget.title == "Soft Services PM W/O" ? "schedule" : "",
        assignresourcelist,
      );
      for (int i = 0; i < assignresourcelist.length; i++) {
        print("nameController2>>>${assignresourcelist[i].name.toString()}");
        if (user_name == assignresourcelist[i].name.toString()) {
          reportrecorcesId = assignresourcelist[i].id.toString();
          setState(() {});
          break;
        }
        print("RecorcesId>>>${RecorcesId}");
      }
      setState(() {});
      if (widget.title == "PPM W/O") {
        RequestAddOrUpdateTaskLogppm(context);
      }
      else if(widget.ServiceId == "2" ){
        RequestAddOrUpdateTaskLog(context);
        //}
      }
      else {
        RequestAddOrUpdateTaskLog(context);
      }
      setState(() {});
    }
  }

  /// AdditionolInfo ........
  Future<void> RequestAdditionolInfo(
      BuildContext context,
      bool load,
      String taskLogId,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
       try {
      final response = await http.get(
          Uri.parse(status == "4"
              ? main_base_url +
              AllApiServices.scheduleapi +
              AllApiServices.task_log_additionol_info +
              taskLogId.toString()
              : main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.task_log_additionol_info +
              taskLogId.toString()
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      print("additionalInfo" + jsonResponse.toString());
      if (response.statusCode == 200) {
        var taskresources = jsonResponse['taskResources'];
        // var masterResources = jsonResponse['masterResources']['data'];

        // print("masterResources>>${masterResources}");
        print("taskresources>>${taskresources}");

        // if (masterResources != null) {
        //   masterResources.forEach((e) {
        //     Data model = Data.fromJson(e);
        //     masterResourceslist.add(model);
        //   });
        //   print("masterResourceslist<<${masterResourceslist.length}");
        // }
        if (taskresources != null) {
          taskresources.forEach((e) {
            TaskResourcesModel model = TaskResourcesModel.fromJson(e);
            taskResourceslist.add(model);
            setState(() {});
            p.setString("resourcename",
                taskResourceslist.first.resourceName.toString());
            setState(() {});
            print("taskresources>>${taskResourceslist.first.resourceName}");
          });
          // if(taskResourceslist.isNotEmpty){
          //   p.setString("resourcename", taskResourceslist.first.resourceName.toString());
          //   setState(() {});
          // }

          if (taskResourceslist.isNotEmpty) {
            nameController.text =
                taskResourceslist.first.resourceName.toString();
            setState(() {});
          }
          print("nameController${nameController.text}");

          setState(() {});
        }
      } else {
        print(response.reasonPhrase);
        CustomLoader.showAlertDialog(context, false);
      }
    } catch (e) {
      //   CustomLoader.showAlertDialog(context, false);
      print(e);
      throw Exception('errorr>>>>> ${e.toString()}');
    }
    return;
  }

  /// GetProjectsMasterData Api call....
  Future<void> RequestGetLocationAndResourceMasterData1(
      BuildContext context, String taskLogId, String projectId) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    CustomLoader.showAlertDialog(context, true);

    try {
      var response = await http.get(
          Uri.parse(
              status == "4"?
              main_base_url+AllApiServices.scheduleapi+AllApiServices.GetLocationAndResourceMasterData +
                  "${taskLogId}/${projectId}":
              main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.GetLocationAndResourceMasterData +
                  "${taskLogId}/${projectId}"
          ),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print(response.body);
      CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        var floors2 = jsonResponse['floors'];
        var buildings = jsonResponse['buildings'];
        var units = jsonResponse['units'];
        var rooms = jsonResponse['rooms'];
        var reporterSubTypes = jsonResponse['reporterSubTypes'];
        var resources = jsonResponse['resources'];
        var reporterTypes = jsonResponse['reporterTypes'];
        var countryCodes = jsonResponse['countryCodes'];

        countryCodeslist!.clear();
        is_country = false;
        buildingModel = Buildings(id: 0, name: "Select Building", code: "");
        buildingslist!.add(buildingModel!);

        unitsModel = Units(id: 0, name: "Select Units", code: "");
        unitslist!.add(unitsModel!);

        roomModel = Rooms(id: 0, name: "Select Rooms", code: "");
        roomslist!.add(roomModel!);

        floorModel = FloorsModel(id: 0, name: "Select Floor", code: "");
        floorlist.add(floorModel!);

        ResourcesmainModel =
            AssignToModel(id: 0, name: "Select Resources", code: "");
        assigntolist.add(ResourcesmainModel!);
        setState(() {});

        ///  buildings
        if (buildings != null) {
          buildings.forEach((e) {
            Buildings model = Buildings.fromJson(e);
            buildingslist!.add(model);
          });
        }

        ///  countryCodes
        if (countryCodes != null) {
          countryCodes.forEach((e) {
            CountryCodes model = CountryCodes.fromJson(e);
            countryCodeslist!.add(model);
          });
          if(countryCodeslist!.isNotEmpty){

            for(int i = 0; i < countryCodeslist!.length; i++){
              if(MobileCode == countryCodeslist!.first.mobileCode.toString()){
                MobileCode = countryCodeslist![i].mobileCode.toString();
                setState(() {});
              }
            }

          }
          setState(() {});
        }

        /// floors
        if (floors2 != null) {
          floors2.forEach((e) {
            FloorsModel model = FloorsModel.fromJson(e);
            floorlist.add(model);
          });
        }

        /// units
        List<Units> unitl = [];
        if (units != null) {
          units.forEach((e) {
            Units model = Units.fromJson(e);
            unitl.add(model);
          });

          for (int i = 0; i < unitl.length; i++) {
            if (buildingId.toString() == unitl[i].buildingId.toString()) {
              unitslist!.add(unitl[i]);
            }
          }
        }

        /// reporterTypes..................................
        List<ReporterTypes> reporter = [];
        if (reporterTypes != null) {
          reporterTypes.forEach((e) {
            ReporterTypes model = ReporterTypes.fromJson(e);
            reporter.add(model);
          });

          for (int i = 0; i < reporter.length; i++) {
            reporterTypeslist!.add(reporter[i]);
          }
          repoterTypeId = reporterTypeslist!.first.id.toString();
          setState(() {});
        }

        /// ReporterSubTypes.........................
        List<ReporterSubTypes> reportersubtype = [];
        if (reporterSubTypes != null) {
          reporterSubTypes.forEach((e) {
            ReporterSubTypes model = ReporterSubTypes.fromJson(e);
            reportersubtype.add(model);
          });
          setState(() {});

          for (int i = 0; i < reportersubtype.length; i++) {
            if (repoterTypeId.toString() ==
                reportersubtype[i].reporterTypeId.toString()) {
              reporterSubTypeslist!.add(reportersubtype[i]);
              setState(() {});
              print("ReporterSubTypes???${reporterSubTypeslist!.length}");
              setState(() {});
            }
          }
          reporterSubTypesId = reporterSubTypeslist!.first.id.toString();
        }

        /// rooms
        List<Rooms> rooml = [];
        if (rooms != null) {
          rooms.forEach((e) {
            Rooms model = Rooms.fromJson(e);
            rooml.add(model);
          });

          for (int i = 0; i < rooml.length; i++) {
            if (unitId.toString() == rooml[i].unitId.toString()) {
              roomslist!.add(rooml[i]);
              print("roomslist???${roomslist!.length}");
            }
          }
        }

        List<Resources> resources1 = [];
        if (resources != null) {
          resources.forEach((e) {
            Resources model = Resources.fromJson(e);
            Resourceslist!.add(model);
          });

          setState(() {});
        }
      } else {}
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// GetProjectsMasterData Api call....
  Future<void> RequestGetLocationAndResourceMasterData(
      BuildContext context, String taskLogId, String projectId) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    CustomLoader.showAlertDialog(context, true);

    print("url.............${ status == "4"?
    main_base_url+AllApiServices.scheduleapi+AllApiServices.GetLocationAndResourceMasterData +
        "${taskLogId}/${projectId}/${AllApiServices.isedit}":
    main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.GetLocationAndResourceMasterData +
        "${taskLogId}/${projectId}/${AllApiServices.isedit}"}");
    try {
      var response = await http.get(
          Uri.parse(
              status == "4"?
              main_base_url+AllApiServices.scheduleapi+AllApiServices.GetLocationAndResourceMasterData +
                  "${taskLogId}/${projectId}":
              main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.GetLocationAndResourceMasterData +
                  "${taskLogId}/${projectId}"
          ),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print(response.body);
      CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      print("jsonResponse............${jsonResponse}");
      if (response.statusCode == 200) {
        var floors2 = jsonResponse['floors'];
        var buildings = jsonResponse['buildings'];
        var units = jsonResponse['units'];
        var rooms = jsonResponse['rooms'];
        var reporterSubTypes = jsonResponse['reporterSubTypes'];
        var resources = jsonResponse['resources'];
        var reporterTypes = jsonResponse['reporterTypes'];
        var countryCodes = jsonResponse['countryCodes'];

        countryCodeslist!.clear();
        is_country = false;
        buildingModel = Buildings(id: 0, name: "Select Building", code: "");
        buildingslist!.add(buildingModel!);

        unitsModel = Units(id: 0, name: "Select Units", code: "");
        unitslist!.add(unitsModel!);

        roomModel = Rooms(id: 0, name: "Select Rooms", code: "");
        roomslist!.add(roomModel!);

        floorModel = FloorsModel(id: 0, name: "Select Floor", code: "");
        floorlist.add(floorModel!);

        // ResourcesmainModel =
        //     AssignToModel(id: 0, name: "Select Resources", code: "");
        // assigntolist.add(ResourcesmainModel!);
        setState(() {});

        ///  buildings
        if (buildings != null) {
          buildings.forEach((e) {
            Buildings model = Buildings.fromJson(e);
            buildingslist!.add(model);
          });
        }

        ///  countryCodes
        if (countryCodes != null) {
          countryCodes.forEach((e) {
            CountryCodes model = CountryCodes.fromJson(e);
            countryCodeslist!.add(model);
          });
          if(countryCodeslist!.isNotEmpty){

            for(int i = 0; i < countryCodeslist!.length; i++){
              if(MobileCode == countryCodeslist!.first.mobileCode.toString()){
                MobileCode = countryCodeslist![i].mobileCode.toString();
                setState(() {});
              }
            }

          }
          setState(() {});
        }

        /// floors
        if (floors2 != null) {
          floors2.forEach((e) {
            FloorsModel model = FloorsModel.fromJson(e);
            floorlist.add(model);
          });
        }

        /// units
        List<Units> unitl = [];
        if (units != null) {
          units.forEach((e) {
            Units model = Units.fromJson(e);
            unitl.add(model);
          });

          for (int i = 0; i < unitl.length; i++) {
            if (buildingId.toString() == unitl[i].buildingId.toString()) {
              unitslist!.add(unitl[i]);
            }
          }
        }

        /// reporterTypes..................................
        List<ReporterTypes> reporter = [];
        if (reporterTypes != null) {
          reporterTypes.forEach((e) {
            ReporterTypes model = ReporterTypes.fromJson(e);
            reporter.add(model);
          });

          for (int i = 0; i < reporter.length; i++) {
            reporterTypeslist!.add(reporter[i]);
          }
          repoterTypeId = reporterTypeslist!.first.id.toString();
          setState(() {});
        }

        /// ReporterSubTypes.........................
        List<ReporterSubTypes> reportersubtype = [];
        if (reporterSubTypes != null) {
          reporterSubTypes.forEach((e) {
            ReporterSubTypes model = ReporterSubTypes.fromJson(e);
            reportersubtype.add(model);
          });
          setState(() {});

          for (int i = 0; i < reportersubtype.length; i++) {
            if (repoterTypeId.toString() ==
                reportersubtype[i].reporterTypeId.toString()) {
              reporterSubTypeslist!.add(reportersubtype[i]);
              setState(() {});
              print("ReporterSubTypes???${reporterSubTypeslist!.length}");
              setState(() {});
            }
          }
          reporterSubTypesId = reporterSubTypeslist!.first.id.toString();
        }

        /// rooms
        List<Rooms> rooml = [];
        if (rooms != null) {
          rooms.forEach((e) {
            Rooms model = Rooms.fromJson(e);
            rooml.add(model);
          });

          for (int i = 0; i < rooml.length; i++) {
            if (unitId.toString() == rooml[i].unitId.toString()) {
              roomslist!.add(rooml[i]);
              print("roomslist???${roomslist!.length}");
            }
          }
        }

        List<Resources> resources1 = [];
        if (resources != null) {
          resources.forEach((e) {
            Resources model = Resources.fromJson(e);
            Resourceslist!.add(model);
          });

          setState(() {});
        }
      } else {}
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }


  /// GetProjectsMasterData Api call....
  Future<void> Requestfloor1(BuildContext context, String taskLogId,
      String projectId, String type) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    var base_url = p.getString("mainurl");

    try {
      CustomLoader.ProgressloadingDialog(context, true);
      print(
          "url<<<${AllApiServices.GetLocationAndResourceMasterData + "${taskLogId}/${projectId}"}");
      var response = await http.get(
          Uri.parse(
              status == "4"?
              main_base_url+AllApiServices.scheduleapi+AllApiServices.GetLocationAndResourceMasterData +
                  "${taskLogId}/${projectId}/${AllApiServices.isedit}":
              main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.GetLocationAndResourceMasterData +
                  "${taskLogId}/${projectId}/${AllApiServices.isedit}"
          ),
          //   body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      CustomLoader.ProgressloadingDialog(context, false);
      if (response.statusCode == 200) {
        print(" projects jsonResponse resorce ${jsonResponse}");
        var floors2 = jsonResponse['floors'];
        var units = jsonResponse['units'];
        var rooms = jsonResponse['rooms'];
        var resources = jsonResponse['resources'];
        var reporterSubTypes = jsonResponse['reporterSubTypes'];
        var reporterTypes = jsonResponse['reporterTypes'];
        var countryCodeslist = jsonResponse['countryCodeslist'];

        print("floors>>>${floors2}");
        print("units>>>${units}");
        print("rooms>>>${rooms}");
        print("resources>>>${resources}");

        if (type == "floor") {
          /// units

          List<Units> unit1 = [];
          if (units != null) {
            units.forEach((e) {
              Units model = Units.fromJson(e);
              unit1.add(model);
              print("units name>>${model.name}");
            });

            for (int i = 0; i < unit1.length; i++) {
              if (buildingId.toString() == unit1[i].buildingId.toString()) {
                //  if (unit1[i].name.toString() != "") {
                unitslist!.add(unit1[i]);
                // }
              }
            }

            setState(() {});
          }

          /// rooms
          List<Rooms> rooml = [];
          if (rooms != null) {
            rooms.forEach((e) {
              Rooms model = Rooms.fromJson(e);
              rooml.add(model);
            });

            for (int i = 0; i < rooml.length; i++) {
              if (unitId.toString() == rooml[i].unitId.toString()) {
                roomslist!.add(rooml[i]);
              }
            }
            setState(() {});
          }

        }
        else if (type == "unit") {
          /// rooms
          List<Rooms> rooml = [];
          if (rooms != null) {
            rooms.forEach((e) {
              Rooms model = Rooms.fromJson(e);
              rooml.add(model);
            });

            for (int i = 0; i < rooml.length; i++) {
              if (unitId.toString() == rooml[i].unitId.toString()) {
                roomslist!.add(rooml[i]);
              }
            }
            setState(() {});
          }

          setState(() {});

          /// resources1
          List<Resources> resources1 = [];
          // if(resources != null){
          //   resources.forEach((e) {
          //     Resources model = Resources.fromJson(e);
          //     Resourceslist!.add(model);
          //   });
          //
          //   setState(() {});
          // }
        }
        else if (type == "scan") {
          List<Resources> resources1 = [];
          if (resources != null) {
            Resourceslist!.clear();
            ResourcesmainModel =
                AssignToModel(id: 0, name: "Select Resources", code: "");
            assigntolist.add(ResourcesmainModel!);
            setState(() {});
            resources.forEach((e) {
              Resources model = Resources.fromJson(e);
              Resourceslist!.add(model);
            });

            setState(() {});
          }
        }
        else if (type == "SubReporterType") {
          // reporterTypeslist!.clear();
          reporterSubTypeslist!.clear();

          // /// reporterTypes..................................
          // List<ReporterTypes> reporter = [];
          // if (reporterTypes != null) {
          //   reporterTypes.forEach((e) {
          //     ReporterTypes model = ReporterTypes.fromJson(e);
          //     reporter.add(model);
          //   });
          //
          //   for (int i = 0; i < reporter.length; i++) {
          //     reporterTypeslist!.add(reporter[i]);
          //     print("hhggjg???${reporterTypeslist!.length}");
          //   }
          // }

          /// ReporterSubTypes.........................
          List<ReporterSubTypes> reportersubtype = [];
          if (reporterSubTypes != null) {
            reporterSubTypes.forEach((e) {
              ReporterSubTypes model = ReporterSubTypes.fromJson(e);
              reportersubtype.add(model);
            });

            for (int i = 0; i < reportersubtype.length; i++) {
              if (repoterTypeId.toString() ==
                  reportersubtype[i].reporterTypeId.toString()) {
                reporterSubTypeslist!.add(reportersubtype[i]);
                print("ReporterSubTypes???${reporterSubTypeslist!.length}");
                if(reporterSubTypeslist!.isNotEmpty){
                  reporterSubTypesId = reporterSubTypeslist!.first.id.toString();
                }
              }
            }
            await Webservices.RequestGetResourcesByReporterType(
              context,
              true,
              repoterTypeId,
              reporterSubTypesId,
              taskLogId,
              projectId,
              widget.title == "Soft Services PM W/O" ? "schedule" : "",
              assignresourcelist,
            );
          }


          // ///  Resources.............
          // List<Resources> resources1 = [];
          // if (resources != null) {
          //   Resourceslist!.clear();
          //   ResourcesmainModel =
          //       Resources(id: 0, name: "Select Resources", code: "");
          //   Resourceslist!.add(ResourcesmainModel!);
          //   setState(() {});
          //   resources.forEach((e) {
          //     Resources model = Resources.fromJson(e);
          //     resources1.add(model);
          //   });
          //   setState(() {});
          //
          //   for (int i = 0; i < resources.length; i++) {
          //     if (reporterSubTypesId.toString() ==
          //         resources[i].resourceSubTypeId.toString()) {
          //       resourceslist.add(resources[i]);
          //       print("ReporterSubTypes???${resourceslist.length}");
          //     }
          //   }
          //   setState(() {});
          // }

        } else {
          /// units
          List<Units> unit1 = [];
          if (units != null) {
            units.forEach((e) {
              Units model = Units.fromJson(e);
              unit1.add(model);
              print("units name>>${model.name}");
            });

            for (int i = 0; i < unit1.length; i++) {
              if (buildingId.toString() == unit1[i].buildingId.toString()) {
                // if (unit1[i].name.toString() != "") {
                unitslist!.add(unit1[i]);
                // }
              }
            }
            print("units name>>${unitslist!.length}");
            setState(() {});
          }

          /// rooms
          List<Rooms> rooml = [];
          if (rooms != null) {
            rooms.forEach((e) {
              Rooms model = Rooms.fromJson(e);
              rooml.add(model);
            });

            for (int i = 0; i < rooml.length; i++) {
              if (unitId.toString() == rooml[i].unitId.toString()) {
                roomslist!.add(rooml[i]);
                print("roomslist???${roomslist!.length}");
              }
            }
            setState(() {});
          }

          /// floors
          if (floors2 != null) {
            floors2.forEach((e) {
              FloorsModel model = FloorsModel.fromJson(e);
              floorlist.add(model);
              print("floorlist???${roomslist!.length}");
            });
          }
          setState(() {});
        }
        setState(() {});
      } else {}
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }


  /// GetProjectsMasterData Api call....
  Future<void> Requestfloor(BuildContext context, String taskLogId,
      String projectId, String type) async {

    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();

    try {
      CustomLoader.ProgressloadingDialog(context, true);
      var response = await http.get(
          Uri.parse(
              status == "4"?
              main_base_url+AllApiServices.scheduleapi+AllApiServices.GetLocationAndResourceMasterData +
                  "${taskLogId}/${projectId}":
              main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.GetLocationAndResourceMasterData +
                  "${taskLogId}/${projectId}"
          ),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse................${jsonResponse}");
      CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        print(" projects jsonResponse resorce ${jsonResponse}");
        var floors2 = jsonResponse['floors'];
        var units = jsonResponse['units'];
        var rooms = jsonResponse['rooms'];
        var reporterSubTypes = jsonResponse['reporterSubTypes'];


        if (type == "floor") {
          /// units

          List<Units> unit1 = [];
          if (units != null) {
            units.forEach((e) {
              Units model = Units.fromJson(e);
              unit1.add(model);
              print("units name>>${model.name}");
            });

            for (int i = 0; i < unit1.length; i++) {
              if (buildingId.toString() == unit1[i].buildingId.toString()) {
                unitslist!.add(unit1[i]);
              }
            }
            setState(() {});
          }

          /// rooms
          List<Rooms> rooml = [];
          if (rooms != null) {
            rooms.forEach((e) {
              Rooms model = Rooms.fromJson(e);
              rooml.add(model);
            });

            for (int i = 0; i < rooml.length; i++) {
              if (unitId.toString() == rooml[i].unitId.toString()) {
                roomslist!.add(rooml[i]);
              }
            }
            setState(() {});
          }

        }
        else if (type == "unit") {
          /// rooms
          List<Rooms> rooml = [];
          if (rooms != null) {
            rooms.forEach((e) {
              Rooms model = Rooms.fromJson(e);
              rooml.add(model);
            });

            for (int i = 0; i < rooml.length; i++) {
              if (unitId.toString() == rooml[i].unitId.toString()) {
                roomslist!.add(rooml[i]);
              }
            }
            setState(() {});
          }

          setState(() {});

        }
        else if (type == "scan") {
        }
        else if (type == "SubReporterType") {
          reporterSubTypeslist!.clear();

          /// ReporterSubTypes.........................
          List<ReporterSubTypes> reportersubtype = [];
          if (reporterSubTypes != null) {
            reporterSubTypes.forEach((e) {
              ReporterSubTypes model = ReporterSubTypes.fromJson(e);
              reportersubtype.add(model);
            });

            for (int i = 0; i < reportersubtype.length; i++) {
              if (repoterTypeId.toString() ==
                  reportersubtype[i].reporterTypeId.toString()) {
                reporterSubTypeslist!.add(reportersubtype[i]);
                print("ReporterSubTypes???${reporterSubTypeslist!.length}");
                if(reporterSubTypeslist!.isNotEmpty){
                  reporterSubTypesId = reporterSubTypeslist!.first.id.toString();
                }
              }
            }
            await Webservices.RequestGetResourcesByReporterType(
              context,
              true,
              repoterTypeId,
              reporterSubTypesId,
              taskLogId,
              projectId,
              widget.title == "Soft Services PM W/O" ? "schedule" : "",
              assignresourcelist,
            );
          }
        } else {
          /// units
          List<Units> unit1 = [];
          if (units != null) {
            units.forEach((e) {
              Units model = Units.fromJson(e);
              unit1.add(model);
              print("units name>>${model.name}");
            });

            for (int i = 0; i < unit1.length; i++) {
              if (buildingId.toString() == unit1[i].buildingId.toString()) {
                unitslist!.add(unit1[i]);
              }
            }
            print("units name>>${unitslist!.length}");
            setState(() {});
          }

          /// rooms
          List<Rooms> rooml = [];
          if (rooms != null) {
            rooms.forEach((e) {
              Rooms model = Rooms.fromJson(e);
              rooml.add(model);
            });

            for (int i = 0; i < rooml.length; i++) {
              if (unitId.toString() == rooml[i].unitId.toString()) {
                roomslist!.add(rooml[i]);
                print("roomslist???${roomslist!.length}");
              }
            }
            setState(() {});
          }

          /// floors
          if (floors2 != null) {
            floors2.forEach((e) {
              FloorsModel model = FloorsModel.fromJson(e);
              floorlist.add(model);
              print("floorlist???${roomslist!.length}");
            });
          }
          setState(() {});
        }
        setState(() {});
      } else {}
    } on SocketException catch (e) {
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }


  /// AddOrUpdateTaskLog........
  Future<void> RequestAddOrUpdateTaskLog(
      BuildContext context,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    CustomLoader.showAlertDialog(context, true);
    DateTime dateTime = DateTime.now();
    if (taskModel.isEmpty) {
    } else {
      duedate = DateFormat.d().format(DateTime.parse(
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
      summary =
      "${duedate + " : " + user_name + " (MOB)" + " - " + summaryController.text},\n";
      print(
          "summary ${ status == "4"
              ? main_base_url +
              AllApiServices.scheduleapi +
              AllApiServices.AddOrUpdateTaskLog
              : main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.AddOrUpdateTaskLog}");

      /// update data
      try {
        final response = await http.post(
            Uri.parse(status == "4"
                ? main_base_url +
                AllApiServices.scheduleapi +
                AllApiServices.AddOrUpdateTaskLog
                : main_base_url +
                AllApiServices.base_name_PPmApi +
                AllApiServices.AddOrUpdateTaskLog
            ),
            body: json.encode( {
              "id": 0,
              "parentId": 0,
              "title":problemController.text,
              "taskSlNo": 0,
              "securityInfoId": ppmIdController.text.trim().isEmpty
                  ? ""
                  : ppmIdController.text,
              "serviceTypeId": widget.ServiceId == "2" ? 2 : serviceTypeId.toString() == "1" ? 3 : 2,
              "dueDate": duedate,
              "reportedById":widget.ServiceId == "2" ?  reporterRecorcesId : reportrecorcesId.isEmpty || reportrecorcesId == "" ? null : reportrecorcesId,
              "reportedByName": widget.ServiceId == "2" ?  ReporternameController.text : user_name,
              "userId": 1,
              "reportedDate": duedate,
              "typeId":typeId.isEmpty || typeId == "" ? null : typeId,
              "subTypeId": subtypeId.isEmpty || subtypeId == "" ? null : subtypeId,
              "categoryId":  categoryId.isEmpty || categoryId == "" ? null : categoryId,
              "channelId": channelID!.isEmpty || channelID == "" ? null : channelID,
              "modeId": 0,
              "locId": locID.trim().isNotEmpty || locID.toString() != "null" ? locID: "6",
              "locDate": "2023-10-26T10:28:54.191Z",
              "summary": summary.isEmpty ? "" : summary,
              "priorityId": priorityId.isEmpty || priorityId == "" ? null : priorityId,
              "faultCodeId": faultcodeId,
              "estimatedStockCost": 0,
              "estimatedLabourCost": 0,
              "estimatedTime": 0,
              "assetId":asset_IdController.text.trim().isEmpty == ""
                  ? null
                  : asset_IdController.text,
              "assetDescription":desController.text.trim().isEmpty || desController.text == ""
                  ? null
                  : desController.text,
              "assetCode": asset_codeController.text.trim().isEmpty ||
                  asset_codeController.text == ""
                  ? null
                  : asset_codeController.text,
              "assetName": "",
              "hasAsset": asset_codeController.text.trim().isEmpty ||
                  asset_codeController.text == ""
                  ? false
                  : true,
              "projectId": projectId.isEmpty || projectId == "" ? null : projectId,
              "buildingId": buildingId.isEmpty || buildingId == "" ? null : buildingId,
              "floorId":floorId.isEmpty || floorId == "" ? null : floorId,
              "unitId":unitId.isEmpty || unitId == "" ? null : unitId,
              "roomId": roomId.isEmpty || roomId == "" ? null : roomId,
              "reporterTypeId": widget.ServiceId == "2" ? repoterTypeId :  2,
              "reporterSubTypeId": widget.ServiceId == "2" ? reporterSubTypesId : 1,
              "mobileCode": widget.ServiceId == "2" ? MobileCode:  mobilecode,
              "mobileNo": widget.ServiceId == "2" ? reporter_mobilenoController.text: mobileController.text,
              "emailAddress": widget.ServiceId == "2" ? reporter_emailController.text: emailController.text,
              "statusId": 1,
              "taskInstructionId": selectedtaskinstructionID.trim().isEmpty ? null : selectedtaskinstructionID,
              "ratingId": 0,
              // widget.ServiceId == "2" ? RecorcesId :
              "resourceId": RecorcesId,
              "completionDate": "2023-10-26T10:28:54.191Z",
              "feedbackUserId": 0,
              "feedbackUserName": "string",
              "feedbackComments": "string",
              "feedbackDate": "2023-10-26T10:28:54.191Z",
              "signatureUrl": "string",
              "onHoldReason": "string",
              "onHoldDate": "2023-10-26T10:28:54.191Z",
              "onHoldReasonId": 0,
              "rejectedReason": "string",
              "loggedByEmail": "string",
              "loggedByDesignation": "string",
              "loggedByDate": "2023-10-26T10:28:54.191Z",
              "refNumber": "string",
              "ppmCode": "string",
              "parentWorkOrder": "string",
              "isMobile": true,
              "isAutoIssued": true
            }),

            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${p.getString("access_token")}'
            });


        if (response.statusCode == 200) {
          CustomLoader.showAlertDialog(context, false);
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => SucessWorkOrderScreen(),
          ),ModalRoute.withName('/'));
        }
      } catch (e) {
        CustomLoader.showAlertDialog(context, false);
        print(e);
        throw Exception('AddOrUpdateTaskLog error ${e.toString()}');
      }
      return;
    }
  }

  Future<void> RequestAddOrUpdateTaskLogppm(
      BuildContext context,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);
    DateTime dateTime = DateTime.now();
    var request = {};
    if (taskModel.isEmpty) {
    } else {
      duedate = DateFormat.d().format(DateTime.parse(
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

      var username = p.getString("resourcename").toString();
      setState(() {});

      summary = "${duedate + " : " + user_name + " (MOB)" + " - " + summaryController.text},\n";

      /// update data
      try {
        final response = await http.post(
            Uri.parse(widget.appbartitle == "schedule"
                ? main_base_url +
                AllApiServices.scheduleapi +
                AllApiServices.AddOrUpdateTaskLog
                : main_base_url +
                AllApiServices.base_name_PPmApi +
                AllApiServices.AddOrUpdateTaskLog
              // main_base_url + AllApiServices.AddOrUpdateTaskLog
            ),
            body: json.encode({
              "id": 0,
              "parentId": 0,
              "title":problemController.text,
              "taskSlNo": 0,
              "securityInfoId": ppmIdController.text.trim().isEmpty
                  ? ""
                  : ppmIdController.text,
              "serviceTypeId": widget.ServiceId == "2" ? 2 : serviceTypeId.toString() == "1" ? 3 : 2,
              "dueDate": duedate,
              "reportedById":widget.ServiceId == "2" ?  reporterRecorcesId : reportrecorcesId.isEmpty || reportrecorcesId == ""
                  ? null
                  : reportrecorcesId,
              "reportedByName": widget.ServiceId == "2" ?  ReporternameController.text : user_name,
              "userId": 1,
              "reportedDate": duedate,
              "typeId":typeId.isEmpty || typeId == "" ? null : typeId,
              "subTypeId": subtypeId.isEmpty || subtypeId == "" ? null : subtypeId,
              "categoryId":  categoryId.isEmpty || categoryId == "" ? null : categoryId,
              "channelId": channelID!.isEmpty || channelID == "" ? null : channelID,
              "modeId": 0,
              "locId":locID.trim().isNotEmpty || locID.toString() != "null" ? locID: "6",
              "locDate": "2023-10-26T10:28:54.191Z",
              "summary": summary.isEmpty ? "" : summary,
              "priorityId": priorityId.isEmpty || priorityId == "" ? null : priorityId,
              "faultCodeId": faultcodeId,
              "estimatedStockCost": 0,
              "estimatedLabourCost": 0,
              "estimatedTime": 0,
              "assetId":asset_IdController.text.trim().isEmpty == ""
                  ? null
                  : asset_IdController.text,
              "assetDescription":desController.text.trim().isEmpty || desController.text == ""
                  ? null
                  : desController.text,
              "assetCode": asset_codeController.text.trim().isEmpty ||
                  asset_codeController.text == ""
                  ? null
                  : asset_codeController.text,
              "assetName": "",
              "hasAsset": asset_codeController.text.trim().isEmpty ||
                  asset_codeController.text == ""
                  ? false
                  : true,
              "projectId": projectId.isEmpty || projectId == "" ? null : projectId,
              "buildingId": buildingId.isEmpty || buildingId == "" ? null : buildingId,
              "floorId":floorId.isEmpty || floorId == "" ? null : floorId,
              "unitId":unitId.isEmpty || unitId == "" ? null : unitId,
              "roomId": roomId.isEmpty || roomId == "" ? null : roomId,
              "reporterTypeId": widget.ServiceId == "2" ? repoterTypeId :  2,
              "reporterSubTypeId": widget.ServiceId == "2" ? reporterSubTypesId : 1,
              "mobileCode": widget.ServiceId == "2" ? MobileCode:  mobilecode,
              "mobileNo": widget.ServiceId == "2" ? reporter_mobilenoController.text: mobileController.text,
              "emailAddress": widget.ServiceId == "2" ? reporter_emailController.text: emailController.text,
              "statusId": 1,
              "taskInstructionId": selectedtaskinstructionID.trim().isEmpty ? null : selectedtaskinstructionID,
              "ratingId": 0,
              "completionDate": "2023-10-26T10:28:54.191Z",
              "feedbackUserId": 0,
              "feedbackUserName": "string",
              "feedbackComments": "string",
              "feedbackDate": "2023-10-26T10:28:54.191Z",
              "signatureUrl": "string",
              "onHoldReason": "string",
              "onHoldDate": "2023-10-26T10:28:54.191Z",
              "onHoldReasonId": 0,
              "rejectedReason": "string",
              "loggedByEmail": "string",
              "loggedByDesignation": "string",
              "loggedByDate": "2023-10-26T10:28:54.191Z",
              "refNumber": "string",
              "ppmCode": "string",
              "parentWorkOrder": "string",
              "resourceId": widget.ServiceId == "2" ? "": RecorcesId,
              "isMobile": true,
              "isAutoIssued": true
            }),

            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${p.getString("access_token")}'
            });

        if (response.statusCode == 200) {
          CustomLoader.showAlertDialog(context, false);
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => SucessWorkOrderScreen(),
          ),ModalRoute.withName('/'));
        } else {

        }
      } catch (e) {
        CustomLoader.showAlertDialog(context, false);
        print(e);
        throw Exception('AddOrUpdateTaskLog error ${e.toString()}');
      }
      return;
    }
  }



  Future getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagefilelist.add(File(image!.path));

      setState(() {});
    } else {
      // Utility().getToast('Please select image for edit');
      setState(() {});
    }
  }

  Future _getFromCamera() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagefilelist.add(File(image!.path));
      setState(() {});
    } else {
      setState(() {});
    }
  }

  void _handleimagepicker() {
    showModalBottomSheet<int>(
      barrierColor: Colors.black.withOpacity(0.80),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            height: 330,
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Scaffold(
                backgroundColor: myColors.black.withOpacity(0.1),
                bottomNavigationBar: Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(bottom: 0, left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //     hsized20,
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () {
                                    CustomNavigator.popNavigate(context);
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                    size: 20,
                                  )),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      CustomNavigator.popNavigate(context);
                                      getImage();
                                    },
                                    child: Container(
                                      child: Text(
                                        "Gallery",
                                        style: TextStyle(
                                            color: myColors.black,
                                            fontSize: 15,
                                            fontFamily:
                                            MyString.PlusJakartaSansBold),
                                      ),
                                    ),
                                  ),
                                  hsized5,
                                  Divider(),
                                  hsized5,
                                  GestureDetector(
                                    onTap: () {
                                      CustomNavigator.popNavigate(context);
                                      _getFromCamera();
                                    },
                                    child: Container(
                                      child: Text(
                                        "Camera",
                                        style: TextStyle(
                                            color:myColors.black,
                                            fontSize: 15,
                                            fontFamily:
                                            MyString.PlusJakartaSansBold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            hsized40,
                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: 40,
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 30 : 15,
      margin: EdgeInsets.only(right: 4, left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? myColors.app_theme : myColors.newBar_1,
      ),
    );
  }
}

