import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class RouterUtil {
  final BuildContext context;

  /// 路由管理方法
  RouterUtil(this.context);

  /// 页面切换时长
  Duration durationDef = Duration(milliseconds: 200);

  /// 路由跳转，
  /// [arguments]路由参数
  Future? push(
    page, {
    dynamic arguments,
  }) {
    return Get.toNamed(
      page,
      arguments: arguments,
    );
  }

  /// 路由回退
  void pop({dynamic result}) {
    Get.back(result: result);
  }

  /// 回退到指定页面
  void until(page) {
    Get.until((route) => route == page);
  }

  /// 替换当前路由，
  /// [arguments]路由参数
  Future? repace(
    page, {
    dynamic arguments,
  }) {
    return Get.offNamed(
      page,
      arguments: arguments,
    );
  }

  /// 替换全部路由，
  /// [arguments]路由参数
  Future? repaceAll(
    page, {
    dynamic arguments,
  }) {
    return Get.offAllNamed(
      page,
      arguments: arguments,
    );
  }
}
