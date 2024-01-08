import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  int _currentPage = 0;
  final _controller = PageController(initialPage: 0);
  final List<Color> gredient = [Color(0xc2003b73), Color(0xc20fe1c2)];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: data,
      child: Scaffold(
        backgroundColor: myColors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: myColors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: myColors.white,

              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: 300,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      myColors.color_bar.withOpacity(0.01),
                      myColors.color_bar.withOpacity(0.04)
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18),
                height: 200,
                width: double.infinity,
                child: LineChart(
                  sampleData2,
                  swapAnimationDuration: const Duration(milliseconds: 250),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 5,
        maxY: 4,
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
        // lineChartBarData2_1,
        lineChartBarData2_2,
        // lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case
          1:
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
        color: myColors.color_bar,
        fontWeight: FontWeight.bold,
        fontSize: 11.50,
        letterSpacing: 0.4,
        fontFamily: MyString.PlusJakartaSansregular,);
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

  FlGridData get gridData => FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.transparent),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
       isCurved: true,
         gradient: LinearGradient(
      colors: [myColors.color_bar,myColors.color_bar],
    ),
        barWidth: 4,
       isStrokeCapRound: true,
       isStepLineChart: false,
        aboveBarData: BarAreaData(color: Colors.red),
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
           gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [myColors.color_bar.withOpacity(0.60),myColors.color_bar.withOpacity(0.04)],
      ),
        ),
        spots:
            [
          FlSpot(0, 1),
          FlSpot(1, 0.5),
          FlSpot(2, 1.8),
          FlSpot(3, 1.8),
          FlSpot(4, 1.7),
          FlSpot(5, 2),
        ],
      );
}


/*
class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  late TooltipBehavior _tooltip;
  late List<ChartData> chartData ;

  @override
  void initState() {
    chartData = [
      ChartData('China', 12, 10, 14, 20),
      ChartData('USA', 14, 11, 18, 23),
      ChartData('UK', 16, 10, 15, 20),
      ChartData('Brazil', 18, 16, 18, 24)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      StackedColumnSeries<ChartData, String>(
                          groupName: 'Group A',
                          dataSource: chartData,
                          color: Colors.yellow,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y1
                      ),
                      StackedColumnSeries<ChartData, String>(
                          groupName: 'Group B',
                          dataSource: chartData,
                          color: Colors.red,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y2
                      ),
                      */
/*StackedColumnSeries<ChartData, String>(
                          groupName: 'Group A',
                          color: Colors.yellow,
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y3
                      ),
                      StackedColumnSeries<ChartData, String>(
                          groupName: 'Group B',
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y4
                      )*//*

                    ]
                )
            )
        )
    );
  }
}

class ChartData{
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
}*/
