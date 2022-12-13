import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/bookdanlist.dart';
import 'package:film_review/model/booklist.dart';
import 'package:film_review/model/jingli.dart';
import 'package:film_review/model/jinglilist.dart';
import 'package:film_review/model/yuduzhuangtailist.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/rpx.dart';
import 'package:film_review/widgets/booktotal/bookdanxiangxi.dart';
import 'package:film_review/widgets/booktotal/booknote.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
List<book> booksum = [];
List<yuduzhuangtai> reads = [];
List<bookdan> bookdans = [];
List<jingli> jinglis=[];
String url2 = "http://6a857704.r2.vip.cpolar.cn";
void getbookinfo(String userid) async {
  final dio = Dio();
  try {
    print("开始");
    final uri = Uri.parse(url2 + "/book_query");
    final uri2 = Uri.parse(url2 + "/reading_status_query?user_id=${userid}");
    // 3.发送网络请求
    Response response, response2,response3,response4;
    response = await dio.getUri(uri);
    response2 = await dio.getUri(uri2);
    Map<String, dynamic> data = response.data;
    Map<String, dynamic> data2 = response2.data;
    booklist bookstory = booklist.fromJson(data["content"]);
    print("开始2");
    yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);
    print("开始3");
    //ans = response.data;
    booksum = bookstory.books;
    reads = readsum.reads;
    final uri3 = Uri.parse(url2 + "/experience_query");
    // 3.发送网络请求
    response3 = await dio.getUri(uri3);
    Map<String, dynamic> data3 = response3.data;
    jinglilist ans = jinglilist.fromJson(data3["content"]);
    print("开始4");
    jinglis = ans.jilings;
    response4 =
    await dio.get(url2 + "/booklist_query");
    Map<String, dynamic> data4 = response4.data;
    bookdanlist bookdansummy = bookdanlist.fromJson(data4["content"]);
    bookdans = bookdansummy.bookdans;
    print("开始5");
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
class MyCollect_booklist_book extends StatefulWidget{
  final String  targetbooklist;
  String userid;
  String session_id;
  MyCollect_booklist_book(this.targetbooklist,this.userid,this.session_id);
  @override
  MyCollect_booklist_bookState createState() {
    return MyCollect_booklist_bookState(targetbooklist:targetbooklist,userid: userid);
  }
}

class MyCollect_booklist_bookState extends State<MyCollect_booklist_book> with SingleTickerProviderStateMixin{
  MyCollect_booklist_bookState({Key key,this.targetbooklist,this.userid,this.session_id}) : super();
  final String targetbooklist;
  String userid;
  String session_id;
  String url="http://6a857704.r2.vip.cpolar.cn";
  List targetbooklists=[{}];
  List book=[];
  List books=[];
  @override
  void initState() {
    super.initState();
    setState(() {
      targetbooklists=targetbooklist.substring(1).substring(0,targetbooklist.length-2).split(",");
      // debugPrint(targetbooklists.length.toString());
    });
    for(int i=0;i<targetbooklists.length;i++){
      gettargetbook(targetbooklists[i].trim());
    }
    print("${userid}");
    getbookinfo(userid.toString());
  }


  //TODO 获取后端图书数据(查询图书）
  Future<void> gettargetbook(String book_id) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.Request('GET', Uri.parse('$url/book_query?book_id=$book_id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent=await response.stream.transform(utf8.decoder).join();
      setState(() {
        book=json.decode(responseContent)["content"];
        books.add(book);
      });
      // debugPrint("book:"+book.toString());
      // debugPrint("hihi:"+books.toString());
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  List<Widget> _getbookreviewData() {
    var temp = books.map((value) {
      // debugPrint(value.toString().trim());
      // debugPrint("nowbook:"+book.toString());
      return Card(
          margin: EdgeInsets.all(rpx(10.0)),
          child: Container(
              height: rpx(280.0),
              decoration: BoxDecoration(
                border: new Border.all(color: Colors.black26, width: rpx(0.8)),
              ),
              child: Padding(padding: EdgeInsets.all(rpx(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child:
                    Image.asset("images/${value[0]["book_picture"]}", width: rpx(280), height: rpx(240),),
                    ),
                    Expanded(child: Column(
                      children: [
                        SizedBox(height:rpx(10.0),),
                        Text("《"+value[0]["book_name"]+"》", style: TextStyle(fontSize: rpx(20.0)),),
                        SizedBox(height:rpx(5.0),),
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
                              int k2=0;

                              for(int j=0;j<booksum.length;j++)
                                {
                                      if(booksum[j].book_id.toString()==value[0]["book_id"].toString())
                                        {
                                                 k=j;
                                                 break;
                                        }
                                }
                              for(int j=0;j<reads.length;j++)
                              {
                                if(reads[j].book_id.toString()==value[0]["book_id"].toString())
                                {
                                  k2=j;
                                  break;
                                }
                              }
                              List<bookdan> includebang = [];
                              for (int i = 0; i < bookdans.length; i++) {
                                for (int j = 0; j < bookdans[i].book_id.length; j++) {
                                  if (value[0]["book_id"].toString() == bookdans[i].book_id[j].toString()) {
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
      appBar: AppBar(title: Text("书单",style: TextStyle(color: Colors.white),), centerTitle: true,),
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