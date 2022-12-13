import 'package:flutter/material.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/bookdanlist.dart';
import 'package:film_review/model/booklist.dart';
import 'package:film_review/model/jingli.dart';
import 'package:film_review/model/jinglilist.dart';
import 'package:film_review/model/yuduzhuangtailist.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/widgets/booktotal/addbook.dart';
import 'package:film_review/widgets/booktotal/mybooklist.dart';
import 'package:film_review/widgets/booktotal/shudanlistItem.dart';
import 'package:film_review/widgets/booktotal/zaidu.dart';
import 'dart:convert';
import 'package:http/http.dart'
as http; // use 'as http' to avoid possible name clashes
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:film_review/model/search.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/widgets/booktotal/shujia.dart';
import 'package:image_picker/image_picker.dart';
import 'package:film_review/widgets/booktotal/addshudan.dart';

List<book> books = [];
List<yuduzhuangtai> reads = [];
List<yuduzhuangtai> readsums = [];
List<bookdan> bookdans = [];
List<bookdan> mybookdans = [];
List<jingli> jinglis;
int len = 0;
int num = 0;
int num2 = 0;
int bookd = 0;
int num3 = 0;
String url = "http://6a857704.r2.vip.cpolar.cn";
bool judge(List<yuduzhuangtai> ans, yuduzhuangtai a) {
  for (int i = 0; i < ans.length; i++) {
    // print("${ans[i]} ${a}");

    if (ans[i].book_id.toString() == a.book_id.toString()) {
      return false;
    }
  }
  return true;
}

