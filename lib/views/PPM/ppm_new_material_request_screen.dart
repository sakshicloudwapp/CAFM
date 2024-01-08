/*
import 'dart:convert';
import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/totalPriceModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/views/PPM/ppm_mr_view_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/my_string.dart';
import '../../model/models/GetMrDrtailModel.dart';
import '../../widgets/custom_texts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MR_Model {
  String title;

  MR_Model(this.title);
}
List<MR_Model> mrList = [];

class PPM_New_Material_Request_Screen extends StatefulWidget {
  String title;
  String taskLogId;
  String taskTypeId;
  String projectId;
  Function oncallback;
  PPM_New_Material_Request_Screen({Key? key,required this.title,required this.taskLogId,required this.taskTypeId,required this.projectId,required this.oncallback}) : super(key: key);

  @override
  _PPM_New_Material_Request_ScreenState createState() => _PPM_New_Material_Request_ScreenState();
}

class _PPM_New_Material_Request_ScreenState extends State<PPM_New_Material_Request_Screen> {
  TextEditingController typeController = TextEditingController();
  TextEditingController spareController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController manufectureController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController requestqntController = TextEditingController();
  TextEditingController unitpriceController = TextEditingController();
  TextEditingController totalpriceController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController modelController = TextEditingController();

  List<TotalPriceModel> totalpricelist = [];
  final quantityfocus = FocusNode();
  final manufecturefocus = FocusNode();
  final requestqntfocus = FocusNode();
  final unitpricefocus = FocusNode();
  final totalpricefocus = FocusNode();
  final desfocus = FocusNode();
  String sparecodeId = "";

  List<MrTypes>? mrTypes = [];
  List<StocksModel>? stocks = [];
  List<ProjectsStockModel>? projects = [];
  // List<CreateMrModel>? createmrlist = [];

  int avlqty = 0;
  int reqqty = 0;


  ProjectsStockModel? projectModel;
  MrTypes? mrTypesModel;
  StocksModel? stocksModel;
  String stockId = "";
  String stockname = "";
  String manufecturer = "";
  String unitprice = "";
  String mrtypeId = "";
  String mrtypename = "";
  List<MrStockModel> mrstocklist = [];
  List<MrDetailItems>? mrDetailItems = [];
  List<MrDetails>? mrDetailslist = [];

  List<Map<String, String>> newFaultCode = [
    {"name": "Stock"},
    {"name": "Type2"},
    {"name": "Type3"},
  ];
  late int tappedIndex;

  List<String> subjectList = [
    "ACCE - Accelerator Building",
    "ACCE - Accelerator ",
    "ACCE -  Building",
  ];
  String? selectBuilding;

  @override
  void initState() {
    super.initState();
    tappedIndex = 0;
    getmrdetailApi();
  }

  final ImagePicker imagePicker = ImagePicker();
  File? _image;
  List<File> imagefilelist = [];
  String img = "";



  getmrdetailApi()async{
    mrDetailslist!.clear();
    mrstocklist.clear();
    mrTypes!.clear();
    stocks!.clear();
    setState(() {});
    await Webservices.RequestGetMRDetailsByTaskId(context, true, widget.taskLogId, widget.taskTypeId, widget.projectId,mrstocklist,mrTypes,stocks,mrDetailslist);
    setState(() {});
    print("mrlist>>>${mrTypes!.length}");
    requestqntController.text = "0";
    for(int i =0; i< stocks!.length; i++ ){
      print("stock code >> ${stocks![i].sparePartCode}");
    }

  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return GestureDetector(
      onTap: (){
        requestqntfocus.unfocus();
        quantityfocus.unfocus();
        manufecturefocus.unfocus();
        desfocus.unfocus();
        setState(() {});
      },
      child: MediaQuery(
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
                                child: CustomText.CustomBoldTextDM(
                                    "Material Request",
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
                              onTap: (){
                                requestqntfocus.unfocus();
                                quantityfocus.unfocus();
                                manufecturefocus.unfocus();
                                desfocus.unfocus();
                                setState(() {});
                                mrList.add(MR_Model("Computer"),);
                                if(mrtypeId.trim().isEmpty || mrtypeId == ""){
                                  CustomToast.showToast(msg: "Please select mr type");
                                }
                                else if(desController.text.isEmpty){
                                  CustomToast.showToast(msg: "Please enter description");
                                }
                                else if(requestqntController.text.trim().isEmpty || requestqntController.text == ""){
                                  CustomToast.showToast(msg: "Please enter req qty");
                                }else {
                                  MrDetailItems model;
                                  model = MrDetailItems(
                                      id: 0,
                                      mrId: 0,
                                      mrTypeId: int.parse(mrtypeId),
                                      stockId: typeController.text == "Stock Item"  ? int.parse(stockId): 0,
                                      stockName: typeController.text == "Stock Item"  ? stockname :desController.text,
                                      availableQty: typeController.text == "Stock Item"  ?  int.parse(quantityController.text) : 0,
                                      requiredQty:typeController.text == "Stock Item"  ?  int.parse(requestqntController.text) : int.parse(requestqntController.text),
                                      unitPrice:typeController.text == "Stock Item"  ?  double.parse(unitpriceController.text) : 0,
                                      totalPrice: totalpriceController.text.trim().isEmpty ? 0 : double.parse(totalpriceController.text),
                                      remarks: manufecturer,
                                      typename: typeController.text);
                                  mrDetailItems!.add(model);

                                  setState(() {});
                                  if(mrDetailItems!.isNotEmpty){
                                    mrTypesModel = null;
                                    spareController.text = "";
                                    sparecodeId = "";
                                    quantityController.text = "";
                                    requestqntController.text = "0";
                                    unitpriceController.text = "0";
                                    totalpriceController.text = "";
                                    manufectureController.text = "";
                                    modelController.text = "";
                                    desController.text = "";
                                    requestqntController.text = "0";
                                    //stocksModel = null;
                                    typeController.text = "";
                                    mrtypeId = "";
                                    setState(() {});

                                  }
                                }
                                Requestcreatemr(context);
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


          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ///Camera...............................................
                Container(
                  height: 210,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    //border: Border.all(color: myColors.app_theme),
                    color: myColors.white_1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      */
/*  Container(
                        alignment: Alignment.topLeft,
                        child: CustomText.CustomMediumText(
                            MyString.Camera,
                            myColors.black,
                            FontWeight.w500,
                            12,
                            1,
                            TextAlign.center),
                      ),*/
/*

                      _image == null
                          ? GestureDetector(
                        onTap: () {
                          pickImage(context, ImageSource.camera);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icons/camera.png",
                                width: 55,
                                height: 50,
                              ),
                              Text("Add a photo",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily:  MyString.PlusJakartaSansregular,
                                    color: myColors.grey_two
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                          : Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: Image.file(
                          File(_image!.path.toString()),
                          width: 55,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),

               */
/* Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: CustomText.CustomSemiBoldText(MyString.New_Material_Request,
                      myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
                ),*/
