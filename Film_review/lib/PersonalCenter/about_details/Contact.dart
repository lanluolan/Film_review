import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("联系我们", style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body:Padding(
          padding:EdgeInsets.all(rpx(10.0)) ,
          child: Column(
            children: [
              Text("邮箱：2314312364@qq.com",style: TextStyle(fontSize: rpx(15.0)),),
              Padding(padding: EdgeInsets.only(left: rpx(20.0),right: rpx(20.0)),
                child: Divider(
                  color: Colors.black26,
                ),
              ),
              Text("地址：浙江省杭州市江干区白杨街道浙江工商大学",style: TextStyle(fontSize: rpx(15.0)),),
            ],
          ),
        )
    );
  }
}