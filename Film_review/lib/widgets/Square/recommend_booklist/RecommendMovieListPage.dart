import 'dart:convert';

import 'package:film_review/widgets/Square/recommend_booklist/RecommendMovieListDetail.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:film_review/widgets/Square/recommend_booklist/RecommendBookListDetail.dart';

class RecommendMovieListPage extends StatefulWidget {
  List recommendmovielists;
  RecommendMovieListPage(this.recommendmovielists);
  @override
  RecommendMovieListPageState createState() =>
      RecommendMovieListPageState(recommendmovielists: recommendmovielists);
}

class RecommendMovieListPageState extends State<RecommendMovieListPage> {
  RecommendMovieListPageState({Key key, this.recommendmovielists}) : super();
  String url="http://6a857704.r2.vip.cpolar.cn";
  final List recommendmovielists;
  List movietemp = [{}];
  Map<int, dynamic> map = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < recommendmovielists.length; i++) {
      getNetmovielistData(recommendmovielists[i]);
    }
    // print("map:"+map.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  //TODO 查询“电影”(GET)
  Future<void> getmovie(int j, String movie_id) async {
    var headers = {'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/movie_query?movie_id=$movie_id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent =
          await response.stream.transform(utf8.decoder).join();
      setState(() {
        movietemp = json.decode(responseContent)["content"];
        if (movietemp[0] != "{}" && movietemp[0] != "[{}]") {
          map[j].add(movietemp[0]);
        }
      });
      print(await response.stream.bytesToString());
    }
  }

  void getNetmovielistData(Map<String, dynamic> value) {
    Future.wait([
      // 2秒后返回结果
      Future.delayed(new Duration(seconds: 1), () {
        return "hello_movielist";
      }),
    ]).then((results) {
      print(results[0]);
      for (int i = 0; i < value["movie_id"].length; i++) {
        map[value["movielist_id"]] = [];
        Future(() =>
            getmovie(value["movielist_id"], value["movie_id"][i].toString()));
      }
    }).catchError((e) {
      print(e);
    });
  }

  List<Widget> _getData() {
    var temp = recommendmovielists.map((value) {
      print("mark:" + value["movielist_id"].toString());
      print(map[value["movielist_id"]].toString());
      return Card(
          margin: EdgeInsets.all(rpx(10)),
          child: Column(children: <Widget>[
            GestureDetector(
              onTap: () {
                // debugPrint("book:"+book.toString());
                if (map[value["movielist_id"]].toString() != "") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => RecommendMovieListDetail(
                          map[value["movielist_id"]])));
                }
              },
              child: Container(
                width: rpx(200),
                height: rpx(220),
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("images/${value["movielist_picture"]}"),
                      fit: BoxFit.fill),
                ),
                alignment: Alignment.center,
              ),
            ),
            Text(value["movielist_name"]),
          ]));
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("推荐影单"),
          centerTitle: true,
        ),
        body: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.3 / 2.0,
            children: this._getData()));
  }
}
