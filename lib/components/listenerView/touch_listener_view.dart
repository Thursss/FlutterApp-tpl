import 'package:flutter/cupertino.dart';

enum PointerType { onPointerDown, onPointerMove, onPointerUp }

/// 用于定义返回给使用者的数据规范接口
class TouchPointModel {
  TouchPointModel({this.i, this.offset, this.type});

  /// 当前第几个子组件在顶部
  int i;

  /// 偏移量
  num offset;

  // 事件类型
  PointerType type;
}

/// 用于定义返回给使用者的数据规范接口
class TouchBindingModel {
  TouchBindingModel({this.childPoints, this.childSizes, this.containerSize});

  /// 所有的子组件的尺寸信息
  List childSizes;

  /// 所有的子组件的位置信息
  List childPoints;

  /// 父容器的尺寸信息
  Size containerSize;
}

class TouchListenerView extends StatefulWidget {
  ///
  TouchListenerView({this.children, this.onMove, this.onBinding, Key key})
      : super(key: key);

  /// 子控件
  final List<Widget> children;

  /// 初始化完成回调
  final Function onBinding;

  /// 移动回调
  final Function onMove;

  @override
  TouchListenerViewState createState() => TouchListenerViewState();
}

class TouchListenerViewState extends State<TouchListenerView> {
  ///
  WidgetsBinding widgetsBinding;

  /// 所有的子组件的尺寸信息
  List<Size> childSizes = [];

  /// 所有的子组件的位置信息
  List<num> childPoints = [];

  /// 容器的尺寸信息
  Size containerSize;

  /// 触摸事件处理
  /// [dy]
  void onPointer(double dy, PointerType type) {
    /// 手指在列表的位置索引
    int index = 0;

    /// 在组件上y轴移动的位置
    // double dy = event.localPosition.dy;

    /// 容器高度
    double containerHeight = containerSize.height;

    // 根据位置信息判断当前位于第几个子组件中
    for (var i = 1; i < childPoints.length; i++) {
      if (dy < childPoints[i] && dy > childPoints[i - 1]) {
        index = i;
        break;
      }
    }

    // 如果触摸范围超过容器范围
    if (dy <= 0) index = 0;
    if (dy > containerHeight) index = childPoints.length;

    // 执行回调
    if (widget.onMove != null)
      widget.onMove(TouchPointModel(i: index, type: type, offset: dy));
  }

  /// 提供给外部来更新组件状态
  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();

    widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback) {
      // 获取父容器尺寸
      containerSize = context.size;

      /// 获取所有子组件尺寸并保存至 [childSizes] 内
      /// 计算所有子组件位置并保存至 [childPoints] 内
      num heightSum = 0;

      widget.children.forEach((item) {
        GlobalKey key = item.key;
        // 获取尺寸信息
        Size size = key.currentContext.size;
        childSizes.add(size);

        // 计算高度
        heightSum += size.height;
        childPoints.add(heightSum);
      });

      if (widget.onBinding != null)
        widget.onBinding(TouchBindingModel(
          childPoints: childPoints,
          childSizes: childSizes,
          containerSize: containerSize,
        ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Column(
        children: widget.children,
      ),

      // 触摸
      onPointerDown: (event) {
        onPointer(event.localPosition.dy, PointerType.onPointerDown);
      },
      // 移动
      onPointerMove: (event) {
        onPointer(event.localPosition.dy, PointerType.onPointerMove);
      },
      // 抬起
      onPointerUp: (event) {
        onPointer(event.localPosition.dy, PointerType.onPointerUp);
      },
    );
  }
}
