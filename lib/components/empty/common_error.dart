import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonErrorWeigth extends StatelessWidget {
  /// 异步加载失败时的表现
  CommonErrorWeigth({this.onRefresh, this.error = '', this.imageUrl, Key? key})
      : super(key: key);
  final dynamic error;
  final String? imageUrl;
  final Function? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // YKImage(
            //   imageUrl: imageUrl ?? 'images/default/noImg/noImg_noGoods.png',
            //   width: 300.w,
            // ),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            if (onRefresh != null)
              ElevatedButton(
                child: Text('重新加载'),
                onPressed: () {
                  onRefresh!();
                },
              ),
          ],
        ),
      ),
    );
  }
}
