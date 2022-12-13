import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/dianzan.dart';
import 'package:film_review/model/dianzanlist.dart';
import 'package:film_review/model/jingli.dart';
import 'package:film_review/model/jinglilist.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/user.dart';
import 'package:film_review/model/userlist.dart';
import 'package:film_review/model/yingpinglist.dart';
import 'package:film_review/model/yingpingmodel.dart';
import 'package:film_review/widgets/message/includemoviedan.dart';
import 'package:film_review/widgets/message/messagenote2.dart';
import 'package:film_review/widgets/message/messageping.dart';
import 'package:film_review/widgets/message/messagenote3.dart';

import 'package:http/http.dart' as http;

String url = "http://6a857704.r2.vip.cpolar.cn";
String id;
bool judge(List<moviedan> ans, moviedan a) {
  for (int i = 0; i < ans.length; i++) {
    // print("${ans[i]} ${a}");

    if (ans[i].movielist_id.toString() == a.movielist_id.toString()) {
      return false;
    }
  }
  return true;
}

void postRequestFunction(String ans, String session_id) async {
  print("Authorization:${session_id}");
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(url + '/watching_status_modify'));
  request.fields.addAll({
    'movie_id': id,
    'watching_status': ans,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  print("发送成功");
  if (response.statusCode == 200) {
    print("修改成功${id}");

    // print(await response.stream.bytesToString());
  } else {
    print("修改失败");
    print(response.reasonPhrase);
  }
}

List<yingpingmodel> yingpings = [];
List<jingli> jinglis = [];

class messagenote extends StatelessWidget {
  movie m1;
  List<moviedan> yingdans = [];
  List<movie> movies = [];
  String session_id;
  String userid;
  messagenote({Key key, this.m1, this.yingdans, this.movies, this.session_id,this.userid})
      : super(key: key);
  List<moviedan> includedans = [];

  void getmovieinfo() async {
    final dio = Dio();
    try {
      String movieid = m1.movie_id.toString();
      final uri = Uri.parse(url + "/movie_reaction_query?movie_id=${movieid}");

      final uri2 = Uri.parse(url + "/experience_query");
      // 3.发送网络请求
      Response response, response2;
      response = await dio.getUri(uri);
      response2 = await dio.getUri(uri2);
      Map<String, dynamic> data = response.data;
      Map<String, dynamic> data2 = response2.data;
      if (data["content"] != null) {
        yingpinglist moviepingshum = yingpinglist.fromJson(data["content"]);
        yingpings = moviepingshum.yingpings;
      }

      jinglilist ans = jinglilist.fromJson(data2["content"]);
      //  yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);

      jinglis = ans.jilings;

      print("影评成功");
      print("长度${yingdans.length}");
      for (int i = 0; i < yingdans.length; i++) {
        for (int j = 0; j < yingdans[i].movie_id.length; j++) {
          print("电影：${m1.movie_id}影单：  ${yingdans[i].movie_id[j]}");
          if (m1.movie_id.toString() == yingdans[i].movie_id[j].toString()) {
            if (judge(includedans, yingdans[i])) {
              includedans.add(yingdans[i]);
              print("添加成功");
              break;
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

  List<user> users = [];
  void getuserinfo() async {
    final dio = Dio();
    try {
      final uri = Uri.parse(url + "/user_query");
      // 3.发送网络请求
      Response response, response2;
      response = await dio.getUri(uri);
      Map<String, dynamic> data = response.data;
      userlist usersum = userlist.fromJson(data["content"]);
      //  yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);
      users = usersum.users;

      print("用户成功");
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

  List<dianzan> dianzans = [];
  void getdianzaninfo() async {
    final dio = Dio();
    try {
      final uri = Uri.parse(url + "/likes_query");
      // 3.发送网络请求
      Response response;
      response = await dio.getUri(uri);

      Map<String, dynamic> data = response.data;
      dianzanlist dianzansum = dianzanlist.fromJson(data["content"]);
      //  yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);
      dianzans = dianzansum.dianzans;

      print("点赞成功");
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
    getmovieinfo();
    getuserinfo();
    getdianzaninfo();
    print("mssagenote:${yingdans.length}");
    id = m1.movie_id.toString();

    // TODO: implement build
    String url = "images/${m1.movie_picture}";
    String url2 = "images/1668557646608.webp";
    return Scaffold(
        appBar: AppBar(),
        body: new SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Image(
                          image: AssetImage(url == "images/" ? url2 : url),
                          height: 160,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Container(
                                    child: getTitleWidget(),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 75,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                            builder: (_) => messagepingjia(
                                              m1: m1,
                                              yingpings: yingpings,
                                              session_id: session_id,
                                            )));
                                      },
                                      child: Text(
                                        "查看影评",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color:
                                            Color.fromARGB(255, 30, 149, 181)),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromARGB(
                                                  255, 249, 247, 250))),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              getstartWidget(),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      postRequestFunction("已看", session_id);
                                    },
                                    child: Text(
                                      " 已看 ",
                                      style: TextStyle(
                                          color:
                                          Color.fromARGB(255, 248, 249, 249)),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 30, 173, 217))),
                                  ),
                                  SizedBox(width: 20),
                                  OutlinedButton(
                                    onPressed: () {
                                      postRequestFunction("计划看", session_id);
                                    },
                                    child: Text(
                                      " 想看 ",
                                      style: TextStyle(
                                          color:
                                          Color.fromARGB(255, 246, 247, 246)),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 30, 173, 217))),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (_) => includemovie(
                                            yingdans: includedans,
                                            movies: movies,
                                            session_id: session_id,
                                            userid: userid,
                                          )));
                                    },
                                    child: Text(
                                      "↗查看包含此电影的影单",
                                      style: TextStyle(
                                          color:
                                          Color.fromARGB(255, 166, 168, 166)),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  jianjie(),
                  SizedBox(
                    height: 5,
                  ),
                  Text("演职员表",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  zuozhe()
                ],
              ),
            )));
  }

  Widget jianjie() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("剧情介绍",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 5,
        ),
        Text(" ${m1.description}",
            maxLines: 15,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 146, 143, 143),
                fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget zuozhe() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        zuozheText(),
      ],
    );
  }

  Widget getzuozheImage2() {
    return Image(
      image: AssetImage('images/1668557646608.webp'),
      height: 150,
    );
  }

  Widget zuozheText() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getzuozheTitleWidget(),
            SizedBox(
              height: 5,
            ),
            Text("主要演员：${m1.main_performer}")
          ],
        ),
      ),
    );
  }

  Widget getzuozheTitleWidget() {
    return Text(
      "导演：${m1.director}",
    );
  }

  Widget getTitleWidget() {
    return Column(children: <Widget>[
      Text("${m1.movie_name}",
          maxLines: 3,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
      Text(
        "(${m1.release_date.substring(0, 4)})",
        style: TextStyle(fontSize: 18, color: Colors.black54),
      )
    ]);
  }
  /* Widget getTitleWidget() {
    return Stack(
      children: <Widget>[
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: "${m1.movie_name}",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            TextSpan(
              text: "(${m1.release_date.substring(0, 4)})",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            )
          ]),
          maxLines: 4,
        ),
      ],
    );
  }*/

  Widget getstartWidget() {
    //String ans = read1.create_time;
    return Text(
      "${m1.producer_country}/${m1.movie_type}/${m1.release_date}/片长${m1.duration}分",
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14),
    );
  }
}

