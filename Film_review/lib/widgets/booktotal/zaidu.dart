import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:dio/dio.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/jingli.dart';
import 'package:http/http.dart'
    as http; // use 'as http' to avoid possible name clashes
import 'booklistItem.dart';
import 'package:film_review/model/yueduzhuangtai.dart';

class zaidu extends StatelessWidget {
  List<book> books = [];
  List<yuduzhuangtai> reads = [];
  List<bookdan> bookdans = [];
  BuildContext context2;
  List<jingli> jinglis;
  String session_id;
  String userid;
  zaidu(
      {Key key,
      this.reads,
      this.books,
      this.context2,
      this.bookdans,
      this.jinglis,
      this.session_id,this.userid})
      : super(key: key);

  final _biggerFont = const TextStyle(fontSize: 18.0); // 字体大小
  @override
  Widget build(BuildContext context) {
    return _buildSuggestions(); // body为一个ListView
  }

  Widget _buildSuggestions() {
    return new Expanded(
      child: new ListView.builder(
        padding: const EdgeInsets.all(16.0), // 设置padding
        itemBuilder: (context, index) {
          return bookListItem(
              reads[index], books, context2, bookdans, jinglis, session_id,userid);
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: reads.length,
      ),
    );
  }
}
