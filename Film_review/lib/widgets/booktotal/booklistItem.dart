import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/jingli.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/widgets/booktotal/addDigest.dart';
import 'package:film_review/widgets/booktotal/addreadsense.dart';
import 'package:film_review/widgets/booktotal/booknote.dart';
import 'package:film_review/widgets/booktotal/reading.dart';
import 'package:film_review/widgets/booktotal/readplan.dart';
import 'package:percent_indicator/percent_indicator.dart';

class bookListItem extends StatelessWidget {
  final List<book> book1;
  final yuduzhuangtai read1;
  List<bookdan> bangdans = [];
  List<jingli> jinglis;
  //final yuduzhuangtai read;
  BuildContext context2;
  String session_id;
  String userid;
  bookListItem(this.read1, this.book1, this.context2, this.bangdans,
      this.jinglis, this.session_id,this.userid);
  int bookid = 0;

  List<bookdan> includebang = [];
  @override
  Widget build(BuildContext context) {
    book ans;
    bookid = int.parse(read1.book_id);
    for (int i = 0; i < book1.length; i++) {
      if (book1[i].book_id.toString() == bookid.toString()) {
        ans = book1[i];

        break;
      }
    }
    for (int i = 0; i < bangdans.length; i++) {
      for (int j = 0; j < bangdans[i].book_id.length; j++) {
        if (bookid == bangdans[i].book_id[j]) {
          includebang.add(bangdans[i]);
          break;
        }
      }
    }
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
              new Border.all(width: 1, color: Color.fromARGB(255, 79, 78, 78))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 2.具体内容
          getMovieContentWidget(ans),
          SizedBox(height: 12),

          getshijian(),
          SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }

  Widget getshijian() {
    int sum = 0;
    for (int i = 0; i < read1.reading_times.length; i++) {
      sum += int.parse(read1.reading_times[i].toString().substring(18, 19));
      sum +=
          60 * int.parse(read1.reading_times[i].toString().substring(15, 16));
      sum +=
          3600 * int.parse(read1.reading_times[i].toString().substring(12, 13));
    }
    int hour = (sum ~/ 3600);
    int minute = (sum - 3600 * hour) ~/ 60;

    return Center(
      child: Text(
        "阅读时间：${hour}时${minute}分" +
            "      " +
            "阅读天数：${read1.reading_times.length}天",
        style: TextStyle(
          color: Color.fromARGB(255, 143, 142, 141),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  // 具体内容
  Widget getMovieContentWidget(book ans) {
    return Container(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: getContentImage(ans),
          ),
          getContentDesc(ans),
        ],
      ),
    );
  }

  Widget getContentImage(book ans) {
    return InkWell(
        onTap: () {
          Navigator.of(context2).push(MaterialPageRoute(
              builder: (_) => booknote(
                    b1: ans,
                    read1: read1,
                    includebang: includebang,
                    jinglis: jinglis,
                    session_id: session_id,
                    userid: userid,

                  )));
        },
        child: ClipRRect(
            //borderRadius: BorderRadius.circular(5),

            child: Image.asset("images/${ans.book_picture}")

            // child: Image.network(
            // "http://7182fde7.r3.cpolar.top/book_query/${book1[bookid].book_picture}"),
            ));
  }

  Widget getContentDesc(book ans) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                getTitleWidget(ans),

              //  IconButton(
             //       onPressed: () {}, icon: Icon(Icons.keyboard_arrow_down)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            getstartWidget(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                getInfoWidget(ans),
                SizedBox(width: 10),
                jingdu()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getTitleWidget(book ans) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
                Text("${ans.book_name}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text("(${ans.writer})",style: TextStyle(fontSize: 15, color: Colors.black54)),
          ],
        )
        // Text.rich(
        //   TextSpan(children: [
        //     TextSpan(
        //         text: ans.book_name,
        //
        //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        //     TextSpan(
        //       text: "(${ans.writer})",
        //       style: TextStyle(fontSize: 18, color: Colors.black54),
        //     ),
        //   ]),
        //   maxLines: 2,
        // ),
      ],
    );
  }

  Widget jingdu() {
    double ans;
    return new CircularPercentIndicator(
      radius: 30.0,
      lineWidth: 5.0,
      animation: true,
      percent: int.parse(read1.reading_pages) / int.parse(read1.total_pages),
      center: new Text(
        "${int.parse(read1.reading_pages) / (int.parse(read1.total_pages) + 1) * 100}%",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Color.fromARGB(255, 11, 118, 137),
    );
  }

  Widget getstartWidget() {
    String ans = read1.create_time;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text("开始时间:"),
        SizedBox(width: 5),
        Text(
            "${ans.substring(0, 4)}年${ans.substring(5, 7)}月${ans.substring(8, 10)}日")
      ],
    );
  }

  Widget getInfoWidget(book ans) {
    // 2.创建Widget
    return Row(
      children: [
        Container(
          height: 45,
          width: 60,
          decoration: new BoxDecoration(
            color: Color.fromARGB(255, 124, 246, 171),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0)),
          ),
          child: IconButton(
            onPressed: () {
              int k = 0;
              for (int i = 0; i < book1.length; i++) {
                if (bookid.toString() == book1[i].book_id.toString()) {
                  k = i;
                  break;
                }
              }
              Navigator.push(
                context2,
                MaterialPageRoute(
                    builder: (context) => reading(
                          b1: book1[k],
                          r1: read1,
                        )),
              );
            },
            icon: Icon(Icons.alarm),
          ),
        ),
        Container(
          height: 45,
          width: 60,
          decoration: new BoxDecoration(
            color: Color.fromARGB(255, 124, 246, 171),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)),
          ),
          child: _popupMenuButton(context2, ans),
        )
      ],
    );
  }

  PopupMenuButton _popupMenuButton(BuildContext context, book ans) {
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => digest(
                    session_id: session_id,
                  )));
        } else if (value == "书评") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => readsense(
                    b1: ans,
                    session_id: session_id,
                  )));
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => readplan()));
        }
      },
      onCanceled: () {
        print("canceled");
      },
      color: Color.fromARGB(255, 124, 246, 171),
      icon: Icon(
        Icons.local_library,
        color: Color.fromARGB(255, 8, 143, 143),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          width: 2,
          color: Color.fromARGB(255, 124, 246, 171),
          style: BorderStyle.solid,
        ),
      ),
    );
  }
  // 电影简介（原生名称）

}
