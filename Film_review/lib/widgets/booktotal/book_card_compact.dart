import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:film_review/model/book.dart';

class BookCardCompact extends StatelessWidget {
  final book book1;

  final VoidCallback onClick;
  BookCardCompact(this.book1, {this.onClick});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onClick,
      child: new Container(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Hero(
                    child: new Image.network(
                      book1.book_picture,
                      height: 150.0,
                      width: 100.0,
                    ),
                    tag: book1.book_id,
                  ),
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 24.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            book1.book_name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20.0),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          new SizedBox(
                            height: 4.0,
                          ),
                          new Text(book1.writer),
                          //   new SizedBox(height: 8.0,),
                          //    new Text(_short(book.subtitle, 30)),
                        ],
                      ),
                    ),
                  ),
                  new SizedBox(
                    width: 16.0,
                  )
                ],
              ),
              new Divider(
                color: Colors.black38,
                indent: 128.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _short(String title, int targetLength) {
    var list = title.split(" ");
    int buffer = 0;
    String result = "";
    bool showedAll = true;
    for (String item in list) {
      if (buffer + item.length <= targetLength) {
        buffer += item.length;
        result += item += " ";
      } else {
        showedAll = false;
        break;
      }
    }
    //Handle case of one very long word
    if (result == "" && title.length > 18) {
      result = title.substring(0, 18);
      showedAll = false;
    }

    if (!showedAll) result += "...";
    return result;
  }
}