/*


                ///Type.............................................

                Container(
                  margin: EdgeInsets.only(left: 20,top: 20),
                 // width: 75,
                  alignment: Alignment.centerLeft,
                  child: CustomText.CustomMediumText(MyString.Type, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                ),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 0),
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: mrTypes!.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {});
                            tappedIndex = index;

                            mrtypeId = mrTypes![index].id.toString();
                            print("tappedIndex......$mrtypeId");
                          },
                          child: Container(
                            // height: 50,
                              decoration: BoxDecoration(
                                  color: tappedIndex == index
                                      ? myColors.app_theme
                                      : myColors.grey_border,
                                  // color: AppColors.appContainer,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(30,10,30,10),
                                    child: Text(
                                        mrTypes![index].name.toString(),
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily:  MyString.PlusJakartaSansregular,
                                            color: tappedIndex == index
                                                ? myColors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center),
                                  ))),
                        ),
                      ),
                    ),
                  ),
                ),

                ///SubGroup.............................................

                Container(
                  margin: EdgeInsets.only(left: 20,top: 20),
                  // width: 75,
                  alignment: Alignment.centerLeft,
                  child: CustomText.CustomMediumText(MyString.SubGroup, myColors.black, FontWeight.w700, 12, 1, TextAlign.center),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: myColors.grey_23),
                        //color: myColors.bg_bottom
                    ),
                    padding: EdgeInsets.fromLTRB(15,5,15,5),
                    margin: EdgeInsets.only(top: 10,bottom: 20,left: 20,right: 20),
                    alignment: Alignment.center,
                    child:  subjectDropDown()
                ),

                /// Quantity and Unit Price............
                Container(
                  padding: EdgeInsets.only(left: 15, right: 10,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(child: Quantitydropdown()
                          //Text("Building"),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Unit Price",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: myColors.black,
                                    fontFamily:  MyString.PlusJakartaSansBold,
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
                                child: Center(
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
                                      color: myColors.black,
                                    ),

                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "1000",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: myColors.black,
                                            fontFamily:
                                            MyString.PlusJakartaSansregular,),
                                        isDense: true,
                                        // this will remove the default content padding
                                        contentPadding:
                                        EdgeInsets.fromLTRB(16, 1, 0, 0)),
                                    maxLines: 1,
                                    cursorColor: myColors.grey_26,
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                /// Total Price and Manufaturer .....................
                Container(
                  padding: EdgeInsets.only(left: 15, right: 10,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Price",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: myColors.black,
                                    fontFamily:  MyString.PlusJakartaSansBold,
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
                                  child: Center(
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
                                        color: myColors.black,
                                      ),

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "2000",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.black,
                                              fontFamily:
                                              MyString.PlusJakartaSansregular,),
                                          isDense: true,
                                          // this will remove the default content padding
                                          contentPadding:
                                          EdgeInsets.fromLTRB(16, 1, 0, 0)),
                                      maxLines: 1,
                                      cursorColor: myColors.grey_26,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Manufaturerdropdown()
                          //Text("Building"),
                        ),
                      ),


                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Model",style: TextStyle(fontFamily:  MyString.PlusJakartaSansBold,fontWeight: FontWeight.w700,fontSize: 12),),
                      SizedBox(height: 5),
                      Container(
                          height: 45.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: myColors.grey_38),
                              color: Colors.white.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(10)),
                          //  margin: EdgeInsets.only(left: 25,right: 25),
                          child: Center(
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
                                color: myColors.black,
                              ),

                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "IPV 55625428",
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: myColors.black,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,),
                                  isDense: true,
                                  // this will remove the default content padding
                                  contentPadding:
                                  EdgeInsets.fromLTRB(16, 1, 0, 0)),
                              maxLines: null,
                              cursorColor: myColors.grey_26,
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: DottedDecoration(
                    shape: Shape.line, linePosition: LinePosition.bottom, //remove this to get plane rectange
                  ),
                ),
                SizedBox(height: 35,),
                ///new list............................................
                Container(
                  height: 44,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: myColors.app_theme),
                    color: myColors.light_blue.withOpacity(0.40),
                  ),
                  child: Row(
                    children: [
                      ///S.Grp.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText(MyString.S_Grp, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),

                      ///S.Name.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText("S.Name", myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),

                      ///Qty.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText("Qty", myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),

                      ///Unit Price.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText(MyString.unit_Price, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),

                      ///T Price.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText(MyString.T_Price, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),
                    ],
                  ),
                ),

                Container(
                  // height: 55,
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 12),
                  padding: EdgeInsets.fromLTRB(18, 14, 18, 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: myColors.app_theme),
                    color: myColors.bg,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 75,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(MyString.Type, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                          ),
                          Container(
                            width: 5,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                          ),
                          SizedBox(width: 10,)
                        ],
                      ),

                      Expanded(
                        child: Column(
                          children: [

                            Typedropdown(),

                 Container(
                            //  height: 25,
                              padding: EdgeInsets.only(bottom: 5),
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
                                  'assets/fonts/Poppins/Poppins-Regular.ttf',
                                  color: myColors.grey_26,
                                ),

                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: MyString.Stock,
                                    hintStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: myColors.grey_26,
                                        fontFamily:
                                        "assets/fonts/Poppins/Poppins-Regular.ttf"),
                                    isDense: true,
                                    // this will remove the default content padding
                                    contentPadding:
                                    EdgeInsets.fromLTRB(16, 1, 0, 0)),
                                maxLines: 1,
                                cursorColor: myColors.grey_26,
                              ),
                            ),


                            // Container(
                            //   height: 1,
                            //   margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                            //   color: myColors.grey_25,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ///Form.............................................
                Container(
                  // height: 330,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: myColors.app_theme),
                    color: myColors.bg,
                  ),
                  child: Column(
                    children: [
                      ///Spare part code...........................................
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 75,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText("Spare part code", myColors.black, FontWeight.w500, 12, 2, TextAlign.start),
                                ),

                                Container(
                                  width: 5,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                                SizedBox(width: 10,),
                              ],
                            ),

                            Expanded(
                              child: Column(
                                children: [


                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:  typeController.text == "Stock Item" ?
                                    Sparedropdown()
                                        :Container(),
                                  ),


                                  // Container(
                                  //   height: 1,
                                  //   margin: EdgeInsets.fromLTRB(12, 5, 0, 0),
                                  //   color: myColors.grey_25,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Description...........................................

                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 75,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(MyString.Description, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                            ),
                            Container(
                              width: 5,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height:25,
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      controller: desController,
                                      focusNode: desfocus,
                                      enabled:  typeController.text == "Stock Item" ? false:true,
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
                                        'assets/fonts/Poppins/Poppins-Regular.ttf',
                                        color: myColors.grey_26,
                                      ),

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter description",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_26,
                                              fontFamily:
                                              "assets/fonts/Poppins/Poppins-Regular.ttf"),
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
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Avt Quantity...........................................
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 75,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText("Avt Qty.", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                                Container(
                                  width: 5,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                                // SizedBox(width: 10,)
                              ],
                            ),
                            //typeController.text != "Stock Item" ?Container():
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height:25,
                                    // margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      enabled: typeController.text == "Stock Item" ? false:false,
                                      controller: quantityController,
                                      focusNode: quantityfocus,
                                      keyboardType: TextInputType.text,
                                      onChanged: (String value) {
                                        print("TAG" + value);
                                        avlqty = int.parse(quantityController.text);
                                        setState(() {});

                                      },
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.none,
                                        fontFamily:
                                        'assets/fonts/Poppins/Poppins-Regular.ttf',
                                        color: myColors.grey_26,
                                      ),

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "0",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_26,
                                              fontFamily:
                                              "assets/fonts/Poppins/Poppins-Regular.ttf"),
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
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Req qty...........................................
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 75,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText("Req Qty.", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                                Container(
                                  width: 5,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                                // SizedBox(width: 10,)
                              ],
                            ),

                            typeController.text == "Stock Item" ?
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          controller: requestqntController,
                                          enabled: false,
                                          focusNode: requestqntfocus,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "0",
                                              hintStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: myColors.grey_26,
                                                  fontFamily:
                                                  "assets/fonts/Poppins/Poppins-Regular.ttf"),
                                              isDense: true,
                                              // this will remove the default content padding
                                              contentPadding:
                                              EdgeInsets.fromLTRB(16, 1, 0, 0)),
                                          cursorColor: myColors.grey_26,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none,
                                            fontFamily:
                                            'assets/fonts/Poppins/Poppins-Regular.ttf',
                                            color: myColors.grey_26,
                                          ),
                                          keyboardType: TextInputType.numberWithOptions(
                                              decimal: false, signed: false),
                                          // inputFormatters: <TextInputFormatter>[
                                          //   WhitelistingTextInputFormatter.digitsOnly
                                          // ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                              print("avlqty>>${avlqty}");
                                              print("reqqty>>${reqqty}");
                                              reqqty = int.parse(requestqntController.text);
                                              setState(() {});
                                              if(avlqty <= reqqty){

                                              }else{
                                                int currentValue = int.parse(requestqntController.text);
                                                setState(() {
                                                  currentValue++;
                                                  requestqntController.text =
                                                      (currentValue).toString(); // incrementing value
                                                });

                                                totalpricelist.clear();
                                                RequestIssuingStockPrice(context,false,widget.taskLogId.toString(),requestqntController.text);
                                                setState(() {});
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:myColors.app_theme,
                                                  borderRadius: BorderRadius.circular(3)
                                              ),
                                              height: 20,
                                              alignment: Alignment.center,

                                              child: Icon(Icons.arrow_drop_up,color: Colors.white,),
                                            ),
                                          ),

                                          SizedBox(height: 5,),

                                          GestureDetector(
                                            onTap: (){
                                              if(requestqntController.text == "0"){
                                              }else{
                                                int currentValue = int.parse(requestqntController.text);
                                                setState(() {
                                                  print("Setting state");
                                                  currentValue--;
                                                  requestqntController.text =
                                                      (currentValue).toString(); // decrementing value
                                                });

                                                totalpricelist.clear();
                                                RequestIssuingStockPrice(context,false,widget.taskLogId.toString(),requestqntController.text);
                                                setState(() {});
                                                // if(totalpricelist.isNotEmpty){
                                                //   totalpriceController.text = totalpricelist.first.totalPrice.toString();
                                                //   setState(() {});
                                                // }

                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:myColors.app_theme,
                                                  borderRadius: BorderRadius.circular(3)
                                              ),
                                              height: 20,
                                              alignment: Alignment.center,

                                              child: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                            ),
                                          ),

                                          SizedBox(height: 2,),
                                          // IconButton(
                                          //  //   minWidth: 10.0,
                                          //   icon: Icon(Icons.arrow_drop_down,size: 40,),
                                          //   onPressed: () {
                                          //
                                          //
                                          //   },
                                          // ),
                                        ],
                                      ),
                                      // Spacer(
                                      //   flex: 2,
                                      // )
                                    ],
                                  ),

                                  Container(
                                    height: 1,
                                    margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            ):
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          controller: requestqntController,
                                          enabled: false,
                                          focusNode: requestqntfocus,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "0",
                                              hintStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: myColors.grey_26,
                                                  fontFamily:
                                                  "assets/fonts/Poppins/Poppins-Regular.ttf"),
                                              isDense: true,
                                              // this will remove the default content padding
                                              contentPadding:
                                              EdgeInsets.fromLTRB(16, 1, 0, 0)),
                                          cursorColor: myColors.grey_26,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none,
                                            fontFamily:
                                            'assets/fonts/Poppins/Poppins-Regular.ttf',
                                            color: myColors.grey_26,
                                          ),
                                          keyboardType: TextInputType.numberWithOptions(
                                              decimal: false, signed: false),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                              print("avlqty>>${avlqty}");
                                              print("reqqty>>${reqqty}");
                                              reqqty = int.parse(requestqntController.text);

                                              int currentValue = int.parse(requestqntController.text);
                                              setState(() {
                                                currentValue++;
                                                requestqntController.text =
                                                    (currentValue).toString(); // incrementing value
                                              });
                                              totalpricelist.clear();
                                              RequestIssuingStockPrice(context,false,widget.taskLogId.toString(),requestqntController.text);
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:myColors.app_theme,
                                                  borderRadius: BorderRadius.circular(3)
                                              ),
                                              height: 20,
                                              alignment: Alignment.center,

                                              child: Icon(Icons.arrow_drop_up,color: Colors.white,),
                                            ),
                                          ),

                                          SizedBox(height: 5,),

                                          GestureDetector(
                                            onTap: (){

                                              int currentValue = int.parse(requestqntController.text);
                                              setState(() {
                                                print("Setting state");
                                                currentValue--;
                                                requestqntController.text =
                                                    (currentValue).toString(); // decrementing value
                                              });

                                              totalpricelist.clear();
                                              RequestIssuingStockPrice(context,false,widget.taskLogId.toString(),requestqntController.text);
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:myColors.app_theme,
                                                  borderRadius: BorderRadius.circular(3)
                                              ),
                                              height: 20,
                                              alignment: Alignment.center,

                                              child: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                            ),
                                          ),

                                          SizedBox(height: 2,),
                                          // IconButton(
                                          //  //   minWidth: 10.0,
                                          //   icon: Icon(Icons.arrow_drop_down,size: 40,),
                                          //   onPressed: () {
                                          //
                                          //
                                          //   },
                                          // ),
                                        ],
                                      ),
                                      // Spacer(
                                      //   flex: 2,
                                      // )
                                    ],
                                  ),

                                  Container(
                                    height: 1,
                                    margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            )
                            //     :
                            // Expanded(
                            //   child: Column(
                            //     children: [
                            //       Container(
                            //         height:25,
                            //         // / margin: EdgeInsets.only(top: 10),
                            //         alignment: Alignment.topLeft,
                            //         child: TextField(
                            //           controller:requestqntController ,
                            //           focusNode: requestqntfocus,
                            //
                            //           keyboardType: TextInputType.number,
                            //           onChanged: (String value) {
                            //             if( typeController.text != "Stock Item"){
                            //               var req = double.parse(value);
                            //               var unitprice = double.parse(unitpriceController.text);
                            //               var  total = req * unitprice;
                            //               totalpriceController.text = total.toString();
                            //               setState(() {});
                            //               print("total >>>${total}");
                            //             }
                            //
                            //
                            //           },
                            //           style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w500,
                            //             decoration: TextDecoration.none,
                            //             fontFamily:
                            //             'assets/fonts/Poppins/Poppins-Regular.ttf',
                            //             color: myColors.grey_26,
                            //           ),
                            //
                            //           decoration: InputDecoration(
                            //               border: InputBorder.none,
                            //               hintText: "0",
                            //               hintStyle: TextStyle(
                            //                   fontSize: 12,
                            //                   fontWeight: FontWeight.w500,
                            //                   color: myColors.grey_26,
                            //                   fontFamily:
                            //                   "assets/fonts/Poppins/Poppins-Regular.ttf"),
                            //               isDense: true,
                            //               // this will remove the default content padding
                            //               contentPadding:
                            //               EdgeInsets.fromLTRB(16, 1, 0, 0)),
                            //           maxLines: 1,
                            //           cursorColor: myColors.grey_26,
                            //         ),
                            //       ),
                            //
                            //       Container(
                            //         height: 1,
                            //         margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                            //         color: myColors.grey_25,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),


                      /// Hide total price and
                      // ///Unit Price...........................................
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                      //   child: Row(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Container(
                      //             width: 75,
                      //             alignment: Alignment.topLeft,
                      //             child: CustomText.CustomMediumText("Unit price", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                      //           ),
                      //           Container(
                      //             width: 5,
                      //             alignment: Alignment.topLeft,
                      //             child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                      //           ),
                      //           // SizedBox(width: 10,)
                      //         ],
                      //       ),
                      //
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             Container(
                      //               height:25,
                      //               // / margin: EdgeInsets.only(top: 10),
                      //               alignment: Alignment.topLeft,
                      //               child: TextField(
                      //                 controller:unitpriceController ,
                      //                 enabled: typeController.text != "Stock Item" ? true :false,
                      //                 focusNode: unitpricefocus,
                      //                 keyboardType: TextInputType.number,
                      //                 onChanged: (String value) {
                      //                   if(typeController.text != "Stock Item"){
                      //                     var req = double.parse(requestqntController.text);
                      //                     var unitprice = double.parse(value);
                      //                     var  total = req * unitprice;
                      //                     totalpriceController.text = total.toString();
                      //                     setState(() {});
                      //                     print("total >>>${total}");
                      //                     setState(() {});
                      //                   }
                      //
                      //                 },
                      //                 style: TextStyle(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w500,
                      //                   decoration: TextDecoration.none,
                      //                   fontFamily:
                      //                   'assets/fonts/Poppins/Poppins-Regular.ttf',
                      //                   color: myColors.grey_26,
                      //                 ),
                      //
                      //                 decoration: InputDecoration(
                      //                     border: InputBorder.none,
                      //                     hintText: "0",
                      //                     hintStyle: TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w500,
                      //                         color: myColors.grey_26,
                      //                         fontFamily:
                      //                         "assets/fonts/Poppins/Poppins-Regular.ttf"),
                      //                     isDense: true,
                      //                     // this will remove the default content padding
                      //                     contentPadding:
                      //                     EdgeInsets.fromLTRB(16, 1, 0, 0)),
                      //                 maxLines: 1,
                      //                 cursorColor: myColors.grey_26,
                      //               ),
                      //             ),
                      //
                      //             Container(
                      //               height: 1,
                      //               margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      //               color: myColors.grey_25,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      //     ///Total Price...........................................
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 75,
                      //         alignment: Alignment.topLeft,
                      //         child: CustomText.CustomMediumText(MyString.Total_Price, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                      //       ),
                      //       Container(
                      //         width: 5,
                      //         alignment: Alignment.topLeft,
                      //         child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                      //       ),
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             Container(
                      //               height:25,
                      //               margin: EdgeInsets.only(top: 10),
                      //               alignment: Alignment.topLeft,
                      //               child: TextField(
                      //                 keyboardType: TextInputType.text,
                      //                 controller: totalpriceController,
                      //                 focusNode: totalpricefocus,
                      //                 enabled: typeController.text != "Stock Item" ? true :false,
                      //                 onChanged: (String value) {
                      //                   print("TAG" + value);
                      //                   setState(() {});
                      //                 },
                      //                 style: TextStyle(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w500,
                      //                   decoration: TextDecoration.none,
                      //                   fontFamily:
                      //                   'assets/fonts/Poppins/Poppins-Regular.ttf',
                      //                   color: myColors.grey_26,
                      //                 ),
                      //
                      //                 decoration: InputDecoration(
                      //                     border: InputBorder.none,
                      //                     hintText: "0",
                      //                     hintStyle: TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w500,
                      //                         color: myColors.grey_26,
                      //                         fontFamily:
                      //                         "assets/fonts/Poppins/Poppins-Regular.ttf"),
                      //                     isDense: true,
                      //                     // this will remove the default content padding
                      //                     contentPadding:
                      //                     EdgeInsets.fromLTRB(16, 1, 0, 0)),
                      //                 maxLines: 1,
                      //                 cursorColor: myColors.grey_26,
                      //               ),
                      //             ),
                      //
                      //             Container(
                      //               height: 1,
                      //               margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      //               color: myColors.grey_25,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      ///Manufacturer...........................................
                      //  typeController.text == "Stock Item" ?Container():
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  //   width: 75,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(MyString.Manufacturer, myColors.black, FontWeight.w500, 12, 2, TextAlign.center),
                                ),
                                SizedBox(width: 3,),
                                Container(
                                  width: 5,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                              ],
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height:25,
                                    // margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      controller: manufectureController,
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
                                        'assets/fonts/Poppins/Poppins-Regular.ttf',
                                        color: myColors.grey_26,
                                      ),

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_26,
                                              fontFamily:
                                              "assets/fonts/Poppins/Poppins-Regular.ttf"),
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
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Model...........................................
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 75,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(MyString.Model, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                            ),
                            Container(
                              width: 5,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height:25,
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      controller: modelController,
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
                                        'assets/fonts/Poppins/Poppins-Regular.ttf',
                                        color: myColors.grey_26,
                                      ),

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_26,
                                              fontFamily:
                                              "assets/fonts/Poppins/Poppins-Regular.ttf"),
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
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15,)
                    ],
                  ),
                ),

                Row(
                  children: [
                    /// Clear All Button.....
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          requestqntfocus.unfocus();
                          quantityfocus.unfocus();
                          manufecturefocus.unfocus();
                          desfocus.unfocus();
                          setState(() {});
                          mrTypesModel = null;
                          //MrTypes(id:0,name: "Select type",code: "",description: "",groupId: 0.0);
                          manufectureController.text = "";
                          typeController.text = "";
                          spareController.text = "";
                          sparecodeId = "";
                          quantityController.text = "";
                          desController.text = "";
                          requestqntController.text = "0";
                          unitpriceController.text = "0";
                          totalpriceController.text = "";
                          manufectureController.text = "";
                          modelController.text = "";
                          desController.text = "";
                          stockId = "";
                          stockname = "";
                          manufecturer = "";
                          unitprice = "";
                          mrtypeId = "";
                          mrtypename = "";
                          mrDetailItems!.clear();
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(16, 20, 16, 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: myColors.app_theme,
                          ),
                          child: CustomText.CustomBoldText(
                              MyString.Clear_All,
                              myColors.white,
                              FontWeight.w700,
                              14,
                              1,
                              TextAlign.center),
                        ),
                      ),
                    ),

                    /// Add new Button.....
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {

                          requestqntfocus.unfocus();
                          quantityfocus.unfocus();
                          manufecturefocus.unfocus();
                          desfocus.unfocus();
                          setState(() {});
                          mrList.add(MR_Model("Computer"),);
                          if(mrtypeId.trim().isEmpty || mrtypeId == ""){
                            CustomToast.showToast(msg: "Please select mr type");
                          }
                          else if(desController.text.isEmpty){
                            CustomToast.showToast(msg: "Please enter description");
                          }
                          else if(requestqntController.text.trim().isEmpty || requestqntController.text == ""){
                            CustomToast.showToast(msg: "Please enter req qty");
                          }else {
                            MrDetailItems model;
                            model = MrDetailItems(
                                id: 0,
                                mrId: 0,
                                mrTypeId: int.parse(mrtypeId),
                                stockId: typeController.text == "Stock Item"  ? int.parse(stockId): 0,
                                stockName: typeController.text == "Stock Item"  ? stockname :desController.text,
                                availableQty: typeController.text == "Stock Item"  ?  int.parse(quantityController.text) : 0,
                                requiredQty:typeController.text == "Stock Item"  ?  int.parse(requestqntController.text) : int.parse(requestqntController.text),
                                unitPrice:typeController.text == "Stock Item"  ?  double.parse(unitpriceController.text) : 0,
                                totalPrice: totalpriceController.text.trim().isEmpty ? 0 : double.parse(totalpriceController.text),
                                remarks: manufecturer,
                                typename: typeController.text);
                            mrDetailItems!.add(model);

                            setState(() {});
                            if(mrDetailItems!.isNotEmpty){
                              mrTypesModel = null;
                              spareController.text = "";
                              sparecodeId = "";
                              quantityController.text = "";
                              requestqntController.text = "0";
                              unitpriceController.text = "0";
                              totalpriceController.text = "";
                              manufectureController.text = "";
                              modelController.text = "";
                              desController.text = "";
                              requestqntController.text = "0";
                              //stocksModel = null;
                              typeController.text = "";
                              mrtypeId = "";
                              setState(() {});

                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(16, 20, 16, 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: myColors.app_theme,
                          ),
                          child: CustomText.CustomBoldText(
                              MyString.ADD_NEW,
                              myColors.white,
                              FontWeight.w700,
                              14,
                              1,
                              TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 40,
                ),

                ///new list............................................
                Container(
                  height: 44,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: myColors.orange),
                    color: myColors.light_orange,
                  ),
                  child: Row(
                    children: [
                      ///S.Grp.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText(MyString.S_Grp, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),

                      ///S.Name.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText("Description", myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),

                      ///Qty.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText("Req qty", myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),

                      ///Unit Price.....................................................
                      // Expanded(
                      //     flex: 1,
                      //     child: CustomText.CustomMediumText(MyString.unit_Price, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      // ),

                      ///T Price.....................................................
                      // Expanded(
                      //     flex: 1,
                      //     child: CustomText.CustomMediumText(MyString.T_Price, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      // ),
                    ],
                  ),
                ),

                ///List................................................
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: mrDetailItems!.length,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: MR_List(index: index, mrdetail: mrDetailItems![index],mrDetailItems:mrDetailItems!, deletefunction: (){
                                mrDetailItems!.removeAt(index);
                                setState(() {});
                              },),
                            ),
                          );
                        })),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 200,
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Requestcreatemr(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: myColors.app_theme,
                        ),
                        child: CustomText.CustomBoldText(
                            MyString.Save,
                            myColors.white,
                            FontWeight.w700,
                            14,
                            1,
                            TextAlign.center),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///DropDown................

  subjectDropDown(){
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          'SG-125 : AC Equipment',
          style: TextStyle(
            fontSize: 14,
            color: Theme
                .of(context)
                .hintColor,
          ),
        ),
        iconStyleData: IconStyleData(
          icon: SvgPicture.asset(
            "assets/images/dropDown.svg",
            color: myColors.grey_five,
          ),
          iconSize: 14,
        ),
        items: subjectList
            .map((String cityTypList) =>
            DropdownMenuItem<String>(
              value: cityTypList,
              child: Text(
                cityTypList.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
            .toList(),
        value: selectBuilding,
        onChanged: (String? value) {
          setState(() {
            selectBuilding = value;
          });
        },
        buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 0),
            height: 40,
            width: 400
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 35,
        ),

      ),
    );
  }

  Quantitydropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quantity",
            style: TextStyle(
                fontSize: 12,
                color: myColors.black,
                fontFamily:  MyString.PlusJakartaSansBold,
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
                    color: myColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily:  MyString.PlusJakartaSansBold),
                //
                hint: Text(
                  '02',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily:  MyString.PlusJakartaSansBold,
                    fontWeight: FontWeight.w400,
                    color: myColors.black,
                  ),
                ),
                items: subjectList
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily:  MyString.PlusJakartaSansBold,
                      fontWeight: FontWeight.w400,
                      color: myColors.grey_five,
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
                value: selectBuilding,
                onChanged: (String? value) {
                  setState(() {
                    selectBuilding = value.toString();
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
        ],
      ),
    );
  }
  Manufaturerdropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Manufaturer",
            style: TextStyle(
                fontSize: 12,
                color: myColors.black,
                fontFamily:  MyString.PlusJakartaSansBold,
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
                    color: myColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily:  MyString.PlusJakartaSansBold,),
                //
                hint: Text(
                  'Intel',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily:  MyString.PlusJakartaSansBold,
                    fontWeight: FontWeight.w400,
                    color: myColors.black,
                  ),
                ),
                items: subjectList
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily:  MyString.PlusJakartaSansBold,
                      fontWeight: FontWeight.w400,
                      color: myColors.grey_five,
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
                value: selectBuilding,
                onChanged: (String? value) {
                  setState(() {
                    selectBuilding = value.toString();
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
        ],
      ),
    );
  }

  /// Dropdowns>>>>>>>>
  Typedropdown() {
    return  DropdownButton2<MrTypes>(
      underline: Container(height: 1,color: myColors.grey_25,),
      isExpanded: true,
      hint: Text(
        'Select type',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
          fontFamily:  MyString.PlusJakartaSansregular,
          color: myColors.grey_27,
        ),
      ),
      onChanged: ( value) async {
        //stocks!.clear();
        spareController.text = "";
        manufectureController.text = "";
        typeController.text = "";
        modelController.text = "";
        sparecodeId = "";
        quantityController.text = "";
        unitpriceController.text = "";
        reqqty = 0;
        avlqty = 0;
        totalpriceController.text = "";

        desController.text = "";
        stockId = "";
        stockname = "";
        manufecturer = "";
        unitprice = "";
        mrtypeId = "";
        mrtypename = "";
        stockId = "";
        stocksModel = null;
        requestqntController.text = "0";
        setState(() {});

        // This is called when the user selects an item.
        if (value!.name.toString() == "Select Project") {
          mrTypesModel = value;
          mrtypeId ="";
          mrtypename ="";
          typeController.text = "";
        } else {
          mrtypeId = value.id.toString();
          mrtypename = value.name.toString();
          typeController.text = value.name.toString();
          mrTypesModel = value;
          setState(() {});
        }
      },
      selectedItemBuilder: (BuildContext context) {
        return mrTypes!.map((e) {
          return Container(
            padding: EdgeInsets.only(left: 6.0),
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(minWidth: 100),
            child: Text(
              e.name.toString(),
              style: const TextStyle(
                  color: myColors.grey_27, fontWeight: FontWeight.w500,fontSize: 12),
            ),
          );
        }).toList();
      },
      items: mrTypes!
          .map((value) => DropdownMenuItem(
        value: value,
        child:Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              mrtypeId == value.id.toString() ?
              Padding(
                padding:  EdgeInsets.only(right: 0.0),
                child: Icon(Icons.check,size: 15,),
              ):
              Container(),

              Expanded(
                child: Text(
                  value.name.toString() == "Select type"?
                  value.name.toString():
                  value.name.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                    fontFamily:  MyString.PlusJakartaSansregular,
                    color:value.name.toString() == "Select Units" ? myColors.grey_27 : myColors.grey_one.withOpacity(0.90),

                  ),
                ),
              ),
            ],
          ),
        ),
      ))
          .toList(),
      value: mrTypesModel,

      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 5),
        // height: 40,
        width: 400,
      ),
      dropdownSearchData: DropdownSearchData(
        // searchController: typeController,
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
            controller: typeController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 0,
              ),
              hintText: 'Search for an item...',
              hintStyle:  TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
                fontFamily:  MyString.PlusJakartaSansregular,
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
          typeController.clear();
        }
      },
    );
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
        */
