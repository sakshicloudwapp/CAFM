import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/model/models/GetWorkOrderByType.dart';
import 'package:fm_pro/model/models/resourceModel.dart';
import 'package:fm_pro/views/Reactive/accepted_jobs_screen.dart';
import 'package:fm_pro/views/Reactive/reactive_jobs_detail_screen.dart';
import 'package:fm_pro/views/tab_ppm_screen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:fm_pro/widgets/custom_texts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/my_string.dart';
import '../../model/models/getTaskLogDataModel.dart';
import '../../model/reactive_job_list_model.dart';
import '../../services/webservices.dart';
import '../../utils/list.dart';

List<ReactiveJobListModel> reactiveJobList = [];

class ReactiveWorkordersScreen extends StatefulWidget {
  Function callback;
  String serviceTypeId;
  Function updatestatus;
  String title;
  String appbartitle;

  ReactiveWorkordersScreen(
      {Key? key,
      required this.callback,
      required this.serviceTypeId,
      required this.updatestatus,
      required this.title,
      required this.appbartitle})
      : super(key: key);

  @override
  _ReactiveWorkordersScreenState createState() =>
      _ReactiveWorkordersScreenState();
}

class _ReactiveWorkordersScreenState extends State<ReactiveWorkordersScreen> {
  List<String> staticList = <String>[];
  String bodystatus = "dash_home";
  String statusId = "";
  String title = "";

  late Map<DateTime, List<dynamic>> _events;

  late List<dynamic> _selectedEvents;
  TextEditingController _eventController = TextEditingController();

  void initState() {
    super.initState();
    setmenuId();
    getapi();
    // _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
  }

  List<GetWorkOrderByTypeModel> getworkorderbytypelist = [];
  List<GetWorkOrderByTypeModel> main_gettasldatalist = [];
  List<GetWorkOrderByTypeModel> gettasldatalist = [];
  List<GetWorkOrderByTypeModel> activegettasldatalist = [];
  List<GetWorkOrderByTypeModel> complete_gettasldatalist = [];
  List<GetWorkOrderByTypeModel> Assigned_gettasldatalist = [];
  List<GetWorkOrderByTypeModel> contain_gettasldatalist = [];
  List<GetWorkOrderByTypeModel> accepted_gettasldatalist = [];
  List<GetWorkOrderByTypeModel> rejected_gettasldatalist = [];
  List<GetWorkOrderByTypeModel> on_hold_gettasldatalist = [];

  String checkstatus = "";

  String menuId = "";
  SharedPreferences? p;

  setmenuId() async {
    p = await SharedPreferences.getInstance();
    menuId = p!.getString("menu_ID").toString();
    setState(() {});
  }

