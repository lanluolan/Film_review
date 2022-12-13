import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/booklist.dart';
import 'package:film_review/widgets/booktotal/addbookshoudong.dart';

TextEditingController emailController =
    new TextEditingController(); //声明controller
String url = "http://6a857704.r2.vip.cpolar.cn";
List<book> books = [];
void getbookinfo() async {
  final dio = Dio();
  try {
    final uri = Uri.parse(url + "/book_query");
    // 3.发送网络请求
    Response response, response2;
    response = await dio.getUri(uri);
    Map<String, dynamic> data = response.data;
    booklist bookstory = booklist.fromJson(data["content"]);

    //ans = response.data;
    books = bookstory.books;
    print("书籍成功");
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

class addbooksearch extends StatefulWidget {
  List<String> res;
  String session_id;
  addbooksearch(this.res, this.session_id);
  @override
  addbooksearchState createState() => new addbooksearchState(res, session_id);
}

class addbooksearchState extends State<addbooksearch> {
  List<String> res;
  String session_id;
  addbooksearchState(this.res, this.session_id);
  int index = -1;
  @override
  Widget build(BuildContext context) {
    print("boosklen:${books.length}");
    getbookinfo();
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: emailController,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        for (int i = 0; i < books.length; i++) {
                          if (books[i].book_name.toString() ==
                              emailController.text.toString()) {
                            index = i;
                            print("搜索书籍成功");
                            break;
                          }
                        }
                      });
                    },
                    icon: Icon(Icons.search),
                  ),
                  hintText: "请输入您要搜索的书籍名称或作者",
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
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: new Border.all(
                        width: 1, color: Color.fromARGB(255, 181, 181, 181))),
                child: Row(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => addbookshoudong(
                                    session_id: session_id,
                                  )),
                        );
                      },
                      icon: Icon(Icons.add)),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text("没有您要查找的书籍？"),
                      Text("手动录入"),
                    ],
                  )
                ]),
              ),
              if (index != -1)
                Center(
                  child: bookimage(index),
                )
            ],
          ),
        ));
  }

  Widget bookimage(int index) {
    String url = "images/${books[index].book_picture}";
    String url2 = "images/saohei.webp";
    return Container(
        child: InkWell(
      child: Image(
        image: AssetImage(
          url == "images/" ? url2 : url,
        ),
        height: 300,
      ),
      onTap: () {
        List<String> ans = [];
        if (res.length != 0) {
          for (int i = 0; i < res.length; i++) {
            ans.add(res[i].toString());
          }
        }
        ans.add(books[index].book_id.toString());
        Navigator.pop(context, ans);
      },
    ));
  }
}
