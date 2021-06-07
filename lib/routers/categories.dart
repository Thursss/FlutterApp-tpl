import 'package:FlutterAppTpl/ui/test/index.dart';

class CategoriesRouter {
  /// 全部商品
  static const String testPage = '/TestPage';

  /// 全部商品的路由配置
  List<Map<String, dynamic>> testRouters = [
    {
      'path': testPage,
      'page': TestPage(),
    },
  ];
}