//import 'package:json_annotation/json_annotation.dart';
void getbookdiget() async {
  final dio = Dio();
  try {
    final uri2 = Uri.parse(url + "/experience_query");
    // 3.发送网络请求
    Response response, response2;

    response2 = await dio.getUri(uri2);

    Map<String, dynamic> data2 = response2.data;

    jinglilist ans = jinglilist.fromJson(data2["content"]);
    //  yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);
    // for (int i = 0; i < ans.jilings.length; i++) {
    //  if (ans.jilings[i].type == '1') jinglis.add(ans.jilings[i]);
    //}
    jinglis = ans.jilings;
    bookd = 1;
    print("书摘成功");
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

void getbookinfo(String userid) async {
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
    books = bookstory.books;
    readsums = readsum.reads;
    print(readsum.reads.length);
    if (reads.length != 0) {
      for (int i = 0; i < reads.length; i++) {
        if (reads[i].reading_status != "在读") {
          reads.removeAt(i);
          break;
        }
      }
    }
    for (int i = 0; i < readsum.reads.length; i++) {
      if (readsum.reads[i].reading_status == "在读") {
        if (judge(reads, readsum.reads[i])) {
          reads.add(readsum.reads[i]);
        }
      }
    }
    print("书桌成功${books.length}");
    num2 = reads.length;
    num3 = readsum.reads.length;
    len = len + 1;
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

void getbookdan(String userid) async {
  final dio = Dio();
  try {
    Response response2 = await dio.get(url + "/booklist_query");
    Map<String, dynamic> data2 = response2.data;
    bookdanlist bookdansum = bookdanlist.fromJson(data2["content"]);
    bookdans = bookdansum.bookdans;
    print('全部榜单成功');

    Response response =
    await dio.get(url + "/booklist_query?user_id=${userid}");
    Map<String, dynamic> data = response.data;
    bookdanlist bookdansummy = bookdanlist.fromJson(data["content"]);
    mybookdans = bookdansummy.bookdans;
    num = mybookdans.length;
    print('我的榜单成功');
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

class first extends StatefulWidget {
  String session_id;
  String userid;
  first(this.session_id, this.userid);
  @override
  firstState createState() => new firstState(session_id, userid);
}

String dropdownValue = "全部";
String dropdownValuelist = "在读";

class firstState extends State<first> {
  String session_id;
  String userid;
  firstState(this.session_id, this.userid);
  void _incrementCounter() async {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => addbook(
            session_id: session_id,
          )));
    });
  }

  void _incrementCounter2() async {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => addshudan(
            session_id: session_id,
          )));
    });
  }

  bool f1 = true;
  bool f2 = false;

  void bt1() async {
    setState(() {
      //ans = response.data;

      if (f1 == false) {
        f1 = true;
        f2 = false;
      } else {
        f1 = false;
        f2 = true;
      }
    });
  }

  void bt2() async {
    setState(() {
      if (f2 == false) {
        f2 = true;
        f1 = false;
      } else {
        f2 = false;
        f1 = true;
      }
    });
  }

  int flag = 1;
  @override
  Widget build(BuildContext context) {
    getbookinfo(userid);
    getbookdan(userid);
    getbookdiget();
    print("P:${session_id}");
    const select = ['全部', '在读', '已读', '想读', '闲置'];
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(),
        body: Container(
          alignment: Alignment(-0.5, -0.75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 10, height: 10), // 50宽度
                  Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                          width: 1, color: Color.fromARGB(255, 192, 189, 189)),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: TextButton(
                      onPressed: bt1,
                      child: const Text('书桌'),
                      style: TextButton.styleFrom(
                        primary: f1 == false
                            ? Color.fromARGB(255, 78, 75, 75)
                            : Color.fromARGB(255, 255, 255, 255),
                        textStyle: TextStyle(
                            fontSize: f1 == true ? 20 : 15,
                            color: Color.fromARGB(255, 31, 32, 32)),
                        backgroundColor: f1 == true
                            ? Color.fromARGB(255, 71, 18, 152)
                            : null,
                      ),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                          width: 1, color: Color.fromARGB(255, 192, 189, 189)),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: TextButton(
                      child: Text("书架"),
                      onPressed: bt2,
                      style: TextButton.styleFrom(
                        primary: f2 == false
                            ? Color.fromARGB(255, 78, 75, 75)
                            : Color.fromARGB(255, 255, 255, 255),
                        textStyle: TextStyle(
                            fontSize: f2 == true ? 20 : 15,
                            color: Color.fromARGB(255, 31, 32, 32)),
                        backgroundColor: f2 == true
                            ? Color.fromARGB(255, 71, 18, 152)
                            : null,
                      ),
                    ),
                  )

                  // if (f1 == true && flag == 1) search(),
                  // if (f2 == true) shudan(),
                ],
              ),
              if (f1 == true && f2 == false)
                Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    getlist(),
                    SizedBox(width: 10), // 30宽度
                    if (flag == 1)
                      Text(
                        "你正在阅读" + num2.toString() + "本书",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    if (flag != 1) shudanlist(),
                    Spacer(), // use Spacer
                    if (f1 == true && flag == 1) search(),
                  ],
                ),
              SizedBox(height: 15),
              if (f2 == true && f1 == false)
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "总计${num3}本书",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      alignment: Alignment(0, 0),
                      height: 25,
                      width: 80,
                      decoration: BoxDecoration(
                          border: new Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 181, 181, 181))),
                      child: shaixuankuang(),
                    )
                  ],
                ),
              if (num == 0 || num2 == 0 || num3 == 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0)),
                  ],
                ),
              if (f1 == true && f2 == false && flag == 1)
                zaidu(
                  reads: reads,
                  books: books,
                  context2: context,
                  bookdans: bookdans,
                  jinglis: jinglis,
                  session_id: session_id.toString(),
                ),
              // if (f1 == true && f2 == false && flag == 2) shudanlist(),
              if (f1 == true && f2 == false && flag == 2)
                mybooklist(
                  bd1: mybookdans,
                  context2: context,
                  books: books,
                  session_id: session_id,
                  userid: userid,
                ),
              if (f2 == true && f1 == false)
                shujia(
                  books: books,
                  reads: readsums,
                  readstaus: dropdownValue,
                  jinglis: jinglis,
                  session_id: session_id,
                  bangdans: bookdans,
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: flag == 1 ? _incrementCounter : _incrementCounter2,
          tooltip: flag == 1 ? '添加书籍' : '添加书单',
          child: flag == 1 ? Icon(Icons.add_outlined) : Icon(Icons.event_note),
        ),
      ),
    );
  }

  Widget getlist() {
    return Container(
      height: 40,
      width: 110,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
          new Border.all(width: 1, color: Color.fromARGB(255, 79, 78, 78))),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        value: dropdownValuelist,
        onChanged: (String newValue) {
          setState(() {
            dropdownValuelist = newValue;
            if (dropdownValuelist == "在读") {
              flag = 1;
            }
            if (dropdownValuelist == "书单") {
              flag = 2;
            }
          });
        },
        items:
        <String>['在读', '书单'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
          );
        }).toList(),
      ),
    );
  }

  Widget shaixuankuang() {
    return DropdownButton<String>(
      underline: const SizedBox(),
      //decoration: const InputDecoration(border: OutlineInputBorder()),
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['全部', '在读', '已读', '想读', '闲置']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget search() {
    return IconButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SearchPage(
              type: 0,
              books: books,
            ))),
        icon: const Icon(Icons.search));
  }

  Widget shudan() {
    return Container(
      child: Column(children: [
        IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => addshudan(
                  session_id: session_id,
                ))),
            icon: const Icon(Icons.event_note)),
        Text("添加书单")
      ]),
    );
  }

  Widget shudanlist() {
    return Container(
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Text(
              "你已经创建了${num}个书单",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 20,
            ),
            search(),
          ],
        ),
      ]),
    );
  }
}
