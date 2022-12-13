import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/shouye.dart';
import 'package:film_review/widgets/booktotal/addshudan.dart';
import 'package:film_review/widgets/booktotal/bookgard.dart';
import 'package:film_review/widgets/booktotal/editshudan.dart';
import 'package:film_review/widgets/booktotal/shudanbook.dart';
import 'package:http/http.dart' as http;

int fshoucang = 0;
String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(bookdan b1, String session_id) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/booklist_delete'));
  request.fields.addAll({
    'booklist_id': b1.booklist_id.toString(),
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("删除书单成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void postRequestFunction2(bookdan b1, String ans) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/booklist_modify'));
  request.fields.addAll({
    'booklist_id': b1.booklist_id.toString(),
    'collector_id': ans.toString(),
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("添加收藏成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class bookxiangqing extends StatelessWidget {
  bookdan bangdan1;
  String session_id;
  String userid;
  List<book> books;
  bookxiangqing(
      {Key key, this.bangdan1, this.books, this.session_id, this.userid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Title(context),
              SizedBox(
                height: 90,
              ),
              shudanbookview(bangdan1, books),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => addshudan(
                    session_id: session_id,
                  )));
        },
        tooltip: '添加书籍',
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Widget Title(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
      decoration: BoxDecoration(
          border:
              new Border.all(width: 1, color: Color.fromARGB(255, 79, 78, 78)),
          color: Color.fromARGB(255, 212, 224, 171)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 2.具体内容
          getContentWidget(context),
          Container(
            padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
            child: Text(
              "${bangdan1.description}",
              maxLines: 3,
            ),
          ),
          Row(
            children: [
              Spacer(),
              if (bangdan1.user_id == userid.toString())
                Icon(
                  Icons.edit,
                  size: 15,
                ),
              if (bangdan1.user_id == userid.toString())
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              editshudan(bangdan1, books, session_id)));
                    },
                    child: Text("编辑")),
              if (bangdan1.user_id != userid.toString())
                IconButton(
                    onPressed: () {
                      List<String> ans = [];
                      if (bangdan1.collector_id.length != 0 && fshoucang == 0) {
                        for (int i = 0; i < bangdan1.collector_id.length; i++) {
                          if (bangdan1.collector_id[i].toString() == userid.toString()) {
                            fshoucang = 1;
                          }
                          ans.add(bangdan1.collector_id[i].toString());
                        }
                        if (fshoucang == 0) ans.add(userid);
                      } else {
                        ans.add(userid);
                      }
                      postRequestFunction2(bangdan1, ans.toString());
                    },
                    icon: fshoucang == 0
                        ? Icon(Icons.favorite_border)
                        : Icon(Icons.favorite))
            ],
          )
        ],
      ),
    );
  }

  Widget getContentWidget(BuildContext context) {
    return Row(
      children: [
        Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          label: Text(
            "${bangdan1.booklist_name}",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          backgroundColor: Color.fromARGB(255, 5, 134, 12),
        ),
        Spacer(),
        if (bangdan1.user_id == userid.toString())
          IconButton(
              onPressed: () {
                postRequestFunction(bangdan1, session_id);
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete))
      ],
    );
  }
}
