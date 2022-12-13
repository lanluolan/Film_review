import 'dart:convert';

import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:film_review/Square/recommend_booklist/RecommendBookListDetail.dart';

class RecommendBookListPage extends StatefulWidget {
  List recommendbooklists;
  String userid;
  String session_id;
  RecommendBookListPage(this.recommendbooklists,this.userid,this.session_id);
  @override
  RecommendBookListPageState createState() => RecommendBookListPageState(recommendbooklists:recommendbooklists,userid: userid,session_id: session_id);
}

class RecommendBookListPageState extends State<RecommendBookListPage> {
  RecommendBookListPageState({Key key, this.recommendbooklists,this.userid,this.session_id}) : super();
  String url="http://6a857704.r2.vip.cpolar.cn";
  final List recommendbooklists;
  String userid;
  String session_id;
  List booktemp=[{}];
  Map<int,dynamic> map={};


  @override
  void initState() {
    super.initState();
    for(int i=0;i<recommendbooklists.length;i++){
      getNetbooklistData(recommendbooklists[i]);
    }
    // print("map:"+map.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  //TODO 查询“图书”(GET)
  Future<void> getbook(int j,String book_id) async {
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
        if(booktemp[0]!="{}" && booktemp[0]!="[{}]"){
          map[j].add(booktemp[0]);
        }
      });
      print(await response.stream.bytesToString());
    }
  }

  void getNetbooklistData(Map<String,dynamic> value) {

    Future.wait([
      // 2秒后返回结果
      Future.delayed(new Duration(seconds: 1), () {
        return "hello_booklist";
      }),
    ]).then((results) {
      print(results[0]);
      for (int i = 0; i < value["book_id"].length; i++) {
        map[value["booklist_id"]]=[];
        Future(() => getbook(value["booklist_id"],value["book_id"][i].toString()));
      }
    }).catchError((e) {
      print(e);
    });
  }

  List<Widget> _getData() {
    var temp = recommendbooklists.map((value) {
      print("mark:"+value["booklist_id"].toString());
      print(map[value["booklist_id"]].toString());
      return Card(
          margin: EdgeInsets.all(rpx(10)),
          child: Column(children: <Widget>[
            GestureDetector(
              onTap: () {
                // debugPrint("book:"+book.toString());
                if (map[value["booklist_id"]].toString() != "") {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                      RecommendBookListDetail(map[value["booklist_id"]],userid,session_id)));
                }
              },
              child: Container(
                width: rpx(200),
                height: rpx(220),
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("images/${value["booklist_picture"]}"),
                    fit: BoxFit.fill
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
            Text(value["booklist_name"]),
          ]));
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("推荐书单"),
          centerTitle:true,
        ),
        body: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.3/2.0,
            children:this._getData()
        )
    );
  }
}