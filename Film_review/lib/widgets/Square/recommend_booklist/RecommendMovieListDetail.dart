import 'dart:convert';

import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:film_review/widgets/Square/recommend/RecommendPage_BookClass.dart';
import 'package:film_review/widgets/Square/recommend/RecommendPage_MovieClass.dart';
import 'package:http/http.dart' as http;

class RecommendMovieListDetail extends StatelessWidget {
  List movies;
  RecommendMovieListDetail(this.movies);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: MyHomePageH(movies: movies));
  }
}

class MyHomePageH extends StatefulWidget {
  MyHomePageH({Key key, this.movies}) : super(key: key);
  final List movies;
  @override
  RecommendMovieListDetailState createState() {
    return RecommendMovieListDetailState(movies: this.movies);
  }
}

class RecommendMovieListDetailState extends State<MyHomePageH> {
  RecommendMovieListDetailState({Key key, this.movies}) : super();
  final List movies;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _getData() {
    var temp = movies.map((value) {
      return Card(
          margin: EdgeInsets.all(rpx(10)),
          child: Column(children: <Widget>[
            //电影图片
            AspectRatio(
                aspectRatio: 2.0 / 1.0,
                child: Image.asset(
                  "images/${value["movie_picture"]}",
                  fit: BoxFit.cover,
                )),
            //电影名字
            ListTile(
              title: Text(
                value["movie_name"],
                style: TextStyle(fontSize: rpx(20)),
              ),
              subtitle: Text("电影"),
            ),
            //电影介绍
            ListTile(
                title: Text(
              value["description"],
              style: TextStyle(
                  color: Colors.black45, overflow: TextOverflow.ellipsis),
              maxLines: 5,
            )),
            //详情按钮
            Container(
              height: rpx(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "详情>",
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                ],
              ),
            ),
          ]));
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "影单详情",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView(children: this._getData()));
  }
}
