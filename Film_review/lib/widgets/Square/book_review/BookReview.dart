import 'dart:convert';

import 'package:film_review/Login/User.dart';

import 'BookReviewRemarkList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:film_review/rpx.dart';

class BookReview extends StatefulWidget {
  String session_id;
  List bookreview;
  String email;
  String like;
  List likes;
  String remark;
  Map<int, dynamic> map;
  Map<int, dynamic> mapthumb;
  Map<int, dynamic> mapremark;
  Map<int, dynamic> mapremarkcontent;
  Map<int, dynamic> mapremark_remark;
  BookReview(
      this.session_id,
      this.bookreview,
      this.email,
      this.like,
      this.likes,
      this.remark,
      this.map,
      this.mapthumb,
      this.mapremark,
      this.mapremarkcontent,
      this.mapremark_remark);
  @override
  BookReviewState createState() => BookReviewState(
      session_id: session_id,
      bookreview: bookreview,
      email: email,
      like: like,
      likes: likes,
      remark: remark,
      map: map,
      mapthumb: mapthumb,
      mapremark: mapremark,
      mapremarkcontent: mapremarkcontent,
      mapremark_remark: mapremark_remark);
}

class BookReviewState extends State<BookReview> {
  BookReviewState(
      {Key key,
      this.session_id,
      this.bookreview,
      this.email,
      this.like,
      this.likes,
      this.remark,
      this.map,
      this.mapthumb,
      this.mapremark,
      this.mapremarkcontent,
      this.mapremark_remark})
      : super();
  String url="http://6a857704.r2.vip.cpolar.cn";
  final String session_id;
  final List bookreview;
  final String email;
  final String like;
  final List likes;
  final String remark;
  final Map<int, dynamic> map;
  final Map<int, dynamic> mapthumb;
  final Map<int, dynamic> mapremark;
  final Map<int, dynamic> mapremarkcontent;
  final Map<int, dynamic> mapremark_remark;

  User userData;

  @override
  void initState() {
    super.initState();
    print("userdata:");
    GetUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
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

  //TODO 添加“点赞”（POST）
  Future<void> postlike(String session_id, String type, String dest_id) async {
    print(dest_id);
    var headers = {
      'Authorization': session_id,
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$url/likes_add'));
    request.fields.addAll({'type': type, 'dest_id': dest_id});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      debugPrint("post success");
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  List<Widget> _getData() {
    var temp = bookreview.map((value) {
      // print(value["book_reaction_id"].toString());
      // debugPrint("value:"+value.toString());
      return Card(
          margin: EdgeInsets.all(rpx(10.0)),
          child:Container(
            height: rpx(230.0),
            child: Column(
              children: [
                SizedBox(
                  height: rpx(5.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: rpx(20.0)),
                      child: TextButton(
                        child:Text(value["title"],style: TextStyle(fontSize: rpx(20.0)),),
                        onPressed: (){
                          },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: rpx(15.0)),
                      child: Text(
                        value["create_time"],
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: rpx(7.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: rpx(20.0)),
                          child: Container(
                            width: rpx(200.0),
                            child: Text(
                              value["content"],
                              style: TextStyle(color: Colors.black38),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      "images/${value["book_reaction_picture"]}",
                      width: rpx(115.0),
                      height: rpx(115.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: rpx(7.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: rpx(20.0), bottom: rpx(5.0))),
                            Image.asset(
                              "images/person.jpg",
                              width: rpx(25.0),
                              height: rpx(25.0),
                            ),
                            Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                            Text(
                              value["user_id"],
                              style: TextStyle(color: Colors.black38),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.message),
                              color: Colors.grey,
                              iconSize: rpx(18),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        BookReviewRemarkList(
                                            session_id,
                                            bookreview,
                                            mapremark_remark)));
                              },
                            ),
                            Padding(padding: EdgeInsets.only(left: rpx(10))),
                            Text(mapremark[value["book_reaction_id"]]),
                            Padding(padding: EdgeInsets.only(right: rpx(20.0))),
                            IconButton(
                              icon: mapthumb[value["book_reaction_id"]]
                                  ? Icon(
                                Icons.favorite,
                              )
                                  : Icon(Icons.favorite_border),
                              iconSize: rpx(18),
                              onPressed: () {
                                setState(() {
                                  mapthumb[value["book_reaction_id"]] =
                                  !mapthumb[value["book_reaction_id"]];
                                  map[value["book_reaction_id"]] = (int.parse(
                                      map[value["book_reaction_id"]]) +
                                      1)
                                      .toString();
                                  postlike(session_id, "6", value["book_id"]);
                                });
                              },
                            ),
                            Padding(padding: EdgeInsets.only(left: rpx(10))),
                            Text(map[value["book_reaction_id"]]),
                            Padding(padding: EdgeInsets.only(right: rpx(15)))
                          ], //mapthumb[value["book_reaction_id"]]
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),

      );
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("书评"),
          centerTitle: true,
        ),
        body: ListView(children: this._getData()));
  }
}
