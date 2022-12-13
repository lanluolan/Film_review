import 'package:flutter/material.dart';
import 'package:film_review/model/editgirdview.dart';
import 'package:film_review/model/editgirdview2.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:http/http.dart' as http;

TextEditingController emailController =
    new TextEditingController(); //声明controller
TextEditingController emailController2 = new TextEditingController();
String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(moviedan m1) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/movielist_modify'));
  request.fields.addAll({
    'movielist_id': m1.movielist_id.toString(),
    'movielist_name': emailController.text,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("题目修改成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class edityingdan extends StatelessWidget {
  moviedan m1;
  List<movie> movies;
  String session_id;
  edityingdan(this.m1, this.movies, this.session_id);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("编辑影单"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              tooltip: '保存',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: new SingleChildScrollView(
            child: Container(
                child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                controller: emailController,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "${m1.movielist_name}",
                  fillColor: Color(0xFFF2F2F2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1),
                  ),
                  suffix: IconTextButton(),
                ),

                // 绑定控制器
                // controller: _username,
                // 输入改变以后的事件
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              Container(
                  height: 400,
                  padding:
                      EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border: new Border.all(
                        width: 1, color: Color.fromARGB(255, 79, 78, 78)),
                  ),
                  child: Column(
                    children: [
                      girdview2(m1, movies, session_id),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailController2,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "#历史#文学",
                  fillColor: Color(0xFFF2F2F2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1),
                  ),
                  suffix: IconTextButton2(),
                ),

                // 绑定控制器
                // controller: _username,
                // 输入改变以后的事件
                onChanged: (value) {},
              ),
            ],
          ),
        )
                // 多行文本输入框

                )));
  }

  Widget IconTextButton() {
    return Container(
      width: 80,
      child: Row(
        children: [
          Spacer(),
          Icon(
            Icons.edit,
            size: 15,
          ),
          TextButton(
              onPressed: () {
                postRequestFunction(m1);
              },
              child: Text("编辑"))
        ],
      ),
    );
  }

  Widget IconTextButton2() {
    return Container(
      width: 80,
      child: Row(
        children: [
          Spacer(),
          Icon(
            Icons.add,
            size: 15,
          ),
          TextButton(onPressed: () {}, child: Text("标签"))
        ],
      ),
    );
  }
}
