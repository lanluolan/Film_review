import 'dart:convert';

import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:film_review/widgets/Square/recommend/RecommendPage_MovieClass.dart';
import 'package:film_review/widgets/Square/recommend/RecommendPage_BookClass.dart';
import 'package:http/http.dart' as http;

class RecommendBookListDetail extends StatelessWidget {
  List books;
  RecommendBookListDetail(this.books);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: MyHomePageH(books: books));
  }
}

class MyHomePageH extends StatefulWidget {
  MyHomePageH({Key key, this.books}) : super(key: key);
  final List books;
  @override
  RecommendBookListDetailState createState() {
    return RecommendBookListDetailState(books: this.books);
  }
}

class RecommendBookListDetailState extends State<MyHomePageH> {
  RecommendBookListDetailState({Key key, this.books}) : super();
  final List books;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _getData() {
    var temp = books.map((value) {
      return Card(
          margin: EdgeInsets.all(rpx(10)),
          child: Column(children: <Widget>[
            //书本图片
            AspectRatio(
                aspectRatio: 2.0 / 1.0,
                child: Image.asset(
                  "images/${value["book_picture"]}",
                  fit: BoxFit.cover,
                )),
            //书本名字
            ListTile(
              title: Text(
                value["book_name"],
                style: TextStyle(fontSize: rpx(20)),
              ),
              subtitle: Text("书籍"),
            ),
            //书本介绍
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
                    onPressed: () {

                    },
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
          leading: Icon(Icons.backspace),
          automaticallyImplyLeading: true,
          title: Text(
            "书单详情",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView(children: this._getData()));
  }
}
