import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/widgets/booktotal/addDigest.dart';
import 'package:film_review/widgets/booktotal/addreadsense.dart';
import 'package:film_review/widgets/booktotal/bookpingjia.dart';
import 'package:film_review/widgets/booktotal/includebooklist.dart';
import 'package:film_review/widgets/booktotal/readplan.dart';
import 'package:percent_indicator/percent_indicator.dart';

class booknote2 extends StatelessWidget {
  book b1;
  booknote2({Key key, this.b1}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(),
        body: new SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: new Border.all(
                    color: Colors.grey, //边框颜色
                    width: 1, //边框宽度
                  ), // 边色与边宽度
                  color: Colors.white, // 底色
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2, //阴影范围
                      spreadRadius: 1, //阴影浓度
                      color: Colors.grey, //阴影颜色
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20), // 圆角也可控件一边圆角大小
                  //borderRadius: BorderRadius.only(
                  //  topRight: Radius.circular(10),
                  // bottomRight: Radius.circular(10)) //单独加某一边圆角
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: getContentImage(),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                getTitleWidget(),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                              width: 10,
                            ),
                            Text("${b1.writer}"),
                            SizedBox(
                              height: 15,
                            ),
                            getstartWidget(),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _popupMenuButton(context, b1),
                                SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => bookpingjia()));
                                  },
                                  icon: Icon(Icons.chrome_reader_mode),
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => includebook()));
                                  },
                                  icon: Icon(Icons.my_library_books_outlined),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Divider(
                height: 1.0,
                indent: 0.0,
                color: Color.fromARGB(255, 120, 116, 116),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      side: BorderSide(width: 1, color: Colors.grey),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.storage),
                    label: Text("加入书架", style: TextStyle(fontSize: 25))),
              )
            ],
          ),
        )));
  }

  Widget getTitleWidget() {
    return Stack(
      children: <Widget>[
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: "${b1.book_name}",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ]),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget getContentImage() {
    return Image(
      image: AssetImage('images/${b1.book_picture}'),
      height: 180,
    );
  }

  Widget getstartWidget() {
    //String ans = read1.create_time;
    return Text(
      "这本书不在您的书单中",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}

PopupMenuButton _popupMenuButton(BuildContext context, book b1) {
  return PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(Icons.bookmark),
              Text("书摘"),
            ],
          ),
          value: "书摘",
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(Icons.sd_card),
              Text("书评"),
            ],
          ),
          value: "书评",
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(Icons.date_range),
              Text("读书计划"),
            ],
          ),
          value: {"读书计划"},
        ),
      ];
    },
    onSelected: (value) {
      if (value == "书摘") {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => digest()));
      } else if (value == "书评") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => readsense(
                  b1: b1,
                )));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => readplan()));
      }
    },
    onCanceled: () {
      print("canceled");
    },
    color: Color.fromARGB(255, 142, 142, 142),
    icon: Icon(
      Icons.playlist_add,
      color: Color.fromARGB(255, 8, 143, 143),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        width: 2,
        color: Color.fromARGB(255, 180, 176, 176),
        style: BorderStyle.solid,
      ),
    ),
  );
}
