import 'dart:convert';

import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPostBookReview extends StatefulWidget{
  String email;
  List bookreviews;
  MyPostBookReview(this.email,this.bookreviews);
  @override
  MyPostBookReviewState createState() {
    return MyPostBookReviewState(email:email,bookreviews:bookreviews);
  }
}

class MyPostBookReviewState extends State<MyPostBookReview> with SingleTickerProviderStateMixin{
  MyPostBookReviewState({Key key,this.email,this.bookreviews}) : super();
  final String email;
  final List bookreviews;

  @override
  void initState() {
    super.initState();
  }

  // //TODO 获取书评后端数据(查询读后感）
  // Future<void> getbookreviewsList(String email) async {
  //   var headers = {
  //     'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
  //   };
  //   var request = http.Request('GET', Uri.parse('https://3421171d.r2.vip.cpolar.cn/book_reaction_query?user_id=$email'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     String responseContent=await response.stream.transform(utf8.decoder).join();
  //     setState(() {
  //       bookreviews=json.decode(responseContent)["content"];
  //     });
  //     debugPrint(bookreviews.toString());
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  List<Widget> _getbookreviewData() {
    var temp = bookreviews.map((value) {
      return Card(
          margin: EdgeInsets.all(rpx(10)),
          child: Container(
              height: rpx(220),
              decoration: BoxDecoration(
                border: new Border.all(color: Colors.black26, width: 0.8),
              ),
              child: Padding(padding: EdgeInsets.all(rpx(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child:
                    Image.asset("images/${value["book_reaction_picture"]}", width: rpx(240), height: rpx(210),),
                    ),
                    Expanded(child: Column(
                      children: [
                        SizedBox(height:rpx(10.0),),
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
        children: _getbookreviewData(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}