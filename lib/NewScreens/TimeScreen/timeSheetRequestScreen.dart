import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/views/profile_screens/NotificationScreen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:fm_pro/widgets/custom_texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSheetRequestScreen extends StatefulWidget {
  const TimeSheetRequestScreen({Key? key}) : super(key: key);

  @override
  State<TimeSheetRequestScreen> createState() => _TimeSheetRequestScreenState();
}

class _TimeSheetRequestScreenState extends State<TimeSheetRequestScreen> {

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

  List<String> subjectList = [
    "ACCE - Accelerator Building",
    "ACCE - Accelerator ",
    "ACCE -  Building",
  ];
  String? selectBuilding;


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
                  MyString.Request_s,
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
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("RID :",style: TextStyle(fontFamily: MyString.PlusJakartaSansBold,fontWeight: FontWeight.w800,fontSize: 15),),
                      Container(
                        margin: EdgeInsets.fromLTRB(0,20,0,0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Subject",style: TextStyle(fontSize: 12,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w600,color: myColors.grey_28),),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: myColors.grey_23),
                                    color: myColors.bg_bottom
                                ),
                                padding: EdgeInsets.fromLTRB(15,5,15,5),
                                margin: EdgeInsets.only(top: 10,bottom: 20),
                                alignment: Alignment.center,
                                child:  subjectDropDown()
                            ),
                            Text("Description",style: TextStyle(fontSize: 12,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w600,color: myColors.grey_28),),
                            Container(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              padding: EdgeInsets.fromLTRB(20,10,20,10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: myColors.grey_29),
                                color: myColors.bg_bottom
                              ),
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
                                  hintText: "",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: myColors.txt_txtfield,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,),
                                  counter: Offstage(),
                                  isDense: true,
                                  // this will remove the default content padding
                                  contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                ),
                                maxLines: null,
                                cursorColor: myColors.black,
                              ),
                            ),
                            Text("Bank",style: TextStyle(fontSize: 12,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w600,color: myColors.grey_28),),
                            Container(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              padding: EdgeInsets.fromLTRB(20,10,20,10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: myColors.grey_29),
                                  color: myColors.bg_bottom
                              ),
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
                                  hintText: "",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: myColors.txt_txtfield,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,),
                                  counter: Offstage(),
                                  isDense: true,
                                  // this will remove the default content padding
                                  contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                ),
                                maxLines: null,
                                cursorColor: myColors.black,
                              ),
                            ),
                            Text("Additional Info 1",style: TextStyle(fontSize: 12,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w600,color: myColors.grey_28),),
                            Container(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              padding: EdgeInsets.fromLTRB(20,10,20,10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: myColors.grey_29),
                                  color: myColors.bg_bottom
                              ),
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
                                  hintText: "",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: myColors.txt_txtfield,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,),
                                  counter: Offstage(),
                                  isDense: true,
                                  // this will remove the default content padding
                                  contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                ),
                                maxLines: null,
                                cursorColor: myColors.black,
                              ),
                            ),
                            Text("Additional Info 2",style: TextStyle(fontSize: 12,fontFamily: MyString.PlusJakartaSansBold,fontWeight: FontWeight.w600,color: myColors.grey_28),),
                            Container(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              padding: EdgeInsets.fromLTRB(20,10,20,10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: myColors.grey_29),
                                  color: myColors.bg_bottom
                              ),
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
                                  hintText: "",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: myColors.txt_txtfield,
                                      fontFamily:
                                      MyString.PlusJakartaSansregular,),
                                  counter: Offstage(),
                                  isDense: true,
                                  // this will remove the default content padding
                                  contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                ),
                                maxLines: null,
                                cursorColor: myColors.black,
                              ),
                            ),
                            SizedBox(height: 25,),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    //margin: EdgeInsets.only(bottom: 30,right: 35,left: 35),
                                    child: InkWell(
                                      onTap: (){
                                       // CustomNavigator.pushNavigate(context, TimeSheetRequestScreen());
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 155,
                                        margin: EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                            color: myColors.app_theme,
                                            borderRadius: BorderRadius.circular(35.0)
                                        ),
                                        child: Center(
                                          child: Text("Submit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12,
                                                color: myColors.white,
                                                fontFamily: MyString.PlusJakartaSansBold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                   // margin: EdgeInsets.only(bottom: 30,right: 35,left: 35),
                                    child: InkWell(
                                      onTap: (){
                                       // CustomNavigator.pushNavigate(context, TimeSheetRequestScreen());
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 155,
                                        margin: EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                            color: myColors.purple_3,
                                            borderRadius: BorderRadius.circular(35.0)
                                        ),
                                        child: Center(
                                          child: Text("Cancel",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 13,
                                                color: myColors.app_theme,
                                                fontFamily: MyString.PlusJakartaSansBold
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        )
    );
  }
  subjectDropDown(){
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          'Select Any one',
          style: TextStyle(
            fontSize: 14,
            color: Theme
                .of(context)
                .hintColor,
          ),
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
}
