import 'dart:convert';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RankingList extends StatefulWidget {
  String user_name;
  RankingList(this.user_name);
  @override
  RankingListState createState() => RankingListState(user_name:user_name);
}

class RankingListState extends State<RankingList> {
  RankingListState({Key key, this.user_name}) : super();
  final String user_name;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("排行榜", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: rpx(5.0)),
        child: Column(
          children: <Widget>[
            //排行榜图片
            Padding(
              padding: EdgeInsets.only(left: rpx(30.0), right: rpx(30.0)),
              child: Column(
                children: [
                  SizedBox(height: rpx(5.0),),
                  Container(
                    height: rpx(360.0),
                    width: rpx(350.0),
                    child: Stack(
                      alignment: FractionalOffset(0.5, 0.89),
                      children: [
                        Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(left: rpx(40), right: rpx(40)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: rpx(40),),
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                        "images/beijin.jpg",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          child:Column(
                            children: [
                              SizedBox(height: rpx(10.0)),
                              Image.asset("images/userlist.png"),
                            ],
                          ),
                          width:rpx(300),
                          height: rpx(300),
                          top: rpx(100.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: rpx(10.0),),
            //第一行用户
            Padding(
              padding: EdgeInsets.only(left: rpx(15.0), right: rpx(15.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("1", style: TextStyle(fontSize: rpx(30)),),
                      Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "images/beijin.jpg",
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                      Text(user_name, style: TextStyle(fontSize: rpx(30))),
                    ],
                  ),
                  Column(
                    children: [
                      Text("已看2本书", style: TextStyle(color: Colors.black45)),
                      SizedBox(height: rpx(5.0),),
                      Text("已看6部电影", style: TextStyle(color: Colors.black45)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}