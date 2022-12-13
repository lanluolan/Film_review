import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'bookimage.dart';

class shudanbookview extends StatefulWidget {
  bookdan b1;
  List<book> books;
  shudanbookview(this.b1, this.books);
  @override
  State<StatefulWidget> createState() {
    return ScrollHomePageState(b1, books);
  }
}

class ScrollHomePageState extends State {
  bookdan b1;
  List<book> books;
  ScrollHomePageState(this.b1, this.books);
  @override
  Widget build(BuildContext context) {
    return Expanded(

        ///构建九宫格数据数据
        child: Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
      child: buildGridView1(),
    ));
  }

  ///GridView 的基本使用
  ///通过构造函数来创建
  Widget buildGridView1() {
    return GridView(
      ///子Item排列规则
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: 3,
          //纵轴间距
          mainAxisSpacing: 10.0,
          //横轴间距
          crossAxisSpacing: 10.0,
          //子组件宽高长度比例
          childAspectRatio: 0.75),

      ///GridView中使用的子Widegt
      children: buildListViewItemList(),
    );
  }

  List<Widget> buildListViewItemList() {
    List<Widget> list = [];

    ///模拟的8条数据
    for (int i = 0; i < b1.book_id.length; i++) {
      list.add(buildListViewItemWidget(i));
    }

    return list;
  }

  ///创建GridView使用的子布局
  Widget buildListViewItemWidget(int index) {
    int k = 0;
    for (int i = 0; i < books.length; i++) {
      if (books[i].book_id.toString() == b1.book_id[index].toString()) {
        k = i;
        print(k);
        break;
      }
    }
    String url = "images/${books[k].book_picture}";
    String url2 = "images/saohei.webp";
    return new Container(
      ///内容剧中
      alignment: Alignment.center,

      ///根据角标来动态计算生成不同的背景颜色
      //  color: Colors.cyan[100 * (index % 9)],
      child: Image(
        image: AssetImage(url == "images/" ? url2 : url),
        height: 100,
      ),
    );
  }
}
