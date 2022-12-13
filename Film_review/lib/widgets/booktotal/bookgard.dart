import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/jingli.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/shouye.dart';
import 'package:film_review/widgets/booktotal/bookimage.dart';
import 'package:film_review/widgets/booktotal/booknote.dart';
import 'package:film_review/widgets/booktotal/booknote3.dart';
import 'package:film_review/widgets/booktotal/booknote4.dart';
import 'package:film_review/widgets/booktotal/booknote5.dart';

class bookGridView extends StatefulWidget {
  List<book> books = [];
  List<yuduzhuangtai> reads = [];
  List<jingli> jinglis = [];
  List<bookdan> bangdans = [];
  String readstaus;
  String session_id;
  String userid;
  bookGridView(
      {Key key,
      this.books,
      this.reads,
      this.readstaus,
      this.jinglis,
      this.session_id,
      this.bangdans,
      this.userid})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ScrollHomePageState(
        books, reads, readstaus, session_id, bangdans, jinglis,userid);
  }
}

class ScrollHomePageState extends State {
  List<book> books = [];
  List<yuduzhuangtai> reads = [];
  List<bookdan> bangdans = [];
  List<jingli> jinglis = [];
  String readstaus;
  String session_id;
  String userid;
  ScrollHomePageState(this.books, this.reads, this.readstaus, this.session_id,
      this.bangdans, this.jinglis,this.userid);

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

  int bookid = 0;
  book ans;
  List<Widget> buildListViewItemList() {
    List<Widget> list = [];
    print("shujia:${reads.length}");
    for (int i = 0; i < reads.length; i++) {
      for (int j = 0; j < books.length; j++) {
        if (books[j].book_id.toString() == reads[i].book_id.toString()) {
          print("出现的数${books[j].book_id}");
          // print("${ans.book_name}");
          if (readstaus == "全部")
            list.add(buildListViewItemWidget(i, books[j]));
          else {
            if (readstaus == reads[i].reading_status) {
              list.add(buildListViewItemWidget(i, books[j]));
            }
          }
          break;
        }
      }
    }

    return list;
  }

  ///创建GridView使用的子布局
  Widget buildListViewItemWidget(int index, book ans) {
    List<bookdan> includebang = [];
    bookid = int.parse(reads[index].book_id);
    for (int i = 0; i < bangdans.length; i++) {
      for (int j = 0; j < bangdans[i].book_id.length; j++) {
        if (bookid == bangdans[i].book_id[j]) {
          includebang.add(bangdans[i]);
          break;
        }
      }
    }
    return new Container(
      ///内容剧中
      alignment: Alignment.center,

      ///根据角标来动态计算生成不同的背景颜色
      color: Colors.cyan[100 * (index % 9)],
      child: InkWell(
          onTap: () {
            if (reads[index].reading_status == "在读") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => booknote(
                        b1: ans,
                        read1: reads[index],
                        jinglis: jinglis,
                        session_id: session_id,
                        includebang: includebang,
                        userid: userid,
                      )));
            } else if (reads[index].reading_status == "已读") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => booknote5(
                        b1: ans,
                        read1: reads[index],
                        jinglis: jinglis,
                        session_id: session_id,
                        includebang: includebang,
                    userid: userid,
                      )));
            } else if (reads[index].reading_status == "想读") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => booknote3(
                        b1: ans,
                        read1: reads[index],
                        jinglis: jinglis,
                        session_id: session_id,
                        includebang: includebang,
                    userid: userid,
                      )));
            } else if (reads[index].reading_status == "闲置") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => booknote4(
                        b1: ans,
                        read1: reads[index],
                        jinglis: jinglis,
                        session_id: session_id,
                        includebang: includebang,
                    userid: userid,
                      )));
            }
          },
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(5),
            child: bookImagegird(
              read1: reads[index],
              b1: ans,
              session_id: session_id,
            ),
            //reads[index], ans
            // child: Image.network(
            // "http://7182fde7.r3.cpolar.top/book_query/${book1[bookid].book_picture}"),
          )),
    );
  }
}
