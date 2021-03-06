import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:FlutterAppTpl/components/iconfont/icon_font.dart';

/// 输入框组件
class YKSreachInput extends StatefulWidget {
  /// 输入框组件
  YKSreachInput({
    Key key,
    this.hintText = '搜索',
    this.hintStyle,
    this.fillColor = Colors.white,
    this.isDelay = true,
    this.durationTime = 200,
    // this.controller,
    this.focusNode,
    this.width,
    this.height,
    this.onTap,
    this.onChang,
    this.onClear,
  }) : super(key: key);

  /// 焦点控制器
  final FocusNode focusNode;

  /// 输入框宽度
  final double width;

  /// 输入框高度
  final double height;

  /// 提示文本
  final String hintText;

  /// 提示文本样式
  final TextStyle hintStyle;

  /// 背景颜色
  final Color fillColor;

  /// 是否启用节流
  final bool isDelay;

  /// 节流时间，默认200毫秒
  final int durationTime;

  /// 输入框控制器
  // final TextEditingController controller;

  /// 点击组件触发
  final Function onTap;

  /// 输入内容变化时触发
  final Function onChang;

  /// 清除输入框内容时触发
  final Function onClear;

  @override
  _YKSreachInputState createState() => _YKSreachInputState();
}

class _YKSreachInputState extends State<YKSreachInput> {
  /// 输入控制器
  TextEditingController _controller = TextEditingController();

  /// 搜索值
  String searchVal = '';

  ///
  Timer timer;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? null,
      height: widget.height ?? 88.h,
      decoration: BoxDecoration(
        color: widget.fillColor ?? Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconFont(
              IconNames.sousuo,
              color: '#A6ABB7',
              size: 44.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.w),
                child: TextField(
                  controller: _controller,
                  focusNode: widget.focusNode,
                  maxLines: 1,
                  autofocus: false,
                  enabled: widget.onTap == null ? true : false,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintStyle: widget.hintStyle ??
                        TextStyle(
                          color: Color.fromRGBO(166, 171, 183, 1),
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                        ),
                    labelStyle: TextStyle(
                      height: 1,
                    ),
                  ),
                  style: TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 28.sp,
                    color: Color.fromRGBO(66, 66, 66, 1),
                  ),
                  onChanged: (val) {
                    val = val?.trim();
                    setState(() {
                      // 当第一次输入时立即执行，然后才节流
                      if (widget.isDelay == true && searchVal != '') {
                        timer?.cancel();
                        timer = Timer(
                            Duration(milliseconds: widget.durationTime), () {
                          searchVal = val;
                          if (widget.onChang != null) widget.onChang(val);
                        });
                      } else {
                        searchVal = val;
                        if (widget.onChang != null) widget.onChang(val);
                      }
                    });
                  },
                ),
              ),
            ),
            if (searchVal?.isNotEmpty)
              InkWell(
                child: IconFont(
                  IconNames.qingchu,
                  color: '#A6ABB7',
                  size: 44.w,
                ),
                onTap: () {
                  if (searchVal == '') return;
                  _controller.clear();
                  setState(() {
                    searchVal = '';
                    if (widget.onClear != null) widget.onClear();
                    if (widget.onChang != null) widget.onChang('');
                  });
                },
              ),
          ],
        ),
        onTap: () {
          if (widget.onTap != null) widget.onTap();
        },
      ),
    );
  }
}
