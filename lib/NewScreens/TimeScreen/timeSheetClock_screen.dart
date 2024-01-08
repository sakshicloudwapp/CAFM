import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:fm_pro/widgets/custom_texts.dart';

class TimeSheetClockScreen extends StatefulWidget {
  const TimeSheetClockScreen({Key? key}) : super(key: key);

  @override
  State<TimeSheetClockScreen> createState() => _TimeSheetClockScreenState();
}

class _TimeSheetClockScreenState extends State<TimeSheetClockScreen> {

  List<String> titleList=['BAR  CODE   SCANNER','NFC READER','QR CODE SCANNER','BULK CHECK IN/OUT'];
  List<String> imgList=['assets/icons/ic_barcode_scanner.png','assets/icons/ic_wifi-square.png','assets/icons/ic_Colorscan-barcode.png','assets/icons/ic_checkInOut.png'];

  bool isClockIn = false;
  bool isClockOut = false;


  @override

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
    child: Scaffold(
      backgroundColor: myColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
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
              MyString.Timesheet,
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
              alignment: Alignment.center,
              child: Text(
                "08:30",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  fontFamily:
                  MyString.PlusJakartaSansBold,
                  color: myColors.black,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Friday Feb - 2021",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily:
                  MyString.PlusJakartaSansregular,
                  color: myColors.active_thirteen,
                ),
              ),
            ),
            hsized25,
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: (){
                              isClockIn = true;
                              setState(() {});
                            },
                            child: isClockIn == true?
                            Image.asset("assets/icons/color_ClockIn.png",height: 100,width: 100,):
                            Image.asset("assets/icons/ic_clockStart.png",height: 100,width: 100,)
                          ),
                          SizedBox(height: 10),
                          Text("CLOCK IN",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: myColors.black
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30,),

                      isClockIn == true
                          ? Container(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                isClockOut = true;
                                setState(() {});
                              },
                              child:  isClockOut == true?
                              Image.asset("assets/icons/color_clockOut.png",height: 100,width: 100,):
                              Image.asset("assets/icons/gray_clockOut.png",height: 100,width: 100,)
                            ),
                            SizedBox(height: 10),
                            Text("CLOCK OUT",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: myColors.black
                              ),
                            ),
                          ],
                        ),
                      )
                          :Container()
                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Container(
                   // width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child:Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/3.5,
                                padding: EdgeInsets.all(10),
                                decoration: DottedDecoration(
                                  shape: Shape.line, linePosition: LinePosition.right, //remove this to get plane rectange
                                ),
                                child: Column(
                                  children: [
                                    isClockIn == true?
                                    Image.asset("assets/icons/color_clockIn1.png",height: 40,width: 40,):
                                    Image.asset("assets/icons/ic_clock.png",height: 40,width: 40,),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("CLOCK IN",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: MyString.PlusJakartaSansBold,
                                      fontSize: 12,
                                      color:  isClockIn == true?
                                      myColors.app_theme:myColors.grey_40
                                    ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //Spacer(),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/3.5,
                                padding: EdgeInsets.all(10),
                               /* decoration: DottedDecoration(
                                  shape: Shape.line, linePosition: LinePosition.right, //remove this to get plane rectange
                                ),*/
                                child: Column(
                                  children: [
                                isClockOut == true?
                                    Image.asset("assets/icons/color_clockOut1'.png",height: 40,width: 40,):
                                    Image.asset("assets/icons/ic_clockPause.png",height: 40,width: 40,),
                                    Text("CLOCK OUT",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: MyString.PlusJakartaSansBold,
                                          fontSize: 12,
                                          color:isClockOut == true?
                                          myColors.app_theme:myColors.grey_40
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                           // Spacer(),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/3.5,
                                padding: EdgeInsets.all(0),
                                decoration: DottedDecoration(
                                  shape: Shape.line, linePosition: LinePosition.left, //remove this to get plane rectange
                                ),
                                child: Column(
                                  children: [
                                    isClockOut == true?
                                    Image.asset("assets/icons/color_working.png",height: 40,width: 40,):
                                    Image.asset("assets/icons/ic_clockWorking.png",height: 40,width: 40,),
                                    Text("WORKING HRS",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: MyString.PlusJakartaSansBold,
                                          fontSize: 12,
                                          color:isClockOut == true?
                                          myColors.app_theme:myColors.grey_40,
                                      ),
                                    maxLines: null,
                                    //  textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: DottedDecoration(
                            shape: Shape.line, linePosition: LinePosition.bottom, //remove this to get plane rectange
                          ),
                        ),

                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/3.5,
                                padding: EdgeInsets.all(10),
                                decoration: DottedDecoration(
                                  shape: Shape.line, linePosition: LinePosition.right, //remove this to get plane rectange
                                ),
                                child: Column(
                                  children: [
                                    Text("0:00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: MyString.PlusJakartaSansregular,
                                          fontSize: 24,
                                          color: myColors.grey_40
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          //  Spacer(),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/3.5,
                                padding: EdgeInsets.all(10),
                                /*decoration: DottedDecoration(
                                  shape: Shape.line, linePosition: LinePosition.right, //remove this to get plane rectange
                                ),*/
                                child: Column(
                                  children: [
                                    Text("0:00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: MyString.PlusJakartaSansregular,
                                          fontSize: 24,
                                          color: myColors.grey_40
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                           // Spacer(),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/3.5,
                                padding: EdgeInsets.all(10),
                                decoration: DottedDecoration(
                                  shape: Shape.line, linePosition: LinePosition.left, //remove this to get plane rectange
                                ),
                                child: Column(
                                  children: [
                                    Text("0:00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: MyString.PlusJakartaSansregular,
                                          fontSize: 24,
                                          color: myColors.grey_40
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  hsized20,
                  /// Gridview...............................
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 35),
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.center,
                    child:  GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 2/2,
                        crossAxisSpacing: 2/2,
                        mainAxisSpacing: 5/2,
                        children: List.generate(
                            imgList.length, (index) {
                          return InkWell(
                              onTap: (){
                               /* if (titleList[index].toString() == "Clock"){
                                  CustomNavigator.pushNavigate(context, TimeSheetClockScreen());
                                }*/
                              },
                              child: gridItem(imgList[index],myColors.app_theme,titleList[index],myColors.white,myColors.app_theme));
                        })
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }

  /// Gridview Items...............................
  gridItem(
      String img, Color color, String title, Color bgcolor, Color textcolor) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 120,
            width: 120,
            margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: bgcolor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: color, width: 0.6),
                boxShadow: [
                  BoxShadow(
                      color: myColors.app_theme.withOpacity(0.05),
                      spreadRadius: 2),
                ]),
            child: Image.asset(
              img,
              height: 35,
              width: 35,
              color: textcolor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: MyString.PlusJakartaSansSemibold,
                  fontSize: 13,
                  color: myColors.black),
            ),
          )
        ],
      ),
    );
  }

}

