import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter_my_picker/picker_view.dart';
import 'package:percent_indicator/percent_indicator.dart';

class shujujiegou extends StatelessWidget {
  const shujujiegou({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: new Border.all(
                    width: 1, color: Color.fromARGB(255, 181, 181, 181))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const LinearProgressIndicator(
                value: 0.5,
                minHeight: 10,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
              Row(
                children: [
                  Text("已看5部"),
                  SizedBox(
                    width: 25,
                  ),
                  Text("想看15部"),
                ],
              ),
              Text("总计： 42小时 25分钟")
            ]),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: new Border.all(
                    width: 1, color: Color.fromARGB(255, 181, 181, 181))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("月度数据",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 10, 10, 10))),
              Container(
                height: 300,
                child: getBar(),
              )
            ]),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: new Border.all(
                    width: 1, color: Color.fromARGB(255, 181, 181, 181))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    child: Text(
                      "已看且还没有发表过影评的影片",
                      maxLines: 10,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  jingdu(),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    child: Text(
                      "发表过影评的影片",
                      maxLines: 10,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Widget jingdu() {
    double ans;
    return new CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 15.0,
      animation: true,
      percent: 0.7,
      center: new Text(
        "33.3%",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Color.fromARGB(255, 11, 118, 137),
    );
  }

  Widget getBar() {
    List<Barsales> dataBar = [
      new Barsales("10月", 20),
      new Barsales("11月", 50),
      new Barsales("12月", 20),
      new Barsales("1月", 80),
      new Barsales("2月", 120),
    ];

    var seriesBar = [
      charts.Series(
        data: dataBar,
        domainFn: (Barsales sales, _) => sales.day,
        measureFn: (Barsales sales, _) => sales.sale,
        id: "Sales",
      )
    ];
    return charts.BarChart(seriesBar);
  }
}

//柱状图
class Barsales {
  String day;
  int sale;

  Barsales(this.day, this.sale);
}
