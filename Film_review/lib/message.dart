import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/moviedanlist.dart';
import 'package:film_review/model/movielist.dart';
import 'package:film_review/model/watch.dart';
import 'package:film_review/model/watchlist.dart';
import 'package:film_review/widgets/message/xiangkan.dart';
import 'package:film_review/widgets/message/yikan.dart';
import 'widgets/drop_down_menu.dart';
import 'model/menu_controller.dart';
import 'package:film_review/widgets/message/bangdan.dart';
import 'package:film_review/widgets/message/shijianzhou.dart';
import 'package:film_review/widgets/message/shujutongji.dart';
import 'package:film_review/widgets/message/jijiangshangying.dart';
import 'widgets/message/messagard.dart';
import 'package:http/http.dart' as http;

List<movie> movies = [];
List<movie> wantmovies = [];
List<movie> yikanmovies = [];
List<watch> watchs = [];
List<moviedan> yingdans = [];
List<moviedan> myyingdans = [];

int len = 0;
int len2 = 0;
String url = "http://6a857704.r2.vip.cpolar.cn";

bool judge(List<movie> ans, movie a) {
  for (int i = 0; i < ans.length; i++) {
    // print("${ans[i]} ${a}");

    if (ans[i].movie_id.toString() == a.movie_id.toString()) {
      return false;
    }
  }
  return true;
}

