import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/bookdanlist.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/moviedanlist.dart';
import 'package:film_review/model/shuping.dart';
import 'package:film_review/model/shupinglist.dart';
import 'package:film_review/model/yingpinglist.dart';
import 'package:film_review/model/yingpingmodel.dart';
import 'package:flutter/material.dart';
import 'package:film_review/widgets/Square/SquarePage.dart';
import 'package:film_review/PersonalCenter/Mine.dart';
import 'message.dart';
import 'shouye.dart';
String url = "http://6a857704.r2.vip.cpolar.cn";
List  booklist=[{}];
List movielist=[{}];
void getinfo() async {
  final dio = Dio();
  try {

    Response response2 = await dio.get(url + "/booklist_query");
    Response response = await dio.get(url + "/movielist_query");
    Map<String, dynamic> data2 = response2.data;
    bookdanlist bookdansum = bookdanlist.fromJson(data2["content"]);
    booklist =data2["content"];
    Map<String, dynamic> data = response.data;
    moviedanlist yingdansum = moviedanlist.fromJson(data["content"]);
    movielist = data["content"];


    print('书单和影单成功');
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
//主界面
class MyApp2 extends StatefulWidget {
  String session_id, userid;
  MyApp2(
    this.session_id,
    this.userid,
  );
  @override
  MyAppState createState() => new MyAppState(session_id, userid);
}

class MyAppState extends State<MyApp2> with SingleTickerProviderStateMixin {
  TabController controller;
  String session_id, userid;
  MyAppState(
    this.session_id,
    this.userid,
  );
  @override
  void initState() {
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("MyAPP2:"+userid);//userid和seesion_id是反的
    return new MaterialApp(
      debugShowCheckedModeBanner:false,
      home: new Scaffold(
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new first(session_id,userid),
            SingleChildScrollView(
              child: new Message(
                session_id: session_id,
                userid: userid,
              ),
            ),
            new SquarePage(session_id, userid, "username",booklist
                ,movielist),
            new Mine(userid,session_id),
          ],
        ),
        bottomNavigationBar: new Material(
          color: Colors.white,
          child: new TabBar(
            controller: controller,
            labelColor: Colors.deepPurpleAccent,
            unselectedLabelColor: Colors.black26,
            tabs: <Widget>[
              new Tab(
                text: "书籍",
                icon: new Icon(Icons.library_books),
              ),
              new Tab(
                text: "电影",
                icon: new Icon(Icons.local_movies),
              ),
              new Tab(
                text: "发现",
                icon: new Icon(Icons.find_in_page_sharp),
              ),
              new Tab(
                text: "我的",
                icon: new Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
