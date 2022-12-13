import 'dart:convert';

import 'package:film_review/Login/User.dart';
import 'package:film_review/Square/wordDetailsMovie.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieReview extends StatefulWidget {
  String session_id;
  List moviereview;
  String email;
  String likemovie;
  List likesmovie;
  String remarkmovie;
  Map<int,dynamic> mapmovie;
  Map<int,dynamic> mapthumbmovie;
  Map<int,dynamic> mapremarkmovie;
  Map<int,dynamic> mapremarkcontentmovie;
  Map<int,dynamic> mapremark_remarkmovie;
  List userlistAll;
  MovieReview(this.session_id,this.moviereview,this.email,this.likemovie,this.likesmovie,this.remarkmovie,this.mapmovie,this.mapthumbmovie,this.mapremarkmovie,this.mapremarkcontentmovie,this.mapremark_remarkmovie,this.userlistAll);
  @override
  MovieReviewState createState() => MovieReviewState(session_id:session_id,moviereview:moviereview,email:email,likemovie:likemovie,likesmovie:likesmovie,remarkmovie:remarkmovie,mapmovie:mapmovie,mapthumbmovie:mapthumbmovie,mapremarkmovie:mapremarkmovie,mapremarkcontentmovie:mapremarkcontentmovie,mapremark_remarkmovie:mapremark_remarkmovie,userlistAll:userlistAll);
}

class MovieReviewState extends State<MovieReview> {
  MovieReviewState({Key key,this.session_id,this.moviereview,this.email,this.likemovie,this.likesmovie,this.remarkmovie,this.mapmovie,this.mapthumbmovie,this.mapremarkmovie,this.mapremarkcontentmovie,this.mapremark_remarkmovie,this.userlistAll}) : super();
  String url="http://6a857704.r2.vip.cpolar.cn";
  final String session_id;
  final List moviereview;
  final String email;
  final String likemovie;
  final List likesmovie;
  final String remarkmovie;
  final Map<int,dynamic> mapmovie;
  final Map<int,dynamic> mapthumbmovie;
  final Map<int,dynamic> mapremarkmovie;
  final Map<int,dynamic> mapremarkcontentmovie;
  final Map<int,dynamic> mapremark_remarkmovie;
  final List userlistAll;
  User userData;
  List movies=[{}];
  Map moviesend={};
  String namestr="";

  @override
  void initState() {
    super.initState();
    GetUserInfo();
    getmovie();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //TODO 查询用户信息（用户查询）
  GetUserInfo() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('$url/user_query?user_id=$email'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent = await response.stream.transform(utf8.decoder).join();
      setState((){
        userData = User.fromJson(json.decode(responseContent)["content"][0]);
      });
      debugPrint(userData.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 查询“电影”(GET)
  Future<void> getmovie() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/movie_query'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        movies=json.decode(responseContent)["content"];
      });
      // debugPrint("movie:"+movie.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  //TODO 添加“点赞”（POST）
  Future<void> postlike(String session_id,String type,String dest_id) async {
    print(dest_id);
    var headers = {
      'Authorization': session_id,
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$url/likes_add'));
    request.fields.addAll({
      'type': type,
      'dest_id': dest_id
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      debugPrint("post success");
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  List<Widget> _getData() {
    var temp = moviereview.map((value){
      for(int i=0;i<userlistAll.length;i++){
        if(userlistAll[i]["user_id"]==value["user_id"]){
          setState(() {
            namestr=userlistAll[i]["user_name"];
          });
        }
      }
      return Card(
          margin: EdgeInsets.all(rpx(10.0)),
          child:Container(
            height: rpx(270.0),
            child: Column(
              children: [
                SizedBox(height: rpx(5.0),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.only(left: rpx(20.0)),
                      child:TextButton(child:Text(value["title"],style: TextStyle(fontSize: rpx(20.0)),),onPressed: (){
                        for(int i=0;i<movies.length;i++){
                          if(movies[i]["movie_id"].toString()==value["movie_id"]){
                            setState((){
                              moviesend=movies[i];
                              print("moviesend:"+moviesend.toString());
                            });
                          }
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => wordDetailsMovie(userData,value,moviesend)));
                      },),),
                    Padding(padding: EdgeInsets.only(right: rpx(15.0)),child:Text(value["create_time"],style: TextStyle(color: Colors.black38),),),
                  ],
                ),
                SizedBox(height: rpx(7.0),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: rpx(33.0)),
                          child: Container(
                            width: rpx(200.0),
                            child:Text(value["content"],style: TextStyle(color: Colors.black38),overflow: TextOverflow.ellipsis,maxLines: 5,),
                          ),),
                      ],
                    ),
                    Image.asset("images/${value["movie_reaction_picture"]}",width: rpx(115.0),height: rpx(115.0),),
                  ],
                ),
                SizedBox(height: rpx(7.0),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(left:rpx(30.0),bottom: rpx(5.0))),
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                "images/beijin.jpg",
                              ),
                              minRadius: 10,
                            ),
                            Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                            Text(namestr,style: TextStyle(color: Colors.black38),),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(icon:Icon(Icons.message),color: Colors.grey, iconSize: rpx(18),onPressed: (){
                            },),
                            Padding(padding: EdgeInsets.only(left: rpx(10))),
                            Text(mapremarkmovie[value["movie_reaction_id"]]),
                            Padding(padding: EdgeInsets.only(right: rpx(20.0))),
                            IconButton(
                              icon: mapthumbmovie[value["movie_reaction_id"]]
                                  ? Icon(Icons.favorite,)
                                  : Icon(Icons.favorite_border),
                              iconSize: rpx(18),
                              onPressed: () {setState(() {
                                mapthumbmovie[value["movie_reaction_id"]]=!mapthumbmovie[value["movie_reaction_id"]];
                                mapmovie[value["movie_reaction_id"]]=(int.parse(mapmovie[value["movie_reaction_id"]])+1).toString();
                                postlike(session_id, "6", value["movie_id"]);
                              });},),
                            Padding(padding: EdgeInsets.only(left: rpx(10))),
                            Text(mapmovie[value["movie_reaction_id"]]),
                            Padding(padding: EdgeInsets.only(right: rpx(15)))
                          ],//mapthumbmovie[value["movie_reaction_id"]]
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
      );
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("影评"),
          centerTitle:true,
        ),
        body: ListView(
            children:this._getData()
        )
    );
  }
}