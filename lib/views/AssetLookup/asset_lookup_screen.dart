import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/AssetcodeLocalModel.dart';
import 'package:fm_pro/services/databaseHelper.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/views/AssetLookup/asset_lookup_detail_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../global/my_string.dart';
import '../../model/models/asset_lookupModel.dart';
import '../../utils/customToast.dart';
import '../../widgets/customNavigator.dart';
import '../../widgets/custom_texts.dart';

class AssetLookupScreen extends StatefulWidget {

  const AssetLookupScreen({Key? key}) : super(key: key);

  @override
  _AssetLookupScreenState createState() => _AssetLookupScreenState();
}

class _AssetLookupScreenState extends State<AssetLookupScreen> {
  List<AssetLookupDataModel> getassetlookupList = [];

  List<String> assetcodelist = [];
  List<String> _searchResult = [];
  TextEditingController searchcontroller = TextEditingController();
  final searchfocus = FocusNode();
  SharedPreferences? pre;
  bool is_search = false;

  getApi() async{
    getassetlookupList.clear();
    setState((){});
    await Webservices.RequestGetassetlookupdata(context, getassetlookupList, true);
    if(getassetlookupList.isNotEmpty){
      print("kvskkjl${getassetlookupList.length}");
      print("name >>>>${getassetlookupList[0].description}");
    }

    setState((){});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpre();
   // getApi();
  }

  getpre() async{
    assetcodelist.clear();
  pre =  await SharedPreferences.getInstance();
    assetcodelist = pre!.getStringList("assetcodelist")!;
    setState(() {});
  }

  // void _queryAll() async {
  //   final allRows = await DatabaseHelperComfortSettings.queryAllRows();
  //   comfortdrttinglist.clear();
  //   allRows.forEach((row) => comfortdrttinglist.add(ComfortSettings.fromJson(row)));
  //   setState(() {});
  //   print("comfortsettingschedulelist>>>${comfortdrttinglist.length}");
  // }

  addcode()async{
    SharedPreferences p = await SharedPreferences.getInstance();
    final dbHelper = Databaseassetcode.instance;
    Map<String, dynamic> row = {
      Databaseassetcode.columnassetcode: searchcontroller.text,
    };
    LocalStassetcodeModel detailModel = LocalStassetcodeModel.fromJson(row);

    await dbHelper.insert(detailModel);
    print("dbHelper>> ");
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(is_search?120:85),
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
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                          Spacer(),
                          Container(
                              alignment: Alignment.center,
                              child: CustomText.CustomBoldTextDM(
                                  MyString.asset_lookup,
                                  myColors.black,
                                  FontWeight.w700,
                                  16,
                                  1,
                                  TextAlign.center)),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              is_search = !is_search;
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 10),
                              child:    Container(
                                //alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  "assets/images/search.svg",width: 28,
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () async{
                              SharedPreferences p = await SharedPreferences.getInstance();
                               // var res ="TFMAR000031";
                             //   var res ="CTGT-CTGTA-BS3-B3CA-BLDG-FAFN-0001";
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
                                  assetcodelist.add(res);
                                  setState(() {});
                                  SharedPreferences p = await SharedPreferences.getInstance();
                                  p.setStringList("assetcodelist", assetcodelist);
                                  setState(() {});
                                  addcode();
                                  if(res.toString() == "-1" || res.contains("https") || res.contains("http")){
                                    CustomToast.showToast(msg: "Invalid asset code");
                                  }else{

                                  }
                                }
                              });
                              setState(() {});
                            },
                            child: Container(
                              width: 38,
                              height: 38,
                              margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
                              child: Center(child: Image.asset("assets/icons/qr.png",width: 30,
                                height: 38,)),
                            ),
                          ),
                        ],
                      ),

                      //Search...................................................................................................................
                      Visibility(
                        visible: is_search?true:false,
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                                          controller: searchcontroller,
                                          focusNode: searchfocus,
                                          keyboardType: TextInputType.text,
                                          onSubmitted: (value) async{


                                          },
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          body: bodyWidget(),

          bottomNavigationBar: InkWell(
            onTap: (){
              assetcodelist.clear();
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: myColors.app_theme,
              ),
              child: CustomText.CustomBoldText(MyString.CLEAR, myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
            ),
          )
        ));
  }

  /// widget body......

bodyWidget(){
    return Container(
      margin: EdgeInsets.only(top: 10,),
      child: assetcodelist.isNotEmpty ?
      Stack(
        children: [

          _searchResult.length != 0 || searchcontroller.text.isNotEmpty
              ?
          ListView.builder(
              itemCount: _searchResult.length,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: listwidget( index),
                );
              }):
          ListView.builder(
              itemCount: assetcodelist.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context,int index){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: listwidget( index),
            );
          }),


        ],
      )
          :Container(),
    );
}


listwidget(int index){
    return Container(
      child: GestureDetector(
        onTap: (){
          print("hjj${assetcodelist[index]}");
          CustomNavigator.custompush(context, AssetLookupDetailScreen(assetId: assetcodelist[index],),true);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
          decoration: BoxDecoration(
              color: myColors.white,
              border: Border.all(color: myColors.grey_five,width: 0.5),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: myColors.grey_five,
                    spreadRadius: 0.4
                )
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowui("AssetName : ","${assetcodelist[index]}"),
              // SizedBox(height: 10,),
              // rowui("System : ","${getassetlookupList[index].systemName}"),
            ],
          ),
        ),
      ),
    );
}
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    print("text<<<${text}");
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _searchResult.clear();
    assetcodelist.forEach((userDetail) {
      print("text<<<${userDetail}");
      if (userDetail.toString().toUpperCase().contains(text.toUpperCase()) || userDetail.toString().toUpperCase().contains(text.toUpperCase()))
        _searchResult.add(userDetail);
    });
    print("_searchResult<<<${_searchResult.length}");
    setState(() {});
  }

/// widget row.....

rowui(String title,String des){
    return Container(
      child:     Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(title,style: TextStyle(color: myColors.black,fontWeight: FontWeight.w500)))),
          Expanded(
              flex: 2,
              child: Container(
              alignment: Alignment.centerLeft,
              child: Text(des,style: TextStyle(color: myColors.black),))),
        ],
      ),
    );
}
}
