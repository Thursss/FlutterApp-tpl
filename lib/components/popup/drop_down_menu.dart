import 'package:flutter/material.dart';

import 'popup.dart';

/// 下拉弹窗对齐类型
enum JustifyType { center, left, right }

class DropDownMenu extends StatelessWidget {
  /// 下拉框，
  DropDownMenu({
    this.child,
    this.action,
    this.height = 200,
    this.width,
    this.backgroudColor,
    this.justify = JustifyType.left,
    this.onDropCallBack,
    this.dropMenu,
    Key? key,
  }) : super(key: key);

  ///
  final Widget? child;

  /// 触发下拉的组件，当为null时由child触发
  final Widget? action;

  /// 下拉框的内容
  final Widget? dropMenu;

  /// 下拉框高度
  final double height;

  /// 下拉框宽度
  final double? width;

  /// 背景颜色
  final Color? backgroudColor;

  /// 对齐方式
  final JustifyType justify;

  /// 下拉框展开，收起时的回调 true为展开，false为收起
  final Function? onDropCallBack;

  /// GlobalKey
  GlobalKey _globalKey = GlobalKey();

  /// 调用Popup.show方法，展开下拉框
  Future dropDowm(BuildContext _, Rect box) {
    if (onDropCallBack != null) onDropCallBack!(true);
    return Popup.show(
      _,
      top: box.bottom,
      left: box.left,
      height: height,
      width: width ?? (box.right - box.left),
      backgroudColor: backgroudColor,
      child: dropMenu,
      builder: (Animation<double> animation) {
        return SizeTransition(
          sizeFactor: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
          child: dropMenu,
        );
      },
      onClose: () {
        if (onDropCallBack != null) onDropCallBack!(false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: _globalKey,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        child != null
            ? Expanded(
                child: InkWell(
                  child: child,
                  onTap: () {
                    if (action == null) {
                      RenderBox renderBox = (_globalKey.currentContext
                          ?.findRenderObject() as RenderBox);
                      Rect box =
                          renderBox.localToGlobal(Offset.zero) & renderBox.size;
                      dropDowm(context, box);
                    }
                  },
                ),
              )
            : Container(width: 0),
        InkWell(
          child: action ?? Container(),
          onTap: () {
            RenderBox renderBox =
                (_globalKey.currentContext?.findRenderObject() as RenderBox);
            Rect box = renderBox.localToGlobal(Offset.zero) & renderBox.size;
            dropDowm(context, box).then((res) {});
          },
        ),
      ],
    );
  }
}
