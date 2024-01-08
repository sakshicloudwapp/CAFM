import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/views/profile_screens/NotificationScreen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:fm_pro/widgets/custom_texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSheetResourceScreen extends StatefulWidget {
  const TimeSheetResourceScreen({Key? key}) : super(key: key);

  @override
  State<TimeSheetResourceScreen> createState() => _TimeSheetResourceScreenState();
}

class _TimeSheetResourceScreenState extends State<TimeSheetResourceScreen> {

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
                  MyString.Resources,
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
                  margin: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("29",style: TextStyle(fontSize: 18,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w700),),
                          Text("Fri",style: TextStyle(fontSize: 14,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w400),)
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Muhammad Iqbal",style: TextStyle(fontSize: 14,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w600),),
                          Text("Supervisor",style: TextStyle(fontSize: 10,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w600),)
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Absent",style: TextStyle(fontSize: 12,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w500,color: myColors.red_2),),
                          Row(
                            children: [
                              Image.asset("assets/images/img_reject_red.png",height: 15,width: 15,),
                              SizedBox(width: 5,),
                              Text("04",style: TextStyle(fontSize: 14,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w500,color: myColors.red_2),),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Present",style: TextStyle(fontSize: 12,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w500,color: myColors.green_2),),
                          Row(
                            children: [
                              Image.asset("assets/images/accepctNew_icon.png",height: 15,width: 15,),
                              SizedBox(width: 5,),
                              Text("02  ",style: TextStyle(fontSize: 14,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w500,color: myColors.green_2),),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height/1.5,
                  child: ListView.builder(
                    itemCount: 5,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context ,int index){
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: myColors.containerClr,
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Emp Code  :  111345",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: MyString.PlusJakartaSansSemibold,fontSize: 12),),
                                 Spacer(),
                                  Row(
                                    children: [
                                      Image.asset("assets/images/img_reject_red.png",height: 15,width: 15,),
                                      SizedBox(width: 5,),
                                      Text("Absent  ",style: TextStyle(fontSize: 14,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w500,color: myColors.red_2),),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: DottedDecoration(
                                    shape: Shape.line, linePosition: LinePosition.bottom,color: myColors.active_ten//remove this to get plane rectange
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text("Designation",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: MyString.PlusJakartaSansSemibold,fontSize: 12,color: myColors.black),),
                                Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 45),
                                    child: Text("Male Cleaner  ",style: TextStyle(fontSize: 12,fontFamily: MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w600,color: myColors.grey_41),),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("Employee Name",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: MyString.PlusJakartaSansSemibold,fontSize: 12,color: myColors.black),),
                                 Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 45),
                                    child: Text("Milan Chand  Bahadur  ",style: TextStyle(fontSize: 12,fontFamily:MyString.PlusJakartaSansSemibold,fontWeight: FontWeight.w600,color: myColors.grey_41),),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        )
    );
  }
}