/* Navigator.pop(context);
        HESQ_Model model = HESQ_Model(
          questionId: widget.questionsModel.id.toString(),
          comments: controller.text,
          taskLogId: int.parse(widget.tasklogId.toString()),
          answerId: int.parse(answerId.toString()),
          linkId: int.parse(widget.questionsModel.id.toString()),
          imageUrl: "",
          isCheckListItem: true,
          //file:_image == null ? null : File(_image!.path.toString())
        );
        updateOrInsertHESQ(model);*/
/*

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
      */
/*  HESQ_Model model = HESQ_Model(
        questionId: widget.questionsModel.id.toString(),
        comments: controller.text,
        taskLogId: int.parse(widget.tasklogId.toString()),
        answerId: int.parse(answerId.toString()),
        linkId: int.parse(widget.questionsModel.id.toString()),
        imageUrl: "",
        isCheckListItem: true,
        //file:_image == null ? null : File(_image!.path.toString())
      );
      updateOrInsertHESQ(model);*/
/*

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
        */
/* Navigator.pop(context);
        HESQ_Model model = HESQ_Model(
          questionId: widget.questionsModel.id.toString(),
          comments: controller.text,
          taskLogId: int.parse(widget.tasklogId.toString()),
          answerId: int.parse(answerId.toString()),
          linkId: int.parse(widget.questionsModel.id.toString()),
          imageUrl: "",
          isCheckListItem: true,
          //file:_image == null ? null : File(_image!.path.toString())
        );
        updateOrInsertHESQ(model);*/
