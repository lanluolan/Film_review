import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'dart:async';

import 'package:film_review/widgets/booktotal/readdata.dart';
import 'package:film_review/widgets/booktotal/stopread.dart';
import 'package:http/http.dart' as http;

class reading extends StatefulWidget {
  book b1;
  yuduzhuangtai r1;
  String session_id;
  reading({Key key, this.b1, this.r1, this.session_id}) : super(key: key);
  @override
  readingstate createState() => new readingstate(b1, r1, session_id);
}

bool isPlaying = false;
int secondspassed = 0;
int seconds = 0;
int minutes = 0;
int hours = 0;
String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(book b1, String time, String session_id) async {
  print("${session_id}");
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(url + '/reading_status_modify'));
  request.fields.addAll(
      {'book_id': b1.book_id.toString(), 'reading_times': time.toString()});
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("${b1.book_id.toString()}");
    print("${response}");
    print("增加时间成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
    print("连接失败");
  }
}

class readingstate extends State<reading> {
  book b1;
  yuduzhuangtai r1;
  String session_id;
  readingstate(this.b1, this.r1, this.session_id);
  static const duration = const Duration(seconds: 1);
  Timer timer;

  void addtick() {
    if (isPlaying) {
      setState(() {
        secondspassed = secondspassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (timer) {
        addtick();
      });
    }
    hours = secondspassed ~/ (60 * 60);
    minutes = (secondspassed % 3600) ~/ 60;
    seconds = secondspassed % 60;
    DateTime dateTime = DateTime.now();
    print("${dateTime.toString().substring(0, 10)}");

    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new ExactAssetImage('images/beijin.jpg'),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("正在读", style: TextStyle(color: Colors.black, fontSize: 18)),
              SizedBox(
                height: 30,
              ),
              Container(
                  child: Center(
                    child: Column(children: [
                      Image(
                        image: AssetImage('images/${b1.book_picture}'),
                        height: 180,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("${b1.book_name}",
                          style: TextStyle(color: Colors.black, fontSize: 25)),
                      Text("(${b1.writer})",
                          style: TextStyle(color: Colors.black, fontSize: 10))
                    ]),
                  )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  constraints:
                  new BoxConstraints.expand(width: 350, height: 80),
                  decoration: new BoxDecoration(
                    border: new Border.all(width: 1.0, color: Colors.black),
                    // borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 45.0,
                        semanticLabel: 'label',
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                          "${minutes.toString().padLeft(2, '0')}   :    ${seconds.toString().padLeft(2, '0')}",
                          style: TextStyle(color: Colors.black, fontSize: 45)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                // 末端按钮对齐的容器

                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        secondspassed = 0;
                      },
                      icon: Icon(Icons.loop),
                      iconSize: 35,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    IconButton(
                      icon: (isPlaying)
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow),
                      onPressed: () {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      },
                      iconSize: 35,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    IconButton(
                      onPressed: () {
                        List<String> ans = [];
                        print("${r1.reading_times.length}");
                        for (int i = 0; i < r1.reading_times.length; i++) {
                          print("hello:" +
                              r1.reading_times[i].toString().substring(0, 10));
                          //  if (r1.reading_times[i].toString().substring(0, 10) !=
                          //    dateTime.toString().substring(0, 10)) {

                          ans.add("\"${r1.reading_times[i].toString()}\"");
                          //}
                        }

                        ans.add(
                            "\"${dateTime.toString().substring(0, 10)} ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}\"");

                        print("reading:${session_id}");
                        postRequestFunction(
                            b1, ans.toString(), session_id.toString());
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                stopread(b1, r1, secondspassed, session_id)));
                      },
                      icon: Icon(Icons.stop),
                      iconSize: 35,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
