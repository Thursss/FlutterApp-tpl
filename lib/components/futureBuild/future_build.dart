import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:FlutterAppTpl/components/empty/common_error.dart';

/*
 * 异步加载组件
 * @param {Future} future
 * @param {Function} builder 请求成功时的构建函数
 * @param {Function} errorBuilder 请求失败时的构建函数
 * @param {bool} loading 是否显示loading状态
 * @param {Widget} loadingWidget loading状态
 */
class FutureBuild extends StatefulWidget {
  /// 需要异步数据来渲染视图时使用，
  /// 加载成功时会调用builder并返回异步数据，
  /// 加载失败时会调用[errorBuilder]并返回失败信息，
  /// [loading]是否显示loadingWidget，
  /// [loadingWidget]加载时显示的组件，默认为loading图标，
  FutureBuild(
    {
    this.future,
    this.builder,
    this.onRefresh,
    this.errorBuilder,
    this.loading = true,
    this.loadingWidget,
    Key? key,
  }) : super(key: key);

  /// future
  final Future? future;

  /// 请求成功时的构建函数
  final Function? builder;

  /// 请求失败时的构建函数
  final Function? errorBuilder;

  /// 重新加载
  final Function? onRefresh;

  /// 是否显示loading状态
  final bool loading;

  /// 自定义loading状态
  final Widget? loadingWidget;

  @override
  _FutureBuildState createState() => _FutureBuildState();
}

class _FutureBuildState extends State<FutureBuild> {
  late Future future;
  late AsyncSnapshot _snapshot;
  Object? _activeCallbackIdentity;

  @override
  void initState() {
    super.initState();
    future = widget.future!;
    _snapshot = AsyncSnapshot.withData(ConnectionState.none, null);
    _subscribe();
  }

  @override
  void didUpdateWidget(FutureBuild oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.future != widget.future) {
      future = widget.future!;
      if (_activeCallbackIdentity != null) {
        _unsubscribe();
        _snapshot = _snapshot.inState(ConnectionState.none);
      }
      _subscribe();
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (future != null) {
      final Object callbackIdentity = Object();
      _activeCallbackIdentity = callbackIdentity;
      future.then<void>((data) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot.withData(ConnectionState.done, data);
          });
        }
      }, onError: (Object error) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot.withError(ConnectionState.done, error);
          });
        }
      });
      _snapshot = _snapshot.inState(ConnectionState.waiting);
    }
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (_snapshot.connectionState) {
          case ConnectionState.none:
            return Text('还没有开始网络请求');
          case ConnectionState.active:
            return Text('ConnectionState.active');
          case ConnectionState.waiting:
            // 加载中
            return widget.loading
                ? Center(
                    child: widget.loadingWidget ?? CircularProgressIndicator())
                : SizedBox();
          // return Offstage(
          //   offstage: widget.loading,
          //   child: Center(
          //       child: widget.loadingWidget ?? CircularProgressIndicator()),
          // );
          case ConnectionState.done:
            // 加载完成
            if (_snapshot.hasError) {
              return (widget.errorBuilder != null)
                  ? widget.errorBuilder!(_snapshot.error)
                  : CommonErrorWeigth(
                      error: _snapshot.error,
                      onRefresh: widget.onRefresh,
                    );
            }
            if (_snapshot.hasData) {
              return widget.builder!((_snapshot.data is Response)
                  ? json.decode(_snapshot.data.toString())
                  : _snapshot.data);
            }
            return SizedBox();
          default:
            return SizedBox();
        }
      },
    );
  }
}
