import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListLoading extends StatelessWidget {
  /// 商品列表加载时的骨架图
  ListLoading({Key key, this.count = 3}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext _, int i) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160.w,
                height: 160.w,
                margin: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
                color: Color.fromRGBO(200, 200, 200, .3),
              ),
              Expanded(
                child: Container(
                  height: 200.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 30.h,
                        width: 250.w,
                        color: Color.fromRGBO(200, 200, 200, .3),
                      ),
                      Container(
                        height: 25.h,
                        width: 350.w,
                        color: Color.fromRGBO(200, 200, 200, .3),
                      ),
                      Container(
                        height: 25.h,
                        width: 350.w,
                        color: Color.fromRGBO(200, 200, 200, .2),
                      ),
                      Container(
                        height: 20.h,
                        width: 250.w,
                        color: Color.fromRGBO(200, 200, 200, .2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
