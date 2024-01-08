import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/resourceModel.dart';
import 'package:fm_pro/views/PPM/wo_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../global/global_theme_button.dart';
import '../../global/my_string.dart';
import '../../model/models/getTaskLogDataModel.dart';
import '../../widgets/custom_texts.dart';

class ReactiveModel {
  String title;
  bool isChecked;
  bool isAssigned;

  ReactiveModel(this.title, this.isChecked, this.isAssigned);
}

List<ReactiveModel> reactiveCheckList = [];
List<String> assignedList = [];

class PPM_DetailScreen extends StatefulWidget {
  String title;
  //List<GetTaskLogDataResponse> gettasldatalist;
  List<Resources> gettasldatalist;

   PPM_DetailScreen({Key? key,required this.title,required this.gettasldatalist}) : super(key: key);

  @override
  _PPM_DetailScreenState createState() => _PPM_DetailScreenState();
}

class _PPM_DetailScreenState extends State<PPM_DetailScreen> {
  String selected_icon = "";

  onCallBack(String title) {
    selected_icon = title;
    setState(() {});
  }

  void initState() {
    super.initState();
    assignedList.clear();

    reactiveCheckList = [
      ReactiveModel("ahgh", false, false),
      ReactiveModel("ahgh", false, false),
      ReactiveModel("ahgh", false, false),
      ReactiveModel("ahgh", false, false),
      ReactiveModel("ahgh", false, false),
      ReactiveModel("ahgh", false, false),
      ReactiveModel("ahgh", false, false),
      ReactiveModel("ahgh", false, false),
      ReactiveModel("ahgh", false, false),
      ReactiveModel("ahgh", false, false),
      ReactiveModel("ahgh", false, false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(170),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: myColors.app_theme,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark, // For iOS (dark icons)
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
                                    MyString.PPM,
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
                                  contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                ),
                                maxLines: 1,
                                cursorColor: myColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //After Search...............................................................................................................
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Row(
                          children: [
                            ///Filter.....................
                            InkWell(
                              onTap: () {
                                selected_icon = "filter";

                                //Open Bottomsheet Filter......................................................................................
                                showModalBottomSheet<void>(
                                  enableDrag: false,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40)),
                                  ),
                                  builder: (BuildContext context) {
                                    return Container(
                                        height: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                                          color: myColors.white,
                                        ),
                                        child: BottomSheetFilterUI(
                                          callback: onCallBack,
                                        ));
                                  },
                                );

                                setState(() {});
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selected_icon == "filter"
                                      ? myColors.cyan
                                      : myColors.app_theme,
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                      "assets/images/ic_filter_white.svg",
                                      height: 16,
                                      width: 16,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),

                            ///Arrow Down.................
                            InkWell(
                              onTap: () {
                                selected_icon = "arrow_down";
                                setState(() {});
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selected_icon == "arrow_down"
                                      ? myColors.cyan
                                      : myColors.app_theme,
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                      "assets/images/ic_down_white.svg",
                                      height: 16,
                                      width: 16,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),

                            ///Refresh....................
                            InkWell(
                              onTap: () {
                                selected_icon = "refresh";
                                setState(() {});
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selected_icon == "refresh"
                                      ? myColors.cyan
                                      : myColors.app_theme,
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                      "assets/images/refresh_ccw.svg",
                                      height: 16,
                                      width: 16,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),

                            Expanded(child: Container()),

                            ///Select Date................
                            InkWell(
                              onTap: () {
                                selected_icon = "calender";
                                setState(() {});
                                //Open Bottomsheet Calender......................................................................................
                                showModalBottomSheet<void>(
                                  enableDrag: false,
                                  isScrollControlled: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40)),
                                  ),
                                  builder: (BuildContext context) {
                                    return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(40)),
                                          color: myColors.white,
                                        ),
                                        height:470,
                                        child: BottomSheetCalenderUI(
                                          callback: onCallBack,
                                        ));
                                  },
                                );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: CustomText.CustomBoldTextDM(
                                          MyString.Select_Date,
                                          myColors.white,
                                          FontWeight.w700,
                                          12,
                                          1,
                                          TextAlign.center),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 4),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: selected_icon == "calender"
                                            ? myColors.cyan
                                            : myColors.app_theme,
                                      ),
                                      child: Center(
                                          child: SvgPicture.asset(
                                            "assets/images/ic_calender_white.svg",
                                            height: 16,
                                            width: 16,
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  ],
                                ),
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
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: myColors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(24, 20, 0, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: MyString.PlusJakartaSansBold,
                        color: myColors.dark_grey_txt,
                      ),
                    ),
                  ),
                  //list................................................................................................................................
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: reactiveCheckList.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                // PersistentNavBarNavigator.pushNewScreen(
                                //   context,
                                //   screen: WO_Detail_Screen(taskLogId: '', OnCallback: (){}, serviceId: '', loaction: '', title: '',),
                                //   withNavBar: false, // OPTIONAL VALUE. True by default.
                                //   pageTransitionAnimation: PageTransitionAnimation.fade,
                                // );
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 3),
                                child: PPM_list(index: index, btn_name: widget.title,),
                              ),
                            );
                          })),

                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

