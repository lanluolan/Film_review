import 'package:film_review/PersonalCenter/MyPlan.dart';
import 'package:film_review/PersonalCenter/mymessage_details/MyMessage_inform.dart';
import 'package:film_review/PersonalCenter/mymessage_details/MyMessage_like.dart';
import 'package:film_review/PersonalCenter/mymessage_details/MyMessage_remark.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyMessage extends StatefulWidget{
  final String email;
  MyMessage(this.email);
  @override
  MyMessageState createState() {
    return MyMessageState(email:email);
  }
}

class MyMessageState extends State<MyMessage> with SingleTickerProviderStateMixin{
  MyMessageState({Key key,this.email}) : super();
  final String email;
  int _currentIndex = 0;
  final List<Tab> tabs = [
    Tab(text: '通知',),
    Tab(text: '点赞',),
    Tab(text: '评论',),
  ];
  TabController _controller;

  List mymessagelist=[{}];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    setState(() {
      mymessagelist=[
        MyMessage_inform(),
        MyMessage_like(email),
        MyMessage_remark(email),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的消息",style: TextStyle(color: Colors.white)),centerTitle: true,
        bottom: TabBar(
          onTap: (index){
            setState(() {
              this._currentIndex = index;
            });
            setState(() {
              this._currentIndex = index;
            });
            debugPrint(_currentIndex.toString());
          },
          tabs: tabs,
          controller: _controller,
          labelColor: Colors.white,
        ),
      ),
      body: TabBarView(
        // 禁止手势滑动
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: tabs.map((Tab tab) =>
            Padding(
              padding: EdgeInsets.only(top: rpx(10.0)),
              child:this.mymessagelist[_currentIndex],
            ),
        ).toList(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}