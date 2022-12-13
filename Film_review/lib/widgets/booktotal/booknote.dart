import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/jingli.dart';
import 'package:film_review/model/jinglilist.dart';
import 'package:film_review/model/shuping.dart';
import 'package:film_review/model/shupinglist.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/shouye.dart';
import 'package:film_review/widgets/booktotal/addDigest.dart';
import 'package:film_review/widgets/booktotal/addreadsense.dart';
import 'package:film_review/widgets/booktotal/includebooklist.dart';
import 'package:film_review/widgets/booktotal/reading.dart';
import 'package:film_review/widgets/booktotal/readplan.dart';
import 'bookpingjia.dart';
import 'package:percent_indicator/percent_indicator.dart';

String url = "http://6a857704.r2.vip.cpolar.cn";
List<shuping> shupings = [];

int bookzp = 0;

class booknote extends StatelessWidget {
  book b1;
  List<bookdan> includebang = [];
  List<jingli> jinglis;
  yuduzhuangtai read1;
  String session_id;
  String userid;
  booknote(
      {Key key,
      this.b1,
      this.read1,
      this.includebang,
      this.jinglis,
      this.session_id,
      this.userid})
      : super(key: key);

  void getbookinfo() async {
    final dio = Dio();
    try {
      String bookid = b1.book_id.toString();
      final uri = Uri.parse(url + "/book_reaction_query?book_id=${bookid}");

      final uri2 = Uri.parse(url + "/experience_query");
      // 3.发送网络请求
      Response response, response2;
      response = await dio.getUri(uri);
      response2 = await dio.getUri(uri2);
      Map<String, dynamic> data = response.data;
      Map<String, dynamic> data2 = response2.data;
      print("${bookid} ");
      print(data.toString());
      if (data.toString() != "{code: 4}") {
        shupinglist bookpingshum = shupinglist.fromJson(data["content"]);
        shupings = bookpingshum.shupings;
      }
      jinglilist ans = jinglilist.fromJson(data2["content"]);
      //  yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);

      jinglis = ans.jilings;
      bookzp = 1;
      print("书摘书评成功 ${bookid}");
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getbookinfo();
    List<jingli> myjinglis = [];
    for (int i = 0; i < jinglis.length; i++) {
      if (jinglis[i].user_id == "test") {
        myjinglis.add(jinglis[i]);
      }
    }
    return Scaffold(
        appBar: AppBar(),
        body: new SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: new Border.all(
                    color: Colors.grey, //边框颜色
                    width: 1, //边框宽度
                  ), // 边色与边宽度
                  color: Colors.white, // 底色
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2, //阴影范围
                      spreadRadius: 1, //阴影浓度
                      color: Colors.grey, //阴影颜色
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20), // 圆角也可控件一边圆角大小
                  //borderRadius: BorderRadius.only(
                  //  topRight: Radius.circular(10),
                  // bottomRight: Radius.circular(10)) //单独加某一边圆角
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: getContentImage(),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                getTitleWidget(),
                                Spacer(),
                                _popupMenuButton2(context)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                              width: 10,
                            ),
                            Text("${b1.writer}"),
                            SizedBox(
                              height: 15,
                            ),
                            getstartWidget(),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => includebook(
                                                  includebang: includebang,
                                                )));
                                  },
                                  child: Text(
                                    "↗查看包含这本书的书单",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color:
                                            Color.fromARGB(255, 166, 168, 166)),
                                  )),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => reading(
                                                  b1: b1,
                                                  r1: read1,
                                                  session_id: session_id,
                                                )));
                                  },
                                  icon: Icon(Icons.alarm),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                _popupMenuButton(context, b1, session_id),
                                SizedBox(width: 5),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => bookpingjia(
                                                  shupings: shupings,
                                                  b1: b1,
                                                  session_id: session_id,
                                              userid: userid,
                                                )));
                                  },
                                  icon: Icon(Icons.chrome_reader_mode),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 1.0,
                indent: 0.0,
                color: Color.fromARGB(255, 120, 116, 116),
              ),
              yuedushuju(myjinglis),
              Divider(
                height: 1.0,
                indent: 0.0,
                color: Color.fromARGB(255, 120, 116, 116),
              ),
              SizedBox(
                height: 15,
              ),
              Text("书摘",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 52, 172, 181),
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 1.0,
                indent: 0.0,
                color: Color.fromARGB(255, 120, 116, 116),
              ),
              SizedBox(
                height: 5,
              ),
              Text("共${myjinglis.length}条"),
              bookdiget(myjinglis)
            ],
          ),
        )));
  }

  Widget getTitleWidget() {
    return  Container(
      width: 100,
      child:   Text("${b1.book_name}",
          maxLines: 2,
          style: TextStyle(

            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,)),

    );
  }

  Widget yuedushuju(List<jingli> myjinglis) {
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
            Text("${read1.create_time}",
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
            sumdata(myjinglis),
          ],
        )
      ]),
    );
  }

  Widget sumdata(List<jingli> myjinglis) {
    int sum = 0;
    for (int i = 0; i < read1.reading_times.length; i++) {
      sum += int.parse(read1.reading_times[i].toString().substring(18, 19));
      sum +=
          60 * int.parse(read1.reading_times[i].toString().substring(15, 16));
      sum +=
          3600 * int.parse(read1.reading_times[i].toString().substring(12, 13));
    }
    int hour = (sum ~/ 3600);
    int minute = (sum - 3600 * hour) ~/ 60;

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
                    Text("${hour}时${minute}分")
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
                    Text("${myjinglis.length}条")
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
                        Text("${read1.reading_times.length}天")
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
                    Text("${shupings.length}条")
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
      percent: int.parse(read1.reading_pages) / int.parse(read1.total_pages),
      center: new Text(
        "${read1.reading_pages}/${read1.total_pages}",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Color.fromARGB(255, 11, 118, 137),
    );
  }

  Widget getContentImage() {
    return Image(
      image: AssetImage('images/${b1.book_picture}'),
      height: 180,
    );
  }

  Widget getstartWidget() {
    //String ans = read1.create_time;
    return Text(
      "${b1.writer} / ${b1.publisher} /${b1.book_type}/${b1.publication_date}/${b1.price}",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 16),
    );
  }
}

