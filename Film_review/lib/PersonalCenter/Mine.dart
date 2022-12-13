import 'dart:convert';
import 'package:film_review/PersonalCenter/MyCollect.dart';
import 'package:film_review/PersonalCenter/MyMessage.dart';
import 'package:film_review/PersonalCenter/MyPlan.dart';
import 'package:film_review/PersonalCenter/MyPost.dart';
import 'package:film_review/PersonalCenter/PersonInfo.dart';
import 'package:film_review/PersonalCenter/Vip.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:film_review/PersonalCenter/menu_item.dart';
import 'package:film_review/Login/User.dart';
import 'package:http/http.dart' as http;
import 'package:film_review/PersonalCenter/About.dart';
import 'package:film_review/Square/ranking_list/RankingList.dart';

class Mine extends StatefulWidget {
  String email;
  String session_id;
  Mine(this.email,this.session_id);
  @override
  _MyHomePageState createState() {
    return _MyHomePageState(email: this.email,session_id:this.session_id);
  }
}
class _MyHomePageState extends State<Mine> {
  _MyHomePageState({Key key,this.email,this.session_id}) : super();
  final double _appBarHeight = rpx(180.0);
  String url="http://6a857704.r2.vip.cpolar.cn";
  User userData;
  final String email;
  final String session_id;


  //MyCollect(我的收藏)
  List collectbooklist=[{}];//书单
  List collectmovielist=[{}];//影单
  //MyCollect(我的收藏)

  //MyPostBookReview(我的发布)
  List bookreviews=[{}];//书评
  List filmreviews=[{}];//影评
  //MyPostBookReview(我的发布)

  //Myplan(我的计划)
  List bookplan=[{}];
  List movieplan=[{}];
  List books=[{}];
  List movies=[{}];
  //Myplan(我的计划)

  @override
  void initState() {
    super.initState();
    GetUserInfo();

    getusercollectbooklistid();
    getusercollectmovielistid();

    getbookreviewsList(email);
    getmoviereviewsList(email);

    getreadbooksList();
    getwatchmoviesList();
    getbooksList();
    getmoviesList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refresh(){
    getreadbooksList();
    getwatchmoviesList();
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

  //MyCollect_booklist(我的收藏)
  //TODO 访问网络：搜索所有书单（查询书单）
  Future<void> getusercollectbooklistid() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/booklist_query'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      String responseContent = await response.stream.transform(utf8.decoder).join();
      setState(() {
        collectbooklist = json.decode(responseContent)["content"];
      });
      debugPrint(collectbooklist.toString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //TODO 访问网络：搜索所有影单（查询影单）
  Future<void> getusercollectmovielistid() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/movielist_query'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      String responseContent = await response.stream.transform(utf8.decoder).join();
      setState(() {
        collectmovielist = json.decode(responseContent)["content"];
      });
      debugPrint(collectmovielist.toString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //MyCollect_booklist(我的收藏)

  //MyPostBookReview(我的发布)
  //TODO 获取书评后端数据(查询读后感）
  Future<void> getbookreviewsList(String email) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/book_reaction_query?user_id=$email'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        bookreviews=json.decode(responseContent)["content"];
      });
      debugPrint(bookreviews.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //TODO 获取影评后端数据(查询观后感）
  Future<void> getmoviereviewsList(String email) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/movie_reaction_query?user_id=$email'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        filmreviews=json.decode(responseContent)["content"];
      });
      debugPrint(filmreviews.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //MyPostBookReview(我的发布)

  //MyPlan(我的计划)
  //TODO 获取"阅读状态"
  Future<void> getreadbooksList() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/reading_status_query?user_id=$email'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        bookplan=json.decode(responseContent)["content"];
      });
      debugPrint("bookplan:"+bookplan.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //TODO 获取"观影状态"
  Future<void> getwatchmoviesList() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/watching_status_query?user_id=$email}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        movieplan=json.decode(responseContent)["content"];
      });
      // debugPrint(readbooks.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //TODO 获取"图书"
  Future<void> getbooksList() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/book_query'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        books=json.decode(responseContent)["content"];
      });
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //TODO 获取"电影"
  Future<void> getmoviesList() async {
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
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //MyPlan(我的计划)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeight,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[
                          Color(0x00000000),
                          Color(0x00000000)
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: rpx(30.0),
                                left: rpx(30.0),
                                bottom: rpx(5.0),
                              ),
                              child: Text(
                                userData.user_name.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: rpx(35.0)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left:rpx(30.0),
                              ),
                              child: Text(
                                // userData.user_description==""?
                                userData.user_description.toString(),
                                style: TextStyle(color: Colors.white, fontSize: rpx(20.0)),
                                )
                              ),
                            Padding(
                                padding: EdgeInsets.only(
                                  left: rpx(20.0),
                                  top: rpx(20.0),
                                ),
                                child:IconButton(icon:Icon(Icons.arrow_circle_right_outlined),color: Colors.white,iconSize: rpx(30.0),onPressed: (){
                                  Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                                    return PersonInfo(userData,session_id);
                                  })).then((value) => GetUserInfo());
                                },),
                            ),
                            ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: rpx(40.0),
                            right: rpx(30.0),
                          ),
                          child:  CircleAvatar(
                            backgroundImage: AssetImage(
                              "images/beijin.jpg",
                            ),
                            minRadius: 30,
                          ),
                        ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: rpx(5.0)),
                  child: Column(
                    children: <Widget>[
                      MenuItems(
                        icon: Icons.star,
                        title: '我的收藏',
                        onPressed: (){
                          Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                            return MyCollect(email,collectbooklist,collectmovielist,userData.user_name, session_id);
                          }));
                        },
                      ),
                      MenuItems(
                        icon: Icons.card_membership,
                        title: '我的会员',
                        onPressed: () {
                          Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                            return Vip();
                          }));
                        },
                      ),
                      MenuItems(
                        icon: Icons.schedule,
                        title: '我的计划',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder:(_)=>MyPlan(userData,bookplan,movieplan,books,movies,session_id))).then((value) {
                            refresh();
                            print("value:"+value.toString());
                          });
                        },
                      ),
                      MenuItems(
                        icon: Icons.post_add,
                        title: '我的发布',
                        onPressed: () {
                          Navigator.push<int>(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                                return MyPost(email,bookreviews,filmreviews,session_id);
                              }));
                        },
                      ),
                      // MenuItems(
                      //   icon: Icons.message,
                      //   title: '我的消息',
                      //   onPressed: () {
                      //     Navigator.push<int>(context, MaterialPageRoute(
                      //         builder: (BuildContext context) {
                      //           return MyMessage(email);
                      //         }));
                      //   },
                      // ),
                      MenuItems(
                        icon: Icons.list,
                        title: '排行榜',
                        onPressed: () {
                          Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                            return RankingList(userData.user_name);
                          }));
                        },
                      ),
                      MenuItems(
                        icon: Icons.person,
                        title: '关于',
                        onPressed: () {
                          Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                            return About();
                          }));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
