import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTitleBar extends StatelessWidget {
  late String title;
  late var action;

  MainTitleBar({required this.title,required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      color: Colors.blue[300],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40.w,
          ),
          GestureDetector(
            onTap: action,
            child: Image.asset('assets/images/appicon_back.png',height: 60.h,width: 60.w,),
          ),
          Container(
            height: 150.h,
            width: 0.78.sw,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 55.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
