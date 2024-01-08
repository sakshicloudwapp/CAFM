import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';


class DeveloperSeries {
  final String year;
  final int developers;
  //final Color barColor;

  DeveloperSeries(
      {
        required this.year,
        required this.developers,
       // required this.barColor
      }
      );
}

class HomePage1 extends StatelessWidget {
  final List<DeveloperSeries> data = [

    DeveloperSeries(
      year: "PPM’s",
      developers: 25,
     // barColor: Colors.blue,
    ),
    DeveloperSeries(
      year: "Reactive",
      developers: 20,
    //  barColor: Colors.green.shade300,
    ),
    DeveloperSeries(
      year: "Corrective",
      developers: 15,
     // barColor: Colors.red.shade300,
    ),
    DeveloperSeries(
      year: "Sub Contractor",
      developers: 18,
    //  barColor: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mediadata = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: mediadata,
      child: Scaffold(
        body: Center(
            child: DeveloperChart(
              data: data,
            )
        ),
      ),
    );
  }
}


class DeveloperChart extends StatelessWidget {
  final List<DeveloperSeries> data;

  DeveloperChart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<Series<DeveloperSeries, String>> series = [
      Series(
          id: "developers",
          data: data,
          domainFn: (DeveloperSeries series, _) => series.year,
          measureFn: (DeveloperSeries series, _) => series.developers,
        //  colorFn: (DeveloperSeries series, _) => series.barColor
      )
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                "Yearly Growth in the Flutter Community",
              ),
              Expanded(
                child: BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }

}
