import 'dart:async';
import 'dart:convert';
import 'package:film_review/Square/ThemePage.dart';
import 'package:film_review/Square/recommend_booklist/RecommendBookListDetail.dart';
import 'package:film_review/Square/recommend_booklist/RecommendMovieListDetail.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:film_review/Square/recommend/RecommendPage.dart';
import 'package:film_review/Square/book_review/BookReview.dart';
import 'package:film_review/Square/movie_review/MovieReview.dart';
import 'package:film_review/Square/recommend_booklist/RecommendBookListPage.dart';
import 'package:film_review/Square/ranking_list/RankingList.dart';
import 'package:http/http.dart' as http;
import 'package:film_review/Square/recommend_booklist/RecommendMovieListPage.dart';

class SquarePage extends StatefulWidget {
  String session_id;
  String email;
  String user_name;
  SquarePage(this.session_id,this.email,this.user_name);
  @override
  _HomeItemDemoPageState createState() => _HomeItemDemoPageState(session_id:session_id,email:email,user_name: user_name);
}

class _HomeItemDemoPageState extends State<SquarePage> {
  _HomeItemDemoPageState({Key key,this.session_id,this.email,this.user_name}) : super();
  String url="http://6a857704.r2.vip.cpolar.cn";
  final String session_id;
  final String email;
  final String user_name;
  var _titleTxt = new TextEditingController();
  //轮播图图片
  List<String> imagelist = [
    "images/scroll1.jpg",
    "images/scroll2.jpg",
    "images/scroll3.jpg",
  ];
  List booklist=[{}];
  List movielist=[{}];

  List bookreviews=[{}];
  List moviereviews=[{}];

  //RecommendBookListDetail（发现-书单->详情）
  List book=[];
  List booktemp=[{}];
  List book2=[];
  List book3=[];
  //RecommendBookListDetail（发现-书单->详情）

  //RecommendMovieListDetail（发现-影单->详情）
  List movie=[];
  List movietemp=[{}];
  List movie2=[];
  List movie3=[];
  //RecommendMovieListDetail（发现-影单->详情）

  //RecommendPage(每日推荐)
  List recommends=[{}];
  List list=[{}];
  List books=[{}];
  List movies=[{}];

  String movie_id="";
  String book_id="";
  //RecommendPage(每日推荐)

  //BookReview(书评)
  String like="0";
  List likes=[{}];
  String remark="0";
  Map<int,dynamic> map={};
  Map<int,dynamic> mapthumb={};
  Map<int,dynamic> mapremark={};
  Map<int,dynamic> mapremarkcontent={};
  Map<int,dynamic> mapremark_remark={};
  //BookReview(书评)

  //MovieReview(影评)
  String likemovie="0";
  List likesmovie=[{}];
  String remarkmovie="0";
  Map<int,dynamic> mapmovie={};
  Map<int,dynamic> mapthumbmovie={};
  Map<int,dynamic> mapremarkmovie={};
  Map<int,dynamic> mapremarkcontentmovie={};
  Map<int,dynamic> mapremark_remarkmovie={};
  //MovieReview(影评)

