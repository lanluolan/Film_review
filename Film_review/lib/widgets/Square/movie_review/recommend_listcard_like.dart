import 'package:flutter/material.dart';
import 'text_syles.dart';

/// 帖子文章的赞组件
///
/// 包括点赞组件 icon ，以及组件点击效果
/// 需要外部参数[likeNum],点赞数量
class ArticleLikeBar extends StatelessWidget {
  /// 帖子id
  final String articleId;

  /// like num
  final int likeNum;

  /// 构造函数
  const ArticleLikeBar({this.articleId, this.likeNum});

  /// 有状态类返回组件信息
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: MaterialButton(
          child: Row(
            children: <Widget>[
              Icon(Icons.thumb_up, color: Colors.grey, size: 18),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                '$likeNum',
                style: TextStyles.commonStyle(),
              ),
            ],
          ),
          onPressed: () => () {},
        )),
      ],
    );
  }
}
