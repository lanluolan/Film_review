import 'package:flutter/material.dart';
import 'package:film_review/model/bookdan.dart';

class shudan extends StatelessWidget {
  // final List<book> book1;
  // final yuduzhuangtai read1;
  //final yuduzhuangtai read;
  bookdan bangdan;
  BuildContext context2;
  shudan(this.bangdan);
  int bookid = 0;
  @override
  Widget build(BuildContext context) {
    // bookid = int.parse(read1.book_id);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
              new Border.all(width: 1, color: Color.fromARGB(255, 79, 78, 78))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 2.具体内容
          getMovieContentWidget(),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget getMovieContentWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: getContentImage(),
        ),
        getContentDesc(),
      ],
    );
  }

  Widget getContentImage() {
    String url = "images/1668557646608.webp";
    String url2 = "images/${bangdan.booklist_picture}";
    return Image(
      image: AssetImage(url2 == "images/" ? url : url2),
      height: 120,
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
                height: 10,
              ),
              Text(
                "收藏量${bangdan.collector_id.length}次",
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 222, 183, 75)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "${bangdan.book_id.length}本   ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 21, 20, 20),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "by ${bangdan.user_id}",
                    style: TextStyle(
                        color: Color.fromARGB(255, 21, 20, 20),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "images/beijin.jpg",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "创建时间：${bangdan.create_time}",
                style: TextStyle(
                    color: Color.fromARGB(255, 37, 36, 36),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ]),
      ),
    );
  }

  Widget getTitleWidget() {
    return Stack(
      children: <Widget>[
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: "${bangdan.booklist_name}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                )),
          ]),
          maxLines: 2,
        ),
      ],
    );
  }
}
