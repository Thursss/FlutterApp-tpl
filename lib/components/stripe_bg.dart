import 'package:flutter/material.dart';

/// 条纹背景
class YKStripeBg extends StatelessWidget {
  ///  条纹背景
  YKStripeBg(
    this.stripeColorList, {
    this.child,
    this.width,
    this.height,
    this.alignment,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.stripeCount = 5,
    Key? key,
  }) : super(key: key);

  /// 子组件
  final Widget? child;

  ///
  final double? width;

  ///
  final double? height;

  ///
  final Alignment? alignment;

  /// 开始方向
  final Alignment? begin;

  /// 结束方向
  final Alignment? end;

  /// 条纹背景数组
  final List<Color> stripeColorList;

  /// 重复次数
  final int stripeCount;

  /// 配置条纹背景数据
  Map<String, List> configureStripeBg() {
    if (stripeColorList == null || stripeColorList.isEmpty || stripeCount == 0)
      throw 'stripeColorList is null or empty';

    Map<String, List> linearGradientList = {
      'colors': [],
      'stops': [],
    };

    int stopsLength = stripeCount * stripeColorList.length;
    double factor = 1 / (stopsLength * 2);
    List itemStripe = [];

    for (int i = 0; i < stripeColorList.length; i++) {
      itemStripe.addAll([stripeColorList[i], stripeColorList[i]]);
    }

    for (int i = 0; i < stripeCount; i++) {
      linearGradientList['colors']?.addAll(itemStripe);
    }

    for (int i = 0; i < stopsLength; i++) {
      double itemVal = double.parse((i * factor).toStringAsFixed(3)) * 2;
      if (itemVal == 0.0) continue;
      linearGradientList['stops']?.addAll([itemVal, itemVal + 0.001]);
    }

    return linearGradientList;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List> linearGradientList = configureStripeBg();
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin ?? Alignment.topLeft,
          end: end ?? Alignment.bottomRight,
          tileMode: TileMode.repeated,
          colors: [...linearGradientList['colors']!],
          stops: [0, ...linearGradientList['stops']!, 1],
        ),
      ),
      child: child ?? Container(),
    );
  }
}
