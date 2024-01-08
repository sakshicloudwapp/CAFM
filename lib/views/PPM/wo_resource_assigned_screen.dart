import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/widgets/custom_texts.dart';

class ResourceAssignedScreen extends StatefulWidget {
  const ResourceAssignedScreen({Key? key}) : super(key: key);

  @override
  State<ResourceAssignedScreen> createState() => _ResourceAssignedScreenState();
}

class _ResourceAssignedScreenState extends State<ResourceAssignedScreen> {

  double newHeight = 0.0;
  GlobalKey _globalKey = GlobalKey();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          //drawer: UpdatesMenuScreen(),
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
                                padding: EdgeInsets.only(left: 15),
                                alignment: Alignment.center,
                                height: 60,
                                // width: 40,
                                child: SvgPicture.asset(
                                  "assets/images/ic_arrow_previous.svg",
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            ),

                            // SizedBox(width: 95,),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: CustomText.CustomBoldTextDM(
                                      "Resource Details",
                                      myColors.black,
                                      FontWeight.w700,
                                      16,
                                      1,
                                      TextAlign.center)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),


            body: Container(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image.asset("assets/images/user.png",height: 130,width: 130,),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text("Muhammad Sami uddin",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: myColors.dark_grey_txt
                      ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text("Designation",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: myColors.dark_blue_1,
                          fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                            color: myColors.black
                          ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("sami@companyname.com",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                color: myColors.black
                            ),
                          )

                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Contact",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                    color: myColors.black
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: (){

                                },
                                child: Image.asset("assets/images/colorWhatsApp_img.png",height: 20,width: 20,),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: (){

                                },
                                child: Image.asset("assets/images/colorCall_img.png",height: 18,width: 18,),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("+91 9066-XXXX-X5",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                color: myColors.black
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                      //  color: Colors.blueGrey,
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height/3.6,
                        width: MediaQuery.of(context).size.width/1.5,
                        //margin: EdgeInsets .fromLTRB(70, 20, 70, 10),
                        child: Stack(
                          children: [
                            Center(child: Image.asset("assets/images/dashLine.png",fit: BoxFit.fill,)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                 // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child:  GestureDetector(
                                          onTap: (){},
                                          child: Column(
                                            children: [
                                              Image.asset("assets/images/color_CheckCircle-img.png",height: 30,width: 30,),
                                              Text("Contacted",
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                    ),

                                    Expanded(
                                        child: GestureDetector(
                                          onTap: (){},
                                          child: Column(
                                            children: [
                                              Image.asset("assets/images/start_img.png",height: 30,width: 30,),
                                              Text("Start",
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Image.asset("assets/images/stop_img.png",height: 30,width: 30,),
                                          Text("Stop",
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                        child: Column(
                                          children: [
                                            Image.asset("assets/images/scan.png",height: 30,width: 30,),
                                            Text("Scan"
                                                "",
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
                      decoration: BoxDecoration(
                        color: myColors.purple_2,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Text("Contacted ",
                          style: TextStyle(
                            fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: myColors.black
                          ),
                          ),
                          Spacer(),
                          Text("20-03-2023 11:33Hrs",
                            style: TextStyle(
                                fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: myColors.black
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
                      decoration: BoxDecoration(
                          color: myColors.purple_2,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Text("Started ",
                            style: TextStyle(
                                fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: myColors.black
                            ),
                          ),
                          Spacer(),
                          Text("20-03-2023 11:33Hrs",
                            style: TextStyle(
                                fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: myColors.black
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
                      decoration: BoxDecoration(
                          color: myColors.purple_2,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Text("Finished ",
                            style: TextStyle(
                                fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: myColors.black
                            ),
                          ),
                          Spacer(),
                          Text("20-03-2023 11:33Hrs",
                            style: TextStyle(
                                fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: myColors.black
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        ));
  }
}



