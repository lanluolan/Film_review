import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("隐私政策", style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body:Padding(
          padding:EdgeInsets.all(rpx(10.0)) ,
          child: ListView(
            children: [
              Text("隐私政策摘要",style: TextStyle(fontSize: rpx(30.0)),),
              Text("书影足迹隐私保护指引\n"
                  "最近更新日期： 2022 年 11 月 8 日\n"
                  "请您在使用本平台前，仔细阅读并充分理解本指引。\n"
                  "书影足迹产品和/或服务是由上文化传播有限公司提供。书影足迹深知个人信息（含个人敏感信息）对你的重要性，并会全力保护你的个人信息安全。我们致力于维持你对我们的信任，恪守以下原则，保护你的个人信息：权责一致原则、目的明确原则、选择同意原则、最小必要原则、公开透明原则、确保安全原则、主体参与原则等。我们根据《中华人民共和国网络安全法》《中华人民共和国个人信息保护法》《中华人民共和国数据安全法》《常见类型移动互联网应用程序必要个人信息范围规定》等法律法规，并参考《信息安全技术 个人信息安全规范》（GB/T 35273-2020）等国家标准，制定书影足迹隐私政策，并致力于保护您的个人信息安全。\n"
                  "本概要将帮助您直观、简明地了解我们是如何收集、处理和保护您的个人信息以及如何保护您的隐私安全。本概要为我们详细隐私政策的附件，您可点击《隐私政策》查看隐私政策正文。\n"
                  "本政策将帮助你了解以下内容：\n"
                  "一、我们如何收集和使用你的个人信息\n"
                  "二、我们如何共享、转让、公开披露你的个人信息\n"
                  "三、我们如何保护你的个人信息\n"
                  "四、你的权利\n"
                  "五、关于儿童的个人信息\n"
                  "六、如何联系我们\n"
                  "一、我们如何收集和使用你的个人信息\n"
                  "(一)  我们如何收集你的个人信息\n"
                  "你在使用书影足迹提供的产品与/或服务时，为了更好地实现你的目的，我们可能收集和使用你的个人信息。包括：\n"
                  "1、你在注册ONE「一个」账号时提供的信息\n"
                  "注册并登录ONE「一个」账号时，需要你提供手机号码、或第三方账号（微信、QQ、微博 ）的信息，我们将通过发送短信验证码来验证你的账号是否有效。你可根据自身需求补充填写个人信息（头像、昵称）。",style: TextStyle(fontSize: rpx(20.0)),),
            ],
          ),
        )
    );
  }
}