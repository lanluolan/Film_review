import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String url = "http://6a857704.r2.vip.cpolar.cn";

void postRequestFunction(String ans, String session_id) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/watching_status_modify'));
  request.fields.addAll({
    'movie_id': "100",
    'watching_status': ans,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  print("发送成功");
  if (response.statusCode == 200) {
    print("修改成功");

    // print(await response.stream.bytesToString());
  } else {
    print("修改失败");
    print(response.reasonPhrase);
  }
}

class jijiangshangying extends StatelessWidget {
  String session_id;
  jijiangshangying(this.session_id);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 12),
          // 2.具体内容
          getMovieContentWidget(),
          SizedBox(height: 12),
          // 3.电影简介
          getMovieIntroduceWidget(),
          SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }

  // 具体内容
  Widget getMovieContentWidget() {
    return Container(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getContentImage(),
          getContentDesc(),
        ],
      ),
    );
  }

  Widget getContentImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset("images/saohei.webp"),
    );
  }

  Widget getContentDesc() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTitleWidget(),
            SizedBox(
              height: 3,
            ),
            getInfoWidget(),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment(-0.5, 0),
              child: getbutton(),
            )
          ],
        ),
      ),
    );
  }

  Widget getbutton() {
    return Container(
      height: 45,
      width: 90,
      child: OutlinedButton(
        onPressed: () {
          postRequestFunction("计划看", session_id);
        },
        child: Text(
          "想看",
          style: TextStyle(color: Color.fromARGB(255, 245, 244, 247)),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 38, 8, 107))),
      ),
    );
  }

  Widget getTitleWidget() {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.play_circle_outline,
          color: Colors.redAccent,
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: "     " + "扫黑行动",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextSpan(
              text: "(${2022})",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            )
          ]),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget getInfoWidget() {
    return Text(
      "2022 / 中国大陆/动作犯罪/林德禄/秦海璐、周一围",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 16),
    );
  }

  // 电影简介（原生名称）
  Widget getMovieIntroduceWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(0xfff2f2f2), borderRadius: BorderRadius.circular(5)),
      child: Text(
        "女大学生离奇坠楼，刚调任到岗的刑侦支队副队长成锐（周一围 饰）被副局长杜于林（王劲松 饰）指派追查背后隐情，发现案件与套路贷、暴力催讨等黑势力犯罪有关，本市企业家安亦明（曾志伟 饰）被列为重点侦查对象，成锐想进一步调查却被要求尽快结案，究竟是谁在充当“保护伞”？城市危机四伏，安亦明之妻周彤（秦海璐 饰）、经济学教授赵羡鱼（张智霖 饰）纷纷身陷其中，为了还人民安宁，成锐和同事们突破难关追踪到底，却不想背后还有更大阴谋。真相究竟为何？他们能否将隐藏在黑暗中的罪恶一扫而尽？",
        style: TextStyle(fontSize: 18, color: Colors.black54),
      ),
    );
  }
}
