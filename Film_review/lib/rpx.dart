import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 初始化屏幕适配
void initScreenUtil(BoxConstraints constraints) {
  ScreenUtil.init(constraints, designSize: Size(540,1170));
}

/// rpx 根据屏幕宽度自适应 1rpx = 0.5px = 1物理像素
double rpx(double rpx) {
  return ScreenUtil().setWidth(rpx);
}
