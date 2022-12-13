import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/message.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/moviedanlist.dart';
import 'package:film_review/model/movielist.dart';
import 'package:film_review/model/watch.dart';
import 'package:film_review/model/watchlist.dart';
import 'package:film_review/widgets/message/addbangdan.dart';
import 'package:film_review/widgets/message/edityingdan.dart';
import 'package:film_review/widgets/message/yingdanmovie.dart';
import 'package:http/http.dart' as http;

String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(moviedan m1, String session_id) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/movielist_delete'));
  request.fields.addAll({
    'movielist_id': m1.movielist_id.toString(),
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("删除影单成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void postRequestFunction2(moviedan b1, String ans) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/movielist_modify'));
  request.fields.addAll({
    'movielist_id': b1.movielist_id.toString(),
    'collector_id': ans.toString(),
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("添加收藏成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

List<movie> planmovies = [];
List<movie> yikanmovies = [];
List<watch> watchs = [];
List<moviedan> yingdans = [];
List<movie> movies = [];
void getmovielistdiangying() async {
  final dio = Dio();
  try {
    Response response = await dio.get(url + "/movie_query");
    Response response2 =
        await dio.get(url + "/watching_status_query?user_id=test");
    print('成功');
    Map<String, dynamic> data = response.data;
    Map<String, dynamic> data2 = response2.data;
    watchlist watchsum = watchlist.fromJson(data2["content"]);
    movielist moviesum = movielist.fromJson(data["content"]);
    movies = moviesum.movies;
    watchs = watchsum.watchs;
    Response response3 = await dio.get(url + "/movielist_query");
    Map<String, dynamic> data3 = response3.data;
    moviedanlist yingdansum2 = moviedanlist.fromJson(data3["content"]);
    yingdans = yingdansum2.yingdans;
    print('榜单和watches成功');
    for (int i = 0; i < watchsum.watchs.length; i++) {
      for (int j = 0; j < moviesum.movies.length; j++) {
        if (watchsum.watchs[i].movie_id == moviesum.movies[j].movie_id) {
          if (watchsum.watchs[i].watching_status == "计划看") {
            planmovies.add(moviesum.movies[j]);
          } else {
            yikanmovies.add(moviesum.movies[j]);
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

int fshoucang = 0;

class yingdanxiangqing extends StatelessWidget {
  moviedan bangdan1;
  List<movie> movies;
  String session_id;
  String userid;
  yingdanxiangqing({Key key, this.bangdan1, this.movies, this.session_id,this.userid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    getmovielistdiangying();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Title(context),
              SizedBox(
                height: 60,
              ),
              yingdanview(
                  bangdan1, movies, yikanmovies, planmovies, yingdans, watchs,userid),
            ],
          ),
        ),
      ),
    );
  }

  Widget Title(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
      decoration: BoxDecoration(
          border:
              new Border.all(width: 1, color: Color.fromARGB(255, 79, 78, 78)),
          color: Color.fromARGB(255, 212, 224, 171)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 2.具体内容
          getContentWidget(context),
          Container(
            padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
            child: Text(
              "${bangdan1.description}",
              maxLines: 3,
            ),
          ),
          Row(
            children: [
              Spacer(),
              if (bangdan1.user_id == "test")
                Icon(
                  Icons.edit,
                  size: 15,
                ),
              if (bangdan1.user_id == "test")
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              edityingdan(bangdan1, movies, session_id)));
                    },
                    child: Text("编辑")),
              if (bangdan1.user_id != "test")
                IconButton(
                    onPressed: () {
                      List<String> ans = [];
                      if (bangdan1.collector_id.length != 0 && fshoucang == 0) {
                        for (int i = 0; i < bangdan1.collector_id.length; i++) {
                          if (bangdan1.collector_id[i].toString() == 'test') {
                            fshoucang = 1;
                          }
                          ans.add(bangdan1.collector_id[i].toString());
                        }
                        if (fshoucang == 0) ans.add("test");
                      } else {
                        ans.add("test");
                      }

                      postRequestFunction2(bangdan1, ans.toString());
                    },
                    icon: fshoucang == 0
                        ? Icon(Icons.favorite_border)
                        : Icon(Icons.favorite))
            ],
          )
        ],
      ),
    );
  }

  Widget getContentWidget(BuildContext context) {
    return Row(
      children: [
        Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          label: Text(
            "${bangdan1.movielist_name}",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          backgroundColor: Color.fromARGB(255, 5, 134, 12),
        ),
        Spacer(),
        if (bangdan1.user_id == "test")
          IconButton(
              onPressed: () {
                postRequestFunction(bangdan1, session_id);
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete))
      ],
    );
  }
}
