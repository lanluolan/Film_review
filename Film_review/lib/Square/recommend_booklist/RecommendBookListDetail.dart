import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/bookdanlist.dart';
import 'package:film_review/model/booklist.dart';
import 'package:film_review/model/jingli.dart';
import 'package:film_review/model/jinglilist.dart';
import 'package:film_review/model/yuduzhuangtailist.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/rpx.dart';
import 'package:film_review/widgets/booktotal/booknote.dart';
import 'package:flutter/material.dart';
import 'package:film_review/Square/recommend/RecommendPage_BookClass.dart';
import 'package:film_review/Square/recommend/RecommendPage_MovieClass.dart';
import 'package:http/http.dart' as http;

List<book> booksum = [];
List<yuduzhuangtai> reads = [];
List<bookdan> bookdans = [];
List<jingli> jinglis=[];
String url2 = "http://6a857704.r2.vip.cpolar.cn";
void getbookinfo(String userid) async {
  final dio = Dio();
  try {

    final uri = Uri.parse(url2 + "/book_query");
    final uri2 = Uri.parse(url2 + "/reading_status_query?user_id=${userid}");
    // 3.发送网络请求
    Response response, response2,response3;
    response = await dio.getUri(uri);
    response2 = await dio.getUri(uri2);
    Map<String, dynamic> data = response.data;
    Map<String, dynamic> data2 = response2.data;

    booklist bookstory = booklist.fromJson(data["content"]);
    print("阅读状态：${userid}");
    yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);

    //ans = response.data;
    booksum = bookstory.books;
    reads = readsum.reads;
    final uri3 = Uri.parse(url2 + "/experience_query");
    // 3.发送网络请求
    response3 = await dio.getUri(uri3);
    Map<String, dynamic> data3 = response3.data;
    jinglilist ans = jinglilist.fromJson(data3["content"]);

    jinglis = ans.jilings;
    Response response4 = await dio.get(url2 + "/booklist_query");
    Map<String, dynamic> data4 = response4.data;
    bookdanlist bookdansummy = bookdanlist.fromJson(data4["content"]);
    bookdans = bookdansummy.bookdans;

    print("书籍详情成功");
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
class RecommendBookListDetail extends StatelessWidget {
  List books;
  String userid;
  String session_id;
  RecommendBookListDetail(this.books,this.userid,this.session_id);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home:MyHomePageH(books: books,userid: userid,session_id: session_id,)
    );
  }
}

class MyHomePageH extends StatefulWidget {
  MyHomePageH({Key key,this.books,this.userid,this.session_id}) : super(key: key);
  final List books;
  String userid;
  String session_id;
  @override
  RecommendBookListDetailState createState() {
    return RecommendBookListDetailState(books: this.books,userid: userid,session_id: session_id);
  }
}

class RecommendBookListDetailState extends State<MyHomePageH> {
  RecommendBookListDetailState({Key key,this.books,this.userid,this.session_id}) : super();
  final List books;
  String userid;
  String session_id;
  @override
  void initState() {
    print("userid::${userid}");
    getbookinfo(userid);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _getData() {
    var temp = books.map((value) {
      return Card(
          margin: EdgeInsets.all(rpx(10)),
          child: Column(children: <Widget>[
            //书本图片
            AspectRatio(
                aspectRatio: 2.0 / 1.0,
                child: Image.asset(
                  "images/${value["book_picture"]}",
                  fit: BoxFit.cover,)),
            //书本名字
            ListTile(
              title: Text(
                value["book_name"],
                style: TextStyle(fontSize: rpx(20)),
              ),
              subtitle: Text("书籍"),
            ),
            //书本介绍
            ListTile(title: Text(value["description"],style: TextStyle(color: Colors.black45,overflow: TextOverflow.ellipsis),maxLines: 5,)),
            //详情按钮
            Container(
              height: rpx(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                 MaterialButton(onPressed: (){
                   int k=0;
                   int k2=0;

                   for(int j=0;j<booksum.length;j++)
                   {
                     if(booksum[j].book_id.toString()==value["book_id"].toString())
                     {
                       k=j;
                       break;
                     }
                   }
                   for(int j=0;j<reads.length;j++)
                   {
                     if(reads[j].book_id.toString()==value["book_id"].toString())
                     {
                       k2=j;
                       break;
                     }
                   }
                   List<bookdan> includebang = [];
                   for (int i = 0; i < bookdans.length; i++) {
                     for (int j = 0; j < bookdans[i].book_id.length; j++) {
                       if (value["book_id"].toString() == bookdans[i].book_id[j].toString()) {
                         includebang.add(bookdans[i]);
                         break;
                       }
                     }
                   }
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (_) => booknote(
                         b1: booksum[k],
                         read1: reads[k2],
                         includebang: includebang,
                         jinglis: jinglis,
                         session_id: session_id,
                         userid:userid ,

                       )));
                 }, child: Text("详情>",style: TextStyle(color: Colors.black38),),),
                ],
              ),
            ),
          ]));
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: AppBar(
          title: Text("书单详情",style: TextStyle(color: Colors.white),),
          centerTitle:true,
        ),
        body: ListView(
            children:this._getData()
        )
    );
  }
}

