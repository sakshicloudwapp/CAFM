import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/views/Reactive/resources_assign_successfully_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../global/my_string.dart';
import '../../widgets/custom_texts.dart';


class ResourcesModel {
  String title;
  bool isChecked;

  ResourcesModel(this.title, this.isChecked);
}

List<ResourcesModel> resourcesList = [];
List<String> assignedResList = [];

class AssignResourcesScreen extends StatefulWidget {

  const AssignResourcesScreen({Key? key}) : super(key: key);

  @override
  _AssignResourcesScreenState createState() => _AssignResourcesScreenState();
}

class _AssignResourcesScreenState extends State<AssignResourcesScreen> {
  @override
  void initState() {
    assignedResList.clear();
    resourcesList = [
      ResourcesModel("Muhammad Sami uddin", false),
      ResourcesModel("Shaik Rahmatulla", false),
      ResourcesModel("Nayab Rasool", false),
      ResourcesModel("Shaik Tamrulla Khan", false),
      ResourcesModel("Muhammad Sami uddin", false),
      ResourcesModel("Muhammad Sami uddin", false),
    ];
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
            preferredSize: Size.fromHeight(135),
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
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.center,
                child: SafeArea(
                  child: Column(
                    children: [
                      //Header......................................................................................................................
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
                                    MyString.Resources,
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
                                  MyString.PlusJakartaSansregular,
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
                                      MyString.PlusJakartaSansregular,),
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
                    ],
                  ),
                ),
              ),
            ),
          ),

          body: Container(

            ///Resources List...........................................................................................................
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: resourcesList.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                resourcesList[index].isChecked = !resourcesList[index].isChecked;
                                setState(() {});
                                if(resourcesList[index].isChecked == true){
                                  assignedResList.add(index.toString());
                                  print("if>>>"+assignedResList.length.toString());
                                  setState(() {});
                                }else{
                                  assignedResList.remove(index.toString());
                                  print("else>>>"+assignedResList.length.toString());
                                  setState(() {});
                                }
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: ResourcesList(index: index),
                              ),
                            );
                          })),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),

          bottomNavigationBar: InkWell(
            onTap:assignedResList.isEmpty ? (){}: (){
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ResourcesAssignSuccessfullyScreen(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: assignedResList.length > 0 ? myColors.app_theme  : myColors.btn_light_blue,
              ),
              child: CustomText.CustomBoldText(MyString.DONE, myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
            ),
          ),

        ));
  }
}
///Resources List.................................................................................................................
class ResourcesList extends StatefulWidget {
  int index;

  ResourcesList({Key? key, required this.index}) : super(key: key);

  @override
  _ResourcesListState createState() => _ResourcesListState();
}

class _ResourcesListState extends State<ResourcesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: resourcesList[widget.index].isChecked== true ? myColors.orange : myColors.app_theme),
        color: resourcesList[widget.index].isChecked== true ? myColors.light_orange :  myColors.bg,
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
                  backgroundImage: AssetImage("assets/images/profle_men.png"),
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
                              resourcesList[widget.index].title,
                              resourcesList[widget.index].isChecked== true ? myColors.orange : myColors.black,
                              FontWeight.w500,
                              14,
                              1,
                              TextAlign.center)),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          alignment: Alignment.topLeft,
                          child: CustomText.CustomMediumText(
                              "Designation",
                              myColors.app_theme,
                              FontWeight.w500,
                              12,
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
                                    "Active",
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
              Container(
                width: 50,
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(bottom: 28),
                  child: Image.asset(
                    resourcesList[widget.index].isChecked== true ? "assets/images/checkbox1_check.png" : "assets/images/checkbox1_uncheck.png",
                    width: 20,
                    height: 20,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 25,
                      margin: EdgeInsets.only(left: 2,top: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: myColors.black),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 25,
                      margin: EdgeInsets.only(left: 2,top: 6),
                      child: Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                                color: myColors.cyan
                            ),
                            child: Center(child: Image.asset(
                              "assets/images/img_whatsapp.png",)),
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            child: Center(child: Image.asset(
                              "assets/images/img_phone1.png", width: 11,
                              height: 11,)),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                            "25",
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