/*

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
      */
/*  HESQ_Model model = HESQ_Model(
        questionId: widget.questionsModel.id.toString(),
        comments: controller.text,
        taskLogId: int.parse(widget.tasklogId.toString()),
        answerId: int.parse(answerId.toString()),
        linkId: int.parse(widget.questionsModel.id.toString()),
        imageUrl: "",
        isCheckListItem: true,
        //file:_image == null ? null : File(_image!.path.toString())
      );
      updateOrInsertHESQ(model);*/
/*

      setState(() {});
    }

    // print("lemmnhfhg>${checkListadd.length}");
  }

  /// Spare part code.......
  Sparedropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<StocksModel>(
        isExpanded: true,
        hint: Text(
          'Select spare part code',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            fontFamily:  MyString.PlusJakartaSansregular,
            color:myColors.grey_27,
          ),
        ),
        onChanged: ( value) async {
          print("value!.code.toString()>>${value!.code.toString()}");
          setState(() {});

          // This is called when the user selects an item.
          if (value.sparePartCode.toString() == "Select Spare Part") {
            stocksModel = value;
            stockId ="";
            spareController.text = "";
            searchController.text = "";
            sparecodeId = "";
            setState(() {});
          } else {
            stockId = value.id.toString();
            stockname = value.name.toString();
            desController.text = value.name.toString();
            manufecturer = value.manufacturer.toString();
            unitprice = value.unitPrice.toString();
            unitpriceController.text = value.unitPrice.toString();
            spareController.text = value.sparePartCode.toString();
            sparecodeId = value.id.toString();
            quantityController.text = value.availableStock.toString();
            avlqty = int.parse(quantityController.text);
            setState(() {});
            stocksModel = value;
            print("djjkb>>${unitprice}");
            print("sparecodeId>>${sparecodeId}");
            setState(() {});
          }
        },
        selectedItemBuilder: (BuildContext context) {
          return stocks!.map((e) {
            return Container(
              //    padding: EdgeInsets.only(left: 8.0),
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(minWidth: 100),
              child: Text(
                e.sparePartCode.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontFamily:  MyString.PlusJakartaSansregular,
                  color: myColors.grey_27 ,
                ),
              ),
            );
          }).toList();
        },
        items: stocks!
            .map((value) => DropdownMenuItem(
          value: value,
          child:Row(
            children: [
              stockId == value.id.toString() ? Icon(Icons.check,size: 15,):Container(),
              SizedBox(width: 6,),
              Expanded(
                child: Text(
                  value.sparePartCode.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                    fontFamily:  MyString.PlusJakartaSansregular,
                    color: myColors.black,

                  ),
                ),
              ),
            ],
          ),
        ))
            .toList(),
        value: stocksModel,

        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 1),
          ///height: 40,
          width: 400,
        ),
        dropdownStyleData:  DropdownStyleData(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          maxHeight: 400,
        ),
        menuItemStyleData: const MenuItemStyleData(
          //  height: 80,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: searchController,
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
              controller: searchController,
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
                  fontFamily:  MyString.PlusJakartaSansregular,
                  color: myColors.grey_27,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value!.sparePartCode.toString().toLowerCase().contains(searchValue) ||  item.value!.sparePartCode.toString().toUpperCase().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchController.clear();
          }
        },
      ),
    );
  }

  Future<void> Requestcreatemr(
      BuildContext context,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);

    String timezone =   p.getString("timezone").toString();
    String status =   p.getString("menu_ID").toString();
    print("timezone >>${status}");
    print("urlhjhk  >>${status == "4"?
    main_base_url +AllApiServices.scheduleapi+ AllApiServices.CreateMaterialRequest:
    main_base_url + AllApiServices.StockApi+AllApiServices.CreateMaterialRequest}");

    int Reporteddate = timezone == "+04:00" ? 4 : 0;
    DateTime dateTime = DateTime.now();
    var request = {};
    if (mrDetailItems!.isEmpty) {
    } else {
      var  duedate = DateFormat.d().format(DateTime.parse(
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

      print("duedate>>${duedate}");
      setState(() {});

      request['code'] = "";
      request['costCenterId'] = null;
      request['costCodeId'] = null;
      request['createdDate'] = duedate;
      request['deptName'] = "";
      request['description'] = "";
      request['financeCodeId'] = null;
      request['id'] = 0;
      request['mrDetailItems'] = mrDetailItems!;
      request['projectId'] = widget.projectId;
      request['reportedByEmail'] ="";
      request['reportedById'] = null;
      request['reportedByMobile'] = "";
      request['reportedByName'] = "";
      request['serviceReportNo'] = "";
      request['taskLogId'] = widget.taskLogId;
      request['taskTypeId'] = widget.taskTypeId;
      request['mrDetailItems'] = [
        for(int i =0; i < mrDetailItems!.length; i++)
          if( mrDetailItems![i].typename == "Stock Item")
            {
              "id": 0,
              "mrTypeId": mrDetailItems![i].mrTypeId,
              "stockId": mrDetailItems![i].stockId,
              "stockName": mrDetailItems![i].stockName,
              "availableQty": mrDetailItems![i].availableQty,
              "requiredQty": mrDetailItems![i].requiredQty,
              "unitPrice": mrDetailItems![i].unitPrice,
              "totalPrice": mrDetailItems![i].totalPrice,
              "remarks": null}
          else
            { "id": 0,
              "mrTypeId": mrDetailItems![i].mrTypeId,
              "stockName": mrDetailItems![i].stockName,
              "availableQty": mrDetailItems![i].availableQty,
              "requiredQty": mrDetailItems![i].requiredQty,
              "unitPrice": mrDetailItems![i].unitPrice,
              "totalPrice": mrDetailItems![i].totalPrice,
              "remarks": null}];

      /// update data
      try {
        var response = await http.post(Uri.parse(
          // status == "4"?
          // main_base_url +AllApiServices.scheduleapi+ AllApiServices.CreateMaterialRequest:
            main_base_url + AllApiServices.StockApi+AllApiServices.CreateMaterialRequest
        ),
            body: convert.jsonEncode(request),

            headers: {
              'Authorization': 'Bearer ${p.getString("access_token")}',
              'Content-Type': 'application/json'
            });
        MrDetailItems model  = MrDetailItems(
          mrTypeId: int.parse(mrtypeId),);

        mrDetailItems!.remove(model);
        print("jfjgghjkjh"+mrDetailItems![0].mrId.toString());


        print("njjfgjh${json.encode({

          "code": "",
          "costCenterId": null,
          "costCodeId": null,
          "createdDate": duedate,
          "deptName": "",
          "description": "",
          "financeCodeId": null,
          "id": 0,
          "mrDetailItems": mrDetailItems,
          "projectId": 1,
          "reportedByEmail": "",
          "reportedById": null,
          "reportedByMobile": "",
          "reportedByName": "",
          "serviceReportNo": "",
          "taskLogId": 4864,
          "taskTypeId": 1


        })}");
        print("response.statusCode${response.statusCode}");
        CustomLoader.showAlertDialog(context, false);
        if (response.statusCode == 200) {

          CustomToast.showToast(msg: "Create mr succesfully");
          Navigator.pop(context);
          widget.oncallback();
        }
        else {
          CustomToast.showToast(msg: "Create mr failled");
          print(response.reasonPhrase);
        }

      } catch (e) {
        CustomLoader.showAlertDialog(context, false);
        print(e);
        throw Exception('AddOrUpdateTaskLog error ${e.toString()}');
      }
      return;
    }
  }

  Future<void> RequestIssuingStockPrice(
      BuildContext context,
      bool load,
      String TasklogId,
      String reqqty,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    load == true ? CustomLoader.showAlertDialog(context, true) : null;
    var base_url = p.getString("mainurl");
    String main_url = "${base_url.toString()}";
    var request = {};
    print("hfhjgjkgjklg${ main_url + AllApiServices.IssuingStockPrice +
        TasklogId +
        "/" +
        reqqty}");

    print("urllll>>${"http://uatcafm.smrthub.com/StockApi/api/StockIssued/IssuingStockPrice/$sparecodeId/$reqqty"}");
    try {
      var headers = {
        'Authorization': 'Bearer ${p.getString("access_token")}'
      };
      var request = http.Request('GET', Uri.parse(main_url + AllApiServices.IssuingStockPrice +  sparecodeId +"/"+reqqty));

      request.headers.addAll(headers);

      var response = await request.send();

      if (response.statusCode == 200) {
        var response2 = await http.Response.fromStream(response);
        final result = jsonDecode(response2.body) as Map<String, dynamic>;
        totalpricelist.clear();
        print("trttyutrjht"+ result.toString());
        totalpriceController.text = result['totalPrice'].toString();
        //   unitpriceController.text = result['stockPriceBatches']['unitPrice'].toString();

        TotalPriceModel totalprice = TotalPriceModel.fromJson(result);
        totalpricelist.add(totalprice);

        if(totalpricelist.isNotEmpty){
          if(totalprice.stockPriceBatches!.isNotEmpty){
            for(int i = 0 ;i < totalprice.stockPriceBatches!.length;i++ ) {
              unitpriceController.text = totalprice.stockPriceBatches![i].unitPrice.toString();
              setState(() {});
            }
          }
        }
        setState(() {});
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      load == true ? CustomLoader.showAlertDialog(context, false) : null;
      print(e);
      throw Exception('Download PDF Fail! ${e.toString()}');
    }
    return;
  }


}

///MR LIST................................
class MR_List extends StatefulWidget {
  int index;
  MrDetailItems mrdetail;
  List<MrDetailItems> mrDetailItems;
  Function deletefunction;
  MR_List({Key? key,required this.index,required this.mrdetail,required this.mrDetailItems,required this.deletefunction}) : super(key: key);

  @override
  _MR_ListState createState() => _MR_ListState();
}

class _MR_ListState extends State<MR_List> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ///S.Grp.....................................................
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      widget.deletefunction();
                      setState(() {

                      });
                    },
                    child: Container(
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(Icons.delete,color: Colors.white,size: 15,),
                        )),
                  ),
                  SizedBox(width: 10,),
                  CustomText.CustomMediumText("${widget.index+1}", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
                ],
              )
          ),

          ///S.Name.....................................................
          Expanded(
            flex: 1,
            child:Text(
              "${widget.mrdetail.stockName}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: myColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                wordSpacing: 0.1,
                fontFamily:  MyString.PlusJakartaSansmedium,
              ),
            ),

            // CustomText.CustomMediumText("${widget.mrdetail.stockName}", myColors.black, FontWeight.w700, 12, 1, )
          ),

          ///Qty.....................................................
          Expanded(
              flex: 1,
              child: CustomText.CustomMediumText("${widget.mrdetail.requiredQty}", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
          ),

          // ///Unit Price.....................................................
          // Expanded(
          //     flex: 1,
          //     child: CustomText.CustomMediumText("1000", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
          // ),
          //
          // ///T Price.....................................................
          // Expanded(
          //     flex: 1,
          //     child: CustomText.CustomMediumText("100000", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
          // ),
        ],
      ),
    );
  }

}





*/


