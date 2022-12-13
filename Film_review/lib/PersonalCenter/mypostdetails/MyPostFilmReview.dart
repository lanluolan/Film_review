import 'dart:convert';

import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPostFilmReview extends StatefulWidget{
  String email;
  List filmreviews;
  MyPostFilmReview(this.email,this.filmreviews);
  @override
  MyPostFilmReviewState createState() {
    return MyPostFilmReviewState(email:email,filmreviews:filmreviews);
  }
}

class MyPostFilmReviewState extends State<MyPostFilmReview> with SingleTickerProviderStateMixin{
  MyPostFilmReviewState({Key key,this.email,this.filmreviews}) : super();
  TextEditingController EditingController = new TextEditingController();
  final String email;
  final List filmreviews;

  @override
  void initState() {
    super.initState();
  }

  // //TODO 获取影评后端数据(查询观后感）
  // Future<void> getbookreviewsList(String email) async {
  //   var headers = {
  //     'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
  //   };
  //   var request = http.Request('GET', Uri.parse('https://3421171d.r2.vip.cpolar.cn/movie_reaction_query?user_id=$email'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     String responseContent=await response.stream.transform(utf8.decoder).join();
  //     setState(() {
  //       filmreviews=json.decode(responseContent)["content"];
  //     });
  //     debugPrint(filmreviews.toString());
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  List<Widget> _getfilmreviewData() {
    var temp = filmreviews.map((value) {
      return Card(
          margin: EdgeInsets.all(rpx(10)),
          child: Container(
              height: rpx(220),
              decoration: BoxDecoration(
                border: new Border.all(color: Colors.black26, width: 0.8),
              ),
              child: Padding(padding: EdgeInsets.all(rpx(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child:
                    Image.asset("images/${value["movie_reaction_picture"]}", width: rpx(240), height: rpx(210),),
                    ),
                    Expanded(child: Column(
                      children: [
                        SizedBox(height: rpx(10.0),),
                        Text(value["title"], style: TextStyle(fontSize: rpx(22.0)),),
                        SizedBox(height: rpx(5.0),),
                        Text(
                          value["content"],
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black45,fontSize: 13),
                        ),
                      ],
                    )
                    )
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
        children: _getfilmreviewData(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}