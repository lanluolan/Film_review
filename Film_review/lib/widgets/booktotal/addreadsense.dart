import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
TextEditingController emailController =
new TextEditingController(); //声明controller
TextEditingController emailController2 =
new TextEditingController(); //声明controller
String bookid;
String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(String session_id) async {
  print("${session_id}");
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(url + '/book_reaction_add'));
  request.fields.addAll({
    'book_id': bookid,
    'title': emailController.text,
    'content': emailController2.text,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("读后感成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
List<Asset> resultList = [];
// 选择照片并上传
Future<void> uploadImages() async {
  if (resultList == null) {
    resultList = List<Asset>();
  }
  try {
    var tmp = await MultiImagePicker.pickImages(
      // 可选参数， 若resultList不为空，再次打开选择界面的适合，可以显示之前选中的图片信息。
      selectedAssets: resultList,
      // 选择图片的最大数量
      maxImages: 9,
      // 是否支持拍照
      enableCamera: true,
      materialOptions: MaterialOptions(
        // 显示所有照片，值为 false 时显示相册
          startInAllView: false,
          allViewTitle: '所有照片',
          actionBarColor: '#2196F3',
          textOnNothingSelected: '没有选择照片'),
    );
    if (tmp.length != 0) {
      resultList = tmp;
     // setState(() {});
    }
  } on Exception catch (e) {
    e.toString();
  }
}
class readsense extends StatelessWidget {
  book b1;
  String session_id;
  readsense({Key key, this.b1, this.session_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bookid = b1.book_id;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.transparent,
          title: Center(
            child: Text("书评"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              tooltip: '保存',
              onPressed: () {
                postRequestFunction(session_id);
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: new SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: "请填写标题(二十个子以内)"),
                      // 绑定控制器
                      // controller: _username,
                      // 输入改变以后的事件
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 130, 132, 134))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: emailController2,
                            autofocus: true,
                            autocorrect: false,
                            keyboardType: TextInputType.multiline,
                            minLines: 20,
                            maxLines: 20,
                            decoration: InputDecoration(
                              hintText: "请填写文字或图片",
                              filled: true,
                              fillColor: Color(0xFFF2F2F2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1),
                              ),
                            ),
                          ),
                          Container(
                              width: 180,
                              alignment: Alignment(-1, -1),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(255, 151, 157, 164)),
                                color: Color.fromARGB(255, 143, 143, 140),
                                shape: BoxShape.rectangle,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    iconSize: 150,
                                    icon: const Icon(
                                      Icons.add,
                                    ),
                                    onPressed: () {
                                      uploadImages();
                                    },
                                  ),
                                  if(resultList.length!=0)
                                    AssetThumb(
                                      asset: resultList[0],
                                      width: 300,
                                      height: 300,
                                    )

                                ],
                              )),
                        ],
                      ),
                    )
                    // 多行文本输入框
                  ],
                ),
              ),
            )));
  }
}
