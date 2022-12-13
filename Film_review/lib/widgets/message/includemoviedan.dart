import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/movielist.dart';
import 'package:film_review/widgets/booktotal/shudan.dart';
import 'package:film_review/widgets/message/bangdan.dart';
import 'package:film_review/widgets/message/yingdan.dart';

class includemovie extends StatelessWidget {
  List<moviedan> yingdans = [];
  List<movie> movies = [];
  String session_id;
  String userid;
  includemovie({Key key, this.yingdans, this.movies, this.session_id,this.userid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.transparent,
          title: Center(
            child: Text("包含影单"),
          ),
        ),
        body: Column(
          children: [
            _buildSuggestions(),
          ],
        ));
  }

  Widget _buildSuggestions() {
    return new Expanded(
      child: new ListView.builder(
        padding: const EdgeInsets.all(16.0), // 设置padding
        itemBuilder: (context, index) {
          return yingdan(
            m1: yingdans[index],
            movies: movies,
            session_id: session_id,
            userid: userid,
          );
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: yingdans.length,
      ),
    );
  }
}
