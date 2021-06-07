import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ui/home/index.dart';
import 'package:FlutterAppTpl/routers/router.dart';

import 'ui/home/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334), // 初始化动态尺寸, 单位为px
      builder: () => RefreshConfiguration(
        headerTriggerDistance: 80.0, // 头部触发刷新的越界距离
        springDescription: SpringDescription(
          stiffness: 170,
          damping: 16,
          mass: 1.9,
        ), // 自定义回弹动画
        maxOverScrollExtent: 100, // 头部最大可以拖动的范围
        maxUnderScrollExtent: 50, // 底部最大可以拖动的范围
        enableScrollWhenRefreshCompleted:
            false, // 如果需要TabBarView左右滑动,你需要把它设置为true
        enableLoadingWhenFailed: true, // 在加载失败的状态下,仍然可以通过手势上拉来触发加载更多
        hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
        enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
        headerBuilder: () => WaterDropHeader(), // 配置默认头部指示器
        footerBuilder: () => ClassicFooter(), // 配置默认底部指示器
        child: GetMaterialApp(
          title: 'LifeApp',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // scaffoldBackgroundColor: ykColorBG,
            highlightColor: Color.fromRGBO(1, 0, 0, 0.0),
            splashColor: Color.fromRGBO(1, 0, 0, 0.0), //拖动颜色
            primaryColor: Colors.blue,
            bottomAppBarColor: Colors.blue,
          ),
          home: MyHomePage(),
          initialRoute: '/',
          unknownRoute: RouterConfig.unkwonPage,
          getPages: [
            ...RouterConfig.routers.map((route) =>
                GetPage(name: route['path'], page: () => route['page']))
          ],
          routingCallback: (routing) {
            if (routing.isBack) {
              // 路由出栈
              RouterConfig.routerBack(routing);
            } else {
              // 路由入栈
              RouterConfig.routerPush(routing);
            }
          },
        ),
      ),
    );
  }
}
