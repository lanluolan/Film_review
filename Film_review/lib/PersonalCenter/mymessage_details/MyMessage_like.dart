import 'dart:convert';

import 'package:film_review/Login/User.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyMessage_like extends StatefulWidget{
  final String email;
  MyMessage_like(this.email);
  @override
  MyMessage_likeState createState() {
    return MyMessage_likeState(email: email);
  }
}

class MyMessage_likeState extends State<MyMessage_like> with SingleTickerProviderStateMixin{
  MyMessage_likeState({Key key,this.email}) : super();
  final String email;
  User userData;
  List remarks=[{}];

  List bookreview=[{}];
  List moviereview=[{}];
  List book=[{}];
  List movie=[{}];
  List like=[{}];

  List sum=[];
  int f=0;
  String flag="";

  @override
  void initState() {
    super.initState();
    getmoviereviewList(email);
    getbookreviewList(email);
    getlikeList();
    setState(() {
      for(int i=0;i<bookreview.length-1;i++){
        sum.add(bookreview[i]);
      }
      for(int i=0;i<moviereview.length-1;i++){
        sum.add(moviereview[i]);
      }
    });
  }

  //TODO 查询用户信息（用户查询）
  GetUserInfo(String id) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('http://44d56d92.r5.cpolar.top/user_query?user_id=$id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent = await response.stream.transform(utf8.decoder).join();
      setState((){
        userData = User.fromJson(json.decode(responseContent)["content"][0]);
      });
      debugPrint(userData.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 获取观后感后端数据
  Future<void> getmoviereviewList(String email) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('https://44d56d92.r5.cpolar.top/movie_reaction_query?user_id=$email'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        moviereview=json.decode(responseContent)["content"];
      });
      debugPrint("moviereview:"+moviereview.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 获取读后感后端数据
  Future<void> getbookreviewList(String email) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('https://44d56d92.r5.cpolar.top/book_reaction_query?user_id=$email'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        bookreview=json.decode(responseContent)["content"];
      });
      debugPrint("bookreview:"+bookreview.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 获取电影后端数据
  Future<void> getmovieList(String movie_id) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('https://44d56d92.r5.cpolar.top/movie_query?movie_id=$movie_id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        movie=json.decode(responseContent)["content"];
      });
      debugPrint("movie:"+movie.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 获取图书后端数据
  Future<void> getbookList(String book_id) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('https://44d56d92.r5.cpolar.top/book_query?book_id=$book_id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        book=json.decode(responseContent)["content"];
      });
      debugPrint("book:"+book.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 获取点赞后端数据
  Future<void> getlikeList() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('https://44d56d92.r5.cpolar.top/likes_query'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        like=json.decode(responseContent)["content"];
      });
      debugPrint("like:"+like.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  void getf(dynamic value,List like) {
    for (int i = 0; i < like.length; i++) {
      if (value.toString()[1] == "m") {
        if (like[i]["type"] == "5" && value["movie_id"].toString() == like[i]["dest_id"]) {
          setState(() {
            flag = "movie";
            f=i;
          });
        }else{
          setState(() {
            flag="";
          });
        }
      }else if(value.toString()[1] == "b"){
        if (like[i]["type"] == "6" && value["book_id"].toString() == like[i]["dest_id"]) {
          setState(() {
            flag = "book";
            f=i;
          });
        }else{
          setState(() {
            flag="";
          });
        }
      }
    }
  }

  List<Widget> _getRemarkData() {
    var temp = sum.map((value) {
      // debugPrint(sum.toString());
      // debugPrint(like.toString());
      debugPrint("value:" + value.toString());
      if (value["user_id"] == email) {
        getf(value, like);
        if (flag=="movie") {
          GetUserInfo(like[f]["user_id"]);
          getmovieList(value["movie_id"]);
          return Card(
              margin: EdgeInsets.all(rpx(10.0)),
              child: Container(
                  height:rpx(240.0),
                  decoration: BoxDecoration(
                    border: new Border.all(
                        color: Colors.black26, width: rpx(0.8)),
                  ),
                  child: Padding(padding: EdgeInsets.only(left: rpx(10.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "images/person.jpg", width: rpx(80),
                                height: rpx(80),),
                              Padding(
                                  padding: EdgeInsets.only(left: rpx(15.0))),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  Padding(padding: EdgeInsets.only(
                                      top: rpx(5.0))),
                                  Text(userData.user_name.toString(),
                                    style: TextStyle(fontSize: rpx(25.0)),),
                                  SizedBox(height: rpx(5.0),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      Text(like[f]["create_time"],
                                        style: TextStyle(
                                            color: Colors.black26),),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: rpx(15.0))),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      Text("来自", style: TextStyle(
                                          color: Colors.black26)),
                                      MaterialButton(onPressed: () {},
                                        child: Text(
                                          movie[0]["movie_name"],
                                          style: TextStyle(
                                              color: Colors
                                                  .blueAccent),),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text("赞了这条感想", style: TextStyle(
                              fontSize: rpx(16.0)),
                            overflow: TextOverflow.ellipsis,),
                          SizedBox(height: rpx(3.0),),
                          Container(
                            height: rpx(100.0),
                            width: rpx(352.0),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              border: new Border.all(
                                  color: Colors.black26,
                                  width: rpx(0.8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start,
                              children: [
                                Image.asset(
                                  "images/${moviereview[0]["movie_reaction_picture"]}",
                                  width: rpx(100), height: rpx(90.0),),
                                Padding(padding: EdgeInsets.only(
                                    left: rpx(10.0))),
                                Text(moviereview[0]["title"].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: rpx(16.0)))
                              ],
                            ),
                          ),
                        ],
                      )
                  )
              )
          );
        }
      }
      return Text("");
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: _getRemarkData(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}