  getapi() async {
    reactiveJobList.clear();
    getworkorderbytypelist.clear();
    await Webservices.RequestGetWorkByOrdersType(
        context, getworkorderbytypelist, true, widget.serviceTypeId);
    setState(() {});
    if (getworkorderbytypelist.isNotEmpty) {
      for (int i = 0; i < getworkorderbytypelist.length; i++) {
        if (getworkorderbytypelist[i].title == "All Jobs") {
          if (getworkorderbytypelist[i].title == "Assigned Jobs" ||
              getworkorderbytypelist[i].title == "Accepted Jobs" ||
              getworkorderbytypelist[i].title == "Active Jobs" ||
              getworkorderbytypelist[i].title == "On Hold Jobs") {
            main_gettasldatalist.add(getworkorderbytypelist[i]);
            ReactiveJobListModel model = ReactiveJobListModel(
                "All Jobs", getworkorderbytypelist[i].value.toString());
            reactiveJobList.add(model);
            setState(() {});
          } else {}
        } else if (getworkorderbytypelist[i].title == "Assigned Jobs") {
          Assigned_gettasldatalist.add(getworkorderbytypelist[i]);
          ReactiveJobListModel model = ReactiveJobListModel(
              "Assigned Jobs", getworkorderbytypelist[i].value.toString());
          reactiveJobList.add(model);
          setState(() {});
        } else if (getworkorderbytypelist[i].title == "Accepted Jobs") {
          accepted_gettasldatalist.add(getworkorderbytypelist[i]);
          ReactiveJobListModel model = ReactiveJobListModel(
              "Accepted Jobs", accepted_gettasldatalist.length.toString());
          reactiveJobList.add(model);
          setState(() {});
        } else if (getworkorderbytypelist[i].title == "Active Jobs") {
          activegettasldatalist.add(getworkorderbytypelist[i]);
          ReactiveJobListModel model = ReactiveJobListModel(
              "Active Jobs", getworkorderbytypelist[i].value.toString());
          reactiveJobList.add(model);
          setState(() {});
        } else if (getworkorderbytypelist[i].title == "Contain") {
          contain_gettasldatalist.add(getworkorderbytypelist[i]);
          ReactiveJobListModel model = ReactiveJobListModel(
              "Contain", getworkorderbytypelist[i].value.toString());
          reactiveJobList.add(model);
          setState(() {});
        } else if (getworkorderbytypelist[i].title == "Completed Jobs") {
          complete_gettasldatalist.add(getworkorderbytypelist[i]);
          ReactiveJobListModel model = ReactiveJobListModel(
              "Finished Jobs", getworkorderbytypelist[i].value.toString());
          reactiveJobList.add(model);
          setState(() {});
        } else if (getworkorderbytypelist[i].title == "Rejected Jobs") {
          rejected_gettasldatalist.add(getworkorderbytypelist[i]);
          ReactiveJobListModel model = ReactiveJobListModel(
              "Rejected Jobs", getworkorderbytypelist[i].value.toString());
          reactiveJobList.add(model);
          setState(() {});
        } else if (getworkorderbytypelist[i].title == "On Hold Jobs") {
          on_hold_gettasldatalist.add(getworkorderbytypelist[i]);
          ReactiveJobListModel model = ReactiveJobListModel(
              "On Hold Jobs", getworkorderbytypelist[i].value.toString());
          reactiveJobList.add(model);
          setState(() {});
        } else {}

        setState(() {});
      }
    }
  }


  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  onCallback(String status) {
    setmenuId();
    getapi();
    bodystatus = status;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.app_theme,
          appBar: bodystatus == "list_view"
              ? null
              : PreferredSize(
                  preferredSize: Size.fromHeight(90),
                  child: AppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: myColors.app_theme,
                      statusBarIconBrightness: Brightness.light,
                      statusBarBrightness:
                          Brightness.dark, // For iOS (dark icons)
                    ),
                    automaticallyImplyLeading: false,
                    backgroundColor: myColors.transparent,
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
                                    //Navigator.pop(context);
                                    this.widget.callback("", "home");
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
                                          widget.appbartitle,
                                          //   MyString.Reactive_Workorder,
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

                            //Calender............................................................................................................
                            /* Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
                            child: TableCalendar(
                              events: _events,
                              initialCalendarFormat: CalendarFormat.week,
                              formatAnimation: FormatAnimation.slide,
                              dayHitTestBehavior: HitTestBehavior.deferToChild,
                              availableGestures:
                                  AvailableGestures.horizontalSwipe,
                              calendarStyle: CalendarStyle(
                                  canEventMarkersOverflow: false,
                                  todayColor: myColors.app_theme,
                                  selectedColor: myColors.white,
                                  todayStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.white)),
                              headerVisible: true,
                              headerStyle: HeaderStyle(
                                //To change the name of month to single letter...............
                                titleTextBuilder: (date, locale) =>
                                    DateFormat.yMMM(locale)
                                        .format(date),

                                // centerHeaderTitle: true,
                                headerPadding:
                                    EdgeInsets.fromLTRB(12, 0, 0, 14),

                                formatButtonDecoration: BoxDecoration(
                                  color: myColors.app_theme,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),

                                leftChevronVisible: false,
                                rightChevronVisible: false,

                                formatButtonTextStyle:
                                    TextStyle(color: myColors.app_theme),
                                formatButtonShowsNext: false,
                                formatButtonVisible: false,

                                titleTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                              daysOfWeekStyle: DaysOfWeekStyle(
                                //To change the name of week to single letter...............
                                dowTextBuilder: (date, locale) =>
                                    DateFormat.E(locale).format(date)[0],

                                weekdayStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.white),

                                weekendStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.white),
                              ),
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              onDaySelected: (date, events, holidays) {
                                setState(() {
                                  _selectedEvents = events;
                                });
                              },
                              builders: CalendarBuilders(
                                selectedDayBuilder: (context, date, events) =>
                                    Container(
                                        margin: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: myColors.selected_calender,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Text(
                                          date.day.toString(),
                                          style:
                                              TextStyle(color: myColors.white),
                                        )),
                                dayBuilder: (context, date, events) =>
                                    Container(
                                        margin: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: myColors.app_theme,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )),
                                todayDayBuilder: (context, date, events) =>
                                    Container(
                                        margin: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: myColors.app_theme,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )),
                                holidayDayBuilder: (context, date, events) =>
                                    Container(
                                        margin: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: myColors.app_theme,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )),
                                weekendDayBuilder: (context, date, events) =>
                                    Container(
                                        margin: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: myColors.app_theme,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )),
                              ),
                              calendarController: _controller,
                            ),
                          ),

                          //Calender Icon..................................................................................
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.fromLTRB(8, 12, 28, 0),
                            child: SvgPicture.asset(
                              "assets/images/ic_new_calender.svg",
                              height: 18,
                              width: 18,
                            ),
                          ),
                        ],
                      ),*/

                            ..._selectedEvents.map((event) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: myColors.white,
                                        border:
                                            Border.all(color: myColors.white)),
                                    child: Center(
                                        child: Text(
                                      event,
                                      style: TextStyle(
                                          color: myColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    )),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          body: bodystatus == "dash_home"
              ?
          Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(34),
                        topRight: Radius.circular(34)),
                    color: myColors.white,
                  ),
                  child: Container(
                      margin: EdgeInsets.only(
                          left: 16, right: 16, top: 45, bottom: 0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            RefreshIndicator(
                              onRefresh: () {
                                return Future.delayed(
                                  Duration(seconds: 0),
                                  () {
                                    print("dbhjgj");
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) => getapi());
                                    setState(() {});
                                  },
                                );
                              },
                              child: getworkorderbytypelist.isNotEmpty
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView.builder(
                                          //  physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              getworkorderbytypelist.length,
                                          //reactiveJobList.length,
                                          itemBuilder: (context, int index) {
                                            return InkWell(
                                              onTap: () {
                                                checkstatus =
                                                    getworkorderbytypelist[
                                                            index]
                                                        .title
                                                        .toString();
                                                print(
                                                    "checkstatus>>>${checkstatus}");
                                                setState(() {});
                                                if (checkstatus == "All Jobs") {
                                                  main_gettasldatalist =
                                                      getworkorderbytypelist;
                                                  setState(() {});
                                                }
                                                else if (checkstatus ==
                                                    "Assigned Jobs") {
                                                  main_gettasldatalist =
                                                      Assigned_gettasldatalist;
                                                  setState(() {});
                                                }
                                                else if (checkstatus ==
                                                    "Active Jobs") {
                                                  main_gettasldatalist =
                                                      activegettasldatalist;
                                                  setState(() {});
                                                } else if (checkstatus ==
                                                    "Accepted Jobs") {
                                                  main_gettasldatalist =
                                                      accepted_gettasldatalist;
                                                  setState(() {});
                                                } else if (checkstatus ==
                                                    "Rejected Jobs") {
                                                  main_gettasldatalist =
                                                      rejected_gettasldatalist;
                                                  setState(() {});
                                                } else if (checkstatus ==
                                                    "On Hold Jobs") {
                                                  main_gettasldatalist =
                                                      on_hold_gettasldatalist;
                                                  setState(() {});
                                                } else if (checkstatus ==
                                                    "Completed Jobs") {
                                                  main_gettasldatalist =
                                                      complete_gettasldatalist;
                                                  setState(() {});
                                                } else if (checkstatus ==
                                                    "Contain Jobs") {
                                                  main_gettasldatalist =
                                                      contain_gettasldatalist;
                                                  setState(() {});
                                                }
                                                if (menuId == "3") {
                                                  bodystatus = "list_view";
                                                  statusId =
                                                      getworkorderbytypelist[
                                                              index]
                                                          .statusId
                                                          .toString();
                                                  title = 'Corrective W/O';
                                                  setState(() {});

                                                  // PersistentNavBarNavigator
                                                  //     .pushNewScreenWithRouteSettings(
                                                  //   context,
                                                  //   settings: RouteSettings(),
                                                  //   screen: TabPpmScreen(
                                                  //     statusId:
                                                  //     getworkorderbytypelist[index]
                                                  //         .statusId
                                                  //         .toString(),
                                                  //     serviceId: widget.serviceTypeId,
                                                  //     title: 'Corrective W/O',
                                                  //     isBack: 'true',
                                                  //
                                                  //     appbartitle: widget.appbartitle,
                                                  //   ),
                                                  //   withNavBar: false,
                                                  //   pageTransitionAnimation:
                                                  //   PageTransitionAnimation.cupertino,
                                                  // );
                                                } else if (menuId == "1") {
                                                  bodystatus = "list_view";
                                                  statusId =
                                                      getworkorderbytypelist[
                                                              index]
                                                          .statusId
                                                          .toString();
                                                  title = 'PPM W/O';
                                                  setState(() {});
                                                  // PersistentNavBarNavigator
                                                  //     .pushNewScreenWithRouteSettings(
                                                  //   context,
                                                  //   settings: RouteSettings(),
                                                  //   screen: TabPpmScreen(
                                                  //     statusId:
                                                  //     getworkorderbytypelist[index]
                                                  //         .statusId
                                                  //         .toString(),
                                                  //     serviceId: widget.serviceTypeId,
                                                  //     title: 'PPM W/O',
                                                  //     appbartitle: widget.appbartitle,
                                                  //     isBack: 'true',
                                                  //   ),
                                                  //   withNavBar: false,
                                                  //   pageTransitionAnimation:
                                                  //   PageTransitionAnimation.cupertino,
                                                  // );
                                                  //  Navigator.push(context, MaterialPageRoute(builder: (_)=> TabPpmScreen(statusId: getworkorderbytypelist[index].statusId.toString(),serviceId:widget.serviceTypeId, title: 'Corrective W/O')));
                                                } else if (menuId == "2") {
                                                  bodystatus = "list_view";
                                                  statusId =
                                                      getworkorderbytypelist[
                                                              index]
                                                          .statusId
                                                          .toString();
                                                  title = 'Reactive W/O';
                                                  setState(() {});
                                                  // PersistentNavBarNavigator
                                                  //     .pushNewScreenWithRouteSettings(
                                                  //   context,
                                                  //   settings: RouteSettings(),
                                                  //   screen: TabPpmScreen(
                                                  //     statusId:
                                                  //     getworkorderbytypelist[index]
                                                  //         .statusId
                                                  //         .toString(),
                                                  //     serviceId: widget.serviceTypeId,
                                                  //     title: 'Reactive W/O',
                                                  //     appbartitle: widget.appbartitle,
                                                  //     isBack: 'true',
                                                  //   ),
                                                  //   withNavBar: false,
                                                  //   pageTransitionAnimation:
                                                  //   PageTransitionAnimation.cupertino,
                                                  // );
                                                  //  Navigator.push(context, MaterialPageRoute(builder: (_)=> TabPpmScreen(statusId: getworkorderbytypelist[index].statusId.toString(),serviceId:widget.serviceTypeId, title: 'Corrective W/O')));
                                                } else if (menuId == '4') {
                                                  print(
                                                      "widget.serviceTypeId${widget.serviceTypeId}");
                                                  bodystatus = "list_view";
                                                  statusId =
                                                      getworkorderbytypelist[
                                                              index]
                                                          .statusId
                                                          .toString();
                                                  title =
                                                      'Soft Services PM W/O';
                                                  setState(() {});
                                                  // PersistentNavBarNavigator
                                                  //     .pushNewScreenWithRouteSettings(
                                                  //   context,
                                                  //   settings: RouteSettings(),
                                                  //   screen: TabPpmScreen(
                                                  //     statusId:
                                                  //     getworkorderbytypelist[index]
                                                  //         .statusId
                                                  //         .toString(),
                                                  //     serviceId: widget.serviceTypeId,
                                                  //     title: 'Soft Services PM W/O',
                                                  //     appbartitle: widget.appbartitle,
                                                  //     isBack: 'true',
                                                  //   ),
                                                  //   withNavBar: false,
                                                  //   pageTransitionAnimation:
                                                  //   PageTransitionAnimation.cupertino,
                                                  // );
                                                  //  Navigator.push(context, MaterialPageRoute(builder: (_)=> TabPpmScreen(statusId: getworkorderbytypelist[index].statusId.toString(),serviceId:widget.serviceTypeId, title: 'Corrective W/O')));
                                                } else {
                                                  //  widget.updatestatus(2,getworkorderbytypelist[index].statusId.toString());
                                                }
                                                setState(() {});
                                              },
                                              child: Container(
                                                child: ReactiveJobsList(
                                                  index: index,
                                                  title: getworkorderbytypelist[
                                                          index]
                                                      .title
                                                      .toString(),
                                                  count: getworkorderbytypelist[
                                                          index]
                                                      .value
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      child: nodata(),
                                    ),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      )),
                )
              : bodystatus == "list_view"
                  ? TabPpmScreen(
                      statusId: statusId,
                      serviceId: widget.serviceTypeId,
                      title: title,
                      isBack: 'true',
                      appbartitle: widget.appbartitle,
                      onCallback: onCallback,
                    )
                  : Container(),
        ));
  }

  nodata() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Image.asset("assets/new_images/no_data.gif")),
          //  hsized10,
          Text(
            "NO WORK ORDERS",
            style: TextStyle(
                color: myColors.app_theme,
                fontSize: 16,
                fontFamily: MyString.PlusJakartaSansBold),
          ),
          hsized10,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Currently you dont have any workorders",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: myColors.grey_27,
                  fontSize: 16,
                  fontFamily: MyString.PlusJakartaSansregular),
            ),
          ),
        ],
      ),
    );
  }

  ///Methods of Graph.........................................................................................................................
  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 5,
        maxY: 3,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_2,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: myColors.grey_seven,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '5';
        break;
      case 2:
        text = '10';
        break;
      case 3:
        text = '15';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.start);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 24,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        color: myColors.grey_seven,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: 0.4,
        fontFamily: "s_asset/font/raleway/Raleway-Regular.ttf");
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Mon', style: style);
        break;
      case 1:
        text = const Text('Tue', style: style);
        break;
      case 2:
        text = const Text('Wed', style: style);
        break;
      case 3:
        text = const Text('Thus', style: style);
        break;
      case 4:
        text = const Text('Fri', style: style);
        break;
      case 5:
        text = const Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 102,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(
      show: true,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: myColors.color_bar_bg,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: myColors.color_bar_bg,
          strokeWidth: 1,
        );
      },
      drawHorizontalLine: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: myColors.color_bar_bg),
          left: BorderSide(color: myColors.color_bar_bg),
          right: BorderSide(color: myColors.color_bar_bg),
          top: BorderSide(color: myColors.color_bar_bg),
        ),
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(
          colors: [myColors.color_bar, myColors.color_bar],
        ),
        barWidth: 2,
        isStrokeCapRound: true,
        isStepLineChart: false,
        aboveBarData: BarAreaData(color: Colors.red),
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
          /* gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [myColors.color_bar.withOpacity(0.60),myColors.color_bar.withOpacity(0.04)],
      ),*/
        ),
        spots: [
          FlSpot(0, 1),
          FlSpot(1, 0.5),
          FlSpot(2, 1.8),
          FlSpot(3, 1.8),
          FlSpot(4, 1.7),
          FlSpot(5, 2),
        ],
      );
}

