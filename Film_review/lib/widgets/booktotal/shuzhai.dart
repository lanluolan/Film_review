import 'package:flutter/material.dart';
import 'package:flutter_my_picker/flutter_my_picker.dart';
import 'booknoticeItem.dart';
// 日期操作，需要时引入
import 'package:flutter_my_picker/common/date.dart';

class shuzhai extends StatefulWidget {
  @override
  myspreadState createState() => myspreadState();
}

// 1. 实现 SingleTickerProviderStateMixin
class myspreadState extends State<shuzhai> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("书摘"),
          ),
        ),
        // 5. 添加TabBarView
        body: bookdiget());
  }

  Widget bookdiget() {
    return Column(
      children: [
        _builddiget(),
      ],
    );
  }

  Widget _builddiget() {
    return new Expanded(
      child: new ListView.builder(
        padding: const EdgeInsets.all(16.0), // 设置padding
        itemBuilder: (context, index) {
          return bookdigetItem();
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 3,
      ),
    );
  }

  Widget bookdigetItem() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: new Border.all(
              width: 1, color: Color.fromARGB(255, 181, 181, 181))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(
                    "P25",
                    style: TextStyle(
                      color: Color.fromARGB(255, 30, 234, 186),
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "2022-11-22 11:30",
                    style: TextStyle(
                      color: Color.fromARGB(255, 169, 174, 173),
                      fontSize: 13,
                    ),
                  ),
                  _popupMenuButton(context),
                ],
              ),
              Text("有人说，生命必须有裂缝，阳光才能照进来，"),
              SizedBox(
                height: 5,
              ),
              getContentImage(),
              SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),

                // 绑定控制器
                // controller: _username,
                // 输入改变以后的事件
                onChanged: (value) {},
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget getContentImage() {
    return Image(
      image: AssetImage('images/haibao.webp'),
      height: 75,
      width: 120,
    );
  }
}

PopupMenuButton _popupMenuButton(BuildContext context) {
  return PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Text("编辑书摘"),
            ],
          ),
          value: "编辑书摘",
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Text("删除书摘"),
            ],
          ),
          value: "删除书摘",
        ),
      ];
    },
    onSelected: (value) {
      if (value == "编辑书摘") {
      } else if (value == "删除书摘") {}
    },
    onCanceled: () {
      print("canceled");
    },
    color: Color.fromARGB(255, 247, 247, 247),
    icon: Icon(Icons.keyboard_arrow_down),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        width: 2,
        color: Color.fromARGB(255, 249, 249, 249),
        style: BorderStyle.solid,
      ),
    ),
  );
}
