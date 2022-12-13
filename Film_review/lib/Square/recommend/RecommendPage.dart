import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/bookdanlist.dart';
import 'package:film_review/model/booklist.dart';
import 'package:film_review/model/jingli.dart';
import 'package:film_review/model/jinglilist.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/moviedanlist.dart';
import 'package:film_review/model/movielist.dart';
import 'package:film_review/model/yuduzhuangtailist.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/rpx.dart';
import 'package:film_review/widgets/booktotal/booknote.dart';
import 'package:film_review/widgets/message/messagenote.dart';
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
List<movie> moviessum = [];
List<moviedan> yingdans = [];
void getmovieinfo(String userid) async {
  final dio = Dio();
  try {
    Response response = await dio.get(url2 + "/movie_query");
    Map<String, dynamic> data = response.data;
    movielist moviesum = movielist.fromJson(data["content"]);
    moviessum=moviesum.movies;
    Response response2 = await dio.get(url2 + "/movielist_query");
    Map<String, dynamic> data2 = response2.data;
    moviedanlist yingdansum2 = moviedanlist.fromJson(data2["content"]);
    yingdans = yingdansum2.yingdans;
    print('电影信息成功');
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
class RecommendPage extends StatefulWidget {
  final List recommends;
  final List list;
  final List books;
  final List movies;
  final String movie_id;
  final String book_id;
  String userid;
  String session_id;
  RecommendPage(this.recommends,this.list,this.books,this.movies,this.movie_id,this.book_id,this.userid,this.session_id);
  @override
  RecommendPageState createState() => RecommendPageState(recommends:recommends,list:list,books:books,movies:movies,movie_id:movie_id,book_id:book_id,userid: userid,session_id: session_id);
}

class RecommendPageState extends State<RecommendPage> {
  RecommendPageState({Key key,this.recommends, this.list, this.books, this.movies, this.movie_id, this.book_id,this.userid,this.session_id}) : super();
  String url="http://6a857704.r2.vip.cpolar.cn";
  final List recommends;
  final List list;
  final List books;
  final List movies;

  final String movie_id;
  final String book_id;
  String userid;
  String session_id;
  @override
  void initState() {
    super.initState();
    // getNetData();

  }

  @override
  void dispose() {
    super.dispose();
  }

  void getNetData(){
    Future.wait([
      // 2秒后返回结果
      Future.delayed(new Duration(seconds: 2), () {
        getrecommendList();
        return "hello";
      }),
      //4秒后返回结果
      Future.delayed(new Duration(seconds: 4), () {
        getmovielist(movie_id);
        return " world";
      }),
      Future.delayed(new Duration(seconds: 4), () {
        getbookslist(book_id);
        return " world";
      })
    ]).then((results){
      print(results[0]+results[1]);
    }).catchError((e){
      print(e);
    });
  }//

  //TODO 获取"每日推荐"(GET)
  void getrecommendList() async {
    final response2=await http.get(Uri.parse('$url/recommend_query'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      // recommends=responseBody["content"];
      // book_id=recommends[0]["book_id"];
      // movie_id=recommends[0]["movie_id"];
      // debugPrint(recommends.toString());
    }
  }
  //TODO 获取"电影"(GET)
  Future<void> getmovielist(String movie_id) async {
    final response2=await http.get(Uri.parse('$url/movie_query?movie_id=$movie_id'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      // movies=responseBody["content"];
    }
  }
  //TODO 获取"图书"(GET)
  Future<void> getbookslist(String book_id) async {
    final response2=await http.get(Uri.parse('$url/book_query?book_id=$book_id'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      setState((){
        // books=responseBody["content"];
      });
    }
  }

  List<Widget> _getData() {
    var temp = list.map((value) {
      print("book_id:"+book_id);
      print("movie_id:"+movie_id);
      return Container(
          margin: EdgeInsets.all(rpx(10)),
          child: Column(
            children: [
              //图书卡片
              Container(
                child:
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: rpx(5.0)),
                      child: Container(
                          height:rpx(300.0),
                          width: rpx(400.0),
                          decoration: BoxDecoration(
                            //设置边框
                            border: new Border.all(
                                color: Colors.black26, width: 0.5),
                          ),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: rpx(25.0), top: rpx(15.0)),
                                      child: Text(movies[0]["movie_name"],
                                        style: TextStyle(fontSize: rpx(25.0)),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: rpx(30.0), top: rpx(20.0)),
                                      child: Container(
                                        height: rpx(145.0),
                                        width: rpx(230.0),
                                        child: Text(
                                          movies[0]["description"], maxLines: 6,
                                          style: TextStyle(fontSize: rpx(20.0),
                                              color: Colors.black38),
                                          overflow: TextOverflow.ellipsis,),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: rpx(280.0), top: rpx(16.0)),
                              child: MaterialButton(
                                onPressed: () {

                                  int k=0;
                                  for(int j=0;j<moviessum.length;j++)
                                  {
                                    if(moviessum[j].movie_id.toString()==movies[0]["movie_id"].toString())
                                    {
                                      k=j;
                                      break;
                                    }
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => messagenote(
                                        m1:  moviessum[k],
                                        yingdans: yingdans ,
                                        movies: moviessum,
                                        session_id:session_id ,
                                      )));
                                },
                                child: Text("详情>",
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                            )
                          ],
                          )
                      ),
                    ),
                    //图片组件
                    Padding(
                      padding: EdgeInsets.only(
                          left: rpx(295.0), top: rpx(35.0), bottom: rpx(25.0)),
                      child: Container(
                        height: rpx(240),
                        width: rpx(175),
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.black26,
                              offset: Offset(0.0, 6.0),
                              blurRadius: 6.0,
                              spreadRadius: 0.5),
                          ],
                        ),
                        child: Image.asset(
                          "images/${movies[0]["movie_picture"]}", width: rpx(240.0), height: rpx(240.0),),
                      ),
                    )
                  ],),
              ),
              SizedBox(height: rpx(15.0),),
              //电影卡片
              Container(
                child:
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: rpx(5.0)),
                      child: Container(
                          height:rpx(300.0),
                          width: rpx(400.0),
                          decoration: BoxDecoration(
                            //设置边框
                            border: new Border.all(
                                color: Colors.black26, width: 0.5),
                          ),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: rpx(25.0), top: rpx(15.0)),
                                      child: Text(books[0]["book_name"],
                                        style: TextStyle(fontSize: rpx(25.0)),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: rpx(30.0), top: rpx(20.0)),
                                      child: Container(
                                        height:rpx(145.0),
                                        width: rpx(230.0),
                                        child: Text(
                                          books[0]["description"],
                                          maxLines: 5,
                                          style: TextStyle(fontSize: rpx(20.0),
                                              color: Colors.black38),
                                          overflow: TextOverflow.ellipsis,),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: rpx(280.0), top: rpx(16.0)),
                              child: MaterialButton(
                                onPressed: () {
                                 int k=0;
                                  int k2=0;

                                  for(int j=0;j<booksum.length;j++)
                                  {
                                    if(booksum[j].book_id.toString()==books[0]["book_id"].toString())
                                    {
                                      k=j;
                                      break;
                                    }
                                  }
                                  for(int j=0;j<reads.length;j++)
                                  {
                                    if(reads[j].book_id.toString()==books[0]["book_id"].toString())
                                    {
                                      k2=j;
                                      break;
                                    }
                                  }
                                  List<bookdan> includebang = [];
                                  for (int i = 0; i < bookdans.length; i++) {
                                    for (int j = 0; j < bookdans[i].book_id.length; j++) {
                                      if (books[0]["book_id"].toString() == bookdans[i].book_id[j].toString()) {
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
                                },
                                child: Text("详情>",
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                            )
                          ],
                          )
                      ),
                    ),
                    //图片组件
                    Padding(
                      padding: EdgeInsets.only(
                          left: rpx(295.0), top: rpx(35.0), bottom: rpx(25.0)),
                      child: Container(
                        height:rpx(240),
                        width: rpx(175),
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.black26,
                              offset: Offset(0.0, 6.0),
                              blurRadius: 6.0,
                              spreadRadius: 0.5),
                          ],
                        ),
                        child: Image.asset(
                          "images/${books[0]["book_picture"]}", width: rpx(240.0), height: rpx(240.0),),
                      ),
                    )
                  ],),
              ),
            ],
          ));
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context){
    print("里面的${userid}");
     getbookinfo(userid);
     getmovieinfo(userid);
    return Scaffold(
      appBar: AppBar(
        title: Text("每日推荐"),
        centerTitle:true,
      ),
      body: ListView(
        children:this._getData()
      )
    );
  }
}

