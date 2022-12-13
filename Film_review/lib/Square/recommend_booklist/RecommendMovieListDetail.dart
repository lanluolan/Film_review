import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/moviedanlist.dart';
import 'package:film_review/model/movielist.dart';
import 'package:film_review/rpx.dart';
import 'package:film_review/widgets/message/messagenote.dart';
import 'package:flutter/material.dart';
import 'package:film_review/Square/recommend/RecommendPage_BookClass.dart';
import 'package:film_review/Square/recommend/RecommendPage_MovieClass.dart';
import 'package:http/http.dart' as http;
List<movie> moviessum = [];
List<moviedan> yingdans = [];
String url2 = "http://6a857704.r2.vip.cpolar.cn";
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
class RecommendMovieListDetail extends StatelessWidget {
  List movies;
  String userid;
  String session_id;
  RecommendMovieListDetail(this.movies,this.userid,this.session_id);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home:MyHomePageH(movies: movies,userid: userid,session_id: session_id,)
    );
  }
}

class MyHomePageH extends StatefulWidget {
  MyHomePageH({Key key,this.movies,this.userid,this.session_id}) : super(key: key);
  final List movies;
  String userid;
  String session_id;
  @override
  RecommendMovieListDetailState createState() {
    return RecommendMovieListDetailState(movies: this.movies,userid: userid,session_id: session_id);
  }
}

class RecommendMovieListDetailState extends State<MyHomePageH> {
  RecommendMovieListDetailState({Key key,this.movies,this.userid,this.session_id}) : super();
  final List movies;
  String userid;
  String session_id;

  @override
  void initState() {
    getmovieinfo(userid);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _getData() {
    var temp = movies.map((value) {
      return Card(
          margin: EdgeInsets.all(rpx(10)),
          child: Column(children: <Widget>[
            //电影图片
            AspectRatio(
                aspectRatio: 2.0 / 1.0,
                child: Image.asset(
                  "images/${value["movie_picture"]}",
                  fit: BoxFit.cover,)),
            //电影名字
            ListTile(
              title: Text(
                value["movie_name"],
                style: TextStyle(fontSize: rpx(20)),
              ),
              subtitle: Text("电影"),
            ),
            //电影介绍
            ListTile(title: Text(value["description"],style: TextStyle(color: Colors.black45,overflow: TextOverflow.ellipsis),maxLines: 5,)),
            //详情按钮
            Container(
              height: rpx(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(onPressed: (){
                    int k=0;
                    for(int j=0;j<moviessum.length;j++)
                    {
                      if(moviessum[j].movie_id.toString()==value["movie_id"].toString())
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
          title: Text("影单详情",style: TextStyle(color: Colors.white),),
          centerTitle:true,
        ),
        body: ListView(
            children:this._getData()
        )
    );
  }
}

