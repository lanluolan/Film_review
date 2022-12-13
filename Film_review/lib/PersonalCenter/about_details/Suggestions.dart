import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';

class Suggestions extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("意见反馈", style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(rpx(10.0)),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                minLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "请输入您的意见和反馈"
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      debugPrint(textEditingController.value.text);
                      Navigator.of(context).pop();
                    },
                    child: Text("提交"),
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}