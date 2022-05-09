import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/Widget/change_password_page.dart';

class SettingSingleImage extends StatelessWidget {
  late String data;
  late String image;
  var nextPage;
  late double widthSize;

  SettingSingleImage({required this.data, required this.image, required this.nextPage, required this.widthSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:  (_) => nextPage)),
      child: Container(
        width: widthSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        // margin: EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: Image.asset(
              image,
              width: 100.w,
              height: 100.h,
            ),),
            SizedBox(width: 12),
            Flexible(
              child: Text(data,
                style: TextStyle(
                  fontSize: 45.sp,
                  color: Colors.grey,
                ),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
