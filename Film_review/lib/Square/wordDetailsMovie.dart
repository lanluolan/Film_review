import 'package:film_review/Login/User.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';

class wordDetailsMovie extends StatefulWidget {
  User userData;
  Map value;
  Map movie;
  wordDetailsMovie(this.userData,this.value,this.movie);
  @override
  wordDetailsMovieState createState() => wordDetailsMovieState(userData:userData,value:value,movie:movie);
}

class wordDetailsMovieState extends State<wordDetailsMovie> {
  wordDetailsMovieState({Key key,this.userData,this.value,this.movie}) : super();
  final User userData;
  final Map value;
  final Map movie;
  Widget build(BuildContext context) {
    print(userData.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text("感想详情"),
          centerTitle: true,
        ),
        body: Padding(padding: EdgeInsets.all(rpx(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "images/beijin.jpg",
                        ),
                        maxRadius: 31,
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: rpx(30.0)),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userData.user_name,style: TextStyle(fontSize: rpx(30.0)),),
                        SizedBox(height: rpx(10.0),),
                        Text(value["create_time"]),
                        SizedBox(height: rpx(10.0),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("来自电影:"),
                            Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                            Text(movie["movie_name"],style: TextStyle(color: Colors.lightBlue),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: rpx(10.0),),
              Text(value["title"],style: TextStyle(fontSize: rpx(32.0)),),
              Text(value["content"],style: TextStyle(fontSize: rpx(28.0),color: Colors.black54),),
            ],
          ),
        )
    );
  }
}
