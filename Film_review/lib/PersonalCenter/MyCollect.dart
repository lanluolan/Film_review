import 'dart:convert';
import 'package:film_review/PersonalCenter/mycollect_details/MyCollect_booklist.dart';
import 'package:film_review/PersonalCenter/mycollect_details/MyCollect_movielist.dart';
import 'package:film_review/Square/book_review/text_syles.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyCollect extends StatefulWidget{
  String email;
  List collectbooklist;
  List collectmovielist;
  String user_name;
  String session_id;
  MyCollect(this.email,this.collectbooklist,this.collectmovielist,this.user_name,this.session_id);
  @override
  MyCollectState createState() {
    return MyCollectState(email:email,collectbooklist:collectbooklist,collectmovielist:collectmovielist,user_name:user_name);
  }
}

class MyCollectState extends State<MyCollect> with SingleTickerProviderStateMixin{
  MyCollectState({Key key,this.email,this.collectbooklist,this.collectmovielist,this.user_name,this.session_id}) : super();
  final String email;
  final List collectbooklist;
  final List collectmovielist;
  final String user_name;
  String session_id;
  List targetbook=[];
  int lisk_count=0; //书单收藏数量

  int _currentIndex = 0;
  final List<Tab> tabs = [
    Tab(text: '书单',),
    Tab(text: '影单',),
  ];
  TabController _controller;

  List mycollectlist=[];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    setState(() {
      mycollectlist=[
        MyCollect_booklist(email,collectbooklist,user_name, session_id),
        MyCollect_movielist(email,collectmovielist,user_name,session_id)
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏",style: TextStyle(color: Colors.white)),centerTitle: true,
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
              child:this.mycollectlist[_currentIndex],
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
