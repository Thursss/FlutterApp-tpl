import 'package:get/get.dart';

import 'package:FlutterAppTpl/unknown_page.dart';
import './categories.dart';

class RouterConfig {
  factory RouterConfig() => _getInstance();
  static RouterConfig? get instance => _getInstance();
  static RouterConfig? _instance;
  // 初始化
  RouterConfig._internal() {}
  static RouterConfig _getInstance() {
    return _instance ?? RouterConfig._internal();
  }

  /// 未知路由
  static GetPage unkwonPage = GetPage(
    name: '/unkwonPage',
    page: () => UnkownPage(),
  );

  /// 路由配置
  static List<Map<String, dynamic>> routers = [
    ...CategoriesRouter().testRouters,
  ];

  /// 路由入栈事件
  static routerPush(Routing? routing) {
    // print(routing.current);
  }

  /// 路由出栈事件
  static routerBack(Routing? routing) {
    // print(routing.previous);
  }
}
