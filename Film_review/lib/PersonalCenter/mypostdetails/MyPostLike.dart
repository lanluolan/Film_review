import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:film_review/Login/User.dart';
import 'package:film_review/PersonalCenter/mypostdetails/MyPostLike.dart';
import 'package:film_review/model/booklist.dart';
import 'package:film_review/model/yuduzhuangtailist.dart';
import 'package:film_review/rpx.dart';
import 'package:film_review/widgets/booktotal/booknote.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPostLike extends StatefulWidget{
  final String email;
  String session_id;
  MyPostLike(this.email,this.session_id);
  @override
  MyPostLikeState createState() {
    return MyPostLikeState(email: email,session_id: session_id);
  }
}

class MyPostLikeState extends State<MyPostLike> with SingleTickerProviderStateMixin{
  MyPostLikeState({Key key,this.email,this.session_id}) : super();
  final String email;
  String session_id;
  String url="http://6a857704.r2.vip.cpolar.cn";
  User userData;
  String likesnumber="";
  String user_name="";

  List likes=[{}];
  List book=[{}];
  List movie=[{}];
  List bookreview=[{}];
  List moviereview=[{}];


  @override
  void initState() {
    super.initState();
    GetUserInfo(email);
    getLikesList(email);
  }
  void getinfo(String userid) async {
    final dio = Dio();
    try {
      final uri = Uri.parse(url + "/book_query");
      final uri2 = Uri.parse(url + "/reading_status_query?user_id=${userid}");
      // 3.发送网络请求
      Response response, response2;
      response = await dio.getUri(uri);
      response2 = await dio.getUri(uri2);
      Map<String, dynamic> data = response.data;
      Map<String, dynamic> data2 = response2.data;
      booklist bookstory = booklist.fromJson(data["content"]);
      yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);

      //ans = response.data;
      print("书籍阅读书单经历 电影观影影单经历");

    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }
  //TODO 查询目标图书信息（查询图书）
  Future<void> gettargetBook(String book_id) async {
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
      debugPrint(book.toString());
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

  //TODO 获取点赞列表后端数据(查询观后感）
  Future<void> getLikesList(String email) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/likes_query?user_id=$email'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        likes=json.decode(responseContent)["content"];
      });
      debugPrint(likes.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 获取点赞数量后端数据(查询点赞）
  Future<void> getLikesnumber(String type,String dest_id) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/likes_query?type=$type&dest_id=$dest_id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        likesnumber=json.decode(responseContent)["size"].toString();
      });
      debugPrint(likesnumber.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 查询目标用户名字（查询用户）
  GetUserInfo(String email) async {
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
        user_name=userData.user_name.toString();
      });
      debugPrint(userData.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 查询目标书评信息（查询图书）
  Future<void> gettargetBookReview(String book_id,String email) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/book_reaction_query?book_id=$book_id&user_id=$email'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        bookreview=json.decode(responseContent)["content"];
      });
      debugPrint(bookreview.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 查询目标影评信息（查询观后感）
  Future<void> gettargetmovieReview(String movie_id,String email) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/movie_reaction_query?book_id=$movie_id&user_id=$email'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        moviereview=json.decode(responseContent)["content"];
      });
      debugPrint(moviereview.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  List<Widget> _getLikeData() {
    var temp = likes.map((value) {
      // debugPrint(value.toString());
      if(value["type"]=="5"){
        gettargetmovieReview(value["dest_id"],email);
        getmovieList(value["dest_id"]);
        getLikesnumber(value["type"],value["dest_id"]);
        return Card(
            margin: EdgeInsets.all(10),
            child: Container(
                height: rpx(250.0),
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
                              "images/person.jpg", width:rpx(100), height: rpx(80),),
                            Padding(padding: EdgeInsets.only(left: rpx(15.0))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(top: rpx(5.0))),
                                Text(
                                  user_name, style: TextStyle(fontSize: rpx(25.0)),),
                                SizedBox(height: rpx(10.0),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(value["create_time"], style: TextStyle(
                                        color: Colors.black26),),
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
                                      child: Text(movie[0]["movie_name"], style: TextStyle(
                                          color: Colors.blueAccent),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(moviereview[0]["title"], style: TextStyle(fontSize: rpx(22.0)),
                          overflow: TextOverflow.ellipsis,),
                        SizedBox(height: rpx(3.0),),
                        Text(moviereview[0]["content"],
                          style: TextStyle(fontSize: rpx(17.0), color: Colors.black45),
                          overflow: TextOverflow.ellipsis,),
                        Padding(padding: EdgeInsets.only(right: rpx(10.0),top: rpx(5.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.favorite),
                              Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                              Text(likesnumber)
                            ],
                          ),
                        ),
                      ],
                    )
                )
            )
        );
      }
      if(value["type"]=="6"){
        gettargetBookReview(value["dest_id"],email);
        gettargetBook(value["dest_id"]);
        debugPrint("hahahahahhaha:"+bookreview.toString());
        getLikesnumber(value["type"],value["dest_id"]);
        return Card(
            margin: EdgeInsets.all(rpx(10.0)),
            child: Container(
                height: rpx(250.0),
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
                              "images/person.jpg", width: rpx(100), height:rpx(80),),
                            Padding(padding: EdgeInsets.only(left: rpx(15.0))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(top: rpx(5.0))),
                                Text(
                                  user_name, style: TextStyle(fontSize: rpx(25.0)),),
                                SizedBox(height: rpx(10.0),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(value["create_time"], style: TextStyle(
                                        color: Colors.black26),),
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
                                      child: Text(book[0]["book_name"], style: TextStyle(
                                          color: Colors.blueAccent),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(bookreview[0]["title"], style: TextStyle(fontSize: rpx(22.0)),
                          overflow: TextOverflow.ellipsis,),
                        SizedBox(height: rpx(3.0),),
                        Text(bookreview[0]["content"],
                          style: TextStyle(fontSize: rpx(17.0), color: Colors.black45),
                          overflow: TextOverflow.ellipsis,),
                        Padding(padding: EdgeInsets.only(right: rpx(10.0),top: rpx(5.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.favorite),
                              Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                              Text(likesnumber)
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
        children: _getLikeData(),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}