import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_27/Widget/merchant_category_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QrResultWithoutImage extends StatelessWidget {
  late String text;

  QrResultWithoutImage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
      width: 1.sw,
      color: Colors.blue[50],
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Receipt for : ',
              style: TextStyle(fontSize: 40.sp),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(color: Colors.blue, fontSize: 50.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
