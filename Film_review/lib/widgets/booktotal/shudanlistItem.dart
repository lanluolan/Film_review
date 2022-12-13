import 'dart:math';

import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/widgets/booktotal/bookdanxiangxi.dart';
import 'package:film_review/widgets/booktotal/booknote.dart';
import 'package:film_review/widgets/booktotal/reading.dart';
import 'package:film_review/widgets/booktotal/readplan.dart';
import 'package:percent_indicator/percent_indicator.dart';

class shudanlistItem extends StatelessWidget {
  // final List<book> book1;
  //final yuduzhuangtai read1;
  //final yuduzhuangtai read;
  bookdan bd;
  List<book> books;
  BuildContext context2;
  String session_id;
  String userid;
  shudanlistItem(
      this.context2, this.bd, this.books, this.session_id, this.userid);
  int bookid = 0;
  @override
  Widget build(BuildContext context) {
    // bookid = int.parse(read1.book_id);
    return Container(
      decoration: BoxDecoration(
          border:
              new Border.all(width: 1, color: Color.fromARGB(255, 79, 78, 78))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 2.具体内容
          getContentWidget(),
          SizedBox(height: 12),
          getContentImage(),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.of(context2).push(MaterialPageRoute(
                        builder: (_) => bookxiangqing(
                              bangdan1: bd,
                              books: books,
                              session_id: session_id,
                              userid: userid,
                            )));
                  },
                  icon: Icon(Icons.local_library))
            ],
          )
        ],
      ),
    );
  }

  // 具体内容
  Widget getContentWidget() {
    return Container(
        decoration: new BoxDecoration(color: Color.fromARGB(255, 66, 218, 109)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Icon(Icons.book), Text("${bd.booklist_name}")],
        ));
  }

  Widget getContentImage() {
    int k1 = 0;
    int k2 = 0;
    int k3 = 0;

    for (int j = 0; j < books.length; j++) {
      if (books[j].book_id.toString() == bd.book_id[0].toString()) {
        k1 = j;
        print("位置${k1}");
        print("榜单书：${bd.book_id[0]}");
        print("图片：${books[k1].book_picture}");
      }
      if (bd.book_id.length >= 2) {
        if (books[j].book_id.toString() == bd.book_id[1].toString()) {
          k2 = j;
          print("位置${k2}");
          print("榜单书：${bd.book_id[1]}");
          print("图片：${books[k2].book_picture}");
        }
      }

      if (bd.book_id.length >= 3) {
        if (books[j].book_id.toString() == bd.book_id[2].toString()) {
          k3 = j;
          print("位置${k3}");
          print("榜单书：${bd.book_id[2]}");
          print("图片：${books[k3].book_picture}");
        }
      }
    }
    String url = "images/${books[k1].book_picture}";
    String url2 = "images/saohei.webp";
    String url3 = "images/${books[k2].book_picture}";
    String url4 = "images/1668557646608.webp";
    String url5 = "images/";
    String url6 = "images/1668557646608.webp";
    if (bd.book_id.length >= 3) {
      url5 = url5 + "${books[k3].book_picture}";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
            onTap: () {},
            child: Image(
              image: AssetImage(
                url == "images/" ? url2 : url,
              ),
              height: 120,
            )),
        if (bd.book_id.length >= 2)
          InkWell(
              onTap: () {},
              child: Image(
                image: AssetImage(
                  url3 == "images/" ? url4 : url3,
                ),
                height: 120,
              )),
        if (bd.book_id.length >= 3)
          InkWell(
              onTap: () {},
              child: Image(
                image: AssetImage(
                  url5 == "images/" ? url6 : url5,
                ),
                height: 120,
              ))
      ],
    );
  }

  // 电影简介（原生名称）

}
