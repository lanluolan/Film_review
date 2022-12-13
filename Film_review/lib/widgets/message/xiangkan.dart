import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:http/http.dart'
    as http; // use 'as http' to avoid possible name clashes;
import 'package:film_review/widgets/message/bangdan.dart';
import 'package:film_review/widgets/message/shijianzhou.dart';
import 'package:film_review/widgets/message/shujutongji.dart';
import 'package:film_review/widgets/message/jijiangshangying.dart';
import 'messagard.dart';

class xiangkan extends StatefulWidget {
  List<moviedan> yingdans = [];
  xiangkan(this.yingdans);
  @override
  xiangkanState createState() => new xiangkanState(yingdans);
}

class xiangkanState extends State<xiangkan> {
  List<moviedan> yingdans = [];
  xiangkanState(this.yingdans);
  bool f3 = true;
  bool f4 = false;
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getxiangkanWidget(),
          if (f3 == true) dianyinggard(),
          if (f4 == true) jijiangshangyin(),
        ],
      ),
    );
  }

  Widget getxiangkanWidget() {
    // 2.创建Widget
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              if (f3 == true) {
              } else {
                f3 = !f3;
                f4 = false;
              }
            });
          },
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: f3 == true
                  ? Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 87, 11, 201),
                          width: 5), // 底部边框
                    )
                  : null, // 左侧边框
            ),
            child: Text(
              '观影计划',
              style: f3 == false
                  ? TextStyle(color: Colors.grey)
                  : TextStyle(color: Color.fromARGB(255, 87, 11, 201)),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              if (f4 == true) {
              } else {
                f3 = false;
                f4 = true;
              }
            });
          },
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: f4 == true
                  ? Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 87, 11, 201),
                          width: 5), // 底部边框
                    )
                  : null, // 左侧边框
            ),
            child: Text(
              '即将上映',
              style: f4 == false
                  ? TextStyle(color: Colors.grey)
                  : TextStyle(color: Color.fromARGB(255, 87, 11, 201)),
            ),
          ),
        ),
      ],
    );
  }
}

Widget jijiangshangyin() {
  return Column(
    //crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("11月11日上映"),
      SizedBox(height: 10),
      Center(
        child: Image.asset("images/saohei.webp"),
      ),
      //  jijiangshangying(s),
    ],
  );
}
