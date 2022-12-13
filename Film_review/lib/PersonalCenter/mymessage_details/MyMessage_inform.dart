import 'package:film_review/PersonalCenter/MyPlan.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyMessage_inform extends StatefulWidget{
  @override
  MyMessage_informState createState() {
    return MyMessage_informState();
  }
}

class MyMessage_informState extends State<MyMessage_inform> with SingleTickerProviderStateMixin{
  List recommends=[{}];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _getData() {
    var temp = recommends.map((value) {
      return Card(
          margin: EdgeInsets.all(rpx(10)),
          child: Container(
              height: rpx(100.0),
              decoration: BoxDecoration(
                border: new Border.all(color: Colors.black26, width: rpx(0.8)),
              ),
              child: Padding(padding: EdgeInsets.all(rpx(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                    Image.asset("images/if-library@1x.jpg"),
                    Padding(padding: EdgeInsets.only(left: rpx(20.0))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("书影足迹",style: TextStyle(fontSize: rpx(18.0)),),
                        Padding(padding: EdgeInsets.only(top: rpx(5.0))),
                        Text("您的会员已到期",style: TextStyle(color: Colors.black45),),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(left:rpx(150.0),bottom: rpx(33.0)),child:Text("2021-08-21"),)
                  ],
                ),
              )
          )
      );
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: _getData(),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}