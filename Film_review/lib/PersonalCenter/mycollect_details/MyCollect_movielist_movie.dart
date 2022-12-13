import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/moviedanlist.dart';
import 'package:film_review/model/movielist.dart';
import 'package:film_review/rpx.dart';
import 'package:film_review/widgets/message/messagenote.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String url2 = "http://6a857704.r2.vip.cpolar.cn";
List<movie> moviessum = [];
List<moviedan> yingdans = [];
void getmovieinfo(String userid) async {
  final dio = Dio();
  try {
    Response response = await dio.get(url + "/movie_query");
    Map<String, dynamic> data = response.data;
    movielist moviesum = movielist.fromJson(data["content"]);
    moviessum=moviesum.movies;
  Response response2 = await dio.get(url + "/movielist_query");
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
class MyCollect_movielist_movie extends StatefulWidget{
  final String  targetmovielist;
  String userid;
  String session_id;
  MyCollect_movielist_movie(this.targetmovielist,this.userid,this.session_id);
  @override
  MyCollect_movielist_movieState createState() {
    return MyCollect_movielist_movieState(targetmovielist:targetmovielist,session_id: session_id);
  }
}

class MyCollect_movielist_movieState extends State<MyCollect_movielist_movie> with SingleTickerProviderStateMixin{
  MyCollect_movielist_movieState({Key key,this.targetmovielist,this.userid,this.session_id}) : super();
  final String targetmovielist;
  String userid;
  String url="http://6a857704.r2.vip.cpolar.cn";
  List targetmovielists=[{}];
  List movie=[];
  List movies=[];
  String session_id;
  @override
  void initState() {
    super.initState();
    setState(() {
      targetmovielists=targetmovielist.substring(1).substring(0,targetmovielist.length-2).split(",");
      // debugPrint(targetmovielists.length.toString());
    });
    for(int i=0;i<targetmovielists.length;i++){
      gettargetmovie(targetmovielists[i].trim());
    }
    getmovieinfo(userid.toString());
  }


  //TODO 获取后端电影数据(查询影片）
  Future<void> gettargetmovie(String movie_id) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/movie_query?movie_id=$movie_id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        movie=json.decode(responseContent)["content"];
        movies.add(movie);
      });
      // debugPrint("movie:"+movie.toString());
      // debugPrint("hihi:"+movies.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  List<Widget> _getbookreviewData() {
    var temp = movies.map((value) {
      // debugPrint(value.toString().trim());
      // debugPrint("nowmovie:"+movie.toString());
      return Card(
          margin: EdgeInsets.all(rpx(10)),
          child: Container(
              height: rpx(280),
              decoration: BoxDecoration(
                border: new Border.all(color: Colors.black26, width: rpx(0.8)),
              ),
              child: Padding(padding: EdgeInsets.all(rpx(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child:
                    Image.asset("images/${value[0]["movie_picture"]}", width: rpx(280), height:rpx(240),),
                    ),
                    Expanded(child: Column(
                      children: [
                        SizedBox(height: rpx(10.0),),
                        Text("《"+value[0]["movie_name"]+"》", style: TextStyle(fontSize: rpx(20.0)),),
                        SizedBox(height: rpx(5.0),),
                        Text(
                          value[0]["description"],
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black45,fontSize: rpx(17.0)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(onPressed: (){
                              int k=0;
                              for(int j=0;j<moviessum.length;j++)
                                {
                                  if(moviessum[j].movie_id.toString()==value[0]["movie_id"].toString())
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
                              child:Text("详情 >",style: TextStyle(color: Colors.black45),) ,
                            )
                          ],
                        ),
                      ],
                    )
                    )
                  ],
                ),
              )
          )
      );
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("影单",style: TextStyle(color: Colors.white),), centerTitle: true,),
      body: ListView(
        children: _getbookreviewData(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}