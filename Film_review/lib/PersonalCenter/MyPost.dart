import 'dart:convert';

import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:film_review/PersonalCenter/mypostdetails/MyPostBookReview.dart';
import 'package:film_review/PersonalCenter/mypostdetails/MyPostFilmReview.dart';
import 'package:film_review/PersonalCenter/mypostdetails/MyPostLike.dart';
import 'package:film_review/PersonalCenter/mypostdetails/MyPostRemark.dart';

class MyPost extends StatefulWidget{
  String email;
  List bookreviews;
  List filmreviews;
  String session_id;
  MyPost(this.email,this.bookreviews,this.filmreviews,this.session_id);
  @override
  MyPostState createState() {
    return MyPostState(email:email,bookreviews:bookreviews,filmreviews:filmreviews,session_id: session_id);
  }
}

class MyPostState extends State<MyPost> with SingleTickerProviderStateMixin{
  MyPostState({Key key,this.email,this.bookreviews,this.filmreviews,this.session_id}) : super();
  TextEditingController EditingController = new TextEditingController();
  final String email;
  final List bookreviews;
  final List filmreviews;
  String session_id;
  int _currentIndex = 0;
  final List<Tab> tabs = [
    Tab(text: '书评',),
    Tab(text: '影评',),
    Tab(text: '点赞',),
    Tab(text: '评论',),
  ];
  List<Widget> _pageList;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    setState(() {
      _pageList = [
        MyPostBookReview(email,bookreviews),
        MyPostFilmReview(email,filmreviews),
        MyPostLike(email,session_id),
        MyPostRemark(email),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我发布的",style: TextStyle(color: Colors.white),),centerTitle: true,
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
              child:this._pageList[_currentIndex],
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