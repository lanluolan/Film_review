import 'dart:convert';
import 'package:film_review/Login/Forget_password.dart';
import 'package:film_review/PersonalCenter/mycollect_details/MyCollect_booklist_book.dart';
import 'package:film_review/Square/book_review/text_syles.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyCollect_booklist extends StatefulWidget{
  String email;
  List collectbooklist;
  String user_name;
  String session_id;
  MyCollect_booklist(this.email,this.collectbooklist,this.user_name,this.session_id);
  @override
  MyCollect_booklistState createState() {
    return MyCollect_booklistState(email:email,collectbooklist:collectbooklist,user_name:user_name);
  }
}

class MyCollect_booklistState extends State<MyCollect_booklist> with SingleTickerProviderStateMixin{
  MyCollect_booklistState({Key key,this.email,this.collectbooklist,this.user_name,this.session_id}) : super();
  final String email;
  String session_id;
  final List collectbooklist;//所有书单
  final String user_name;
  List targetbooklist=[{}];
  int lisk_count=0; //书单收藏数量
  List collector_id=[];//每一个书单对应的收藏id
  int count=0;//收藏id的计数器
  int flag=0;//标记是否所有书单都没有当前用户
  int num=0;//标记用户是否有收藏书单

  @override
  void initState() {
    super.initState();
  }

  //TODO 访问网络：搜索所有书单（查询书单）
  // Future<void> getusercollectbooklistid() async {
  //   var headers = {
  //     'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
  //   };
  //   var request = http.Request('GET', Uri.parse('https://7b8e1f42.r3.vip.cpolar.cn/booklist_query?'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     // print(await response.stream.bytesToString());
  //     String responseContent = await response.stream.transform(utf8.decoder).join();
  //     setState(() {
  //       collectbooklists = json.decode(responseContent)["content"];
  //     });
  //     debugPrint(collectbooklists.toString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  List<Widget> _getData() {
    var temp = collectbooklist.map((value) {
      // debugPrint(value.toString());
      setState(() {
        count++;
        targetbooklist=value["book_id"];
        collector_id=value["collector_id"];
        if(collectbooklist[collectbooklist.length-1].toString()==value.toString()){
          flag=1;
        }
      });
      // debugPrint(collector_id.toString());
      // debugPrint(targetbooklist.toString());
      if(collector_id.indexOf(email)!=-1){
        setState(() {
          num=1;
          count--;
        });
        return Card(
          elevation: 10.0,
          margin: EdgeInsets.all(rpx(10.0)),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(rpx(8.0)),
            child: MaterialButton(
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              flex: 8,
                              child: getUserWidget(),
                            ),
                            Expanded(
                              flex: 2,
                              child: getCommentWidget(value["collector_id"].toList().length),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: rpx(10.0),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(value["description"], style: TextStyle(fontSize: rpx(25.0)),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "images/${value["booklist_picture"]}", height: rpx(220.0), width: rpx(120),),
                      Column(
                        children: [
                          SizedBox(height: rpx(145.0),),
                          MaterialButton(
                            onPressed: () {
                              debugPrint(targetbooklist.toString());
                              Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                                return MyCollect_booklist_book(targetbooklist.toString(),email,session_id);
                              }));
                            },
                            child: Text("更多"),

                            color: Colors.lightBlue,
                            textColor: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),);
      }
      if(num==0 && count==collectbooklist.length && flag==1){
        return Center(child: Text("无收藏的书单",style: TextStyle(fontSize: rpx(18.0),color: Colors.black45),),);
      }
      return Text("");
    });
    return temp.toList();
  }

  /// 帖子栏中的用户头像和昵称信息
  Widget getUserWidget() {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(rpx(30)),
          child:  CircleAvatar(
            backgroundImage: AssetImage(
              "images/beijin.jpg",
            ),
            minRadius: 15,
          ),
        ),
        Padding(padding: EdgeInsets.only(left: rpx(10))),
        Text(
          user_name,
          style: TextStyles.commonStyle(),
        ),
      ],
    );
  }

  /// 帖子栏中的点赞信息
  Widget getCommentWidget(int likenum) {
    return Row(
      children: <Widget>[
        Icon(Icons.favorite, color: Colors.grey, size: 18),
        Padding(padding: EdgeInsets.only(left: 10)),
        Text(
          likenum.toString(),
          style: TextStyles.commonStyle(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: _getData(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
