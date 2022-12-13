import 'package:film_review/Login/User.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';

class wordDetails extends StatefulWidget {
  User userData;
  Map value;
  Map book;
  wordDetails(this.userData,this.value,this.book);
  @override
  wordDetailsState createState() => wordDetailsState(userData:userData,value:value,book:book);
}

class wordDetailsState extends State<wordDetails> {
  wordDetailsState({Key key,this.userData,this.value,this.book}) : super();
  final User userData;
  final Map value;
  final Map book;
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
                            Text("来自书籍:"),
                            Padding(padding: EdgeInsets.only(left:rpx(10.0))),
                            Text(book["book_name"],style: TextStyle(color: Colors.lightBlue),)
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