  //MovieReview(影评)
  //TODO 查询“评论”--评论（GET）
  Future<void> getmovieremark_remark(int j,String dest_id) async {
    final response2=await http.get(Uri.parse('$url/comment_query?type=8&dest_id=$dest_id'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      if(responseBody.containsKey("size")){
        setState((){
          mapremark_remarkmovie[j]=responseBody["content"];
          print("re:"+mapremark_remarkmovie.toString());
        });
      }else{
        print("none remark");
      }
    }
  }
  //TODO 查询“评论”--观后感（GET）
  Future<void> getmovieremark(int j,String dest_id) async {
    final response2=await http.get(Uri.parse('$url/comment_query?type=5&dest_id=$dest_id'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      if(responseBody.containsKey("size")){
        setState((){
          // remark=responseBody["size"].toString();
          mapremarkmovie[j]=remarkmovie.toString();
          print("ma:"+mapremarkmovie[j].toString());
          mapremarkcontentmovie[j]=responseBody["content"];
          print("re:"+mapremarkcontentmovie.toString());
        });
      }else{
        mapremarkmovie[j]="0";
        print("none remark");
      }
      debugPrint("remark:"+remarkmovie.toString());
    }
  }
  //TODO 查询”点赞“(GET)
  Future<void> getmovielike(int j,String dest_id) async {
    final response2=await http.get(Uri.parse('$url/likes_query?type=5&dest_id=$dest_id'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      if(responseBody.containsKey("size")){
        setState(() {
          // like=responseBody["size"].toString();
          mapmovie[j]=likemovie.toString();
          // print("map[j]:"+map[j].toString());
          // likes=responseBody["content"];
          // print("likes："+likes.toString());
          for(int i=0;i<likesmovie.length;i++){
            if(likesmovie[i]["user_id"]==email && likesmovie[i]["dest_id"]==dest_id){
              mapthumbmovie[j]=true;
              break;
            }else{
              mapthumbmovie[j]=false;
            }
          }
          print("thu"+mapthumbmovie[j].toString());
        });
      }else{
        mapmovie[j]="0";
        mapthumbmovie[j]=false;
        print("none like");
      }
      debugPrint("like:"+likemovie.toString());
    }
  }
  //TODO 添加“点赞”（POST）
  Future<void> postmovielike(String session_id,String type,String dest_id) async {
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
  void getNetMovieReviewData(){
    Future.wait([
      // 2秒后返回结果
      Future.delayed(new Duration(seconds: 2), () {
        return "hello";
      }),
    ]).then((results){
      print(results[0]);
      for(int i=0;i<moviereviews.length;i++){
        Future(() => getmovielike(moviereviews[i]["movie_reaction_id"],moviereviews[i]["movie_id"]));
      }
      for(int i=0;i<moviereviews.length;i++){
        Future(() => getmovieremark(moviereviews[i]["movie_reaction_id"],moviereviews[i]["movie_id"]));
      }
      for(int k in mapremarkcontentmovie.keys){//k是moviereview的id
        Future(() => getmovieremark_remark(mapremarkcontentmovie[k]["comment_id"],k.toString()));
      }
    }).catchError((e){
      print(e);
    });
  }
  //MovieReview(影评)

  //BookReview(书评)
  //TODO 查询“评论”--评论（GET）
  Future<void> getremark_remark(int j,String dest_id) async {
    final response2=await http.get(Uri.parse('$url/comment_query?type=8&dest_id=$dest_id'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      if(responseBody.containsKey("size")){
        setState((){
          mapremark_remark[j]=responseBody["content"];
          // print("re:"+mapremark_remark.toString());
        });
      }else{
        print("none remark");
      }
    }
  }
  //TODO 查询“评论”--读后感（GET）
  Future<void> getremark(int j,String dest_id) async {
    final response2=await http.get(Uri.parse('$url/comment_query?type=6&dest_id=$dest_id'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      if(responseBody.containsKey("size")){
        setState((){
          remark=responseBody["size"].toString();
          mapremark[j]=remark.toString();
          // print("ma:"+mapremark[j].toString());
          mapremarkcontent[j]=responseBody["content"];
          // print("re:"+mapremarkcontent.toString());
        });
      }else{
        mapremark[j]="0";
        print("none remark");
      }
      debugPrint("remark:"+remark.toString());
    }
  }
  //TODO 查询”点赞“(GET)
  Future<void> getlike(int j,String dest_id) async {
    final response2=await http.get(Uri.parse('$url/likes_query?type=6&dest_id=$dest_id'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      if(responseBody.containsKey("size")){
        setState(() {
          like=responseBody["size"].toString();
          map[j]=like.toString();
          // print("map[j]:"+map[j].toString());
          likes=responseBody["content"];
          // print("likes："+likes.toString());
          for(int i=0;i<likes.length;i++){
            if(likes[i]["user_id"]==email && likes[i]["dest_id"]==dest_id){
              mapthumb[j]=true;
              break;
            }else{
              mapthumb[j]=false;
            }
          }
          print("mapthumb:"+mapthumb.toString());
        });
      }else{
        map[j]="0";
        mapthumb[j]=false;
        print("none like");
      }
      debugPrint("like:"+like.toString());
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
  void getNetBookReviewData(){
    Future.wait([
      // 2秒后返回结果
      Future.delayed(new Duration(seconds: 2), () {
        return "hello";
      }),
    ]).then((results){
      print(results[0]);
      for(int i=0;i<bookreviews.length;i++){
        Future(() => getlike(bookreviews[i]["book_reaction_id"],bookreviews[i]["book_id"]));
      }
      for(int i=0;i<bookreviews.length;i++){
        Future(() => getremark(bookreviews[i]["book_reaction_id"],bookreviews[i]["book_id"]));
      }
      for(int k in mapremarkcontent.keys){//k是bookreview的id
        Future(() => getremark_remark(mapremarkcontent[k]["comment_id"],k.toString()));
      }
    }).catchError((e){
      print(e);
    });
  }
  //BookReview(书评)

  //RecommendBookListPage(推荐书单-更多)
  //TODO 查询“书单”(GET)
  Future<void> getbooklist() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/booklist_query'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        booklist=json.decode(responseContent)["content"];
      });
      // debugPrint(booklist.toString());
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }
  //RecommendBookListPage(推荐书单-更多)

  //RecommendMovieListPage(推荐影单-更多)
  //TODO 查询“影单”(GET)
  Future<void> getmovielist() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/movielist_query'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        movielist=json.decode(responseContent)["content"];
      });
      // debugPrint(movielist.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //RecommendMovieListPage(推荐影单-更多)

  //SquarePage(发现)
  //TODO 查询“图书”(GET)
  Future<void> getbook(String flag,String book_id) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/book_query?book_id=$book_id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        booktemp=json.decode(responseContent)["content"];
        if (booktemp[0]!="[]" && booktemp[0]!="[{}]"){
          if(flag=="0"){
            book.add(booktemp[0]);
          }else if(flag=="1"){
            book2.add(booktemp[0]);
          }else if(flag=="2"){
            book3.add(booktemp[0]);
          }
        }
      });
      // debugPrint("book:"+book.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //TODO 查询“电影”(GET)
  Future<void> getmovie(String flag,String movie_id) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/movie_query?movie_id=$movie_id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        movietemp=json.decode(responseContent)["content"];
        if (movietemp[0]!="[]" && movietemp[0]!="[{}]"){
          if(flag=="0"){
            movie.add(movietemp[0]);
          }else if(flag=="1"){
            movie2.add(movietemp[0]);
          }else if(flag=="2"){
            movie3.add(movietemp[0]);
          }
        }
      });
      // debugPrint("movie:"+movie.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
  //TODO 查询”读后感“(GET)
  Future<void> getbookreviewsList() async {
    final response2=await http.get(Uri.parse('$url/book_reaction_query'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      setState((){
        bookreviews=responseBody["content"];
      });
      // debugPrint("bookreviews:"+bookreviews.toString());
    }
  }
  //TODO 查询”观后感“(GET)
  Future<void> getmoviereviewsList() async {
    final response2=await http.get(Uri.parse('$url/movie_reaction_query'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      setState((){
        moviereviews=responseBody["content"];
      });
      // debugPrint("moviereviews:"+moviereviews.toString());
    }
  }
  void getNetbooklist_movielistData() {
    Future.wait([
      // 2秒后返回结果
      Future.wait([]),
      Future.delayed(new Duration(seconds: 1), () {
        getbooklist();
        return "hello_booklist";
      }),
      Future.delayed(new Duration(seconds: 1), () {
        getmovielist();
        return "hello_movielist";
      }),
      Future.delayed(new Duration(seconds: 1), () {
        getbookreviewsList();
        return "hello_bookreview";
      }),

      ///
      Future.delayed(new Duration(seconds: 1), () {
        getmoviereviewsList();
        return "hello_moviereview";
      }),
      ///

    ]).then((results) {
      print(results[0]);
      Future.delayed(new Duration(seconds: 1), () {
        debugPrint("len:"+booklist[2]["book_id"].toString());
        for(int i=0;i<booklist[0]["book_id"].length;i++){
          Future(()=>getbook("0",booklist[0]["book_id"][i].toString()));
        }
      });
      Future.delayed(new Duration(seconds: 1), () {
        for(int i=0;i<booklist[1]["book_id"].length;i++){
          Future(()=>getbook("1",booklist[1]["book_id"][i].toString()));
        }
      });
      Future.delayed(new Duration(seconds: 1), () {
        for(int i=0;i<booklist[2]["book_id"].length;i++){
          Future(()=>getbook("2",booklist[2]["book_id"][i].toString()));
        }
      });

      Future.delayed(new Duration(seconds: 1), () {
        // debugPrint("len:"+movielist[2]["movie_id"].toString());
        for(int i=0;i<movielist[0]["movie_id"].length;i++){
          Future(()=>getmovie("0",movielist[0]["movie_id"][i].toString()));
        }
      });
      Future.delayed(new Duration(seconds: 1), () {
        for(int i=0;i<movielist[1]["movie_id"].length;i++){
          Future(()=>getmovie("1",movielist[1]["movie_id"][i].toString()));
        }
      });
      Future.delayed(new Duration(seconds: 1), () {
        for(int i=0;i<movielist[2]["movie_id"].length;i++){
          Future(()=>getmovie("2",movielist[2]["movie_id"][i].toString()));
        }});
    }).catchError((e) {
      print(e);
    });
  }
  //SquarePage(发现)

  //RecommendPage(每日推荐)
  //TODO 获取"每日推荐"(GET)
  void getrecommendRList() async {
    final response2=await http.get(Uri.parse('$url/recommend_query'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      recommends=responseBody["content"];
      book_id=recommends[0]["book_id"];
      movie_id=recommends[0]["movie_id"];
      // debugPrint(recommends.toString());
    }
  }
  //TODO 获取"电影"(GET)
  Future<void> getmovieRlist(String movie_id) async {
    final response2=await http.get(Uri.parse('$url/movie_query?movie_id=$movie_id'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      movies=responseBody["content"];
    }
  }
  //TODO 获取"图书"(GET)
  Future<void> getbooksRlist(String book_id) async {
    final response2=await http.get(Uri.parse('$url/book_query?book_id=$book_id'));
    if (response2.statusCode == 200) {
      var utf8ResponseBody=utf8.decode(response2.bodyBytes);
      Map<String,dynamic> responseBody=json.decode(utf8ResponseBody);
      setState((){
        books=responseBody["content"];
      });
    }
  }
  void getNetRecommendPageData(){
    Future.wait([
      // 2秒后返回结果
      Future.delayed(new Duration(seconds: 2), () {
        getrecommendRList();
        return "hello";
      }),
      //4秒后返回结果
      Future.delayed(new Duration(seconds: 4), () {
        getmovieRlist(movie_id);
        return " world";
      }),
      Future.delayed(new Duration(seconds: 4), () {
        getbooksRlist(book_id);
        return " world";
      })
    ]).then((results){
      print(results[0]+results[1]);
    }).catchError((e){
      print(e);
    });
  }
  //RecommendPage(每日推荐)


  @override
  void initState() {
    super.initState();
    getNetbooklist_movielistData();
    getNetRecommendPageData();//RecommendPage(每日推荐)
    getNetBookReviewData();//BookReview(书评)
    getNetMovieReviewData();//MovieReview(书评)
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children: <Widget>[
          Column(
              children: <Widget>[
                SizedBox(height: rpx(10)),
                //搜索框
                Padding(
                  padding: EdgeInsets.only(left: rpx(5.0),right: rpx(5.0)),
                  child: TextField(
                      controller: _titleTxt,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "搜索书籍或电影",
                          suffixIcon: GestureDetector(
                            onTap: (){

                            },
                            child: Icon(Icons.search),
                          )
                      ),
                  )
                ),
                SizedBox(height: rpx(10)),
                //轮播图
                BannerWidget(
                  imageList: imagelist,
                ),
                //横向列表（每日推荐，书评，影评，排行榜）
                Padding(
                  padding: EdgeInsets.only(left: rpx(20), right: rpx(20), top: rpx(5.0)),
                  child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //每日推荐
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                                    //   return RecommendPage(recommends,list,books,movies,movie_id,book_id);
                                    // }));
                                  },
                                  icon: Image.asset("images/command.jpg"),
                                  iconSize: rpx(48.0),
                                ),
                                Text("每日推荐", style: TextStyle(color: Colors.black38))
                              ],
                            ),
                            //书评
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                                  //       BookReview(session_id,bookreviews,email,like,likes,remark,map,mapthumb,mapremark,mapremarkcontent,mapremark_remark)));
                                  //
                                  },
                                  icon: Image.asset("images/books.jpg"),
                                  iconSize: rpx(48.0),
                                ),
                                Text("书评", style: TextStyle(color: Colors.black38))
                              ],
                            ),
                            //影评
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                                    //   return MovieReview(session_id,moviereviews,email,likemovie,likesmovie,remarkmovie,mapmovie,mapthumbmovie,mapremarkmovie,mapremarkcontentmovie,mapremark_remarkmovie);
                                    // }));
                                  },
                                  icon: Image.asset("images/films.jpg"),
                                  iconSize: rpx(48.0),
                                ),
                                Text("影评", style: TextStyle(color: Colors.black38))
                              ],
                            ),
                            //排行榜
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                                      return RankingList(user_name);
                                    }));
                                  },
                                  icon: Image.asset("images/rangelist.jpg"),
                                  iconSize: rpx(48.0),
                                ),
                                Text("排行榜", style: TextStyle(color: Colors.black38))
                              ],
                            ),
                          ],
                        ),
                      ]
                  ),
                ),
                //第一条灰线
                Padding(
                  padding: EdgeInsets.only(left: rpx(20.0), right: rpx(20.0)),
                  child: Divider(
                    color: Colors.black26,
                  ),
                ),
                //推荐书单
                Padding(
                  padding: EdgeInsets.only(left: rpx(20.0), right: rpx(20.0)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("推荐书单", style: TextStyle(fontSize:rpx(25.0)),),
                          TextButton(
                              onPressed: (){
                               // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RecommendBookListPage(booklist)));
                              },
                              child: Text("更多 >", style: TextStyle(fontSize: rpx(20.0), color: Colors.black38),)
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //书单（图片与文字)
                Padding(
                    padding: EdgeInsets.only(left: rpx(5.0), right: rpx(5.0)),
                    child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //第一个书单
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                        //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RecommendBookListDetail(book)));
                                      },
                                      child: Container(
                                        width: rpx(120),
                                        height: rpx(160),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: AssetImage("images/${booklist[0]["booklist_picture"]}"),
                                              fit: BoxFit.fill
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Text(booklist[0]["booklist_name"]),
                                  ],
                                ),
                              ),
                              //第二个书单
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                       // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RecommendBookListDetail(book2)));
                                      },
                                      child: Container(
                                        width: rpx(120),
                                        height: rpx(160),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: AssetImage("images/${booklist[1]["booklist_picture"]}"),
                                              fit: BoxFit.fill
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Text(booklist[1]["booklist_name"]),
                                  ],
                                ),
                              ),
                              //第三个书单
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                       // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RecommendBookListDetail(book3)));
                                      },
                                      child: Container(
                                        width: rpx(120),
                                        height:rpx(160),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: AssetImage("images/${booklist[2]["booklist_picture"]}"),
                                              fit: BoxFit.fill
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Text(booklist[2]["booklist_name"]),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ]
                    )
                ),
                //推荐影单
                Padding(
                  padding: EdgeInsets.only(left: rpx(20.0), right: rpx(20.0)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("推荐影单", style: TextStyle(fontSize:rpx(25.0)),),
                          TextButton(
                              onPressed: (){
                              //  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RecommendMovieListPage(movielist)));
                              },
                              child: Text("更多 >", style: TextStyle(fontSize:rpx(20.0), color: Colors.black38),)
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //影单（图片与文字)
                Padding(
                    padding: EdgeInsets.only(left: rpx(5.0), right: rpx(5.0)),
                    child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //第一个影单
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                       // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RecommendMovieListDetail(movie)));
                                      },
                                      child: Container(
                                        width: rpx(120),
                                        height: rpx(160),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: AssetImage("images/${movielist[0]["movielist_picture"]}"),
                                              fit: BoxFit.fill
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Text(movielist[0]["movielist_name"]),
                                  ],
                                ),
                              ),
                              //第二个影单
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                      //  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RecommendMovieListDetail(movie2)));
                                      },
                                      child: Container(
                                        width: rpx(120),
                                        height: rpx(160),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: AssetImage("images/${movielist[1]["movielist_picture"]}"),
                                              fit: BoxFit.fill
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Text(movielist[1]["movielist_name"]),
                                  ],
                                ),
                              ),
                              //第三个影单
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                       // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RecommendMovieListDetail(movie3)));
                                      },
                                      child: Container(
                                        width: rpx(120),
                                        height: rpx(160),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: AssetImage("images/${movielist[2]["movielist_picture"]}"),
                                              fit: BoxFit.fill
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Text(movielist[2]["movielist_name"]),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ]
                    )
                )
              ]
          ),
        ],
      )
    );
  }
}

