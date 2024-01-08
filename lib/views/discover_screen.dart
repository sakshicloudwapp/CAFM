import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/views/pie_chart_screen.dart';
import 'package:fm_pro/views/tabs_open_workorders_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../global/my_string.dart';
import '../widgets/custom_texts.dart';
import 'bar_graph_screen.dart';

///chart.............................
class ChartDataBar {
  ChartDataBar(this.x, this.y1, this.barColor);

  final String x;
  final int y1;
  final Color barColor;
}

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late List<ChartDataBar> chartDataBar;

  final dataMap = <String, double>{
    "PPM": 25,
    "Reactive": 03,
    "Corrective": 09,
    "Contractor": 18,
  };

  final legendLabels = <String, String>{
    "Flutter": "Flutter legend",
    "React": "React legend",
    "Xamarin": "Xamarin legend",
    "Ionic": "Ionic legend",
  };

  final colorList = <Color>[
    const Color(0xffD9F3FF),
    const Color(0xff66C7F5),
    const Color(0xff45748A),
    const Color(0xff41A1CE),
    const Color(0xff6c5ce7),
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      const Color.fromRGBO(175, 63, 62, 1.0),
      const Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = false;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 35;

  bool _showLegendsInRow = false;
  bool _showLegends = true;
  bool _showLegendLabel = false;

  bool _showChartValueBackground = false;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.rectangle;

  // LegendPosition? _legendPosition = LegendPosition.right;

  int key = 0;

  @override
  void initState() {
    chartDataBar = [
      ChartDataBar('PPM’s', 25, myColors.blue_ppm),
      ChartDataBar('Reactive', 20, myColors.green_reactive),
      ChartDataBar('Corrective', 16, myColors.pink_corrective),
      ChartDataBar('Sub Contractor', 18, myColors.green_subcontractor)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: math.min(MediaQuery.of(context).size.width / 2.3, 300),
      colorList: colorList,
      initialAngleInDegree: 90,
      chartType: _chartType!,
      centerText: _showCenterText ? "HYBRID" : null,
      legendLabels: _showLegendLabel ? legendLabels : {},
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        //  legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: MyString.PlusJakartaSansregular,
          color: myColors.grey_33,
          fontSize: 12,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        decimalPlaces: 0,
        chartValueStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontFamily: MyString.PlusJakartaSansregular,
          color: myColors.black,
          fontSize: 14,
        ),
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: const [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.app_theme,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: myColors.app_theme,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark, // For iOS (dark icons)
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
                                    MyString.Discover,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              color: myColors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Open.................................................................................
                  Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    margin: EdgeInsets.fromLTRB(20, 16, 20, 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: myColors.app_theme),
                        color: myColors.app_theme_light),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: myColors.app_theme),
                          child: Center(
                            child: Image.asset(
                              "assets/images/white_right.png",
                              height: 12,
                              width: 16,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                  child: CustomText.CustomMediumText(
                                      MyString.Open,
                                      myColors.grey_one,
                                      FontWeight.w500,
                                      14,
                                      1,
                                      TextAlign.center),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                                  child: CustomText.CustomRegularText(
                                      "Workorder",
                                      myColors.grey_34,
                                      FontWeight.w400,
                                      12,
                                      1,
                                      TextAlign.center),
                                ),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: CustomText.CustomBoldTextDM(
                              "56",
                              myColors.black,
                              FontWeight.w700,
                              20,
                              1,
                              TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  ///Pie chart.............................................................................
                  Container(
                    height: 180,
                    child: chart,
                  ),

                  ///View Details................................................................................
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: TabOpenWorkordersScreen(
                          title: MyString.Open,
                        ),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(24, 16, 24, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: myColors.app_theme,
                      ),
                      child: CustomText.CustomBoldText(
                          MyString.View_Details,
                          myColors.white,
                          FontWeight.w700,
                          14,
                          1,
                          TextAlign.center),
                    ),
                  ),

                  ///Completed....................................................................................
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: HomePage1(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                      setState(() {});
                    },
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      margin: EdgeInsets.fromLTRB(20, 16, 20, 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: myColors.green_accept),
                          color: myColors.active_green_light),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: myColors.green_accept),
                            child: Center(
                              child: Image.asset(
                                "assets/images/check_circle_white.png",
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: CustomText.CustomMediumText(
                                            MyString.Completed,
                                            myColors.grey_one,
                                            FontWeight.w500,
                                            14,
                                            1,
                                            TextAlign.center),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(6, 0, 0, 0),
                                        child: CustomText.CustomMediumText(
                                            "(Last one Year)",
                                            myColors.grey_35,
                                            FontWeight.w500,
                                            10,
                                            1,
                                            TextAlign.center),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                                    child: CustomText.CustomRegularText(
                                        "Workorder",
                                        myColors.grey_34,
                                        FontWeight.w400,
                                        12,
                                        1,
                                        TextAlign.center),
                                  ),
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: CustomText.CustomBoldTextDM(
                                "75",
                                myColors.black,
                                FontWeight.w700,
                                20,
                                1,
                                TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///Linear graph chart.............................................................................
                  Container(
                      height: 250,
                      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: SfCartesianChart(
                          borderWidth: 0,
                          plotAreaBorderColor: myColors.mytransparent,
                          enableSideBySideSeriesPlacement: false,
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
                                // text: 'Workorders per type',
                                textStyle: TextStyle(
                                    color: myColors.black,
                                    fontFamily:
                                        "assets/fonts/Poppins/Poppins-Regular.ttf",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)),
                            labelStyle: TextStyle(
                                color: myColors.grey_36,
                                fontFamily:
                                    "assets/fonts/Poppins/Poppins-Regular.ttf",
                                fontSize: 8,
                                fontWeight: FontWeight.w500),
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
                            maximum: 30,
                            maximumLabels: 6,
                            placeLabelsNearAxisLine: false,
                            labelPlacement: LabelPlacement.betweenTicks,
                            interval: 5,
                            axisLine: AxisLine(
                              color: myColors.color_bar_bg,
                              width: 0,
                            ),
                            title: AxisTitle(
                                // text: 'Performance',
                                textStyle: TextStyle(
                                    color: myColors.black,
                                    fontFamily:
                                        "assets/fonts/Poppins/Poppins-Regular.ttf",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)),
                            labelStyle: TextStyle(
                                color: myColors.grey_36,
                                fontFamily:
                                    "assets/fonts/Poppins/Poppins-Regular.ttf",
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
                            StackedColumnSeries<ChartDataBar, String>(
                                groupName: 'Group A',
                                dataSource: chartDataBar,
                                // color: myColors.blue_ppm,
                                width: 0.5,
                                pointColorMapper: (ChartDataBar data, _) =>
                                    data.barColor,
                                xValueMapper: (ChartDataBar data, _) => data.x,
                                yValueMapper: (ChartDataBar data, _) => data.y1,

                             /*   dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                  )*/
                            )
                          ])),

                  ///View Details................................................................................
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: TabOpenWorkordersScreen(
                          title: MyString.Completed,
                        ),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(24, 0, 24, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: myColors.app_theme,
                      ),
                      child: CustomText.CustomBoldText(
                          MyString.View_Details,
                          myColors.white,
                          FontWeight.w700,
                          14,
                          1,
                          TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
