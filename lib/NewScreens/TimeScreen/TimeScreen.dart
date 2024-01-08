//import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_pro/NewScreens/TimeScreen/timeSheetBulkEdits_Screen.dart';
import 'package:fm_pro/NewScreens/TimeScreen/timeSheetClock_screen.dart';
import 'package:fm_pro/NewScreens/TimeScreen/timeSheetNFCTagScreen.dart';
import 'package:fm_pro/NewScreens/TimeScreen/timeSheetResource_screen.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/model/models/homePageModel.dart';
import 'package:fm_pro/views/profile_screens/NotificationScreen.dart';
import 'package:fm_pro/views/tab_home_screen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  List<String> titlelist=['Clock','Resources','Bulk Edits'];
  List<String> imglist=['assets/icons/ic_timer.svg','assets/icons/ic_people.svg','assets/icons/ic_task_square.svg'];
  String name = "";
  String user_name = "";
  String user_img = "";
  String user_designation = "";
  bool is_plumbing = false;

  List<HomePageModel> gethomepageList = [];
  List<HomePageDataModel> gethomepagedataList = [];
  List<ChartData> chartData = [];

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

    ///chart
    chartData = [
      ChartData('Jan', 80, 60, 0, 0),
      ChartData('Fab', 30, 18, 0, 0),
      ChartData('March', 50, 35, 0, 0),
      ChartData('April', 78, 50, 0, 0)
    ];
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    final data  =MediaQuery.of(context);
    return  MediaQuery(data: data.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(85),
            child: AppBar(
              backgroundColor: myColors.app_theme,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: myColors.white,
                // Status bar brightness (optional)
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              flexibleSpace: Container(
                color: myColors.white,
                padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
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
                        width: 75,
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              // alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/images/ic_notification.svg",
                                width: 30,
                                height: 30,
                                fit: BoxFit.fill,
                                color: myColors.black,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20,0,0,0),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: myColors.color_red,
                                    shape: BoxShape.circle),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: MyString.PlusJakartaSansregular,
                                      color: myColors.white,
                                    ),
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
            ),
          ),
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                hsized10,
                !is_plumbing ? plumbingissuecard() : Container(),
                hsized20,
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

                hsized20,
                /// Gridview...............................
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                 child:  GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 1.30/2,
                   crossAxisSpacing: 1/2,
                  mainAxisSpacing: 5/2,
                  children: List.generate(
                      imglist.length, (index) {
                    return InkWell(
                    onTap: (){
                      if (titlelist[index].toString() == "Clock"){
                        CustomNavigator.pushNavigate(context, TimeSheetClockScreen());
                      }else if (titlelist[index].toString() == "Resources"){
                        CustomNavigator.pushNavigate(context, TimeSheetResourceScreen());
                      }else {
                        CustomNavigator.pushNavigate(context, TimeSheetBulkEditScreen());
                      }
                      },
                      child: gridItem(imglist[index],myColors.app_theme,titlelist[index],myColors.white,myColors.black));
                  })
                ),
                ),

                /// Write new NFC ....................
                InkWell(
                  onTap: (){
                    CustomNavigator.pushNavigate(context, TimeSheetNFCTagScreen());
                  },
                  child: Container(
                    //margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    width: MediaQuery.of(context).size.width/1.5,
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    decoration: BoxDecoration(
                      color: myColors.app_theme,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/ic-wifi.png",height: 25,width: 25,),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Write new NFC",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          fontFamily: MyString.PlusJakartaSansregular,
                          color: myColors.white

                        ),
                        )
                      ],
                    ),
                  ),
                ),

                //Graph............................................................................................................
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 15, 15),
                      child: Text(
                        "Team Reports",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily:
                          MyString.PlusJakartaSansBold,
                          color: myColors.black,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(15, 8, 15, 20),
                        child:graphui()
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 15, 20, 15),
                  width: MediaQuery.of(context).size.width/1.12,
                  decoration: BoxDecoration(
                      color: myColors.dark_blue1,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icons/ic_req.png",height: 25,width: 25,),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Have any requests ",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily:
                                MyString.PlusJakartaSansBold,
                                color: myColors.white,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Lorem Ipsum dolemite inki",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily:
                                MyString.PlusJakartaSansregular,
                                color: myColors.white,
                                fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){

                        },
                        child: Text("Click Here",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: MyString.PlusJakartaSansBold,
                              fontSize: 10,
                              color: myColors.white
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }
  /// Plumbing card ui........................
  plumbingissuecard() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      // height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFFF8B806),
                const Color(0xFFFF8C04),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(10.0
          )
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 25, 20),
            child: Image.asset("assets/images/esclamation_icon.png",height: 30,width: 30,),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Plumbing Issue",
                style: TextStyle(
                    fontFamily: MyString.PlusJakartaSansBold,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Request raised  , will get back you soon",
                style: TextStyle(
                    fontFamily: MyString.PlusJakartaSansregular,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                ),
              )
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10
                  , 20),
              child: Text("27-08-2023",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 8,
                    fontFamily: MyString.PlusJakartaSansBold,
                    color: myColors.white
                ),
              )
          ),
          Expanded(
            child: InkWell(
                onTap: (){
                  is_plumbing = false;
                  print("is_hide........$is_plumbing");
                  setState(() {
                  });
                },
                child: Image.asset("assets/images/cross_icon.png",height: 20,width: 20,)),
          ),

        ],
      ),
    );

    // Container(
    //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //   decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //           colors: [myColors.light_orange2, myColors.light_orange2],
    //           begin: Alignment.centerLeft,
    //           end: Alignment.centerRight),
    //       borderRadius: BorderRadius.circular(10)),
    //   child: Row(
    //     children: [
    //       /// First Container..............................
    //       Container(
    //         child: SvgPicture.asset(
    //           "assets/icons/Icon_!.svg",
    //           height: 30,
    //           width: 30,
    //         ),
    //       ),
    //
    //       /// Second  Container...............................
    //       Expanded(
    //         child: Container(
    //           padding: EdgeInsets.only(left: 10, right: 10),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     "Plumbing Issue",
    //                     style: TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 12.20,
    //                         fontFamily: "PlusJakartaSansBold",
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                   Text(
    //                     "27-08-2023",
    //                     style: TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 10,
    //                         fontFamily: "PlusJakartaSansBold",
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ],
    //               ),
    //               Text(
    //                 "Request raised  , will get back you soon",
    //                 style: TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 12.20,
    //                     fontFamily: "PlusJakartaSansmedium",
    //                     fontWeight: FontWeight.w500),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //
    //       /// Third Container..............................
    //       GestureDetector(
    //         onTap: () {
    //           is_plumbing = true;
    //           setState(() {});
    //         },
    //         child: Container(
    //           child: SvgPicture.asset(
    //             "assets/icons/clear.svg",
    //             height: 25,
    //             width: 25,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  /// Gridview Items...............................
  gridItem(
      String img, Color color, String title, Color bgcolor, Color textcolor) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
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
            child: SvgPicture.asset(
              img,
              height: 30,
              width: 30,
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


  /// graph ui.......

  graphui(){
    return  SfCartesianChart(
        borderWidth: 0,
        plotAreaBorderColor: myColors.mytransparent,
        enableSideBySideSeriesPlacement: true,
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
          labelPlacement: LabelPlacement.betweenTicks,
          interval: 1,
          placeLabelsNearAxisLine: false,
          // arrangeByIndex: true
          labelAlignment: LabelAlignment.end,
          axisLine: AxisLine(
            color: myColors.color_bar_bg,
            width: 0,
          ),
          title: AxisTitle(
              text: 'Months',
              textStyle: TextStyle(
                  color: myColors.black,
                  fontFamily:
                  MyString.PlusJakartaSansregular,
                  fontSize: 10,
                  fontWeight: FontWeight.w500)),

          labelStyle: TextStyle(
              color: myColors.label_bar,
              fontFamily:
              MyString.PlusJakartaSansregular,
              fontSize: 8,
              fontWeight: FontWeight.w400),

          majorTickLines: MajorTickLines(
            size: 0,
            width: 0,
          ),

          minorTickLines: MinorTickLines(
            size: 0,
            width: 0,
          ),

          majorGridLines: MajorGridLines(
            color: myColors.color_bar_bg,
            width: 1,
            // dashArray: <double>[5,5]
          ),
          minorGridLines: MinorGridLines(
            color: myColors.color_bar_bg,
            width: 1,
          ),
        ),
        primaryYAxis: CategoryAxis(
          minimum: 0,
          maximum: 100,
          maximumLabels: 6,
          placeLabelsNearAxisLine: false,
          // labelFormat: '{value} ',
          labelPlacement: LabelPlacement.betweenTicks,
          interval: 20,
          axisLine: AxisLine(
            color: myColors.color_bar_bg,
            width: 0,
          ),
          title: AxisTitle(
              text: 'Employess',
              textStyle: TextStyle(
                  color: myColors.black,
                  fontFamily:
                  MyString.PlusJakartaSansregular,
                  fontSize: 11,
                  fontWeight: FontWeight.w400)),
          labelStyle: TextStyle(
              color: myColors.grey_seven,
              fontFamily:
              MyString.PlusJakartaSansregular,
              fontSize: 8,
              fontWeight: FontWeight.w400),

          majorTickLines: MajorTickLines(
            size: 0,
            width: 0,
          ),
          minorTickLines: MinorTickLines(
            size: 0,
            width: 0,
          ),
          majorGridLines: MajorGridLines(
            color: myColors.color_bar_bg,
            width: 1,
            // dashArray: <double>[5,5]
          ),
          minorGridLines: MinorGridLines(
            color: myColors.color_bar_bg,
            width: 1,
          ),
        ),
        series: <ChartSeries>[
          StackedColumnSeries<ChartData, String>(
              groupName: 'Group A',
              dataSource: chartData,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
              color: myColors.green_1,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y1),
          StackedColumnSeries<ChartData, String>(
              groupName: 'Group B',
              dataSource: chartData,
              color: myColors.red_1,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y2),
        ]);
  }

}
