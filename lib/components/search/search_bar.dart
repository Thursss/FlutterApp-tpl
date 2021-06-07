import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import './search_input.dart';

/*
 * app顶部搜索条
 */

class YKSearchBar extends StatefulWidget {
  final String hintText;
  final Color color;
  final Color inputFillColor;
  final bool isDelay;
  final int durationTime;
  final Widget leading;
  final List<Widget> actions;
  final Function onChang;
  final Function onClear;
  final Function onTap;

  /// 顶部搜索条
  const YKSearchBar({
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

  @override
  _YKSearchBarState createState() => _YKSearchBarState();
}

class _YKSearchBarState extends State<YKSearchBar> {
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
                hintText: '药品名、通用名、生产厂家',
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
