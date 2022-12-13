import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/widgets/booktotal/addreadsense.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/widgets/booktotal/addDigest.dart';
import 'readplan.dart';

class bookImagegird extends StatelessWidget {
  yuduzhuangtai read1;
  book b1;
  String session_id;
  bookImagegird({Key key, this.read1, this.b1, this.session_id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("${b1.book_picture}");
    return Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new ExactAssetImage("images/${b1.book_picture}"),
          ),
        ),
        child: Row(
          children: [
            Spacer(),
            Column(
              children: [
                Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  label: Text(
                    "${read1.reading_status}",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  backgroundColor: Color.fromARGB(255, 121, 170, 230),
                ),
                Spacer(),
                Container(
                  alignment: Alignment(1, 1),
                  child: _popupMenuButton(context),
                ),
              ],
            )
          ],
        ));
  }

  PopupMenuButton _popupMenuButton(BuildContext context) {
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
                    b1: b1,
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
      color: Color.fromARGB(255, 142, 142, 142),
      icon: Icon(
        Icons.add_circle,
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
}
