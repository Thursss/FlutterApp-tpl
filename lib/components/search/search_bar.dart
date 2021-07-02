import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import './search_input.dart';

/// app顶部搜索条
class SearchBar extends StatefulWidget {
  /// app顶部搜索条
  const SearchBar({
    Key key,
    this.hintText,
    this.color,
    this.inputFillColor,
    this.isDelay,
    this.durationTime,
    this.leading,
    this.actions,
    this.onChang,
    this.onClear,
    this.onTap,
  }) : super(key: key);

  /// 提示文本
  final String hintText;

  /// 布局样式
  final Color color;

  /// 输入框布局颜色
  final Color inputFillColor;

  /// 是否启用节流
  final bool isDelay;

  /// 节流时间，默认200毫秒
  final int durationTime;

  /// 左边组件
  final Widget leading;

  /// 右边组件
  final List<Widget> actions;

  /// 点击组件触发
  final Function onTap;

  /// 输入内容变化时触发
  final Function onChang;

  /// 清除输入框内容时触发
  final Function onClear;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: 90.h,
      color: widget.color ?? Color.fromRGBO(40, 148, 255, 1),
      padding: EdgeInsets.symmetric(
        horizontal: 22.w,
        vertical: 10.h,
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: widget.leading ??
                Container(
                  child: Image(
                    image: AssetImage('images/default/default_whiteLogo.png'),
                    width: 202.w,
                    height: 48.h,
                    fit: BoxFit.contain,
                  ),
                ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: YKSreachInput(
                hintText: '搜索内容',
                isDelay: widget.isDelay,
                fillColor: widget.inputFillColor,
                durationTime: widget.durationTime,
                onChang: widget.onChang,
                onClear: widget.onClear,
                onTap: widget.onTap,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.actions ?? [],
          ),
        ],
      ),
    );
  }
}
