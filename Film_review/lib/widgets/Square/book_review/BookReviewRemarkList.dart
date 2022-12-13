import 'package:flutter/material.dart';

class BookReviewRemarkList extends StatefulWidget {
  String session_id;
  List bookreview;
  Map<int, dynamic> mapremarkcontent;

  BookReviewRemarkList(this.session_id, this.bookreview, this.mapremarkcontent);
  @override
  BookReviewRemarkListState createState() => BookReviewRemarkListState(
      session_id: session_id,
      bookreview: bookreview,
      mapremarkcontent: mapremarkcontent);
}

class BookReviewRemarkListState extends State<BookReviewRemarkList> {
  BookReviewRemarkListState(
      {Key key, this.session_id, this.bookreview, this.mapremarkcontent})
      : super();
  final String session_id;
  final List bookreview;
  final Map<int, dynamic> mapremarkcontent;
  int flag = 0;

  List<Widget> _getData() {
    var temp = bookreview.map((value) {
      print(mapremarkcontent.toString());
      print("hhh" + mapremarkcontent[value["book_reaction_id"]].toString());
      if (mapremarkcontent.containsKey(value["book_reaction_id"]) &&
          flag == 0) {
        for (int i = 0;
            i < mapremarkcontent[value["book_reaction_id"]].length;
            i++) {
          return Card(
              margin: EdgeInsets.all(10),
              child: Container(
                height: 215.0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "评论：",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Text(
                            mapremarkcontent[value["book_reaction_id"]][i]
                                ["create_time"],
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Container(
                                width: 200.0,
                                child: Text(
                                  value["content"],
                                  style: TextStyle(color: Colors.black38),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //${value["book_reaction_picture"]}
                      ],
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0, bottom: 5.0)),
                                Image.asset(
                                  "images/person.jpg",
                                  width: 25.0,
                                  height: 25.0,
                                ),
                                Padding(padding: EdgeInsets.only(left: 10.0)),
                                Text(
                                  value["user_id"],
                                  style: TextStyle(color: Colors.black38),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ));
        }
        flag = 1;
      }
      if (flag == 0) {
        flag = 1;
        return Text("无评论");
      }
      return Text("");
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: _getData(),
      ),
    );
  }
}
