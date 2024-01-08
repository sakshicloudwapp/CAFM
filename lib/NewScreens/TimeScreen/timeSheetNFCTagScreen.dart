import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_pro/NewScreens/TimeScreen/timeSheetRequestScreen.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/views/profile_screens/NotificationScreen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:fm_pro/widgets/custom_texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSheetNFCTagScreen extends StatefulWidget {
  const TimeSheetNFCTagScreen({Key? key}) : super(key: key);

  @override
  State<TimeSheetNFCTagScreen> createState() => _TimeSheetNFCTagScreenState();
}

class _TimeSheetNFCTagScreenState extends State<TimeSheetNFCTagScreen> {

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

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedprefences();
    setState(() {
    });
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
                                      fontFamily: MyString.PlusJakartaSansBold,
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
                  margin: EdgeInsets.only(left: 20,right: 20,top: 25,bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Emp Code or Name",style: TextStyle(
                        fontFamily: MyString.PlusJakartaSansregular,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: myColors.grey_28
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 10),
                        decoration: BoxDecoration(
                          color: myColors.bg_bottom,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: myColors.grey_23)
                        ),
                        child:  TextField(
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
                            hintText: "11113",
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: myColors.txt_txtfield,
                                fontFamily:
                                MyString.PlusJakartaSansregular,),
                            counter: Offstage(),
                            isDense: true,
                            // this will remove the default content padding
                            contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          ),
                          maxLines: null,
                          cursorColor: myColors.black,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mobile no or Email",style: TextStyle(
                          fontFamily: MyString.PlusJakartaSansregular,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: myColors.grey_28
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 10),
                        
                        decoration: BoxDecoration(
                            color: myColors.bg_bottom,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: myColors.grey_23)
                        ),
                        child:  TextField(
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
                            contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          ),
                          maxLines: null,
                          cursorColor: myColors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width/1.8,
                      decoration: BoxDecoration(
                        color: myColors.app_theme,
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Center(
                        child: Text("Search",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: myColors.white,
                          fontFamily: MyString.PlusJakartaSansregular,
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  height: MediaQuery.of(context).size.height/2.5,
                  child: ListView.builder(
                      itemCount: 1,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index){
                    return Row(
                      children: [
                      InkWell(
                        onTap: (){

                        },
                        child: Image.asset("assets/icons/newRadiobtn.png",height: 20,width: 20,),
                      ),
                        SizedBox(width: 35,),
                        Text("Milan Bahadur Chand",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: MyString.PlusJakartaSansregular,color: myColors.black),)
                      ],
                    );
                  }),
                ),

              ],
            ),
          ),
          bottomNavigationBar: InkWell(
            onTap: () async {
              CustomNavigator.pushNavigate(context, TimeSheetRequestScreen());
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: myColors.app_theme,
              ),
              child: CustomText.CustomBoldText("Write NFC Tag", myColors.white,
                  FontWeight.w700, 14, 1, TextAlign.center),
            ),
          ),
        )
    );
  }
}
