import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/ProjectModel.dart';
import 'package:fm_pro/model/models/scanModel.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/views/discover_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../global/my_string.dart';
import '../../model/get_all_assets_model.dart';
import '../../model/models/asset_lookupModel.dart';
import '../../widgets/custom_texts.dart';

class AssetLookupDetailScreen extends StatefulWidget {
  String assetId;
  AssetLookupDetailScreen({Key? key,required this.assetId}) : super(key: key);

  @override
  _AssetLookupDetailScreenState createState() =>
      _AssetLookupDetailScreenState();
}

class _AssetLookupDetailScreenState extends State<AssetLookupDetailScreen> {
  List<GetAllAssetsModel> getAllAssetsList = [];

  List<AssetLookupDetailModel> assetlookupdetailList = [];
  Generals? geralModel;
  List<ProjectsModel> projectlist = [];
  List<AssetScanModel> assetscanlist = [];
  List<ScanModel> scanlist = [];


  ///
  String asset_code = "";
  String asset_description = "";
  String asset_type = "";
  String system = "";
  String Tag = "";
  String manufacturer = "";
  String model = "";
  String maintainabilityType = "";
  String assetCriticality = "";
  String assetCriticalityDescription = "";
  String location = "";



  /// /// GetLocationDetailsByAssetCode  Api call....
  GetLocationDetailsByAssetCodeapi() async {
    assetscanlist.clear();
    setState(() {});
    await Webservices.RequestGetLocationDetailsByAssetCode(
        context, false, widget.assetId, assetscanlist);
    setState(() {});
    if(assetscanlist.isNotEmpty){
      print("nvnhnmjm${assetscanlist.first.assetName.toString()}");
      asset_code = assetscanlist.first.assetName.toString();
      asset_description = assetscanlist.first.description.toString();
      asset_type = assetscanlist.first.assetType.toString();
      system = assetscanlist.first.systemName.toString();
      Tag = assetscanlist.first.tag.toString();
      manufacturer = assetscanlist.first.manufacturer.toString();
      model = assetscanlist.first.model.toString();
      maintainabilityType = assetscanlist.first.maintainabilityType.toString();
      assetCriticality = assetscanlist.first.assetCriticality.toString();
      assetCriticalityDescription = assetscanlist.first.assetCriticalityDescription.toString();
      location = assetscanlist.first.buildingName.toString()+" | "+assetscanlist.first.floorName.toString()+" | "+assetscanlist.first.roomName.toString();
      setState(() {});
    }

  }

  getdetailApi() async{
    print("""""");
    assetlookupdetailList.clear();
    setState((){});
    await Webservices.RequestGetassetlookupdetail(context, assetlookupdetailList, true,widget.assetId);
    print("getdetailApi ${assetlookupdetailList.length}");
    setState((){});
  }
  @override
  void initState() {
    GetLocationDetailsByAssetCodeapi();
    // Requestscan(true);
    //  getdetailApi();

    super.initState();
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
                statusBarColor: myColors.white,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark, // For iOS (dark icons)
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
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              // alignment: Alignment.center,
                              height: 45,
                              width: 35,
                              child: Image.asset(
                                "assets/icons/ic_newBack.png",
                                height: 16,
                                width: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                child: CustomText.CustomBoldTextDM(
                                    MyString.Asset_Lookup,
                                    myColors.dark_app_theme,
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: false,
                      child: Container(
                        //   height: 200,
                        width: mediaQuerryData.size.width,
                        child: Center(
                            child: Image.asset(
                              "assets/images/img_asset_lookup.png",
                              height: 250,
                              width: mediaQuerryData.size.width,
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: CustomText.CustomSemiBoldText(
                          MyString.Asse_details,
                          myColors.dark_grey_txt,
                          FontWeight.w600,
                          14,
                          1,
                          TextAlign.center),
                    ),

                    ///Asset code.................................................................
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomSemiBoldText(
                                MyString.Asse_code,
                                myColors.dark_grey_txt,
                                FontWeight.w500,
                                14,
                                1,
                                TextAlign.center),
                          ),
                          Container(
                            width: 8,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomSemiBoldText(
                                ":",
                                myColors.black,
                                FontWeight.w500,
                                14,
                                1,
                                TextAlign.center),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: CustomText.CustomSemiBoldText(
                                  widget.assetId,
                                  myColors.dark_grey_txt,
                                  FontWeight.w500,
                                  12,
                                  2,
                                  TextAlign.start),
                            ),
                          )
                        ],
                      ),
                    ),

