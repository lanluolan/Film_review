import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class digest extends StatefulWidget {
  // This widget is the root of your application.
  String session_id;
  digest({Key key, this.session_id}) : super(key: key);

  @override
  digestState createState() => digestState(session_id);
}

TextEditingController emailController =
new TextEditingController(); //声明controller
TextEditingController emailController2 =
new TextEditingController(); //声明controller
String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(String session_id) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(url + '/experience_add'));
  request.fields.addAll({
    'title': emailController.text,
    'content': emailController2.text,
    'type': "1"
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("添加书摘成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class digestState extends State<digest> {
  String session_id;
  digestState(this.session_id);
   File  _image;
  // 图片获取引擎
  final picker = ImagePicker();

  /// 获取摄像头图像的方法
  Future getImageFromCamera() async {
    /// 菜单按钮消失
    Navigator.pop(context);

    /// 需要导入 image_picker.dart 包
    /// import 'package:image_picker/image_picker.dart';
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  /// 获取相册中的图像
  Future getImageFromGallery() async {
    /// 菜单按钮消失
    Navigator.pop(context);

    /// 需要导入 image_picker.dart 包
    /// import 'package:image_picker/image_picker.dart';
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("书摘"),
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
                      decoration: InputDecoration(hintText: "请输入页码"),
                      // 绑定控制器
                      // controller: _username,
                      // 输入改变以后的事件
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 20),
                    // 多行文本输入框
                    TextField(
                      maxLines: 15,
                      decoration: InputDecoration(
                        hintText: "请输入内容或选择照片",
                        border: OutlineInputBorder(),
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () {
                                // 调用 getImage 方法 , 调出相机拍照
                                getImageFromCamera();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.photo_library_outlined),
                              onPressed: () {
                                // 调用 getImageFromGallery 方法 , 调出相册
                                getImageFromGallery();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    TextField(
                      controller: emailController2,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "心得体会", border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            )));
  }
}
