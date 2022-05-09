import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_27/Widget/merchant_category_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QrResultWithImage extends StatelessWidget {
  late String description;
  late String data;
  late String image;

  QrResultWithImage(
      {required this.description, required this.data, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        width: 1.sw,
        child: Row(
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: 60.h,
              width: 60.h,
            ),
            SizedBox(
              width: 40.w,
            ),
            Expanded(
              child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 40.sp),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data,
                    style: TextStyle(color: Colors.blue, fontSize: 50.sp),
                  ),
                ),
              ],
            ),),
          ],
        ));
  }
}
