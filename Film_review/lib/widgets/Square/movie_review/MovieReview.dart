import 'dart:convert';

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
  Map<int, dynamic> mapmovie;
  Map<int, dynamic> mapthumbmovie;
  Map<int, dynamic> mapremarkmovie;
  Map<int, dynamic> mapremarkcontentmovie;
  Map<int, dynamic> mapremark_remarkmovie;
  MovieReview(
      this.session_id,
      this.moviereview,
      this.email,
      this.likemovie,
      this.likesmovie,
      this.remarkmovie,
      this.mapmovie,
      this.mapthumbmovie,
      this.mapremarkmovie,
      this.mapremarkcontentmovie,
      this.mapremark_remarkmovie);
  @override
  MovieReviewState createState() => MovieReviewState(
      session_id: session_id,
      moviereview: moviereview,
      email: email,
      likemovie: likemovie,
      likesmovie: likesmovie,
      remarkmovie: remarkmovie,
      mapmovie: mapmovie,
      mapthumbmovie: mapthumbmovie,
      mapremarkmovie: mapremarkmovie,
      mapremarkcontentmovie: mapremarkcontentmovie,
      mapremark_remarkmovie: mapremark_remarkmovie);
}

class MovieReviewState extends State<MovieReview> {
  MovieReviewState(
      {Key key,
      this.session_id,
      this.moviereview,
      this.email,
      this.likemovie,
      this.likesmovie,
      this.remarkmovie,
      this.mapmovie,
      this.mapthumbmovie,
      this.mapremarkmovie,
      this.mapremarkcontentmovie,
      this.mapremark_remarkmovie})
      : super();
  String url="http://6a857704.r2.vip.cpolar.cn";
  final String session_id;
  final List moviereview;
  final String email;
  final String likemovie;
  final List likesmovie;
  final String remarkmovie;
  final Map<int, dynamic> mapmovie;
  final Map<int, dynamic> mapthumbmovie;
  final Map<int, dynamic> mapremarkmovie;
  final Map<int, dynamic> mapremarkcontentmovie;
  final Map<int, dynamic> mapremark_remarkmovie;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //TODO 添加“点赞”（POST）
  Future<void> postlike(String session_id, String type, String dest_id) async {
    print(dest_id);
    var headers = {
      'Authorization': session_id,
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$url/likes_add'));
    request.fields.addAll({'type': type, 'dest_id': dest_id});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      debugPrint("post success");
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  List<Widget> _getData() {
    var temp = moviereview.map((value) {
      // print(value["book_reaction_id"].toString());
      // debugPrint("value:"+value.toString());
      return Card(
          margin: EdgeInsets.all(rpx(10.0)),
          child: Container(
            height: rpx(230.0),
            child: Column(
              children: [
                SizedBox(
                  height: rpx(5.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: rpx(20.0)),
                      child: Text(
                        value["title"],
                        style: TextStyle(fontSize: rpx(20.0)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: rpx(15.0)),
                      child: Text(
                        value["create_time"],
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: rpx(7.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: rpx(20.0)),
                          child: Container(
                            width: rpx(200.0),
                            child: Text(
                              value["content"],
                              style: TextStyle(color: Colors.black38),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      "images/${value["movie_reaction_picture"]}",
                      width: rpx(115.0),
                      height: rpx(115.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: rpx(7.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: rpx(20.0), bottom: rpx(5.0))),
                            Image.asset(
                              "images/person.jpg",
                              width: rpx(25.0),
                              height: rpx(25.0),
                            ),
                            Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                            Text(
                              value["user_id"],
                              style: TextStyle(color: Colors.black38),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.message),
                              color: Colors.grey,
                              iconSize: rpx(18),
                              onPressed: () {},
                            ),
                            Padding(padding: EdgeInsets.only(left: rpx(10))),
                            Text(mapremarkmovie[value["movie_reaction_id"]]),
                            Padding(padding: EdgeInsets.only(right: rpx(20.0))),
                            IconButton(
                              icon: mapthumbmovie[value["movie_reaction_id"]]
                                  ? Icon(
                                      Icons.favorite,
                                    )
                                  : Icon(Icons.favorite_border),
                              iconSize: rpx(18),
                              onPressed: () {
                                setState(() {
                                  mapthumbmovie[value["movie_reaction_id"]] =
                                      !mapthumbmovie[
                                          value["movie_reaction_id"]];
                                  mapmovie[value["movie_reaction_id"]] =
                                      (int.parse(mapmovie[
                                                  value["movie_reaction_id"]]) +
                                              1)
                                          .toString();
                                  postlike(session_id, "6", value["movie_id"]);
                                });
                              },
                            ),
                            Padding(padding: EdgeInsets.only(left: rpx(10))),
                            Text(mapmovie[value["movie_reaction_id"]]),
                            Padding(padding: EdgeInsets.only(right: rpx(15)))
                          ], //mapthumbmovie[value["movie_reaction_id"]]
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ));
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("影评"),
          centerTitle: true,
        ),
        body: ListView(children: this._getData()));
  }
}
