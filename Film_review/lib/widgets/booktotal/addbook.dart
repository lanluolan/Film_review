import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:film_review/widgets/booktotal/addbooksearch.dart';
import 'package:film_review/widgets/booktotal/addbookshoudong.dart';

List<String> ans = [];

class addbook extends StatelessWidget {
  String session_id;
  addbook({Key key, this.session_id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          // 末端按钮对齐的容器

          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              picAndTextButton(),
              picAndTextButton2(context),
              picAndTextButton3(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget picAndTextButton() {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        children: [
          FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 219, 200, 108),
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          SizedBox(
            height: 10,
          ),
          Text("扫二维码")
        ],
      ),
    );
  }

  Widget picAndTextButton2(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        children: [
          FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => addbooksearch(ans, session_id)));
              },
              backgroundColor: Color.fromARGB(255, 9, 203, 112),
              child: const Icon(
                Icons.search,
              ),
              heroTag: "222"),
          SizedBox(
            height: 10,
          ),
          Text("搜索书籍")
        ],
      ),
    );
  }

  Widget picAndTextButton3(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        children: [
          FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => addbookshoudong(session_id: session_id)));
              },
              child: const Icon(Icons.file_copy_rounded),
              heroTag: "333"),
          SizedBox(
            height: 10,
          ),
          Text("手动录入")
        ],
      ),
    );
  }
}
/*
 style: ElevatedButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 9, 203, 112),
                  style: BorderStyle.solid,
                ),
              ),
            ),*/