import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/model/models/ProjectModel.dart';
import 'package:fm_pro/model/models/scanModel.dart';
import 'package:fm_pro/views/Reactive/assign_resources_screen.dart';
import 'package:fm_pro/views/profile_screens/NotificationScreen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:fm_pro/widgets/custom_texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSheetBulkEditScreen extends StatefulWidget {
  const TimeSheetBulkEditScreen({Key? key}) : super(key: key);

  @override
  State<TimeSheetBulkEditScreen> createState() => _TimeSheetBulkEditScreenState();
}

class _TimeSheetBulkEditScreenState extends State<TimeSheetBulkEditScreen> {

  String name = "";
  String user_name = "";
  String user_img = "";
  String user_designation = "";

  SharedPreferences? pre;
  getSharedprefences() async{
    pre = await SharedPreferences.getInstance();
    user_name = pre!.getString("user_name").toString();
    user_img = pre!.getString("user_profile").toString();
    user_designation = pre!.getString("designation").toString();
    print("username>>${user_img}");

    setState((){});
  }
  TextEditingController projectController = TextEditingController();

  List<String> buildingList = [
    "ACCE - Accelerator Building",
    "ACCE - Accelerator ",
    "ACCE -  Building",
  ];

  List<String> resourceSelectionList = [
    "ALL",
    "Break In",
    "Break Out",
    "Check In",
    "Check Out",
    "New"
  ];

  String? selectBuilding;
  String? selectResource;

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedprefences();
    setState(() {
    });
  }

  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AppBar(
              leading: InkWell(
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
              title: CustomText.CustomBoldTextDM(
                  MyString.BulkEdits,
                  myColors.black,
                  FontWeight.w700,
                  16,
                  1,
                  TextAlign.center),
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: myColors.app_theme,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
              automaticallyImplyLeading: true,
              backgroundColor: myColors.white,
              elevation: 0,
            ),
          ),
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: myColors.white,
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        child: CircleAvatar(
                          radius: 60,
                          child:   user_img.toString() == "null" ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset("assets/images/user_img.png",fit: BoxFit.cover,width: 50,
                                height: 50,)):  ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(user_img,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, exception, stackTrace) {
                                  return Image.asset(
                                    "assets/images/user_img.png",
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  );
                                },
                                width: 45,
                                height: 45,)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          //  height: 45,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Hi,"+  user_name.toString() == "null" ? "" : user_name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily:
                                    MyString.PlusJakartaSansBold,
                                    color: myColors.black,
                                  ),
                                ),
                              ),

                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user_designation.toString() == "null" ? "" : user_designation,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                    MyString.PlusJakartaSansregular,
                                    color: myColors.light_text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Notification Icon.........
                      InkWell(
                        onTap: () {
                          CustomNavigator.pushNavigate(context, NotificationScreen());
                          setState(() {});
                        },
                        child: Container(
                          width: 70,
                          padding: EdgeInsets.fromLTRB(20, 0, 24, 20),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  "assets/images/ic_notification.svg",
                                  width: 28,
                                  height: 28,
                                  fit: BoxFit.fill,
                                  color: myColors.black,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                    color: myColors.color_red,
                                    shape: BoxShape.circle),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: MyString.PlusJakartaSansmedium,
                                      color: myColors.white,
                                    ),
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
                Container(
                  margin: EdgeInsets.fromLTRB(20,10,20,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Building",style: TextStyle(fontSize: 12,fontFamily: MyString.PlusJakartaSansmedium,fontWeight: FontWeight.w600,color: myColors.grey_28),),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: myColors.grey_23),
                              color: myColors.bg_bottom
                          ),
                          padding: EdgeInsets.fromLTRB(15,5,15,5),
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child:  buildingDropDown()
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Resource Selection",style: TextStyle(fontSize: 12,fontFamily: MyString.PlusJakartaSansmedium,fontWeight: FontWeight.w600,color: myColors.grey_28),),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: myColors.grey_23),
                            color: myColors.bg_bottom
                          ),
                          padding: EdgeInsets.fromLTRB(15,5,15,5),
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child:  resourceSelectionDropDown()
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){

                        },
                        child: Image.asset("assets/icons/empty_box.png",height: 15,width: 15,),

                      ),
                      SizedBox(width: 30,),
                      Text("Resources",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: MyString.PlusJakartaSansregular,),),
                      Spacer(),
                      Text("In / Out",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: MyString.PlusJakartaSansregular,),)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: DottedDecoration(
                      shape: Shape.line, linePosition: LinePosition.bottom,color: myColors.grey_42 //remove this to get plane rectange
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: MediaQuery.of(context).size.height/1.5,
                  child: ListView.builder(
                    itemCount: 5,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index){
                        return  Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.fromLTRB(20,0,20,0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){

                                    },
                                    child: Image.asset("assets/icons/empty_box.png",height: 15,width: 15,),

                                  ),
                                  SizedBox(width: 30,),
                                  Image.asset("assets/icons/user_contact_img.png",height: 50,width: 50,),
                                  SizedBox(width: 15,),
                                  Column(
                                    children: [
                                      Text("Ashok Yadav",style: TextStyle(fontSize: 14,fontFamily: MyString.PlusJakartaSansregular,fontWeight: FontWeight.w600),),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Technical Analyst",style: TextStyle(fontSize: 10,fontFamily: MyString.PlusJakartaSansregular,fontWeight: FontWeight.w600,color: myColors.grey_41),),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.asset("assets/icons/ic_out.png",height: 20,width: 20,),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Container(
                                decoration: DottedDecoration(
                                    shape: Shape.line, linePosition: LinePosition.bottom,color: myColors.grey_42 //remove this to get plane rectange
                                ),
                              ),
                            ],
                          ),

                        );
                      }),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        )
    );
  }
  buildingDropDown(){
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          'ACCE - Accelerator Building',
          style: TextStyle(
            fontSize: 14,
            color: Theme
                .of(context)
                .hintColor,
          ),
        ),
        items: buildingList
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

  resourceSelectionDropDown(){
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          'ALL',
          style: TextStyle(
            fontSize: 14,
            color: Theme
                .of(context)
                .hintColor,
          ),
        ),
        items: resourceSelectionList
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
        value: selectResource,
        onChanged: (String? value) {
          setState(() {
            selectResource = value;
          });
        },
        buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 0),
            height: 40,
            width: 400
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 30,
        ),

      ),
    );
  }
}
