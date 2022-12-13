import 'dart:convert';
import 'package:film_review/PersonalCenter/PersonInfo.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'menu_item.dart';
import 'package:film_review/Login/User.dart';
import 'package:film_review/PersonalCenter/PersonInfoModify.dart';

class PersonInfo extends StatefulWidget {
  User userData;
  String session_id;
  PersonInfo(this.userData,this.session_id);
  @override
  PersonInfoState createState() {
    return PersonInfoState(userData: this.userData,session_id:this.session_id);
  }
}

class PersonInfoState extends State<PersonInfo>{
  PersonInfoState({Key key,this.userData,this.session_id}) : super();
  final User userData;
  final String session_id;
  User userDataNew;
  String user_name="";
  String user_description="";
  @override
  void initState() {
    super.initState();
    setState((){
      user_name=userData.user_name;
      user_description=userData.user_description;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  GetUserInfo() async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('http://7b8e1f42.r3.vip.cpolar.cn/user_query?user_id=${userData.user_id}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseContent = await response.stream.transform(utf8.decoder).join();
      setState((){
        userDataNew = User.fromJson(json.decode(responseContent)["content"][0]);
        user_name=userDataNew.user_name;
        user_description=userDataNew.user_description;
      });
      debugPrint(userDataNew.user_description);
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("个人中心"), centerTitle: true,),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: rpx(5.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //头像
                      Padding(
                        padding: EdgeInsets.only(
                            left: rpx(20.0),
                            right: rpx(20.0)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("头像", style: TextStyle(fontSize:rpx(20.0)),),
                            Image.asset("images/person.jpg",width: rpx(50),height: rpx(50),),
                          ],
                        ),
                      ),
                      //第一条线
                      Padding(
                        padding: EdgeInsets.only(left: rpx(20.0), right: rpx(20.0)),
                        child: Divider(
                          color: Colors.black12,
                        ),
                      ),
                      //昵称
                      Padding(
                        padding: EdgeInsets.only(
                          top: rpx(5.0),
                            bottom: rpx(5.0),
                            left: rpx(20.0),
                            right: rpx(20.0)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("昵称", style: TextStyle(fontSize: rpx(20.0)),),
                            Text(user_name.toString(), style: TextStyle(fontSize: rpx(20.0)),),
                          ],
                        ),
                      ),
                      //第二条线
                      Padding(
                        padding: EdgeInsets.only(left: rpx(20.0), right: rpx(20.0)),
                        child: Divider(
                          color: Colors.black12,
                        ),
                      ),
                      //个人介绍
                      Padding(
                        padding: EdgeInsets.only(
                          top:rpx(5.0),
                            bottom: rpx(5.0),
                            left: rpx(20.0),
                            right: rpx(20.0)
                        ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("个人介绍:\n", style: TextStyle(fontSize: rpx(20.0)),),
                            Text(user_description.toString(), style: TextStyle(fontSize: rpx(20.0),color: Colors.black38),),
                          ],
                        ),
                      ),
                      //第三条线
                      Padding(
                        padding: EdgeInsets.only(left: rpx(20.0), right: rpx(20.0)),
                        child: Divider(
                          color: Colors.black12,
                        ),
                      ),
                      Center(
                        child: MaterialButton(
                          onPressed: (){
                            Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                              return PersonInfoModify(session_id);
                            })).then((value) =>GetUserInfo());
                          },
                          color: Colors.lightBlue,
                          textColor: Colors.white,
                          child: Text("修改"),
                        ),
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