                    ///Description.................................................................
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomSemiBoldText(
                                MyString.Description,
                                myColors.dark_grey_txt,
                                FontWeight.w500,
                                14,
                                1,
                                TextAlign.center),
                          ),
                          Container(
                            width: 8,
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomSemiBoldText(
                                ":",
                                myColors.black,
                                FontWeight.w500,
                                14,
                                1,
                                TextAlign.center),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child:

                              CustomText.CustomSemiBoldText(
                                  asset_description,
                                  myColors.dark_grey_txt,
                                  FontWeight.w500,
                                  12,
                                  2,
                                  TextAlign.start),
                            ),
                          )
                        ],
                      ),
                    ),

                    ///Asset Type...................................................................
                    Container(
                      // height: 130,
                      margin: EdgeInsets.fromLTRB(14, 24, 14, 0),
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: myColors.newBar_1),
                        color: myColors.purple_1,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 92,
                                        child:
                                        CustomText.CustomMediumText(
                                            MyString.Asset_Type,
                                            myColors.black,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.start),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        child:
                                        CustomText.CustomMediumText(
                                            ":",
                                            myColors.black,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.start),
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(
                                        child: Container(
                                          child:Text(
                                            asset_type,
                                            style: TextStyle(
                                              color: myColors.dark_grey_txt,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.80,
                                              wordSpacing: 0.1,
                                              fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",
                                            ),
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 10,),
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 92,
                                        alignment: Alignment.centerLeft,
                                        child:
                                        CustomText.CustomMediumText(
                                            MyString.System,
                                            myColors.black,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.center),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        child:
                                        CustomText.CustomMediumText(
                                            ":",
                                            myColors.black,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.start),
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(
                                        child: Container(
                                          child:Text(
                                            system,
                                            style: TextStyle(
                                              color: myColors.dark_grey_txt,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.80,
                                              wordSpacing: 0.1,
                                              fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",
                                            ),
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 12,),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 92,
                                        child:
                                        CustomText.CustomMediumText(
                                            MyString.Tag,
                                            myColors.black,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.start),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        child:
                                        CustomText.CustomMediumText(
                                            ":",
                                            myColors.black,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.start),
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(
                                        child: Container(
                                          // margin: EdgeInsets.only(top: 6),
                                            child:Text(
                                              Tag,
                                              style: TextStyle(
                                                color: myColors.dark_grey_txt,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.80,
                                                wordSpacing: 0.1,
                                                fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",
                                              ),
                                            )),
                                      ),

                                    ],
                                  ),
                                ),

                                /// Manufacturer..........................
                                SizedBox(height: 12,),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        //  width: 75,
                                        child:
                                        CustomText.CustomMediumText(
                                            MyString.Manufacturer,
                                            myColors.black,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.start),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        child:
                                        CustomText.CustomMediumText(
                                            ":",
                                            myColors.black,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.start),
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(
                                        child: Container(
                                          // margin: EdgeInsets.only(top: 6),
                                            child:Text(
                                              manufacturer,
                                              style: TextStyle(
                                                color: myColors.dark_grey_txt,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.80,
                                                wordSpacing: 0.1,
                                                fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",
                                              ),
                                            )),
                                      ),

                                    ],
                                  ),
                                ),

                                SizedBox(height: 12,),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 92,
                                        child:
                                        CustomText.CustomMediumText(
                                            MyString.Model,
                                            myColors.black,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.start),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child:
                                        CustomText.CustomMediumText(
                                            ":",
                                            myColors.black,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.start),
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(
                                        child: Container(
                                            alignment: Alignment.topLeft,
                                            // margin: EdgeInsets.only(top: 6),
                                            child:Text(
                                              model,
                                              style: TextStyle(
                                                color: myColors.dark_grey_txt,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.80,
                                                wordSpacing: 0.1,
                                                fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",
                                              ),
                                            )),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),


                          SizedBox(height: 15,),
                          ///Dotted line.................
                          Container(
                            child: DottedBorder(
                              dashPattern: [3, 4],
                              color: myColors.grey_22,
                              customPath: (size) {
                                return Path()
                                  ..moveTo(0, 0)
                                  ..lineTo(size.width, 0);
                              },
                              child: Container(),
                            ),
                          ),

                          /// Location...................
                          Visibility(
                            visible: location == " |  | " ||  location.trim().isEmpty  ?false:true,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    alignment: Alignment.topLeft,
                                    child:
                                    CustomText.CustomMediumText(
                                        MyString.Location,
                                        myColors.black,
                                        FontWeight.w500,
                                        14,
                                        1,
                                        TextAlign.start),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(top: 6),
                                    child: Text(
                                 location,
                                      style: TextStyle(
                                        color: myColors.dark_grey_txt,
                                        fontWeight:  FontWeight.w500,
                                        fontSize: 12,
                                        wordSpacing: 0.1,
                                        fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// maintainabilityType...................
                          Visibility(
                            visible: maintainabilityType.trim().isEmpty? false:true,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    alignment: Alignment.topLeft,
                                    child:
                                    CustomText.CustomMediumText(
                                        MyString.maintainabilityType,
                                        myColors.black,
                                        FontWeight.w500,
                                        14,
                                        1,
                                        TextAlign.start),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(top: 6),
                                    child: Text(
                                      maintainabilityType,
                                      style: TextStyle(
                                        color: myColors.dark_grey_txt,
                                        fontWeight:  FontWeight.w500,
                                        fontSize: 12,
                                        wordSpacing: 0.1,
                                        fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// maintainabilityType...................
                          Visibility(
                            visible:assetCriticality.trim().isEmpty?false:true ,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    alignment: Alignment.topLeft,
                                    child:
                                    CustomText.CustomMediumText(
                                        MyString.assetCriticality,
                                        myColors.black,
                                        FontWeight.w500,
                                        14,
                                        1,
                                        TextAlign.start),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(top: 6),
                                    child: Text(
                                      assetCriticality,
                                      style: TextStyle(
                                        color: myColors.dark_grey_txt,
                                        fontWeight:  FontWeight.w500,
                                        fontSize: 12,
                                        wordSpacing: 0.1,
                                        fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height /1.37,bottom: MediaQuery.of(context).size.height /15,left: 20,right: 20),
                child: InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: DiscoverScreen(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    // margin: EdgeInsets.fromLTRB(16, 0, 16, 38),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: myColors.app_theme,
                    ),
                    child: CustomText.CustomBoldText(MyString.View_More,
                        myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
                  ),
                ),
              )
            ],
          ),
          /* bottomNavigationBar: InkWell(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: DiscoverScreen(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 38),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: myColors.app_theme,
                ),
                child: CustomText.CustomBoldText(MyString.View_More,
                    myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
              ),
            )*/

        ));
  }


}
