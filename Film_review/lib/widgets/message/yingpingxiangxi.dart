import 'package:flutter/material.dart';
import 'package:film_review/model/commet.dart';
import 'package:film_review/model/dianzan.dart';
import 'package:film_review/model/shuping.dart';
import 'package:film_review/model/yingpingmodel.dart';
import 'package:film_review/widgets/message/addyingping.dart';
import 'package:http/http.dart' as http;

String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(String movieid, String session_id) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request = http.MultipartRequest('POST', Uri.parse(url + '/likes_add'));
  request.fields.addAll({
    'type': "5",
    'dest_id': movieid.toString(),
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("${movieid.toString()}");
    print("点赞成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class yingpingxiangxi extends StatelessWidget {
  yingpingmodel s1;
  List<dianzan> dianzans = [];
  List<comment> comments = [];
  String session_id;
  yingpingxiangxi(this.s1, this.dianzans, this.comments, this.session_id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Material(
            child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "images/beijin.jpg",
                      ),
                    ),
                    getInfo(),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${s1.title}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${s1.content}",
                          style: TextStyle(
                            color: Color.fromARGB(255, 28, 28, 28),
                            fontSize: 15,
                          ),
                        ),
                      ]),
                ),
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.mode_comment_sharp)),
                    Text("${comments.length}"),
                    IconButton(
                        onPressed: () {
                          postRequestFunction(s1.movie_id, session_id);
                        },
                        icon: Icon(Icons.thumb_up)),
                    Text("${dianzans.length}"),
                  ],
                ),
                Divider(
                  height: 1.0,
                  indent: 0.0,
                  color: Color.fromARGB(255, 120, 116, 116),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[_buildSuggestions(comments)],
                  ),
                )
              ],
            ),
          ),
        )));
  }

  Widget getInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${s1.user_id}",
          style: TextStyle(
              color: Color.fromARGB(255, 90, 243, 195),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              "${s1.create_time}",
              style: TextStyle(
                  color: Color.fromARGB(255, 193, 193, 193),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "  来自电影${s1.movie_id}的影评",
              style: TextStyle(
                  color: Color.fromARGB(255, 29, 29, 29),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}

Widget _buildSuggestions(List<comment> comments) {
  return new Expanded(
    child: new ListView.builder(
      padding: const EdgeInsets.all(16.0), // 设置padding
      itemBuilder: (context, index) {
        return pinglunItem(comments, index);
      },
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: comments.length,
    ),
  );
}

Widget pinglunItem(List<comment> comments, int index) {
  return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: new Border.all(
              width: 1, color: Color.fromARGB(255, 181, 181, 181))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  "images/beijin.jpg",
                ),
              ),
              SizedBox(
                width: 10,
              ),
              getpinglun(comments, index),
            ],
          ),
          Text("${comments[index].create_time}",
              maxLines: 5,
              style: TextStyle(
                  color: Color.fromARGB(255, 7, 7, 7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ],
      ));
}

Widget getpinglun(List<comment> comments, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "${comments[index].user_id}",
        style: TextStyle(
            color: Color.fromARGB(255, 121, 29, 240),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Text(
            "${comments[index].content}",
            style: TextStyle(
                color: Color.fromARGB(255, 193, 193, 193),
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
  );
}