///Bottomsheet Filter UI......................
class BottomSheetFilterUI extends StatefulWidget {
  Function callback;

  BottomSheetFilterUI({Key? key, required this.callback}) : super(key: key);

  @override
  _BottomSheetFilterUIState createState() => _BottomSheetFilterUIState();
}

class _BottomSheetFilterUIState extends State<BottomSheetFilterUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: CustomText.CustomRegularTextDM(MyString.Filter_Options,
                    myColors.black, FontWeight.w500, 16, 1, TextAlign.center),
              ),
              Expanded(child: Container()),

              ///Cross..............
              InkWell(
                onTap: () {
                  this.widget.callback("");
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: SvgPicture.asset("assets/images/ic_cross.svg"),
                ),
              ),
            ],
          ),

          Row(
            children: [
              ///By Category........................................................................
              Container(
                  height: 30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 8),
                  padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: myColors.orange),
                    color: myColors.light_orange,
                  ),
                  child: CustomText.CustomRegularTextDM(
                      MyString.By_Category,
                      myColors.orange,
                      FontWeight.w400,
                      14,
                      1,
                      TextAlign.center)),

              ///By ID........................................................................
              Container(
                  height: 30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 8),
                  padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: myColors.orange),
                    color: myColors.light_orange,
                  ),
                  child: CustomText.CustomRegularTextDM(
                      MyString.By_ID,
                      myColors.orange,
                      FontWeight.w400,
                      14,
                      1,
                      TextAlign.center)),

              ///By Date........................................................................
              Container(
                  height: 30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 8),
                  padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: myColors.orange),
                    color: myColors.light_orange,
                  ),
                  child: CustomText.CustomRegularTextDM(
                      MyString.By_Date,
                      myColors.orange,
                      FontWeight.w400,
                      14,
                      1,
                      TextAlign.center)),
            ],
          ),

          Row(
            children: [
              ///By Assigned........................................................................
              Container(
                  height: 30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(3, 6, 3, 8),
                  padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: myColors.orange),
                    color: myColors.light_orange,
                  ),
                  child: CustomText.CustomRegularTextDM(
                      MyString.By_Assigned,
                      myColors.orange,
                      FontWeight.w400,
                      14,
                      1,
                      TextAlign.center)),
            ],
          ),

          //DONE Button..................................................................................................
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.fromLTRB(6, 20, 6, 0),
              child: GlobalThemeButton(
                buttonName: MyString.DONE,
                buttonColor: myColors.app_theme,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///Bottomsheet Calender UI......................

class BottomSheetCalenderUI extends StatefulWidget {
  Function callback;

  BottomSheetCalenderUI({Key? key, required this.callback}) : super(key: key);

  @override
  _BottomSheetCalenderUIState createState() => _BottomSheetCalenderUIState();
}

class _BottomSheetCalenderUIState extends State<BottomSheetCalenderUI> {
  DateTime _currentDate = DateTime.now();
  String _currentMonth = DateFormat.yMMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: myColors.transparent, width: 2.0)),
    /* child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),*/
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          //   icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: myColors.transparent,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: myColors.transparent,
            height: 5.0,
            width: 5.0,
          ),
          // icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: myColors.transparent,
            height: 5.0,
            width: 5.0,
          ),
          // icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2019, 2, 25),
        new Event(
          date: new DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: myColors.transparent,
            height: 5.0,
            width: 5.0,
          ),
        ));

    _markedDateMap.add(
        new DateTime(2019, 2, 10),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 4',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: myColors.transparent,
            height: 5.0,
            width: 5.0,
          ),
        ));

    _markedDateMap.addAll(new DateTime(2019, 2, 11), [
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          color: myColors.transparent,
          height: 5.0,
          width: 5.0,
        ),
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: myColors.app_theme,
      onDayPressed: (date, events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,

      weekendTextStyle: TextStyle(
        color: myColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),

      //week names....
      weekdayTextStyle: TextStyle(
        color: myColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 13,
      ),

      weekDayFormat: WeekdayFormat.short,

      daysTextStyle: TextStyle(
        color: myColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      staticSixWeekFormat: true,

      thisMonthDayBorderColor: myColors.white,
      weekFormat: false,
      dayPadding: 1,
      dayButtonColor: myColors.transparent,
      selectedDayButtonColor: myColors.app_theme,
      selectedDayBorderColor: myColors.app_theme,
      markedDatesMap: _markedDateMap,
      height: 260.0,
      selectedDateTime: _currentDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: myColors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      todayButtonColor: myColors.app_theme,
      selectedDayTextStyle: TextStyle(
        color: myColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: myColors.grey_seven,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: myColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Container(
      padding: EdgeInsets.fromLTRB(12, 12, 12, 80),
      child: Wrap(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: CustomText.CustomRegularTextDM(MyString.Date,
                    myColors.black, FontWeight.w500, 16, 1, TextAlign.center),
              ),
              Expanded(child: Container()),

              ///Cross..............
              InkWell(
                onTap: () {
                  this.widget.callback("");
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: SvgPicture.asset("assets/images/ic_cross.svg"),
                ),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 8, 8, 0),
                child: CustomText.CustomRegularTextDM(
                    MyString.Start_date,
                    myColors.grey_eight,
                    FontWeight.w500,
                    15,
                    1,
                    TextAlign.center),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/images/ic_arrow_right_black.svg",
                  width: 24,
                  height: 16,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: CustomText.CustomRegularTextDM(
                    MyString.End_date,
                    myColors.grey_eight,
                    FontWeight.w500,
                    15,
                    1,
                    TextAlign.center),
              ),
            ],
          ),

          ///Calender...

          /*Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: _calendarCarousel,
          ),*/
          // This trailing comma makes auto-formatting nicer for build methods.
          //custom icon without header
          Container(
            margin: EdgeInsets.only(
              top: 10.0,
              bottom: 0.0,
              left: 10.0,
              right: 10.0,
            ),
            child: new Row(
              children: <Widget>[
                TextButton(
                  child:
                  SvgPicture.asset("assets/images/ic_arrow_previous.svg"),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month - 1);
                      _currentMonth =
                          DateFormat.yMMMM().format(_targetDateTime);
                    });
                  },
                ),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: CustomText.CustomRegularTextDM(
                            _currentMonth,
                            myColors.grey_eight,
                            FontWeight.w500,
                            15,
                            1,
                            TextAlign.center))),
                TextButton(
                  child: Text(''),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month + 1);
                      _currentMonth =
                          DateFormat.yMMMM().format(_targetDateTime);
                    });
                  },
                )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: _calendarCarouselNoHeader,
          ),

          //DONE Button..................................................................................................
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: GlobalThemeButton(
                buttonName: MyString.DONE,
                buttonColor: myColors.app_theme,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemModel {
  String title;
  String image;

  ItemModel(this.title, this.image);
}

///PPM List................................................................................................................................................................................................
class PPM_list extends StatefulWidget {
  int index;
  String btn_name;
   PPM_list({Key? key,required this.index,required this.btn_name}) : super(key: key);

  @override
  _PPM_listState createState() => _PPM_listState();
}

class _PPM_listState extends State<PPM_list> {
  late List<ItemModel> menuItems;
  CustomPopupMenuController _controller = CustomPopupMenuController();
  @override
  void initState() {
    menuItems = [
      ItemModel('Accept', "assets/images/img_green_right.png"),
      ItemModel('Reject', "assets/images/img_red_wrong.png"),
    ];
    setState(() {

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: reactiveCheckList[widget.index].isChecked == true ? myColors.active_twelve: myColors.grey_border),
        color:reactiveCheckList[widget.index].isChecked == true ? myColors.white : myColors.app_theme_light
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: CustomText.CustomSemiBoldText("# MMN14349",
                      myColors.app_theme, FontWeight.w600, 12, 1, TextAlign.center),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 43,
                          padding: EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          child: CustomText.CustomBoldTextDM(
                              "Status",
                              myColors.black,
                              FontWeight.w400,
                              12,
                              1,
                              TextAlign.center)),
                      ///button..............
                      Container(
                        alignment: Alignment.center,
                        height: 18,
                        width: 50,
                        margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: widget.btn_name == "All" ? myColors.app_theme :
                          widget.btn_name == "Accepted" ? myColors.accepted_color :
                          widget.btn_name == "Rejected" ? myColors.red_reject :
                          widget.btn_name == "On Hold" ? myColors.onhold_color :
                          widget.btn_name == "Completed" ? myColors.green_accept :
                          widget.btn_name == "Assigned" ? myColors.blue_assigned :
                          myColors.app_theme,
                        ),
                        child: CustomText.CustomBoldText(
                            widget.btn_name == "All" ? MyString.New : widget.btn_name,
                            myColors.white,
                            FontWeight.w700,
                            8,
                            1,
                            TextAlign.center),
                      ),
                      ///Three dots.........
                      Visibility(
                        visible: widget.btn_name == "All/",
                        child: Container(
                          child: CustomPopupMenu(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                              width: 21,
                              height: 21,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(60)),
                                color: myColors.grey_nine,
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/img_three_dots_theme.png",
                                  height: 20,
                                  width: 10,
                                ),
                              ),
                            ),

                            menuBuilder: () => ClipRect(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: myColors.active_ten),
                                  color: myColors.white,
                                ),
                                child: IntrinsicWidth(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: menuItems
                                        .map(
                                          (item) => GestureDetector(
                                        behavior:
                                        HitTestBehavior.translucent,
                                        onTap: () {
                                          print("onTap");
                                          popupReject();
                                          _controller.hideMenu();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(16, 7, 16, 7),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: Center(child: Image.asset(item.image,height: 20,width: 20,)),
                                              ),
                                              Expanded(
                                                child: Container(
                                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                    child: CustomText.CustomSemiBoldText(item.title
                                                        , myColors.black, FontWeight.w600, 12, 1, TextAlign.center)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                            pressType: PressType.singleClick,
                            verticalMargin: -10,
                            controller: _controller,
                          ),
                        ),
                      ),
                      ///Arrow............
                      InkWell(
                        onTap: () {
                          reactiveCheckList[widget.index].isChecked =
                          !reactiveCheckList[widget.index].isChecked;
                          setState(() {});
                        },
                        child: Container(
                          width: 25,
                          height: 30,
                          child: Center(
                              child: SvgPicture.asset(
                                reactiveCheckList[widget.index].isChecked == true
                                    ? "assets/images/ic_arrow_down_grey.svg"
                                    : "assets/images/ic_arrow_right_grey.svg",
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Visibility(
            visible: reactiveCheckList[widget.index].isChecked,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
              child: Column(
                children: [
                  Container(
                    height: 1.2,
                    color: myColors.active_twelve,
                  ),

                  ///Location....
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: CustomText.CustomMediumText(
                              "Location :",
                              myColors.grey_eleven,
                              FontWeight.w500,
                              12,
                              1,
                              TextAlign.center),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: CustomText.CustomMediumText(
                              "Khadiya Tower | Location (common area)",
                              myColors.grey_one,
                              FontWeight.w400,
                              12,
                              1,
                              TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              ///Problem.....
                              Container(
                                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: CustomText.CustomMediumText(
                                          "Problem :",
                                          myColors.grey_eleven,
                                          FontWeight.w500,
                                          12,
                                          1,
                                          TextAlign.center),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: CustomText.CustomMediumText(
                                          "Backstore lights busted 6 no’s",
                                          myColors.grey_one,
                                          FontWeight.w400,
                                          12,
                                          1,
                                          TextAlign.center),
                                    ),
                                  ],
                                ),
                              ),

                              ///due date....
                              Container(
                                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: CustomText.CustomMediumText(
                                          "Due Date :",
                                          myColors.grey_eleven,
                                          FontWeight.w500,
                                          12,
                                          1,
                                          TextAlign.center),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: CustomText.CustomMediumText(
                                          "20 sep 2022 17:48:36",
                                          myColors.grey_one,
                                          FontWeight.w400,
                                          12,
                                          1,
                                          TextAlign.center),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: 70,
                          padding: EdgeInsets.fromLTRB(0, 22, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 22,
                                      height: 22,
                                      margin: EdgeInsets.only(bottom: 2),
                                      child: Image.asset("assets/images/img_green_right.png"),
                                    ),
                                    CustomText.CustomSemiBoldText(MyString.Accept,
                                        myColors.green_accept, FontWeight.w500, 9, 1, TextAlign.center)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  print("onTap");
                                  popupReject();
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 2),
                                        width: 22,
                                        height: 22,
                                        child: Image.asset("assets/images/img_red_wrong.png"),
                                      ),
                                      CustomText.CustomSemiBoldText(MyString.Reject,
                                          myColors.red_reject, FontWeight.w500, 9, 1, TextAlign.center)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future popupReject() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        content: Container(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: myColors.active_twelve),
              color:Colors.transparent,
          ),
          height: 256,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: CustomText.CustomSemiBoldText("# MMN14349", myColors.app_theme, FontWeight.w600, 14, 1, TextAlign.center),
              ),
              Container(
                height: 1.2,
                color: myColors.active_twelve,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: CustomText.CustomSemiBoldText(MyString.Reason_Of_Rejection, myColors.grey_ten, FontWeight.w500, 12, 1, TextAlign.center),
              ),
              Container(
                height: 90,
                margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),

                ),
                child:  Container(
                  alignment: Alignment.center,
                  height: 82,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/rect_dashed.png"),
                      ),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
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
                      hintText: "Reason...",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: myColors.grey_ten,
                          fontFamily:
                          MyString.PlusJakartaSansregular,),
                      counter: Offstage(),
                      isDense: true,
                      // this will remove the default content padding
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                    ),
                    maxLines: 3,
                    cursorColor: myColors.black,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context); // passing false
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: myColors.app_theme,
                  ),
                  child: CustomText.CustomBoldText(MyString.SUBMIT, myColors.white, FontWeight.w700, 14, 1, TextAlign.center)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
