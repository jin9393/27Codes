import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MerchantSortingBar extends StatelessWidget {
  const MerchantSortingBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Padding(padding: EdgeInsets.only(left: 40.w,top: 20.h,bottom: 20.h),child: Text("Popular Shops Nearby",
              style:
              TextStyle(fontSize: 15, fontWeight: FontWeight.w600,color: Colors.grey)),),
        ),
        Text("View all",
            style:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w600,color: Colors.grey)),
        SizedBox(width: 10),
        Padding(padding: EdgeInsets.only(right: 40.w,top: 20.h,bottom: 20.h),child: Image.asset(
          'assets/images/appicon_filters.png',
          width: 56.w,
          height: 56.h,
        ),),
      ],
    ));
  }
}
