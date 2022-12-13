import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersonInfoModify extends StatelessWidget{
  final TextEditingController textEditingController1 = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();
  String session_id;
  PersonInfoModify(this.session_id);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("修改个人信息"), centerTitle: true,),
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
                      //修改昵称
                      Padding(
                        padding: EdgeInsets.only(
                            top: rpx(5.0),
                            bottom: rpx(5.0),
                            left:rpx(20.0),
                            right: rpx(20.0)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("昵称", style: TextStyle(fontSize: rpx(20.0)),),
                            Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                            Expanded(child: TextField(
                              controller: textEditingController1,
                              decoration: InputDecoration(
                                hintText: "请输入新昵称",
                              ),
                            ),
                            )
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
                            top: rpx(5.0),
                            bottom: rpx(5.0),
                            left: rpx(20.0),
                            right: rpx(20.0)
                        ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("个人介绍:", style: TextStyle(fontSize: rpx(20.0)),),
                            TextField(
                              controller: textEditingController2,
                              minLines: 1,
                              maxLines: 10,
                              decoration: InputDecoration(
                                hintText: "请输入新的个人介绍"
                              ),
                            ),
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
                          onPressed: () async {
                            if(textEditingController1.value.text!="" && textEditingController2.value.text!="") {
                              var headers = {
                                'Authorization': session_id,
                                'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
                              };
                              var request = http.MultipartRequest('POST',
                                  Uri.parse(
                                      'http://7b8e1f42.r3.vip.cpolar.cn/user_modify'));
                              request.fields.addAll({
                                'user_name': textEditingController1.value.text,
                                'user_description': textEditingController2.value
                                    .text,
                              });
                              request.headers.addAll(headers);
                              http.StreamedResponse response = await request
                                  .send();
                              if (response.statusCode == 200) {
                                print(await response.stream.bytesToString());
                              }
                              else {
                                print(response.reasonPhrase);
                              }
                            }
                            Navigator.of(context).pop();
                          },
                          color: Colors.lightBlue,
                          textColor: Colors.white,
                          child: Text("确定"),
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