Widget bookdiget(List<jingli> myjinglis) {
  return Column(
    children: [
      _builddiget(myjinglis),
    ],
  );
}

Widget _builddiget(List<jingli> myjinglis) {
  return new ListView.builder(
    padding: const EdgeInsets.all(16.0), // 设置padding
    itemBuilder: (context, index) {
      return bookdigetItem(index, myjinglis);
    },
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: myjinglis.length,
  );
}

Widget bookdigetItem(int i, List<jingli> myjinglis) {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        border: new Border.all(
          color: Colors.grey, //边框颜色
          width: 1, //边框宽度
        ), // 边色与边宽度
        color: Colors.white, // 底色
        boxShadow: [
          BoxShadow(
            blurRadius: 2, //阴影范围
            spreadRadius: 1, //阴影浓度
            color: Colors.grey, //阴影颜色
          ),
        ],
        // borderRadius: BorderRadius.circular(20), // 圆角也可控件一边圆角大小
        borderRadius:
            BorderRadius.only(bottomRight: Radius.circular(40)) //单独加某一边圆角
        ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 200,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  "P${i}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Spacer(),
                Text(
                  "2022-11-22 11:30",
                  style: TextStyle(
                    color: Color.fromARGB(255, 169, 174, 173),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Text("${myjinglis[i].content}"),
            SizedBox(
              height: 5,
            ),
            getContentImage2(),
            SizedBox(
              height: 5,
            ),
          ]),
        ),
      ],
    ),
  );
}

Widget getContentImage2() {
  return Image(
    image: AssetImage('images/haibao.webp'),
    height: 75,
    width: 120,
  );
}

PopupMenuButton _popupMenuButton(
    BuildContext context, book b1, String session_id) {
  return PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(Icons.bookmark),
              Text("书摘"),
            ],
          ),
          value: "书摘",
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(Icons.sd_card),
              Text("书评"),
            ],
          ),
          value: "书评",
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(Icons.date_range),
              Text("读书计划"),
            ],
          ),
          value: {"读书计划"},
        ),
      ];
    },
    onSelected: (value) {
      if (value == "书摘") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => digest(
                  session_id: session_id,
                )));
      } else if (value == "书评") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => readsense(
                  b1: b1,
                  session_id: session_id,
                )));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => readplan()));
      }
    },
    onCanceled: () {
      print("canceled");
    },
    color: Color.fromARGB(255, 142, 142, 142),
    icon: Icon(
      Icons.playlist_add,
      color: Color.fromARGB(255, 8, 143, 143),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        width: 2,
        color: Color.fromARGB(255, 180, 176, 176),
        style: BorderStyle.solid,
      ),
    ),
  );
}

PopupMenuButton _popupMenuButton2(BuildContext context) {
  return PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Text("编辑书籍"),
            ],
          ),
          value: "编辑书籍",
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Text("删除书籍"),
            ],
          ),
          value: "删除书籍",
        ),
      ];
    },
    onSelected: (value) {
      if (value == "编辑书籍") {
      } else if (value == "删除书籍") {}
    },
    onCanceled: () {
      print("canceled");
    },
    color: Color.fromARGB(255, 247, 247, 247),
    icon: Icon(Icons.keyboard_arrow_down),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        width: 2,
        color: Color.fromARGB(255, 249, 249, 249),
        style: BorderStyle.solid,
      ),
    ),
  );
}