class ReactiveJobsList extends StatefulWidget {
  int index;
  String title;
  String count;

  ReactiveJobsList(
      {required this.index, required this.title, required this.count});

  @override
  _ReactiveJobsListState createState() => _ReactiveJobsListState();
}

class _ReactiveJobsListState extends State<ReactiveJobsList> {
  @override
  Widget build(BuildContext context) {
    return widget.title == "Rejected Jobs"
        ? Container()
        : Container(
            height: 60,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            margin: EdgeInsets.fromLTRB(45, 8, 45, 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                color:
                    widget.index == 0 ? myColors.purple_1 : myColors.app_theme),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.title == "All Jobs"
                        ? Container()
                        : Container(
                            width: 34,
                            height: 34,
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: SvgPicture.asset(
                                widget.title == "Assigned Jobs"
                                    ? "assets/images/assignedtNew_icon.svg"
                                    : widget.title == "Accepted Jobs"
                                        ? "assets/images/acceptNew_icon.svg"
                                        : widget.title == "Rejected Jobs"
                                            ? "assets/images/rejectNew_icon.svg"
                                            : widget.title == "On Hold Jobs"
                                                ? "assets/images/householdNEw_icon.svg"
                                                : widget.title ==
                                                        "Completed Jobs"
                                                    ? "assets/images/completeNew_icon.svg"
                                                    : "assets/images/assignedtNew_icon.svg",
                                height: 16,
                                width: 16,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(
                          widget.title == "All Jobs" ? 10 : 0, 0, 0, 0),
                      child: CustomText.CustomMediumText(
                          widget.title == "Completed Jobs"
                              ? "Finished Jobs"
                              : widget.title,
                          widget.title == "All Jobs"
                              ? myColors.app_theme
                              : myColors.white,
                          FontWeight.w500,
                          15,
                          1,
                          TextAlign.center),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                  child: CustomText.CustomSemiBoldText(
                      widget.count,
                      widget.title == "All Jobs"
                          ? myColors.app_theme
                          : myColors.white,
                      FontWeight.w700,
                      20,
                      1,
                      TextAlign.center),
                ),
              ],
            ),
          );
  }
}

///Notification List.....................................................................................................................
class NotificationList extends StatefulWidget {
  int index;

  NotificationList({required this.index});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: myColors.orange),
        color: myColors.yellow_light,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: myColors.orange),
                child: SvgPicture.asset(
                  "assets/images/status_update.svg",
                  height: 20,
                  width: 22,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: CustomText.CustomSemiBoldText(
                        "Status Update",
                        myColors.grey_one,
                        FontWeight.w600,
                        12,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
                    child: CustomText.CustomRegularText(
                        "3:45 PM",
                        myColors.grey_two,
                        FontWeight.w400,
                        10,
                        1,
                        TextAlign.center),
                  ),
                ],
              )),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: CustomText.CustomLightText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do dolor sit amet, consectetur adipiscing elit, sed do .",
                myColors.grey_one,
                FontWeight.w300,
                12,
                2,
                TextAlign.center),
          ),
        ],
      ),
    );
  }
}