/// ........Old code........


import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/totalPriceModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/views/PPM/ppm_mr_view_screen.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/my_string.dart';
import '../../model/models/GetMrDrtailModel.dart';
import '../../widgets/custom_texts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MR_Model {
  String title;

  MR_Model(this.title);
}
List<MR_Model> mrList = [];

class PPM_New_Material_Request_Screen extends StatefulWidget {
  String title;
  String taskLogId;
  String taskTypeId;
  String projectId;
  Function oncallback;
  PPM_New_Material_Request_Screen({Key? key,required this.title,required this.taskLogId,required this.taskTypeId,required this.projectId,required this.oncallback}) : super(key: key);

  @override
  _PPM_New_Material_Request_ScreenState createState() => _PPM_New_Material_Request_ScreenState();
}

class _PPM_New_Material_Request_ScreenState extends State<PPM_New_Material_Request_Screen> {
  TextEditingController typeController = TextEditingController();
  TextEditingController spareController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController manufectureController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController requestqntController = TextEditingController();
  TextEditingController unitpriceController = TextEditingController();
  TextEditingController totalpriceController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController modelController = TextEditingController();

  List<TotalPriceModel> totalpricelist = [];
  final quantityfocus = FocusNode();
  final manufecturefocus = FocusNode();
  final requestqntfocus = FocusNode();
  final unitpricefocus = FocusNode();
  final totalpricefocus = FocusNode();
  final desfocus = FocusNode();
  String sparecodeId = "";

  List<MrTypes>? mrTypes = [];
  List<StocksModel>? stocks = [];
  List<ProjectsStockModel>? projects = [];
  // List<CreateMrModel>? createmrlist = [];

  int avlqty = 0;
  int reqqty = 0;


  ProjectsStockModel? projectModel;
  MrTypes? mrTypesModel;
  StocksModel? stocksModel;
  String stockId = "";
  String stockname = "";
  String manufecturer = "";
  String unitprice = "";
  String mrtypeId = "";
  String mrtypename = "";
  List<MrStockModel> mrstocklist = [];
  List<MrDetailItems>? mrDetailItems = [];
  List<MrDetails>? mrDetailslist = [];


  @override
  void initState() {
    super.initState();
    getmrdetailApi();
  }


  getmrdetailApi()async{
    mrDetailslist!.clear();
    mrstocklist.clear();
    mrTypes!.clear();
    stocks!.clear();
    setState(() {});
    await Webservices.RequestGetMRDetailsByTaskId(context, true, widget.taskLogId, widget.taskTypeId, widget.projectId,mrstocklist,mrTypes,stocks,mrDetailslist);
    setState(() {});
    print("mrlist>>>${mrTypes!.length}");
    requestqntController.text = "0";
    for(int i =0; i< stocks!.length; i++ ){
      print("stock code >> ${stocks![i].sparePartCode}");
    }

  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return GestureDetector(
      onTap: (){
        requestqntfocus.unfocus();
        quantityfocus.unfocus();
        manufecturefocus.unfocus();
        desfocus.unfocus();
        setState(() {});
      },
      child: MediaQuery(
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
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              widget.oncallback();
                              setState(() {});
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
                                    "Material Request",
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
                  child: CustomText.CustomSemiBoldText(MyString.New_Material_Request,
                      myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
                ),

                ///Type.............................................
                Container(
                  // height: 55,
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 12),
                  padding: EdgeInsets.fromLTRB(18, 14, 18, 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: myColors.app_theme),
                      color: myColors.purple.withOpacity(0.90),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 75,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(MyString.Type, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                          ),
                          Container(
                            width: 5,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                          ),
                          SizedBox(width: 10,)
                        ],
                      ),

                      Expanded(
                        child: Column(
                          children: [

                            Typedropdown(),
                            /* Container(
                            //  height: 25,
                              padding: EdgeInsets.only(bottom: 5),
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
                                  'assets/fonts/Poppins/Poppins-Regular.ttf',
                                  color: myColors.grey_26,
                                ),

                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: MyString.Stock,
                                    hintStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: myColors.grey_26,
                                        fontFamily:
                                        "assets/fonts/Poppins/Poppins-Regular.ttf"),
                                    isDense: true,
                                    // this will remove the default content padding
                                    contentPadding:
                                    EdgeInsets.fromLTRB(16, 1, 0, 0)),
                                maxLines: 1,
                                cursorColor: myColors.grey_26,
                              ),
                            ),*/

                            // Container(
                            //   height: 1,
                            //   margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                            //   color: myColors.grey_25,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ///Form.............................................
                Container(
                  // height: 330,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: myColors.app_theme),
                    color: myColors.purple.withOpacity(0.90),
                  ),
                  child: Column(
                    children: [
                      ///Spare part code...........................................
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 75,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText("Spare part code", myColors.black, FontWeight.w500, 12, 2, TextAlign.start),
                                ),

                                Container(
                                  width: 5,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                                SizedBox(width: 10,),
                              ],
                            ),

                            Expanded(
                              child: Column(
                                children: [


                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:  typeController.text == "Stock Item" ?
                                    Sparedropdown()
                                        :Container(),
                                  ),


                                  // Container(
                                  //   height: 1,
                                  //   margin: EdgeInsets.fromLTRB(12, 5, 0, 0),
                                  //   color: myColors.grey_25,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Description...........................................

                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 83,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(
                                  MyString.Description,
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
                                  FontWeight.w500,
                                  12,
                                  1,
                                  TextAlign.center),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: typeController.text == "Stock Item"
                                    ? Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child:
                                      SparepartDescriptiondropdown(),
                                    ),
                                    Container(
                                      height: 1,
                                      margin: EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      color: myColors.grey_25,
                                    ),
                                  ],
                                )
                                    : Column(
                                  children: [
                                    Container(
                                      height: 25,
                                      margin: EdgeInsets.only(top: 10),
                                      alignment: Alignment.topLeft,
                                      child: TextField(
                                        controller: desController,
                                        focusNode: desfocus,
                                        enabled: typeController.text ==
                                            "Stock Item"
                                            ? false
                                            : true,
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
                                          'assets/fonts/Poppins/Poppins-Regular.ttf',
                                          color: myColors.grey_26,
                                        ),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter description",
                                            hintStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.w500,
                                                color: myColors.grey_26,
                                                fontFamily:
                                                "assets/fonts/Poppins/Poppins-Regular.ttf"),
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
                                      margin: EdgeInsets.fromLTRB(
                                          12, 0, 0, 0),
                                      color: myColors.grey_25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Avt Quantity...........................................
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 75,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText("Avt Qty.", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                                Container(
                                  width: 5,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                                // SizedBox(width: 10,)
                              ],
                            ),
                            //typeController.text != "Stock Item" ?Container():
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height:25,
                                    // margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      enabled: typeController.text == "Stock Item" ? false:false,
                                      controller: quantityController,
                                      focusNode: quantityfocus,
                                      keyboardType: TextInputType.text,
                                      onChanged: (String value) {
                                        print("TAG" + value);
                                        avlqty = int.parse(quantityController.text);
                                        setState(() {});

                                      },
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.none,
                                        fontFamily:
                                        'assets/fonts/Poppins/Poppins-Regular.ttf',
                                        color: myColors.grey_26,
                                      ),

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "0",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_26,
                                              fontFamily:
                                              "assets/fonts/Poppins/Poppins-Regular.ttf"),
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
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Req qty...........................................
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 75,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText("Req Qty.", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                                Container(
                                  width: 5,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                                // SizedBox(width: 10,)
                              ],
                            ),

                            typeController.text == "Stock Item" ?
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          controller: requestqntController,
                                          enabled: false,
                                          focusNode: requestqntfocus,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "0",
                                              hintStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: myColors.grey_26,
                                                  fontFamily:
                                                  "assets/fonts/Poppins/Poppins-Regular.ttf"),
                                              isDense: true,
                                              // this will remove the default content padding
                                              contentPadding:
                                              EdgeInsets.fromLTRB(16, 1, 0, 0)),
                                          cursorColor: myColors.grey_26,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none,
                                            fontFamily:
                                            'assets/fonts/Poppins/Poppins-Regular.ttf',
                                            color: myColors.grey_26,
                                          ),
                                          keyboardType: TextInputType.numberWithOptions(
                                              decimal: false, signed: false),
                                          // inputFormatters: <TextInputFormatter>[
                                          //   WhitelistingTextInputFormatter.digitsOnly
                                          // ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                              print("avlqty>>${avlqty}");
                                              print("reqqty>>${reqqty}");
                                              reqqty = int.parse(requestqntController.text);
                                              setState(() {});
                                              if(avlqty <= reqqty){

                                              }else{
                                                int currentValue = int.parse(requestqntController.text);
                                                setState(() {
                                                  currentValue++;
                                                  requestqntController.text =
                                                      (currentValue).toString(); // incrementing value
                                                });

                                                totalpricelist.clear();
                                                RequestIssuingStockPrice(context,false,widget.taskLogId.toString(),requestqntController.text);
                                                setState(() {});
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:myColors.app_theme,
                                                  borderRadius: BorderRadius.circular(3)
                                              ),
                                              height: 20,
                                              alignment: Alignment.center,

