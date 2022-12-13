import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/jingli.dart';
import 'package:film_review/model/jinglilist.dart';
import 'package:film_review/model/shuping.dart';
import 'package:film_review/model/shupinglist.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/widgets/booktotal/addDigest.dart';
import 'package:film_review/widgets/booktotal/addreadsense.dart';
import 'package:film_review/widgets/booktotal/bookpingjia.dart';
import 'package:film_review/widgets/booktotal/includebooklist.dart';
import 'package:film_review/widgets/booktotal/readplan.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;

String url = "http://6a857704.r2.vip.cpolar.cn";
List<shuping> shupings;

int bookzp = 0;
String id;
void postRequestFunction(String session_id) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/reading_status_modify'));
  request.fields.addAll({'book_id': id, 'reading_status': "在读"});
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("修改成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class booknote3 extends StatelessWidget {
  book b1;
  List<bookdan> includebang = [];
  List<jingli> jinglis;
  yuduzhuangtai read1;
  String session_id;
  String userid;
  booknote3(
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
      final uri = Uri.parse(url + "/book_reaction_query?book_id=3");

      final uri2 = Uri.parse(url + "/experience_query");
      // 3.发送网络请求
      Response response, response2;
      response = await dio.getUri(uri);
      response2 = await dio.getUri(uri2);
      Map<String, dynamic> data = response.data;
      Map<String, dynamic> data2 = response2.data;
      shupinglist bookpingshum = shupinglist.fromJson(data["content"]);
      jinglilist ans = jinglilist.fromJson(data2["content"]);
      //  yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);
      shupings = bookpingshum.shupings;
      jinglis = ans.jilings;
      bookzp = 1;
      print("书摘书评成功 ${id} ${shupings[0].title}");
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
    String bookid = b1.book_id.toString();
    id = bookid;
    // TODO: implement build
    if (bookzp == 0) getbookinfo();
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _popupMenuButton(context, b1, session_id),
                                SizedBox(width: 5),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => bookpingjia(
                                                  b1: b1,
                                                  session_id: session_id,
                                                  shupings: shupings,
                                              userid: userid,
                                                )));
                                  },
                                  icon: Icon(Icons.chrome_reader_mode),
                                ),
                                SizedBox(width: 5),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => includebook(
                                                  includebang: includebang,
                                                )));
                                  },
                                  icon: Icon(Icons.my_library_books_outlined),
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
                height: 25,
              ),
              Divider(
                height: 1.0,
                indent: 0.0,
                color: Color.fromARGB(255, 120, 116, 116),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      side: BorderSide(width: 1, color: Colors.grey),
                    ),
                    onPressed: () {
                      postRequestFunction(session_id);
                    },
                    icon: Icon(Icons.local_library_outlined),
                    label: Text("阅读开始", style: TextStyle(fontSize: 25))),
              )
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

  Widget getContentImage() {
    return Image(
      image: AssetImage('images/${b1.book_picture}'),
      height: 180,
    );
  }

  Widget getstartWidget() {
    //String ans = read1.create_time;
    return Text(
      "等待阅读",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
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
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => digest()));
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
