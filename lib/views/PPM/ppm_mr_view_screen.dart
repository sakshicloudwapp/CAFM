import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/GetMrDrtailModel.dart';
import 'package:fm_pro/model/models/MrItemdetailModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/views/PPM/MrDetailScreen.dart';
import 'package:fm_pro/views/PPM/ppm_new_material_request_screen.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/my_string.dart';
import '../../widgets/custom_texts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MR_Model {
  String title;

  MR_Model(this.title);
}

//List<MR_Model> mrList = [];

class PPM_MR_View extends StatefulWidget {
  String title;
  String taskLogId;
  String taskTypeId;
  String projectId;
  Function oncallback;

   PPM_MR_View({Key? key,required this.title,required this.taskLogId,required this.taskTypeId,required this.projectId,required this.oncallback}) : super(key: key);

  @override
  _PPM_MR_ViewState createState() => _PPM_MR_ViewState();
}

class _PPM_MR_ViewState extends State<PPM_MR_View> {
  List<MrTypes>? mrTypes = [];
  List<StocksModel>? stocks = [];
  List<ProjectsStockModel>? projects = [];
  List<MrStockModel> mrstocklist = [];
  List<MrDetailsModel>? mrDetailslist = [];
  List<MrDetailItemsModel>? mrDetailItems = [];

  @override
  void initState() {

    getmrdetailApi();
    super.initState();
  }


  onupdate(){
    getmrdetailApi();
    setState(() {});
  }

  getmrdetailApi()async{
    mrstocklist.clear();
    mrTypes!.clear();
    stocks!.clear();
    mrDetailslist!.clear();
    setState(() {});
    await RequestGetMRDetailsByTaskId(context, true, widget.taskLogId, widget.taskTypeId, widget.projectId,mrstocklist,mrTypes,stocks);
    setState(() {});
    print("mrlist>>>${mrDetailslist!.length}");

  }


   Future<void> RequestGetMRDetailsByTaskId(
      BuildContext context,
      bool load,
      String taskLogId,
      String taskTypeId,
      String projectId,
      List<MrStockModel> mrstocklist,
      List<MrTypes>? mrTypeslist,
      List<StocksModel>? stockslist,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    print(
        "url>>${main_base_url + AllApiServices.StockApi+ AllApiServices.GetMRDetailsByTaskId + "${taskLogId}/${taskTypeId}/${projectId}"}");
    CustomLoader.showAlertDialog(context, true);
    var request = {};
    try {
      final response = await http.get(
          Uri.parse(main_base_url +AllApiServices.StockApi+ AllApiServices.GetMRDetailsByTaskId+"${taskLogId}/${taskTypeId}/${projectId}"

          ),
          // body: convert.jsonEncode(request),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });
      print("regasg>${response.body}");
      CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      print("additionalInfo" + jsonResponse.toString());
      if (response.statusCode == 200) {
        var mrTypes = jsonResponse['mrTypes'];
        //  var stocks = jsonResponse['stocks'];
        var mrdetail = jsonResponse['mrDetails'];
        // print("stocks>>${stocks}");
        /// Types,,,,
        if(mrTypes != null) {
          mrTypes.forEach((e) {
            MrTypes mrmodel = MrTypes.fromJson(e);
            mrTypeslist!.add(mrmodel);
          });
        }


        /// Stocks,,,,,,,,
        if(mrdetail != null){
          mrdetail.forEach((e1){
            MrDetailsModel mrdetailmodel = MrDetailsModel.fromJson(e1);
            mrDetailslist!.add(mrdetailmodel);
          });
        }


        print("mrTypes>>${mrTypes}");

        print("stocks>>${stocks}");


      } else {
        print(response.reasonPhrase);
        CustomLoader.showAlertDialog(context, false);
      }
    } catch (e) {
      print(e);
      throw Exception('errorr>>>>> ${""}');
    }
    return;
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
          child:AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: myColors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            automaticallyImplyLeading: false,
            backgroundColor: myColors.white,
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
                            width: 65,
                            child: Image.asset(
                              "assets/icons/ic_newBack.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: CustomText.CustomBoldText(
                                  "MR view",
                                  myColors.black,
                                  FontWeight.w700,
                                  16,
                                  1,
                                  TextAlign.center)),
                          flex: 1,
                        ),
                        Container(
                          height: 30,
                          width: 70,
                          child: GestureDetector(
                            onTap: (){
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: PPM_New_Material_Request_Screen(title: widget.title, taskLogId: widget.taskLogId, taskTypeId: widget.taskTypeId, projectId: widget.projectId, oncallback: onupdate,),
                                withNavBar: false,
                                // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                              );
                              setState(() {});
                            },
                            child: Image.asset("assets/icons/add_ic.png",height: 30,width: 30,) ,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

             /* Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: CustomText.CustomSemiBoldText(MyString.MR_View,
                    myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
              ),*/


              ///List MR View.............................................................
              mrDetailslist!.isNotEmpty ?
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: mrDetailslist!.length,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            child: MR_View_list(index: index, mrDetails: mrDetailslist![index],),
                          ),
                        );
                      }))
              : Container(
                height: MediaQuery.of(context).size.height/1.5,
                child: Center(
                  child: Text("No Mr",style: TextStyle(fontSize: 15),),
                ),
              ),



            ],
          ),
        ),
       /* bottomNavigationBar:  Container(
          margin: EdgeInsets.only(bottom: 30),
          child: InkWell(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: PPM_New_Material_Request_Screen(title: widget.title, taskLogId: widget.taskLogId, taskTypeId: widget.taskTypeId, projectId: widget.projectId, oncallback: onupdate,),
                withNavBar: false,
                // OPTIONAL VALUE. True by default.
                pageTransitionAnimation:
                PageTransitionAnimation.fade,
              );
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              margin: EdgeInsets.fromLTRB(24, 10, 24, 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: myColors.app_theme,
              ),
              child: CustomText.CustomBoldText("Create",
                  myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
            ),
          ),
        ),*/
      ),
    );
  }
}

