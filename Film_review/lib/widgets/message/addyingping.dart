import 'package:flutter/material.dart';
import 'package:film_review/model/movie.dart';
import 'package:http/http.dart' as http;

TextEditingController emailController =
new TextEditingController(); //声明controller
TextEditingController emailController2 =
new TextEditingController(); //声明controller

String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(String movieid, String session_id) async {
  print("${session_id}");
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(url + '/movie_reaction_add'));
  request.fields.addAll({
    'movie_id': movieid.toString(),
    'title': emailController.text,
    'content': emailController2.text,
  });
  print(
      "${movieid.toString()} ${emailController.text} ${emailController2.text}");
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("add影评成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class yingping extends StatelessWidget {
  movie m1;
  String session_id;
  yingping({Key key, this.m1, this.session_id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("影评"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              tooltip: '保存',
              onPressed: () {
                postRequestFunction(m1.movie_id, session_id);
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: new SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "请填写标题(二十个子以内)",
                        border: OutlineInputBorder(),
                      ),
                      // 绑定控制器
                      // controller: _username,
                      // 输入改变以后的事件

                      onChanged: (value) {},
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 130, 132, 134))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: emailController2,
                            autofocus: true,
                            autocorrect: false,
                            keyboardType: TextInputType.multiline,
                            minLines: 20,
                            maxLines: 20,
                            decoration: InputDecoration(
                              hintText: "请填写文字或图片",
                              filled: true,
                              fillColor: Color(0xFFF2F2F2),
                            ),
                          ),
                          Container(
                              width: 180,
                              alignment: Alignment(-1, -1),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(255, 151, 157, 164)),
                                color: Color.fromARGB(255, 198, 198, 198),
                                shape: BoxShape.rectangle,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    iconSize: 150,
                                    icon: const Icon(
                                      Icons.add,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )
                    // 多行文本输入框
                  ],
                ),
              ),
            )));
  }
}

