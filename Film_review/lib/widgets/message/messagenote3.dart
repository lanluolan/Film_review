import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/textdraw.dart';
import 'package:film_review/model/yingpinglist.dart';
import 'package:film_review/model/yingpingmodel.dart';
import 'package:film_review/widgets/message/includemoviedan.dart';
import 'package:film_review/widgets/message/addyingping.dart';
import 'package:film_review/widgets/message/messageping.dart';

String url = "http://6a857704.r2.vip.cpolar.cn";
List<yingpingmodel> yingpings = [];
bool judge(List<moviedan> ans, moviedan a) {
  for (int i = 0; i < ans.length; i++) {
    // print("${ans[i]} ${a}");

    if (ans[i].movielist_id.toString() == a.movielist_id.toString()) {
      return false;
    }
  }
  return true;
}

class messageset extends StatelessWidget {
  movie m1;
  List<moviedan> yingdans = [];
  List<movie> movies = [];
  String session_id;
  String userid;
  messageset({Key key, this.m1, this.yingdans, this.movies, this.session_id,this.userid})
      : super(key: key);
  List<moviedan> includedans = [];
  void getmovieinfo() async {
    final dio = Dio();
    try {
      String movieid = m1.movie_id.toString();
      final uri = Uri.parse(url + "/movie_reaction_query?movie_id=${movieid}");

      final uri2 = Uri.parse(url + "/experience_query");
      // 3.发送网络请求
      Response response;
      response = await dio.getUri(uri);
      Map<String, dynamic> data = response.data;
      if (data["content"] != null) {
        yingpinglist moviepingshum = yingpinglist.fromJson(data["content"]);
        yingpings = moviepingshum.yingpings;
      }
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

  @override
  Widget build(BuildContext context) {
    getmovieinfo();
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
                                    child: getTitleWidget(context),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              getstartWidget(),
                              SizedBox(
                                height: 10,
                              ),
                              gettime(),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: 200,
                                  child: Row(
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {},
                                        child: Text(
                                          "开启观影提醒",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 248, 249, 249)),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    255, 30, 173, 217))),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                builder: (_) => yingping(
                                                  m1: m1,
                                                  session_id: session_id,
                                                )));
                                          },
                                          icon: Icon(Icons.library_add))
                                    ],
                                  )),
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
                  Divider(
                    height: 1.0,
                    indent: 0.0,
                    color: Color.fromARGB(255, 120, 116, 116),
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

  Widget gettime() {
    return Container(
      height: 40,
      width: 150,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border:
          new Border.all(width: 1, color: Color.fromARGB(255, 79, 78, 78))),
      child: TextIcon(
        textSpanText: "${m1.release_date.substring(0, 10)}",
        icon: Icons.calendar_month,
        iconColor: Color.fromARGB(137, 32, 72, 183),
      ),
    );
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

  Widget getzuozheImage() {
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

  Widget getTitleWidget(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        width: 120,
        child: Text("${m1.movie_name}",
            maxLines: 3,
            style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
      OutlinedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => messagepingjia(
                m1: m1,
                session_id: session_id,
              )));
        },
        child: Text(
          "查看影评",
          style:
          TextStyle(fontSize: 10, color: Color.fromARGB(255, 30, 149, 181)),
        ),
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all(Color.fromARGB(255, 249, 247, 250))),
      ),
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
