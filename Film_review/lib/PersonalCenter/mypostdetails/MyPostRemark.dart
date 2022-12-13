import 'dart:convert';

import 'package:film_review/Login/User.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPostRemark extends StatefulWidget{
  final String email;
  MyPostRemark(this.email);
  @override
  MyPostRemarkState createState() {
    return MyPostRemarkState(email: email);
  }
}

class MyPostRemarkState extends State<MyPostRemark> with SingleTickerProviderStateMixin{
  MyPostRemarkState({Key key,this.email}) : super();
  final String email;
  String url="http://6a857704.r2.vip.cpolar.cn";
  User userData;
  List remarks=[{}];

  List bookreview=[{}];
  List moviereview=[{}];
  List book=[{}];
  List movie=[{}];

  @override
  void initState() {
    super.initState();
    GetUserInfo();
    getremarkList(email);
  }

  //TODO 查询用户信息（用户查询）
  GetUserInfo() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('$url/user_query?user_id=$email'));
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

  //TODO 获取评论后端数据(查询评论）
  Future<void> getremarkList(String email) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/comment_query?user_id=$email'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        remarks=json.decode(responseContent)["content"];
      });
      debugPrint(remarks.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 获取观后感后端数据
  Future<void> getmoviereviewList(String email,String movie_id) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/movie_reaction_query?user_id=$email&movie_id=$movie_id'));
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
  Future<void> getbookreviewList(String email,String book_id) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/book_reaction_query?user_id=$email&book_id=$book_id'));
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
    var request = http.Request('GET', Uri.parse('$url/movie_query?movie_id=$movie_id'));
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
    var request = http.Request('GET', Uri.parse('$url/book_query?book_id=$book_id'));
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

  List<Widget> _getRemarkData() {
    var temp = remarks.map((value) {
      if (value["type"] == "1") {
        getmoviereviewList(email, value["dest_id"].toString());
        getmovieList(value["dest_id"].toString());
        return Card(
            margin: EdgeInsets.all(rpx(10)),
            child: Container(
                height: rpx(280),
                decoration: BoxDecoration(
                  border: new Border.all(color: Colors.black26, width: 0.8),
                ),
                child: Padding(padding: EdgeInsets.only(left: rpx(10.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "images/person.jpg", width: rpx(100), height: rpx(80),),
                            Padding(padding: EdgeInsets.only(left: rpx(15.0))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(top: rpx(5.0))),
                                Text(userData.user_name.toString(),
                                  style: TextStyle(fontSize: rpx(25.0)),),
                                SizedBox(height: rpx(5.0),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(value["create_time"],
                                      style: TextStyle(color: Colors.black26),),
                                    Padding(
                                        padding: EdgeInsets.only(left: rpx(15.0))),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("来自", style: TextStyle(
                                        color: Colors.black26)),
                                    MaterialButton(onPressed: () {

                                    },
                                      child: Text(movie[0]["movie_name"],
                                        style: TextStyle(
                                            color: Colors.blueAccent),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(value["content"], style: TextStyle(fontSize: rpx(22.0)),
                          overflow: TextOverflow.ellipsis,),
                        SizedBox(height: rpx(3.0),),
                        Container(
                          height: rpx(110.0),
                          width:rpx(500.0),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            border: new Border.all(color: Colors.black26,
                                width: 0.8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/${moviereview[0]["movie_reaction_picture"]}",
                                width: rpx(100.0), height: rpx(100.0),),
                              Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                              Text(moviereview[0]["title"].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: rpx(18.0)))
                            ],
                          ),
                        ),
                      ],
                    )
                )
            )
        );
      }
      if (value["type"] == "2") {
        getbookreviewList(email, value["dest_id"].toString());
        getbookList(value["dest_id"].toString());
        return Card(
            margin: EdgeInsets.all(rpx(10.0)),
            child: Container(
                height: rpx(280.0),
                decoration: BoxDecoration(
                  border: new Border.all(color: Colors.black26, width: 0.8),
                ),
                child: Padding(padding: EdgeInsets.only(left: rpx(10.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "images/person.jpg", width: rpx(100.0), height: rpx(80.0),),
                            Padding(padding: EdgeInsets.only(left: rpx(15.0))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(top: rpx(5.0))),
                                Text(userData.user_name.toString(),
                                  style: TextStyle(fontSize: rpx(25.0)),),
                                SizedBox(height: rpx(5.0),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(value["create_time"],
                                      style: TextStyle(color: Colors.black26),),
                                    Padding(
                                        padding: EdgeInsets.only(left: rpx(15.0))),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("来自", style: TextStyle(
                                        color: Colors.black26)),
                                    MaterialButton(onPressed: () {},
                                      child: Text(book[0]["book_name"],
                                        style: TextStyle(
                                            color: Colors.blueAccent),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(value["content"], style: TextStyle(fontSize: rpx(22.0)),
                          overflow: TextOverflow.ellipsis,),
                        SizedBox(height:rpx(3.0),),
                        Container(
                          height:rpx(110.0),
                          width: rpx(500.0),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            border: new Border.all(color: Colors.black26,
                                width: 0.8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/${bookreview[0]["book_reaction_picture"]}",
                                width: rpx(100.0), height:rpx(100.0),),
                              Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                              Text(bookreview[0]["title"].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: rpx(18.0)))
                            ],
                          ),
                        ),
                      ],
                    )
                )
            )
        );
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