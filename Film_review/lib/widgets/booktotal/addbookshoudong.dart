import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/booklist.dart';
import 'package:http/http.dart' as http;

String url = "http://6a857704.r2.vip.cpolar.cn";
TextEditingController emailController =
    new TextEditingController(); //声明controller
TextEditingController emailController2 =
    new TextEditingController(); //声明controller
TextEditingController emailController3 =
    new TextEditingController(); //声明controller
TextEditingController emailController4 =
    new TextEditingController(); //声明controller
TextEditingController emailController5 =
    new TextEditingController(); //声明controller
TextEditingController emailController6 =
    new TextEditingController(); //声明controller\
String readtai;
List<book> books;
String bookid;
void getbookinfo() async {
  final dio = Dio();
  try {
    final uri = Uri.parse(url + "/book_query");
    // 3.发送网络请求
    Response response;
    response = await dio.getUri(uri);
    Map<String, dynamic> data = response.data;
    booklist bookstory = booklist.fromJson(data["content"]);
    print("图书成功");

    //ans = response.data;
    books = bookstory.books;
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

void postRequestFunction() async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
  };
  var request = http.MultipartRequest('POST', Uri.parse(url + '/book_add'));
  request.fields.addAll({
    'book_name': emailController.text,
    'book_picture': "saohei.webp",
    'book_type': "科幻",
    'description': "无",
    'language': "中文",
    'price': "0",
    'publication_date': "2022-12-5",
    'publisher': emailController3.text,
    'version': "1",
    'writer': emailController2.text
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("请求成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void postRequestFunction2(String session_id) async {
  for (int i = 0; i < books.length; i++) {
    if (books[i].book_name == emailController.text) {
      bookid = books[i].book_id;
    }
  }
  print(bookid);
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/reading_status_modify'));
  request.fields.addAll({
    'book_id': bookid,
    'reading_status': readtai,
    'total_pages': emailController4.text,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("阅读状态成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class addbookshoudong extends StatefulWidget {
  String session_id;
  addbookshoudong({Key key, this.session_id}) : super(key: key);

  @override
  addbookshoudongState createState() => addbookshoudongState(session_id);
}

bool f1 = false;
bool f2 = false;
bool f3 = false;
bool f4 = false;

class addbookshoudongState extends State<addbookshoudong> {
  String session_id;
  addbookshoudongState(this.session_id);
  @override
  Widget build(BuildContext context) {
    getbookinfo();
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              tooltip: '保存',
              onPressed: () {
                //  postRequestFunction();
                postRequestFunction2(session_id);
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("书名"),
              TextFormField(
                controller: emailController,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(
                      255, 208, 235, 161), //背景颜色，必须结合filled: true,才有效
                  filled: true, //重点，必须设置为true，fillColor才有效

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("作者"),
              TextFormField(
                controller: emailController2,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(
                      255, 208, 235, 161), //背景颜色，必须结合filled: true,才有效
                  filled: true, //重点，必须设置为true，fillColor才有效

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("出版社"),
              TextFormField(
                controller: emailController3,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(
                      255, 208, 235, 161), //背景颜色，必须结合filled: true,才有效
                  filled: true, //重点，必须设置为true，fillColor才有效

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("总页码"),
              TextFormField(
                controller: emailController4,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(
                      255, 208, 235, 161), //背景颜色，必须结合filled: true,才有效
                  filled: true, //重点，必须设置为true，fillColor才有效

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("书籍状态"),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      readtai = "在读";
                      if (f1 == false) {
                        f1 = true;
                        f2 = false;
                        f3 = false;
                        f4 = false;
                      } else {
                        f1 = false;
                      }
                    });
                  },
                  child: Text("在读"),
                  style: OutlinedButton.styleFrom(
                    primary: f1 == false
                        ? Color.fromARGB(255, 5, 123, 192)
                        : Colors.white,
                    backgroundColor: f1 == false
                        ? Colors.white
                        : Color.fromARGB(255, 3, 169, 150),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      readtai = "已读";
                      if (f2 == false) {
                        f1 = false;
                        f2 = true;
                        f3 = false;
                        f4 = false;
                      } else {
                        f2 = false;
                      }
                    });
                  },
                  child: Text("已读"),
                  style: OutlinedButton.styleFrom(
                    primary: f2 == false
                        ? Color.fromARGB(255, 5, 123, 192)
                        : Colors.white,
                    backgroundColor: f2 == false
                        ? Colors.white
                        : Color.fromARGB(255, 3, 169, 150),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      readtai = "想读";
                      if (f3 == false) {
                        f1 = false;
                        f2 = false;
                        f3 = true;
                        f4 = false;
                      } else {
                        f3 = false;
                      }
                    });
                  },
                  child: Text("想读"),
                  style: OutlinedButton.styleFrom(
                    primary: f3 == false
                        ? Color.fromARGB(255, 5, 123, 192)
                        : Colors.white,
                    backgroundColor: f3 == false
                        ? Colors.white
                        : Color.fromARGB(255, 3, 169, 150),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      readtai = "想读";
                      if (f4 == false) {
                        f1 = false;
                        f2 = false;
                        f3 = false;
                        f4 = true;
                      } else {
                        f4 = false;
                      }
                    });
                  },
                  child: Text("闲置"),
                  style: OutlinedButton.styleFrom(
                    primary: f4 == false
                        ? Color.fromARGB(255, 5, 123, 192)
                        : Colors.white,
                    backgroundColor: f4 == false
                        ? Colors.white
                        : Color.fromARGB(255, 3, 169, 150),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                )
              ]),
              SizedBox(
                height: 10,
              ),
              Text("阅读开始日期"),
              TextFormField(
                controller: emailController5,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(
                      255, 208, 235, 161), //背景颜色，必须结合filled: true,才有效
                  filled: true, //重点，必须设置为true，fillColor才有效

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("阅读完成日期"),
              TextFormField(
                controller: emailController6,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(
                      255, 208, 235, 161), //背景颜色，必须结合filled: true,才有效
                  filled: true, //重点，必须设置为true，fillColor才有效

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
