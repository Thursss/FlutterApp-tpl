import 'package:flutter/material.dart';

/// 用于定义返回给使用者的数据规范接口
class ScrollPointModel {
  ScrollPointModel({this.i, this.offset});

  /// 当前第几个子组件在顶部
  int i;

  /// 偏移量
  num offset;
}

/// 用于定义返回给使用者的数据规范接口
class ScrollBindingModel {
  ScrollBindingModel({this.childPoints, this.childSizes, this.containerSize});

  /// 所有的子组件的尺寸信息
  List childSizes;

  /// 所有的子组件的位置信息
  List childPoints;

  /// 父容器的尺寸信息
  Size containerSize;
}

class ScrollListenerView extends StatefulWidget {
  /// 滚动监听处理
  ScrollListenerView(
      {this.controller, this.children, this.onBinding, this.onScroll, Key key})
      : super(key: key);

  /// 滚动控制器
  final ScrollController controller;

  /// 子控件
  final List<Widget> children;

  /// 初始化完成回调
  final Function onBinding;

  /// 滚动回调
  final Function onScroll;

  @override
  ScrolLlistenerViewState createState() => ScrolLlistenerViewState();
}

class ScrolLlistenerViewState extends State<ScrollListenerView> {
  ///
  WidgetsBinding widgetsBinding;

  /// 所有的子组件的尺寸信息
  List<Size> childSizes = [];

  /// 所有的子组件的位置信息
  List<num> childPoints = [];

  /// 容器的尺寸信息
  Size containerSize;

  /// 列表滚动监听
  void scrollListener() {
    /// 位于顶部位置组件索引
    int index = 0;

    /// 在组件上y轴移动的位置
    double dy = widget.controller.offset;

    // 根据位置信息当前位于第几个子组件中
    for (var i = 1; i < childPoints.length; i++) {
      if (dy < childPoints[i] && dy > childPoints[i - 1]) {
        index = (i - 1);
        break;
      }
    }

    // 执行回调
    if (widget.onScroll != null)
      widget.onScroll(ScrollPointModel(i: index, offset: dy));
  }

  /// 提供给外部来更新组件状态
  void refresh() {
    if (mounted) setState(() {});
  }

  /// 初始化位置信息
  void onBinding() {
    childPoints = [];
    childSizes = [];

    /// 获取所有子组件尺寸并保存至 [childSizes] 内
    /// 计算所有子组件位置并保存至 [childPoints] 内
    num heightSum = 0.0;

    widget.children.forEach((item) {
      GlobalKey key = item.key;
      // 获取尺寸信息
      Size size = key.currentContext?.size;
      childSizes.add(size);

      // 计算高度
      childPoints.add(heightSum);
      heightSum += size.height;
    });

    // 获取父容器尺寸
    containerSize = Size(context.size.width, heightSum);

    if (widget.onBinding != null)
      widget.onBinding(ScrollBindingModel(
        childPoints: childPoints,
        childSizes: childSizes,
        containerSize: containerSize,
      ));
  }

  @override
  void initState() {
    super.initState();
    // 添加滚动监听
    widget.controller.addListener(scrollListener);

    widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((timeStamp) {
      onBinding();
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        children: widget.children,
      ),
    );
  }
}