void getmovielist(String userid) async {
  len = len + 1;
  final dio = Dio();
  try {
    Response response2 =
        await dio.get(url + "/watching_status_query?user_id=${userid}");

    Map<String, dynamic> data2 = response2.data;
    print('message1成功');
    watchlist watchsum = watchlist.fromJson(data2["content"]);
    Response response = await dio.get(url + "/movie_query");
    if (watchs != watchsum.watchs) {
      watchs = watchsum.watchs;
    }

    print('message2成功  ');

    Map<String, dynamic> data = response.data;
    movielist moviesum = movielist.fromJson(data["content"]);

    for (int i = 0; i < watchsum.watchs.length; i++) {
      for (int j = 0; j < moviesum.movies.length; j++) {
        if (watchsum.watchs[i].movie_id == moviesum.movies[j].movie_id) {
          if (judge(movies, moviesum.movies[j])) {
            movies.add(moviesum.movies[j]);
          }
          if (watchsum.watchs[i].watching_status == "计划看") {
            if (judge(wantmovies, moviesum.movies[j])) {
              wantmovies.add(moviesum.movies[j]);
            }
          } else {
            if (judge(yikanmovies, moviesum.movies[j])) {
              yikanmovies.add(moviesum.movies[j]);
            }
          }
        }
      }
    }
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

void getbangdan(String userid) async {
  final dio = Dio();
  try {
    Response response = await dio.get(url + "/movielist_query?user_id=${userid}");
    Map<String, dynamic> data = response.data;
    moviedanlist yingdansum = moviedanlist.fromJson(data["content"]);
    myyingdans = yingdansum.yingdans;

    Response response2 = await dio.get(url + "/movielist_query");
    Map<String, dynamic> data2 = response2.data;
    moviedanlist yingdansum2 = moviedanlist.fromJson(data2["content"]);
    yingdans = yingdansum2.yingdans;
    print('榜单成功');
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

int len3 = 0;
List<movie> messages;
void getmovielistdiangying() async {
  len3 = len3 + 1;
  final dio = Dio();
  try {
    Response response = await dio.get(url + "/movie_query");

    Map<String, dynamic> data = response.data;
    movielist moviesum = movielist.fromJson(data["content"]);
    messages = moviesum.movies;
    print('电影成功');
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

class Message extends StatefulWidget {
  String session_id;
  String userid;
  Message({Key key, this.session_id,this.userid}) : super(key: key);

  @override
  MessageState createState() => MessageState(session_id,userid);
}

class MessageState extends State<Message> {
  String session_id;
  String userid;
  MessageState(this.session_id,this.userid);
  String dropdownValue = "时间轴";
  int flag = 1;
  bool f1 = true;
  bool f2 = false;
  bool f3 = true;
  bool f4 = false;

  MenuController menuController;
  void bt1() async {
    setState(() {
      if (f1 == false) {
        f1 = true;
        f2 = false;
      } else {
        f1 = false;
        f2 = true;
      }
    });
  }

  void bt2() async {
    setState(() {
      if (f2 == false) {
        f2 = true;
        f1 = false;
      } else {
        f2 = false;
        f1 = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getmovielist(userid);
    //getmovielist();
    getbangdan(userid);

    //getbangdan();
    if (len3 % 2 == 0) getmovielistdiangying();
    //getmovielistdiangying();

    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              messageselect(),
            ],
          ),
          if (f1 == true)
            Container(alignment: Alignment(-0.90, -1), child: getyikan()),
          if (f1 == true && flag == 1)

            shijianzhou(
                movies: yikanmovies,
                watchs: watchs,
                yingdans: yingdans,
                session_id: session_id,
                userid: userid,
            ),
          if (len==0)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0)),
              ],
            ),
          if (f1 == true && flag == 2)
            bangdan(
              bangdans: myyingdans,
              movies: messages,
              session_id: session_id,
              userid: userid,
            ),
          if (f1 == true && flag == 3) shujujiegou(),
          if (f2 == true) getxiangkanWidget(),
          if (f2 == true && f3 == true)
            Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                height: 500,
                child: Column(
                  children: [
                    dianyinggard(
                      movies: wantmovies,
                      yingdans: yingdans,
                      session_id: session_id,
                      userid: userid,
                    ),
                  ],
                )),
          if (f2 == true && f4 == true) jijiangshangyin(),
        ],
    //  ),
    );
  }

  Widget jijiangshangyin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("11月11日上映"),
        SizedBox(height: 10),
        Center(
          child: Image.asset("images/haibao.webp"),
        ),
        jijiangshangying(session_id),
      ],
    );
  }

  Widget messageselect() {
    return Row(
      children: <Widget>[
        TextButton(
          onPressed: bt1,
          child: const Text('已看'),
          style: TextButton.styleFrom(
            primary: f1 == false
                ? Color.fromARGB(255, 78, 75, 75)
                : Color.fromARGB(255, 32, 16, 95),
            textStyle: TextStyle(
                fontSize: f1 == true ? 25 : 20,
                color: Color.fromARGB(255, 31, 32, 32)),
            backgroundColor:
                f1 == true ? Color.fromARGB(255, 5, 93, 148) : null,
          ),
        ),
        TextButton(
          child: Text("想看"),
          onPressed: bt2,
          style: TextButton.styleFrom(
            primary: f2 == false
                ? Color.fromARGB(255, 78, 75, 75)
                : Color.fromARGB(255, 32, 16, 95),
            textStyle: TextStyle(
                fontSize: f2 == true ? 25 : 20,
                color: Color.fromARGB(255, 31, 32, 32)),
            backgroundColor:
                f2 == true ? Color.fromARGB(255, 5, 93, 148) : null,
          ),
        ),
      ],
    );
  }

  Widget getyikan() {
    return DropdownButton<String>(
      underline: const SizedBox(),
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          if (dropdownValue == "时间轴") {
            flag = 1;
          }
          if (dropdownValue == "我的榜单") {
            flag = 2;
          }
          if (dropdownValue == "数据统计") {
            flag = 3;
          }
        });
      },
      items: <String>['时间轴', '我的榜单', '数据统计']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget getxiangkanWidget() {
    // 2.创建Widget
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              if (f3 == true) {
              } else {
                f3 = !f3;
                f4 = false;
              }
            });
          },
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: f3 == true
                  ? Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 87, 11, 201),
                          width: 5), // 底部边框
                    )
                  : null, // 左侧边框
            ),
            child: Text(
              '观影计划',
              style: f3 == false
                  ? TextStyle(color: Colors.grey)
                  : TextStyle(color: Color.fromARGB(255, 87, 11, 201)),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              if (f4 == true) {
              } else {
                f3 = false;
                f4 = true;
              }
            });
          },
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: f4 == true
                  ? Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 87, 11, 201),
                          width: 5), // 底部边框
                    )
                  : null, // 左侧边框
            ),
            child: Text(
              '即将上映',
              style: f4 == false
                  ? TextStyle(color: Colors.grey)
                  : TextStyle(color: Color.fromARGB(255, 87, 11, 201)),
            ),
          ),
        ),
      ],
    );
  }
}