///MR view List......................................................................................................
class MR_View_list extends StatefulWidget {
  int index;
  MrDetailsModel mrDetails;

  MR_View_list({Key? key, required this.index, required this.mrDetails}) : super(key: key);

  @override
  _MR_View_listState createState() => _MR_View_listState();
}

class _MR_View_listState extends State<MR_View_list> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => MrDetailScreen(mrDetailItems: widget.mrDetails.mrDetailItems, mrid:widget.mrDetails.id.toString(),)));
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 90,
        padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: myColors.purple_3,
         // border: Border.all(color: myColors.app_theme),
        ),
        child: Column(
          children: [
            ///Mr No....................................................................

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 80,
                    child: CustomText.CustomRegularText(
                        MyString.Mr_No,
                        myColors.grey_eleven,
                        FontWeight.w500,
                        12,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 12,
                    child: CustomText.CustomRegularText(":", myColors.grey_eleven,
                        FontWeight.w500, 12, 1, TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: CustomText.CustomRegularText(
                          widget.mrDetails.code.toString(),
                          myColors.grey_eleven,
                          FontWeight.w500,
                          12,
                          1,
                          TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),

            ///MR Date....................................................................
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 80,
                    child: CustomText.CustomRegularText(
                        MyString.MR_Date,
                        myColors.grey_eleven,
                        FontWeight.w500,
                        12,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 12,
                    child: CustomText.CustomRegularText(":", myColors.grey_eleven,
                        FontWeight.w500, 12, 1, TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: CustomText.CustomRegularText(
                          widget.mrDetails.createdDate.toString() != "null"
                              ?DateFormat.d().format(
                              DateTime.parse(widget.mrDetails.createdDate.toString())) +
                              "-" + DateFormat.MMM().format(
                              DateTime.parse(
                                  widget.mrDetails.createdDate.toString())) +
                              "-" + DateFormat.y().format(
                              DateTime.parse(
                                  widget.mrDetails.createdDate.toString())) +
                              " " + DateFormat("HH:mm").format(
                              DateTime.parse(
                                  widget.mrDetails.createdDate.toString())): "",
                         // DateFormat.MMMEd().format(DateTime.parse(widget.mrDetails.createdDate.toString())),
                          myColors.grey_eleven,
                          FontWeight.w500,
                          12,
                          1,
                          TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),

            ///Status....................................................................
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 80,
                    child: CustomText.CustomRegularText(
                        MyString.Status,
                        myColors.grey_eleven,
                        FontWeight.w500,
                        12,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 12,
                    child: CustomText.CustomRegularText(":", myColors.grey_eleven,
                        FontWeight.w500, 12, 1, TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: CustomText.CustomRegularText(
                          "Open",
                          myColors.grey_eleven,
                          FontWeight.w500,
                          12,
                          1,
                          TextAlign.center),
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