                                              child: Icon(Icons.arrow_drop_up,color: Colors.white,),
                                            ),
                                          ),

                                          SizedBox(height: 5,),

                                          GestureDetector(
                                            onTap: (){
                                              if(requestqntController.text == "0"){
                                              }else{
                                                int currentValue = int.parse(requestqntController.text);
                                                setState(() {
                                                  print("Setting state");
                                                  currentValue--;
                                                  requestqntController.text =
                                                      (currentValue).toString(); // decrementing value
                                                });

                                                totalpricelist.clear();
                                                RequestIssuingStockPrice(context,false,widget.taskLogId.toString(),requestqntController.text);
                                                setState(() {});
                                                // if(totalpricelist.isNotEmpty){
                                                //   totalpriceController.text = totalpricelist.first.totalPrice.toString();
                                                //   setState(() {});
                                                // }

                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:myColors.app_theme,
                                                  borderRadius: BorderRadius.circular(3)
                                              ),
                                              height: 20,
                                              alignment: Alignment.center,

                                              child: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                            ),
                                          ),

                                          SizedBox(height: 2,),
                                          // IconButton(
                                          //  //   minWidth: 10.0,
                                          //   icon: Icon(Icons.arrow_drop_down,size: 40,),
                                          //   onPressed: () {
                                          //
                                          //
                                          //   },
                                          // ),
                                        ],
                                      ),
                                      // Spacer(
                                      //   flex: 2,
                                      // )
                                    ],
                                  ),

                                  Container(
                                    height: 1,
                                    margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            ):
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          controller: requestqntController,
                                          enabled: false,
                                          focusNode: requestqntfocus,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "0",
                                              hintStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: myColors.grey_26,
                                                  fontFamily:
                                                  "assets/fonts/Poppins/Poppins-Regular.ttf"),
                                              isDense: true,
                                              // this will remove the default content padding
                                              contentPadding:
                                              EdgeInsets.fromLTRB(16, 1, 0, 0)),
                                          cursorColor: myColors.grey_26,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none,
                                            fontFamily:
                                            'assets/fonts/Poppins/Poppins-Regular.ttf',
                                            color: myColors.grey_26,
                                          ),
                                          keyboardType: TextInputType.numberWithOptions(
                                              decimal: false, signed: false),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                              print("avlqty>>${avlqty}");
                                              print("reqqty>>${reqqty}");
                                              reqqty = int.parse(requestqntController.text);

                                              int currentValue = int.parse(requestqntController.text);
                                              setState(() {
                                                currentValue++;
                                                requestqntController.text =
                                                    (currentValue).toString(); // incrementing value
                                              });
                                              totalpricelist.clear();
                                              RequestIssuingStockPrice(context,false,widget.taskLogId.toString(),requestqntController.text);
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:myColors.app_theme,
                                                  borderRadius: BorderRadius.circular(3)
                                              ),
                                              height: 20,
                                              alignment: Alignment.center,

                                              child: Icon(Icons.arrow_drop_up,color: Colors.white,),
                                            ),
                                          ),

                                          SizedBox(height: 5,),

                                          GestureDetector(
                                            onTap: (){

                                              int currentValue = int.parse(requestqntController.text);
                                              setState(() {
                                                print("Setting state");
                                                currentValue--;
                                                requestqntController.text =
                                                    (currentValue).toString(); // decrementing value
                                              });

                                              totalpricelist.clear();
                                              RequestIssuingStockPrice(context,false,widget.taskLogId.toString(),requestqntController.text);
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:myColors.app_theme,
                                                  borderRadius: BorderRadius.circular(3)
                                              ),
                                              height: 20,
                                              alignment: Alignment.center,

                                              child: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                            ),
                                          ),

                                          SizedBox(height: 2,),
                                          // IconButton(
                                          //  //   minWidth: 10.0,
                                          //   icon: Icon(Icons.arrow_drop_down,size: 40,),
                                          //   onPressed: () {
                                          //
                                          //
                                          //   },
                                          // ),
                                        ],
                                      ),
                                      // Spacer(
                                      //   flex: 2,
                                      // )
                                    ],
                                  ),

                                  Container(
                                    height: 1,
                                    margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            )
                            //     :
                            // Expanded(
                            //   child: Column(
                            //     children: [
                            //       Container(
                            //         height:25,
                            //         // / margin: EdgeInsets.only(top: 10),
                            //         alignment: Alignment.topLeft,
                            //         child: TextField(
                            //           controller:requestqntController ,
                            //           focusNode: requestqntfocus,
                            //
                            //           keyboardType: TextInputType.number,
                            //           onChanged: (String value) {
                            //             if( typeController.text != "Stock Item"){
                            //               var req = double.parse(value);
                            //               var unitprice = double.parse(unitpriceController.text);
                            //               var  total = req * unitprice;
                            //               totalpriceController.text = total.toString();
                            //               setState(() {});
                            //               print("total >>>${total}");
                            //             }
                            //
                            //
                            //           },
                            //           style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w500,
                            //             decoration: TextDecoration.none,
                            //             fontFamily:
                            //             'assets/fonts/Poppins/Poppins-Regular.ttf',
                            //             color: myColors.grey_26,
                            //           ),
                            //
                            //           decoration: InputDecoration(
                            //               border: InputBorder.none,
                            //               hintText: "0",
                            //               hintStyle: TextStyle(
                            //                   fontSize: 12,
                            //                   fontWeight: FontWeight.w500,
                            //                   color: myColors.grey_26,
                            //                   fontFamily:
                            //                   "assets/fonts/Poppins/Poppins-Regular.ttf"),
                            //               isDense: true,
                            //               // this will remove the default content padding
                            //               contentPadding:
                            //               EdgeInsets.fromLTRB(16, 1, 0, 0)),
                            //           maxLines: 1,
                            //           cursorColor: myColors.grey_26,
                            //         ),
                            //       ),
                            //
                            //       Container(
                            //         height: 1,
                            //         margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                            //         color: myColors.grey_25,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),


                      /// Hide total price and
                      // ///Unit Price...........................................
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                      //   child: Row(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Container(
                      //             width: 75,
                      //             alignment: Alignment.topLeft,
                      //             child: CustomText.CustomMediumText("Unit price", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                      //           ),
                      //           Container(
                      //             width: 5,
                      //             alignment: Alignment.topLeft,
                      //             child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                      //           ),
                      //           // SizedBox(width: 10,)
                      //         ],
                      //       ),
                      //
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             Container(
                      //               height:25,
                      //               // / margin: EdgeInsets.only(top: 10),
                      //               alignment: Alignment.topLeft,
                      //               child: TextField(
                      //                 controller:unitpriceController ,
                      //                 enabled: typeController.text != "Stock Item" ? true :false,
                      //                 focusNode: unitpricefocus,
                      //                 keyboardType: TextInputType.number,
                      //                 onChanged: (String value) {
                      //                   if(typeController.text != "Stock Item"){
                      //                     var req = double.parse(requestqntController.text);
                      //                     var unitprice = double.parse(value);
                      //                     var  total = req * unitprice;
                      //                     totalpriceController.text = total.toString();
                      //                     setState(() {});
                      //                     print("total >>>${total}");
                      //                     setState(() {});
                      //                   }
                      //
                      //                 },
                      //                 style: TextStyle(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w500,
                      //                   decoration: TextDecoration.none,
                      //                   fontFamily:
                      //                   'assets/fonts/Poppins/Poppins-Regular.ttf',
                      //                   color: myColors.grey_26,
                      //                 ),
                      //
                      //                 decoration: InputDecoration(
                      //                     border: InputBorder.none,
                      //                     hintText: "0",
                      //                     hintStyle: TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w500,
                      //                         color: myColors.grey_26,
                      //                         fontFamily:
                      //                         "assets/fonts/Poppins/Poppins-Regular.ttf"),
                      //                     isDense: true,
                      //                     // this will remove the default content padding
                      //                     contentPadding:
                      //                     EdgeInsets.fromLTRB(16, 1, 0, 0)),
                      //                 maxLines: 1,
                      //                 cursorColor: myColors.grey_26,
                      //               ),
                      //             ),
                      //
                      //             Container(
                      //               height: 1,
                      //               margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      //               color: myColors.grey_25,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      //     ///Total Price...........................................
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 75,
                      //         alignment: Alignment.topLeft,
                      //         child: CustomText.CustomMediumText(MyString.Total_Price, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                      //       ),
                      //       Container(
                      //         width: 5,
                      //         alignment: Alignment.topLeft,
                      //         child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                      //       ),
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             Container(
                      //               height:25,
                      //               margin: EdgeInsets.only(top: 10),
                      //               alignment: Alignment.topLeft,
                      //               child: TextField(
                      //                 keyboardType: TextInputType.text,
                      //                 controller: totalpriceController,
                      //                 focusNode: totalpricefocus,
                      //                 enabled: typeController.text != "Stock Item" ? true :false,
                      //                 onChanged: (String value) {
                      //                   print("TAG" + value);
                      //                   setState(() {});
                      //                 },
                      //                 style: TextStyle(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w500,
                      //                   decoration: TextDecoration.none,
                      //                   fontFamily:
                      //                   'assets/fonts/Poppins/Poppins-Regular.ttf',
                      //                   color: myColors.grey_26,
                      //                 ),
                      //
                      //                 decoration: InputDecoration(
                      //                     border: InputBorder.none,
                      //                     hintText: "0",
                      //                     hintStyle: TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w500,
                      //                         color: myColors.grey_26,
                      //                         fontFamily:
                      //                         "assets/fonts/Poppins/Poppins-Regular.ttf"),
                      //                     isDense: true,
                      //                     // this will remove the default content padding
                      //                     contentPadding:
                      //                     EdgeInsets.fromLTRB(16, 1, 0, 0)),
                      //                 maxLines: 1,
                      //                 cursorColor: myColors.grey_26,
                      //               ),
                      //             ),
                      //
                      //             Container(
                      //               height: 1,
                      //               margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      //               color: myColors.grey_25,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      ///Manufacturer...........................................
                      //  typeController.text == "Stock Item" ?Container():
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  //   width: 75,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(MyString.Manufacturer, myColors.black, FontWeight.w500, 12, 2, TextAlign.center),
                                ),
                                SizedBox(width: 3,),
                                Container(
                                  width: 5,
                                  alignment: Alignment.topLeft,
                                  child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                                ),
                              ],
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height:25,
                                    // margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      controller: manufectureController,
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
                                        'assets/fonts/Poppins/Poppins-Regular.ttf',
                                        color: myColors.grey_26,
                                      ),

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_26,
                                              fontFamily:
                                              "assets/fonts/Poppins/Poppins-Regular.ttf"),
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
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Model...........................................
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 75,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(MyString.Model, myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                            ),
                            Container(
                              width: 5,
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomMediumText(":", myColors.black, FontWeight.w500, 12, 1, TextAlign.center),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height:25,
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      controller: modelController,
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
                                        'assets/fonts/Poppins/Poppins-Regular.ttf',
                                        color: myColors.grey_26,
                                      ),

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "",
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: myColors.grey_26,
                                              fontFamily:
                                              "assets/fonts/Poppins/Poppins-Regular.ttf"),
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
                                    color: myColors.grey_25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15,)
                    ],
                  ),
                ),

                Row(
                  children: [


                    /// Add new Button.....
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {

                          requestqntfocus.unfocus();
                          quantityfocus.unfocus();
                          manufecturefocus.unfocus();
                          desfocus.unfocus();
                          setState(() {});
                          mrList.add(MR_Model("Computer"),);
                          if(mrtypeId.trim().isEmpty || mrtypeId == ""){
                            CustomToast.showToast(msg: "Please select mr type");
                          }
                          else if(desController.text.isEmpty){
                            CustomToast.showToast(msg: "Please enter description");
                          }
                          else if(requestqntController.text.trim().isEmpty || requestqntController.text == ""){
                            CustomToast.showToast(msg: "Please enter req qty");
                          }else {
                            MrDetailItems model;
                            model = MrDetailItems(
                                id: 0,
                                mrId: 0,
                                mrTypeId: int.parse(mrtypeId),
                                stockId: typeController.text == "Stock Item"  ? int.parse(stockId): 0,
                                stockName: typeController.text == "Stock Item"  ? stockname :desController.text,
                                availableQty: typeController.text == "Stock Item"  ?  int.parse(quantityController.text) : 0,
                                requiredQty:typeController.text == "Stock Item"  ?  int.parse(requestqntController.text) : int.parse(requestqntController.text),
                                unitPrice:typeController.text == "Stock Item"  ?  double.parse(unitpriceController.text) : 0,
                                totalPrice: totalpriceController.text.trim().isEmpty ? 0 : double.parse(totalpriceController.text),
                                remarks: manufecturer,
                                typename: typeController.text);
                            mrDetailItems!.add(model);

                            setState(() {});
                            if(mrDetailItems!.isNotEmpty){
                              mrTypesModel = null;
                              spareController.text = "";
                              sparecodeId = "";
                              quantityController.text = "";
                              requestqntController.text = "0";
                              unitpriceController.text = "0";
                              totalpriceController.text = "";
                              manufectureController.text = "";
                              modelController.text = "";
                              desController.text = "";
                              requestqntController.text = "0";
                              //stocksModel = null;
                              typeController.text = "";
                              mrtypeId = "";
                              setState(() {});

                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(16, 20, 16, 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: myColors.app_theme,
                          ),
                          child: CustomText.CustomBoldText(
                              MyString.ADD_NEW,
                              myColors.white,
                              FontWeight.w700,
                              14,
                              1,
                              TextAlign.center),
                        ),
                      ),
                    ),
                    /// Clear All Button.....
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          requestqntfocus.unfocus();
                          quantityfocus.unfocus();
                          manufecturefocus.unfocus();
                          desfocus.unfocus();
                          setState(() {});
                          mrTypesModel = null;
                          //MrTypes(id:0,name: "Select type",code: "",description: "",groupId: 0.0);
                          manufectureController.text = "";
                          typeController.text = "";
                          spareController.text = "";
                          sparecodeId = "";
                          quantityController.text = "";
                          desController.text = "";
                          requestqntController.text = "0";
                          unitpriceController.text = "0";
                          totalpriceController.text = "";
                          manufectureController.text = "";
                          modelController.text = "";
                          desController.text = "";
                          stockId = "";
                          stockname = "";
                          manufecturer = "";
                          unitprice = "";
                          mrtypeId = "";
                          mrtypename = "";
                          mrDetailItems!.clear();
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(16, 20, 16, 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: myColors.app_theme,
                          ),
                          child: CustomText.CustomBoldText(
                              MyString.Clear_All,
                              myColors.white,
                              FontWeight.w700,
                              14,
                              1,
                              TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 40,
                ),

                ///new list............................................
                Container(
                  height: 44,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: myColors.app_theme),
                    color: myColors.light_blue.withOpacity(0.40),
                  ),
                  child: Row(
                    children: [
                      ///S.Grp.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText(MyString.S_Grp, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),

                      ///S.Name.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText("Description", myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),

                      ///Qty.....................................................
                      Expanded(
                          flex: 1,
                          child: CustomText.CustomMediumText("Req qty", myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      ),

                      ///Unit Price.....................................................
                      // Expanded(
                      //     flex: 1,
                      //     child: CustomText.CustomMediumText(MyString.unit_Price, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      // ),

                      ///T Price.....................................................
                      // Expanded(
                      //     flex: 1,
                      //     child: CustomText.CustomMediumText(MyString.T_Price, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                      // ),
                    ],
                  ),
                ),

                ///List................................................
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: mrDetailItems!.length,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: MR_List(index: index, mrdetail: mrDetailItems![index],mrDetailItems:mrDetailItems!, deletefunction: (){
                                mrDetailItems!.removeAt(index);
                                setState(() {});
                              },),
                            ),
                          );
                        })),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        if(mrDetailItems!.isEmpty){
                          CustomToast.showToast(msg: "No any Mr add please add first mr.");
                        }else{
                          Requestcreatemr(context);
                        }

                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: myColors.app_theme,
                        ),
                        child: CustomText.CustomBoldText(
                            MyString.Save,
                            myColors.white,
                            FontWeight.w700,
                            14,
                            1,
                            TextAlign.center),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// Dropdowns>>>>>>>>
  Typedropdown() {
    return  DropdownButton2<MrTypes>(
      underline: Container(height: 1,color: myColors.grey_25,),
      isExpanded: true,
      hint: Text(
        'Select type',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
          fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
          color: myColors.grey_27,
        ),
      ),
      onChanged: ( value) async {
        //stocks!.clear();
        spareController.text = "";
        manufectureController.text = "";
        typeController.text = "";
        modelController.text = "";
        sparecodeId = "";
        quantityController.text = "";
        unitpriceController.text = "";
        reqqty = 0;
        avlqty = 0;
        totalpriceController.text = "";

        desController.text = "";
        stockId = "";
        stockname = "";
        manufecturer = "";
        unitprice = "";
        mrtypeId = "";
        mrtypename = "";
        stockId = "";
        stocksModel = null;
        requestqntController.text = "0";
        setState(() {});

        // This is called when the user selects an item.
        if (value!.name.toString() == "Select Project") {
          mrTypesModel = value;
          mrtypeId ="";
          mrtypename ="";
          typeController.text = "";
        } else {
          mrtypeId = value.id.toString();
          mrtypename = value.name.toString();
          typeController.text = value.name.toString();
          mrTypesModel = value;
          setState(() {});
        }
      },
      selectedItemBuilder: (BuildContext context) {
        return mrTypes!.map((e) {
          return Container(
            padding: EdgeInsets.only(left: 6.0),
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(minWidth: 100),
            child: Text(
              e.name.toString(),
              style: const TextStyle(
                  color: myColors.grey_27, fontWeight: FontWeight.w500,fontSize: 12),
            ),
          );
        }).toList();
      },
      items: mrTypes!
          .map((value) => DropdownMenuItem(
        value: value,
        child:Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              mrtypeId == value.id.toString() ?
              Padding(
                padding:  EdgeInsets.only(right: 0.0),
                child: Icon(Icons.check,size: 15,),
              ):
              Container(),

              Expanded(
                child: Text(
                  value.name.toString() == "Select type"?
                  value.name.toString():
                  value.name.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                    fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
                    color:value.name.toString() == "Select Units" ? myColors.grey_27 : myColors.grey_one.withOpacity(0.90),

                  ),
                ),
              ),
            ],
          ),
        ),
      ))
          .toList(),
      value: mrTypesModel,

      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 5),
        // height: 40,
        width: 400,
      ),
      dropdownSearchData: DropdownSearchData(
        // searchController: typeController,
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
            controller: typeController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 0,
              ),
              hintText: 'Search for an item...',
              hintStyle:  TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
                fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
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
          typeController.clear();
        }
      },
    );
  }

  /// Spare part code.......
  Sparedropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<StocksModel>(
        isExpanded: true,
        hint: Text(
          'Select spare part code',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
            color:myColors.grey_27,
          ),
        ),
        onChanged: ( value) async {
          print("value!.code.toString()>>${value!.code.toString()}");
          setState(() {});

          // This is called when the user selects an item.
          if (value.sparePartCode.toString() == "Select Spare Part") {
            stocksModel = value;
            stockId ="";
            spareController.text = "";
            searchController.text = "";
            sparecodeId = "";
            setState(() {});
          } else {
            stockId = value.id.toString();
            stockname = value.name.toString();
            desController.text = value.name.toString();
            manufecturer = value.manufacturer.toString();
            unitprice = value.unitPrice.toString();
            unitpriceController.text = value.unitPrice.toString();
            spareController.text = value.sparePartCode.toString();
            sparecodeId = value.id.toString();
            quantityController.text = value.availableStock.toString();
            avlqty = int.parse(quantityController.text);
            setState(() {});
            stocksModel = value;
            print("djjkb>>${unitprice}");
            print("sparecodeId>>${sparecodeId}");
            setState(() {});
          }
        },
        selectedItemBuilder: (BuildContext context) {
          return stocks!.map((e) {
            return Container(
              //    padding: EdgeInsets.only(left: 8.0),
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(minWidth: 100),
              child: Text(
                e.sparePartCode.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
                  color: myColors.grey_27 ,
                ),
              ),
            );
          }).toList();
        },
        items: stocks!
            .map((value) => DropdownMenuItem(
          value: value,
          child:Row(
            children: [
              stockId == value.id.toString() ? Icon(Icons.check,size: 15,):Container(),
              SizedBox(width: 6,),
              Expanded(
                child: Text(
                  value.sparePartCode.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                    fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
                    color: myColors.black,

                  ),
                ),
              ),
            ],
          ),
        ))
            .toList(),
        value: stocksModel,

        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 1),
          ///height: 40,
          width: 400,
        ),
        dropdownStyleData:  DropdownStyleData(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          maxHeight: 400,
        ),
        menuItemStyleData: const MenuItemStyleData(
          //  height: 80,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: searchController,
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
              controller: searchController,
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
                  fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
                  color: myColors.grey_27,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value!.sparePartCode.toString().toLowerCase().contains(searchValue) ||  item.value!.sparePartCode.toString().toUpperCase().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchController.clear();
          }
        },
      ),
    );
  }

  /// Spare part Description.......
  SparepartDescriptiondropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<StocksModel>(
        isExpanded: true,
        hint: Text(
          'Select stock',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
            color: myColors.grey_27,
          ),
        ),
        onChanged: (value) async {
          if (value!.sparePartCode.toString() == "Select Spare Part") {
            stocksModel = value;
            stockId = "";
            spareController.text = "";
            searchController.text = "";
            sparecodeId = "";
            setState(() {});
          } else {
            stockId = value.id.toString();
            stockname = value.name.toString();
            desController.text = value.name.toString();
            manufecturer = value.manufacturer.toString();
            unitprice = value.unitPrice.toString();
            unitpriceController.text = value.unitPrice.toString();
            spareController.text = value.sparePartCode.toString();
            sparecodeId = value.id.toString();
            quantityController.text = value.availableStock.toString();
            avlqty = int.parse(quantityController.text);
            setState(() {});
            stocksModel = value;
            setState(() {});
          }
        },
        selectedItemBuilder: (BuildContext context) {
          return stocks!.map((e) {
            return Container(
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(minWidth: 100),
              child: Text(
                e.name.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
                  color: myColors.grey_27,
                ),
              ),
            );
          }).toList();
        },
        items: stocks!
            .map((value) => DropdownMenuItem(
          value: value,
          child: Row(
            children: [
              stockId == value.id.toString()
                  ? Icon(
                Icons.check,
                size: 15,
              )
                  : Container(),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Text(
                  value.name.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                    fontFamily:
                    'assets/fonts/Poppins/Poppins-Regular.ttf',
                    color: myColors.black,
                  ),
                ),
              ),
            ],
          ),
        ))
            .toList(),
        value: stocksModel,

        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 1),

          ///height: 40,
          width: 400,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          maxHeight: 400,
        ),
        menuItemStyleData: const MenuItemStyleData(),
        dropdownSearchData: DropdownSearchData(
          searchController: searchController,
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
              controller: searchController,
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
                  fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
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
            searchController.clear();
          }
        },
      ),
    );
  }

  Future<void> Requestcreatemr1(
      BuildContext context,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);

    String timezone =   p.getString("timezone").toString();
    String status =   p.getString("menu_ID").toString();
    print("timezone >>${status}");

    // >http://uatcafm.smrthub.com/StockApi/api/MaterialRequest/CreateMaterialRequest
    //http://uatcafm.smrthub.com/StockApi/api/MaterialRequest/CreateMaterialRequest
    print("urlhjhk  >>${ main_base_url + "StockApi/api/MaterialRequest/CreateMaterialRequest"}");

    int Reporteddate = timezone == "+04:00" ? 4 : 0;
    DateTime dateTime = DateTime.now();
    var request = {};
    if (mrDetailItems!.isEmpty) {
    } else {
      var  duedate = DateFormat.d().format(DateTime.parse(
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

      print("duedate>>${duedate}");
      setState(() {});

      request['code'] = "";
      request['costCenterId'] = null;
      request['costCodeId'] = null;
      request['createdDate'] = duedate;
      request['deptName'] = "";
      request['description'] = "";
      request['financeCodeId'] = null;
      request['id'] = 0;
      request['mrDetailItems'] = mrDetailItems!;
      request['projectId'] = widget.projectId;
      request['reportedByEmail'] ="";
      request['reportedById'] = null;
      request['reportedByMobile'] = "";
      request['reportedByName'] = "";
      request['serviceReportNo'] = "";
      request['taskLogId'] = widget.taskLogId;
      request['taskTypeId'] = widget.taskTypeId;
      request['mrDetailItems'] = [
        for(int i =0; i < mrDetailItems!.length; i++)
          if( mrDetailItems![i].typename == "Stock Item")
            {
              "id": 0,
              "mrTypeId": mrDetailItems![i].mrTypeId,
              "stockId": mrDetailItems![i].stockId,
              "stockName": mrDetailItems![i].stockName,
              "availableQty": mrDetailItems![i].availableQty,
              "requiredQty": mrDetailItems![i].requiredQty,
              "unitPrice": mrDetailItems![i].unitPrice,
              "totalPrice": mrDetailItems![i].totalPrice,
              "remarks": null}
          else
            { "id": 0,
              "mrTypeId": mrDetailItems![i].mrTypeId,
              "stockName": mrDetailItems![i].stockName,
              "availableQty": mrDetailItems![i].availableQty,
              "requiredQty": mrDetailItems![i].requiredQty,
              "unitPrice": mrDetailItems![i].unitPrice,
              "totalPrice": mrDetailItems![i].totalPrice,
              "remarks": null}];


      print("request>>${request}");


      print("convert.jsonEncode(request)>>${convert.jsonEncode(request)}");
      print("njjfgjh${json.encode({
        for(int i =0; i < mrDetailItems!.length; i++)
          if( mrDetailItems![i].typename == "Stock Item")
            {
              "id": 0,
              "mrTypeId": mrDetailItems![i].mrTypeId,
              "stockId": mrDetailItems![i].stockId,
              "stockName": mrDetailItems![i].stockName,
              "availableQty": mrDetailItems![i].availableQty,
              "requiredQty": mrDetailItems![i].requiredQty,
              "unitPrice": mrDetailItems![i].unitPrice,
              "totalPrice": mrDetailItems![i].totalPrice,
              "remarks": null}
          else
            { "id": 0,
              "mrTypeId": mrDetailItems![i].mrTypeId,
              "stockName": mrDetailItems![i].stockName,
              "availableQty": mrDetailItems![i].availableQty,
              "requiredQty": mrDetailItems![i].requiredQty,
              "unitPrice": mrDetailItems![i].unitPrice,
              "totalPrice": mrDetailItems![i].totalPrice,
              "remarks": null}


      })}");

      /// update data
      try {
        var response = await http.post(Uri.parse(
            main_base_url + "StockApi/api/MaterialRequest/CreateMaterialRequest"
        ),
            body: convert.jsonEncode(request),

            headers: {
              'Authorization': 'Bearer ${p.getString("access_token")}',
              'Content-Type': 'application/json'
            });

        print("response.statusCode${response.statusCode}");
        CustomLoader.showAlertDialog(context, false);
        if (response.statusCode == 200) {

          CustomToast.showToast(msg: "Create mr succesfully");
          Navigator.pop(context);
          widget.oncallback();
          MrDetailItems model  = MrDetailItems(
            mrTypeId: int.parse(mrtypeId),);
          mrDetailItems!.remove(model);
        }
        else {
          CustomToast.showToast(msg: "Create mr failled");
          print(response.reasonPhrase);
        }

      } catch (e) {
        CustomLoader.showAlertDialog(context, false);
        print(e);
        throw Exception('AddOrUpdateTaskLog error ${e.toString()}');
      }
      return;
    }
  }

  Future<void> Requestcreatemr(BuildContext context) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);

    String timezone = p.getString("timezone").toString();
    String status = p.getString("menu_ID").toString();
    print("timezone >> ${status}");

    int Reporteddate = timezone == "+04:00" ? 4 : 0;
    DateTime dateTime = DateTime.now();
    var request = {};

    if (mrDetailItems!.isEmpty) {
      // Handle the case when mrDetailItems is empty, if needed.
    } else {
      var duedate = DateFormat.d().format(
          DateTime.parse(dateTime.toUtc().add(Duration(hours: 4)).toString())) +
          "-" +
          DateFormat.MMM().format(
              DateTime.parse(dateTime.toUtc().add(Duration(hours: 4)).toString())) +
          "-" +
          DateFormat.y().format(
              DateTime.parse(dateTime.toUtc().add(Duration(hours: 4)).toString())) +
          " " +
          DateFormat("HH:mm").format(
              DateTime.parse(dateTime.toUtc().add(Duration(hours: 4)).toString()));

      print("duedate >> ${duedate}");
      setState(() {});

      request['code'] = "";
      request['costCenterId'] = null;
      request['costCodeId'] = null;
      request['createdDate'] = duedate;
      request['deptName'] = "";
      request['description'] = "";
      request['financeCodeId'] = null;
      request['id'] = 0;
      request['mrDetailItems'] = mrDetailItems!;
      request['projectId'] = widget.projectId;
      request['reportedByEmail'] = "";
      request['reportedById'] = null;
      request['reportedByMobile'] = "";
      request['reportedByName'] = "";
      request['serviceReportNo'] = "";
      request['taskLogId'] = widget.taskLogId;
      request['taskTypeId'] = widget.taskTypeId;

      request['mrDetailItems'] = [
        for (int i = 0; i < mrDetailItems!.length; i++)
          if (mrDetailItems![i].typename == "Stock Item")
            {
              "id": 0,
              "mrTypeId": mrDetailItems![i].mrTypeId,
              "stockId": mrDetailItems![i].stockId,
              "stockName": mrDetailItems![i].stockName,
              "availableQty": mrDetailItems![i].availableQty,
              "requiredQty": mrDetailItems![i].requiredQty,
              "unitPrice": mrDetailItems![i].unitPrice,
              "totalPrice": mrDetailItems![i].totalPrice,
              "remarks": null
            }
          else
            {
              "id": 0,
              "mrTypeId": mrDetailItems![i].mrTypeId,
              "stockName": mrDetailItems![i].stockName,
              "availableQty": mrDetailItems![i].availableQty,
              "requiredQty": mrDetailItems![i].requiredQty,
              "unitPrice": mrDetailItems![i].unitPrice,
              "totalPrice": mrDetailItems![i].totalPrice,
              "remarks": null
            },
      ];

      print("jsonEncode(request)>>${jsonEncode(request)}");
      try {
        var response = await http.post(
          Uri.parse(main_base_url + "StockApi/api/MaterialRequest/CreateMaterialRequest"),
          body: convert.jsonEncode(request),
          headers: {
            'Authorization': 'Bearer ${p.getString("access_token")}',
            'Content-Type': 'application/json',
          },
        );
        print("jsonEncod${response.statusCode}");
        //  MrDetailItems model = MrDetailItems(mrTypeId: int.parse(mrtypeId));
        //  mrDetailItems!.remove(model);
        print("jfjgghjkjh" + mrDetailItems![0].mrId.toString());

        print("response.statusCode ${response.statusCode}");
        CustomLoader.showAlertDialog(context, false);

        if (response.statusCode == 200) {
          CustomToast.showToast(msg: "Create mr successfully");
          Navigator.pop(context);
          widget.oncallback();
        } else {
          CustomToast.showToast(msg: "Create mr failed");
          print(response.reasonPhrase);
        }
      } catch (e) {
        CustomLoader.showAlertDialog(context, false);
        print(e);
        throw Exception('AddOrUpdateTaskLog error ${e.toString()}');
      }
    }
  }


  Future<void> RequestIssuingStockPrice(
      BuildContext context,
      bool load,
      String TasklogId,
      String reqqty,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    load == true ? CustomLoader.showAlertDialog(context, true) : null;
    var base_url = p.getString("mainurl");
    String main_url = "${base_url.toString()}";
    var request = {};
    print("hfhjgjkgjklg${ main_url + AllApiServices.IssuingStockPrice +
        TasklogId +
        "/" +
        reqqty}");

    print("urllll>>${"http://uatcafm.smrthub.com/StockApi/api/StockIssued/IssuingStockPrice/$sparecodeId/$reqqty"}");
    try {
      var headers = {
        'Authorization': 'Bearer ${p.getString("access_token")}'
      };
      var request = http.Request('GET', Uri.parse(main_url + AllApiServices.IssuingStockPrice +  sparecodeId +"/"+reqqty));

      request.headers.addAll(headers);

      var response = await request.send();

      if (response.statusCode == 200) {
        var response2 = await http.Response.fromStream(response);
        final result = jsonDecode(response2.body) as Map<String, dynamic>;
        totalpricelist.clear();
        print("trttyutrjht"+ result.toString());
        totalpriceController.text = result['totalPrice'].toString();
        //   unitpriceController.text = result['stockPriceBatches']['unitPrice'].toString();

        TotalPriceModel totalprice = TotalPriceModel.fromJson(result);
        totalpricelist.add(totalprice);

        if(totalpricelist.isNotEmpty){
          if(totalprice.stockPriceBatches!.isNotEmpty){
            for(int i = 0 ;i < totalprice.stockPriceBatches!.length;i++ ) {
              unitpriceController.text = totalprice.stockPriceBatches![i].unitPrice.toString();
              setState(() {});
            }
          }
        }
        setState(() {});
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      load == true ? CustomLoader.showAlertDialog(context, false) : null;
      print(e);
      throw Exception('Download PDF Fail! ${e.toString()}');
    }
    return;
  }


}

///MR LIST................................
class MR_List extends StatefulWidget {
  int index;
  MrDetailItems mrdetail;
  List<MrDetailItems> mrDetailItems;
  Function deletefunction;
  MR_List({Key? key,required this.index,required this.mrdetail,required this.mrDetailItems,required this.deletefunction}) : super(key: key);

  @override
  _MR_ListState createState() => _MR_ListState();
}

class _MR_ListState extends State<MR_List> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ///S.Grp.....................................................
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      widget.deletefunction();
                      setState(() {

                      });
                    },
                    child: Container(
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(Icons.delete,color: Colors.white,size: 15,),
                        )),
                  ),
                  SizedBox(width: 10,),
                  CustomText.CustomMediumText("${widget.index+1}", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
                ],
              )
          ),

          ///S.Name.....................................................
          Expanded(
            flex: 1,
            child:Text(
              "${widget.mrdetail.stockName}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: myColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                wordSpacing: 0.1,
                fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",
              ),
            ),

            // CustomText.CustomMediumText("${widget.mrdetail.stockName}", myColors.black, FontWeight.w700, 12, 1, )
          ),

          ///Qty.....................................................
          Expanded(
              flex: 1,
              child: CustomText.CustomMediumText("${widget.mrdetail.requiredQty}", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
          ),

          // ///Unit Price.....................................................
          // Expanded(
          //     flex: 1,
          //     child: CustomText.CustomMediumText("1000", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
          // ),
          //
          // ///T Price.....................................................
          // Expanded(
          //     flex: 1,
          //     child: CustomText.CustomMediumText("100000", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
          // ),
        ],
      ),
    );
  }

}





