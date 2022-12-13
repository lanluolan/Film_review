import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'RecommendPage_BookClass.dart';
import 'RecommendPage_MovieClass.dart';
import 'package:http/http.dart' as http;

class RecommendPage extends StatefulWidget {
  final List recommends;
  final List list;
  final List books;
  final List movies;

  final String movie_id;
  final String book_id;
  RecommendPage(this.recommends, this.list, this.books, this.movies,
      this.movie_id, this.book_id);
  @override
  RecommendPageState createState() => RecommendPageState(
      recommends: recommends,
      list: list,
      books: books,
      movies: movies,
      movie_id: movie_id,
      book_id: book_id);
}

class RecommendPageState extends State<RecommendPage> {
  RecommendPageState(
      {Key key,
      this.recommends,
      this.list,
      this.books,
      this.movies,
      this.movie_id,
      this.book_id})
      : super();
  String url="http://6a857704.r2.vip.cpolar.cn";
  final List recommends;
  final List list;
  final List books;
  final List movies;

  final String movie_id;
  final String book_id;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  List<Widget> _getData() {
    var temp = list.map((value) {
      print("book_id:" + book_id);
      print("movie_id:" + movie_id);
      return Container(
          margin: EdgeInsets.all(rpx(10)),
          child: Column(
            children: [
              //图书卡片
              Container(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: rpx(5.0)),
                      child: Container(
                          height: rpx(300.0),
                          width: rpx(400.0),
                          decoration: BoxDecoration(
                            //设置边框
                            border: new Border.all(
                                color: Colors.black26, width: 0.5),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: rpx(25.0), top: rpx(15.0)),
                                        child: Text(
                                          movies[0]["movie_name"],
                                          style: TextStyle(fontSize: rpx(25.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: rpx(30.0), top: rpx(20.0)),
                                        child: Container(
                                          height: rpx(145.0),
                                          width: rpx(230.0),
                                          child: Text(
                                            movies[0]["description"],
                                            maxLines: 6,
                                            style: TextStyle(
                                                fontSize: rpx(20.0),
                                                color: Colors.black38),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: rpx(280.0), top: rpx(16.0)),
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Text(
                                    "详情>",
                                    style: TextStyle(color: Colors.black26),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                    //图片组件
                    Padding(
                      padding: EdgeInsets.only(
                          left: rpx(295.0), top: rpx(35.0), bottom: rpx(25.0)),
                      child: Container(
                        height: rpx(240),
                        width: rpx(175),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 6.0),
                                blurRadius: 6.0,
                                spreadRadius: 0.5),
                          ],
                        ),
                        child: Image.asset(
                          "images/${movies[0]["movie_picture"]}",
                          width: rpx(240.0),
                          height: rpx(240.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: rpx(15.0),
              ),
              //电影卡片
              Container(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: rpx(5.0)),
                      child: Container(
                          height: rpx(300.0),
                          width: rpx(400.0),
                          decoration: BoxDecoration(
                            //设置边框
                            border: new Border.all(
                                color: Colors.black26, width: 0.5),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: rpx(25.0), top: rpx(15.0)),
                                        child: Text(
                                          books[0]["book_name"],
                                          style: TextStyle(fontSize: rpx(25.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: rpx(30.0), top: rpx(20.0)),
                                        child: Container(
                                          height: rpx(145.0),
                                          width: rpx(230.0),
                                          child: Text(
                                            books[0]["description"],
                                            maxLines: 5,
                                            style: TextStyle(
                                                fontSize: rpx(20.0),
                                                color: Colors.black38),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: rpx(280.0), top: rpx(16.0)),
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Text(
                                    "详情>",
                                    style: TextStyle(color: Colors.black26),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                    //图片组件
                    Padding(
                      padding: EdgeInsets.only(
                          left: rpx(295.0), top: rpx(35.0), bottom: rpx(25.0)),
                      child: Container(
                        height: rpx(240),
                        width: rpx(175),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 6.0),
                                blurRadius: 6.0,
                                spreadRadius: 0.5),
                          ],
                        ),
                        child: Image.asset(
                          "images/${books[0]["book_picture"]}",
                          width: rpx(240.0),
                          height: rpx(240.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ));
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("每日推荐"),
          centerTitle: true,
        ),
        body: ListView(children: this._getData()));
  }
}
