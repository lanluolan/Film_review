import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/widgets/booktotal/addDigest.dart';
import 'package:film_review/widgets/booktotal/addreadsense.dart';
import 'dart:async';

import 'package:film_review/widgets/booktotal/readdata.dart';
import 'package:film_review/widgets/booktotal/readplan.dart';

import 'package:http/http.dart' as http;

bool isPlaying = false;

TextEditingController emailController =
new TextEditingController(); //声明controller

String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(book b1, String session_id) async {
  print("${session_id}");
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(url + '/reading_status_modify'));
  request.fields.addAll({
    'book_id': b1.book_id,
    'reading_pages': emailController.text,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("添加页数成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void postRequestFunction2(book b1, String session_id) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(url + '/reading_status_modify'));
  request.fields.addAll({'book_id': b1.book_id, 'reading_status': "已读"});
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("修改成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class stopread extends StatelessWidget {
  static const duration = const Duration(seconds: 1);
  Timer timer;
  int secondspassed = 0;
  book b1;
  yuduzhuangtai r1;
  String session_id;
  stopread(this.b1, this.r1, this.secondspassed, this.session_id);
  @override
  Widget build(BuildContext context) {
    int sum = 0;
    for (int i = 0; i < r1.reading_times.length; i++) {
      sum += int.parse(r1.reading_times[i].toString().substring(18, 19));
      sum += 60 * int.parse(r1.reading_times[i].toString().substring(15, 16));
      sum += 3600 * int.parse(r1.reading_times[i].toString().substring(12, 13));
    }
    sum += secondspassed;
    int hour = (sum ~/ 3600);
    int minute = (sum - 3600 * hour) ~/ 60;
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            tooltip: '保存',
            onPressed: () {
              postRequestFunction(b1, session_id);
              postRequestFunction2(b1, session_id);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new ExactAssetImage('images/beijin.jpg'),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: new BoxDecoration(
                  color: Color.fromARGB(255, 223, 229, 226),
                ),
                padding:
                EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                child: Row(children: [
                  Container(
                    child: Image(
                      image: AssetImage('images/${b1.book_picture}'),
                      height: 120,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${b1.book_name}",
                          style: TextStyle(
                              color: Color.fromARGB(255, 144, 238, 89),
                              fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(" ${b1.writer} ",
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 120,
                        child: LinearProgressIndicator(
                          value: 0.5,
                          minHeight: 5,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _popupMenuButton(context, b1),
                    ],
                  )
                ]),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                // constraints: new BoxConstraints.expand(width: 350, height: 80),
                decoration: new BoxDecoration(
                  // border: new Border.all(width: 1.0, color: Colors.black),
                  color: Color.fromARGB(255, 223, 229, 226),
                  // borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                ),
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: new Row(
                  children: [
                    Icon(
                      Icons.alarm,
                      size: 45.0,
                      semanticLabel: 'label',
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text("已读时间",
                            style: TextStyle(
                                color: Color.fromARGB(255, 110, 113, 107),
                                fontSize: 15)),
                        Text("${hour}  :    ${minute}",
                            style: TextStyle(
                                color: Color.fromARGB(255, 127, 206, 75),
                                fontSize: 25)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                // constraints: new BoxConstraints.expand(width: 350, height: 80),
                decoration: new BoxDecoration(
                  color: Color.fromARGB(255, 223, 229, 226),
                  // borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                ),
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: new Row(
                  children: [
                    Icon(
                      Icons.library_books,
                      size: 45.0,
                      semanticLabel: 'label',
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text("已读页数",
                            style: TextStyle(
                                color: Color.fromARGB(255, 110, 113, 107),
                                fontSize: 25)),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 30,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "${r1.reading_pages}",
                                ),
                                controller: emailController,
                                onTap: () {},
                              ),
                            ),
                            Text("/${r1.total_pages}",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 127, 206, 75),
                                    fontSize: 20)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton _popupMenuButton(BuildContext context, book b1) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Icon(Icons.bookmark),
                Text("书摘"),
              ],
            ),
            value: "书摘",
          ),
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Icon(Icons.sd_card),
                Text("书评"),
              ],
            ),
            value: "书评",
          ),
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Icon(Icons.date_range),
                Text("读书计划"),
              ],
            ),
            value: {"读书计划"},
          ),
        ];
      },
      onSelected: (value) {
        if (value == "书摘") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => digest(
                session_id: session_id,
              )));
        } else if (value == "书评") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => readsense(
                b1: b1,
              )));
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => readplan()));
        }
      },
      onCanceled: () {
        print("canceled");
      },
      color: Color.fromARGB(255, 124, 246, 171),
      icon: Icon(
        Icons.list,
        color: Color.fromARGB(255, 8, 143, 143),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          width: 2,
          color: Color.fromARGB(255, 124, 246, 171),
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}
