import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class readdata extends StatelessWidget {
  const readdata({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(),
        body: new SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              kaitou(),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 1.0,
                indent: 0.0,
                color: Color.fromARGB(255, 120, 116, 116),
              ),
              yuedushuju(),
              Divider(
                height: 1.0,
                indent: 0.0,
                color: Color.fromARGB(255, 120, 116, 116),
              ),
              readrili()
            ],
          ),
        )));
  }

  Widget readrili() {
    CalendarController _controller;

    @override
    void initState() {
      _controller = CalendarController();
    }

    List<int> data2 = [];
    int sum;
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("阅读日历",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 10, 10, 10))),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: new Border.all(
                    width: 1, color: Color.fromARGB(255, 79, 78, 78))),
            child: MonthPageView(
              padding: EdgeInsets.all(1),
              scrollDirection: Axis.horizontal, // 水平滑动或者竖直滑动
              option: MonthOption(
                enableContinuous: true, // 单选、连选控制
                marks: {
                  DateDay.now().copyWith(day: 1): '111',
                },
              ),
              showWeekHead: true, // 显示星期头部
              onContinuousSelectListen: (firstDay, endFay) {}, // 连选回调
              onMonthChange: (month) {}, // 月份更改回调
              onDaySelected: (day, data, enable) {}, // 日期选中会迪欧啊
              onCreated: (controller) {}, // 控制器回调
            ),
          ), //  Text("${data2[1].toString()}   ${data2[0].toString()}")
        ],
      ),
    );
  }

  Widget yuedushuju() {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
      child: Column(children: [
        Row(
          children: [
            Text("阅读数据",
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 10, 10, 10))),
            SizedBox(
              width: 30,
            ),
            Text("开始时间:",
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 2, 86, 65))),
            SizedBox(width: 5),
            Text("2022年11月33日",
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 2, 86, 65)))
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Container(
              child: Column(children: [
                Text("阅读进度",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 168, 177, 175))),
                SizedBox(height: 15),
                jingdu(),
              ]),
            ),
            SizedBox(
              width: 15,
            ),
            sumdata(),
          ],
        )
      ]),
    );
  }

  Widget sumdata() {
    return Container(
        padding: EdgeInsets.only(right: 30, left: 30, top: 15, bottom: 15),
        child: Center(
          child: Row(children: [
            Column(
              children: [
                Column(
                  children: [
                    Text("阅读时间",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 168, 177, 175))),
                    SizedBox(
                      height: 15,
                    ),
                    Text("20 时 30 分")
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Text("书摘",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 168, 177, 175))),
                    SizedBox(
                      height: 15,
                    ),
                    Text("6条")
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Text("阅读天数",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 168, 177, 175))),
                        SizedBox(
                          height: 15,
                        ),
                        Text("6天")
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("书评",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 168, 177, 175))),
                    SizedBox(
                      height: 15,
                    ),
                    Text("0条")
                  ],
                )
              ],
            )
          ]),
        ));
  }

  Widget jingdu() {
    double ans;
    return new CircularPercentIndicator(
      radius: 40.0,
      lineWidth: 5.0,
      animation: true,
      percent: 0.7,
      center: new Text(
        "151/225",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Color.fromARGB(255, 11, 118, 137),
    );
  }

  Widget kaitou() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            child: Column(
          children: [
            getContentImage(),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 120,
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  "开始阅读",
                  style: TextStyle(color: Color.fromARGB(255, 245, 244, 247)),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 3, 127, 110))),
              ),
            )
          ],
        )),
        getContentDesc(),
      ],
    );
  }

  Widget getContentImage() {
    return Image(
      image: AssetImage('images/1668557646608.webp'),
      height: 180,
    );
  }

  Widget getContentDesc() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTitleWidget(),
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Spacer(),
                Text("(作者)"),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                "《百年孤独》，是哥伦比亚作家加西亚·马尔克斯创作的长篇小说，是其代表作，也是拉丁美洲魔幻现实主义文学的代表作，被誉为“再现拉丁美洲历史社会图景的鸿篇巨著”。作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一。",
                maxLines: 15,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 11,
                    color: Color.fromARGB(255, 146, 143, 143),
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget getTitleWidget() {
    return Stack(
      children: <Widget>[
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: "百年孤独",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ]),
          maxLines: 2,
        ),
      ],
    );
  }
}
