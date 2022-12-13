import 'package:flutter/material.dart';
import 'package:film_review/model/commet.dart';
import 'package:film_review/model/dianzan.dart';
import 'package:film_review/model/shuping.dart';
import 'package:film_review/widgets/booktotal/bookpingxiangxi.dart';
import 'package:http/http.dart' as http;

String url = "http://6a857704.r2.vip.cpolar.cn";

void postRequestFunction(String bookid, String session_id) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request = http.MultipartRequest('POST', Uri.parse(url + '/likes_add'));
  request.fields.addAll({
    'type': "6",
    'dest_id': bookid.toString(),
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("${bookid.toString()}");
    print("点赞成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void postRequestFunction2(String bookid, String session_id) async {
  print("${session_id}");
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/book_reaction_delete'));
  request.fields.addAll({
    'book_reaction_id': bookid,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("${bookid}");
    print("删除书评成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

int bookid = 0;

bool judge(List<dianzan> ans, dianzan a) {
  for (int i = 0; i < ans.length; i++) {
    // print("${ans[i]} ${a}");

    if (ans[i].likes_id.toString() == a.likes_id.toString()) {
      return false;
    }
  }
  return true;
}

bool judge2(List<comment> ans, comment a) {
  for (int i = 0; i < ans.length; i++) {
    // print("${ans[i]} ${a}");
    if (ans[i].comment_id.toString() == a.comment_id.toString()) {
      return false;
    }
  }
  return true;
}

class booknoticeItem extends StatelessWidget {
  int flag;
  shuping s1;
  List<dianzan> dianzans;
  List<comment> comments;
  String session_id;
  booknoticeItem(
      this.flag, this.s1, this.dianzans, this.comments, this.session_id);
  List<dianzan> mydianzans = [];
  List<comment> mycomments = [];
  List<dianzan> mydianzans2 = [];
  List<comment> mycomments2 = [];
  @override
  Widget build(BuildContext context) {
    print("diananlen:${mydianzans.length}");
    print("commentslen:${mycomments.length}");
    if (flag == 1) {
      for (int i = 0; i < dianzans.length; i++) {
        if (dianzans[i].dest_id.toString() == s1.book_reaction_id.toString()) {
          if (judge(mydianzans, dianzans[i])) {
            mydianzans.add(dianzans[i]);

            print("dianzan:${dianzans[i].likes_id}");
          }
        }
      }
      for (int i = 0; i < comments.length; i++) {
        if (comments[i].dest_id.toString() == s1.book_reaction_id.toString()) {
          if (judge2(mycomments, comments[i])) {
            mycomments.add(comments[i]);

            print("评论：${comments[i].comment_id}");
          }
        }
      }
    } else {
      for (int i = 0; i < dianzans.length; i++) {
        if (dianzans[i].dest_id.toString() == s1.book_reaction_id.toString()) {
          if (judge(mydianzans2, dianzans[i])) {
            mydianzans2.add(dianzans[i]);

            print("dianzan:${dianzans[i].likes_id}");
          }
        }
      }
      for (int i = 0; i < comments.length; i++) {
        if (comments[i].dest_id.toString() == s1.book_reaction_id.toString()) {
          if (judge2(mycomments2, comments[i])) {
            mycomments2.add(comments[i]);

            print("评论：${comments[i].comment_id}");
          }
        }
      }
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: new Border.all(
              width: 1, color: Color.fromARGB(255, 181, 181, 181))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(
                    "${s1.title}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  if (flag == 1)
                    _popupMenuButton2(
                        context, s1, mydianzans, mycomments, session_id)
                ],
              ),
              Text(
                "${s1.content}",
                style: TextStyle(
                    color: Color.fromARGB(255, 193, 193, 193),
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  "images/beijin.jpg",
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Text("${s1.user_id}"),
              Spacer(),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.mode_comment_sharp)),
              Text(
                  flag == 1 ? "${mycomments.length}" : "${mycomments2.length}"),
              IconButton(
                  onPressed: () {
                    postRequestFunction(s1.book_id, session_id);
                  },
                  icon: Icon(Icons.thumb_up)),
              Text(
                  flag == 1 ? "${mydianzans.length}" : "${mydianzans2.length}"),
            ],
          )
        ],
      ),
    );
  }
}

PopupMenuButton _popupMenuButton2(BuildContext context, shuping s1,
    List<dianzan> dianzans, List<comment> comments, String session_id) {
  return PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Text("编辑书评"),
            ],
          ),
          value: "编辑书评",
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Text("删除书评"),
            ],
          ),
          value: "删除书评",
        ),
      ];
    },
    onSelected: (value) {
      if (value == "编辑书评") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                bookpingxiangxi(s1, dianzans, comments, session_id)));
      } else if (value == "删除书评") {
        postRequestFunction2(s1.book_reaction_id, session_id);
        Navigator.pop(context);
      }
    },
    onCanceled: () {
      print("canceled");
    },
    color: Color.fromARGB(255, 247, 247, 247),
    icon: Icon(Icons.keyboard_arrow_down),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        width: 2,
        color: Color.fromARGB(255, 249, 249, 249),
        style: BorderStyle.solid,
      ),
    ),
  );
}