//轮播图构造方法
class BannerWidget extends StatefulWidget {
  final List<String> imageList;

  ///轮播的时间
  final Duration loopDuration;

  BannerWidget({
    //必传参数
    this.imageList,
    //轮播时间
    this.loopDuration = const Duration(seconds: 3),
  });

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}
class _BannerWidgetState extends State<BannerWidget> {
  //显示的轮播总页数
  int _total = 5;
  //当前显示的页数
  int _current = 1;
  //计时器
  Timer _timer;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    //轮播图个数
    _total = widget.imageList.length;
    //轮播控制器
    _pageController = new PageController(initialPage: 5000);
    //开始轮播
    startLoopFunction();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //轮播图
    return Container(
      color: Colors.red,
      height: rpx(250),
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        //手指按下的回调
        onTapDown: (TapDownDetails details) {
          debugPrint("手指按下，停止轮播");
          stopLoopFunction();
        },
        //手指抬起的回调
        onTap: () {
          debugPrint("手指抬起，开始轮播");
          startLoopFunction();
          Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
            return ThemePage();
          }));
        },
        //手指按下后滑动移出的回调
        onTapCancel: () {
          debugPrint("手指移出，开始轮播");
          startLoopFunction();
        },
        child: buildStack(),
      ),
    );
  }

  //定义开始轮播的方法
  void startLoopFunction() {
    //定时器
    _timer = Timer.periodic(widget.loopDuration, (timer) {
      //滑动到下一页
      _pageController.nextPage(
        curve: Curves.linear,
        duration: Duration(
          milliseconds: 200,
        ),
      );
    });
  }

  //定义停止轮播的方法
  void stopLoopFunction() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  Stack buildStack() {
    return Stack(
      children: [
        //第一层 轮播
        Positioned.fill(
          child: PageView.builder(
            //控制器
            controller: _pageController,
            //总页数
            itemCount: 10000,
            //滑动时回调 value 当前显示的页面
            onPageChanged: (value) {
              setState(() {
                _current = value % widget.imageList.length;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              String image = widget.imageList[index % widget.imageList.length];
              return Image.asset(
                image,
                fit: BoxFit.fill,
              );
            },
          ),
        ),
        //第二层 指示器
        Positioned(
          right: rpx(14),
          bottom: rpx(14),
          child: buildContainer(),
        ),
      ],
    );
  }

  Container buildContainer() {
    return Container(
      alignment: Alignment.center,
      width: rpx(50),
      height: rpx(24),
      decoration: BoxDecoration(
          color: Colors.grey[200]?.withOpacity(0.5),
          //设置圆角
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Text(
        "${_current+1}/$_total",
        textAlign: TextAlign.center,
      ),
    );
  }
}

