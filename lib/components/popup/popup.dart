import 'package:flutter/material.dart';
import 'package:FlutterAppTpl/routers/routerUtil.dart';

import 'package:get/get.dart';

class Popup extends PopupRoute {
  /// 显示弹出层 [child] 不能为null，
  /// [top] 弹窗距离顶部的距离，
  /// [left] 弹窗距离左边的距离，
  /// [offsetTop] 弹窗内部控件顶部的偏移量，
  /// [offsetLeft] 弹窗内部控件左边的偏移量，
  /// [width] 弹窗宽度，
  /// [height] 弹窗高度，
  /// [backgroudColor] 弹窗背景颜色，
  /// [onClose] 弹窗关闭触发，
  /// [child] 弹窗内部控件，
  /// [builder] 当需要内部控件需要动画时使用，会传出一个 Animation<double> 对象，return值会代替child，
  Popup({
    this.top = 0.0,
    this.left = 0.0,
    this.offsetTop = 0.0,
    this.offsetLeft = 0.0,
    this.width = 0.0,
    this.height = 200.0,
    this.backgroudColor,
    this.onClose,
    this.child,
    this.builder,
  });

  /// 距离屏幕顶部的位置
  final double top;

  /// 距离屏幕左边
  final double left;

  /// 顶部偏移量
  final double offsetTop;

  /// 左偏移量
  final double offsetLeft;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 背景颜色
  final Color? backgroudColor;

  /// 弹窗关闭时的回调
  final GestureTapCallback? onClose;

  final Widget? child;

  ///
  final Function? builder;

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  /// 显示弹出层 [child] 不能为null，
  /// [top] 弹窗距离顶部的距离，
  /// [left] 弹窗距离左边的距离，
  /// [offsetTop] 弹窗内部控件顶部的偏移量，
  /// [offsetLeft] 弹窗内部控件左边的偏移量，
  /// [width] 弹窗宽度，
  /// [height] 弹窗高度，
  /// [backgroudColor] 弹窗背景颜色，
  /// [onClose] 弹窗关闭触发，
  /// [child] 弹窗内部控件，
  /// [builder] 当需要内部控件需要动画时使用，会传出一个 Animation<double> 对象，return值会代替child，
  static Future show(
    BuildContext _, {
    double top = 0.0,
    double left = 0.0,
    double offsetTop = 0.0,
    double offsetLeft = 0.0,
    double width = 0.0,
    double height = 200.0,
    Color? backgroudColor,
    GestureTapCallback? onClose,
    Widget? child,
    Function? builder,
  }) {
    return Navigator.push(
      _,
      Popup(
        top: top,
        left: left,
        offsetTop: offsetTop,
        offsetLeft: offsetLeft,
        height: height,
        width: width,
        backgroudColor: backgroudColor,
        onClose: onClose,
        child: child,
        builder: builder,
      ),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return CustomSingleChildLayout(
      delegate: _PopupLayout(
        top: top,
        left: left,
        width: width,
        height: height,
      ),
      child: Scaffold(
        backgroundColor: backgroudColor ?? Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topLeft,
          children: [
            InkWell(
              child: Container(
                color: backgroudColor ?? Colors.transparent,
              ),
              onTap: () {
                RouterUtil(context).pop(result: {'statu': false});
                if (onClose != null) onClose!();
              },
            ),
            Positioned(
              top: offsetTop,
              left: offsetLeft,
              child: (builder != null) ? builder!(animation) : child,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      if (onClose != null) onClose!();
    });
  }
}

class _PopupLayout extends SingleChildLayoutDelegate {
  _PopupLayout({
    this.top = 0,
    this.left = 0,
    this.width = 0,
    this.height = 0,
  });

  /// 距离屏幕顶部的位置
  final double top;

  /// 距离屏幕左边
  final double left;

  /// 宽
  final double width;

  /// 高
  final double height;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(Size(width, height));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(left, top);
  }

  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    return true;
  }
}
