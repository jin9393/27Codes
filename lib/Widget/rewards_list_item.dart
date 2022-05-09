import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_27/Model/reward_model.dart';
import 'package:code_27/Widget/merchant_category_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RewardsListItem extends StatelessWidget {
  late RewardModel data;

  RewardsListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(4),
                  height: 180.h,
                  width: 180.w,
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: 160.h,
                  width: 160.w,
                  fit: BoxFit.cover,
                  imageUrl: data.logo,
                  placeholder: (context, url) =>
                      Image.asset(
                        'assets/images/appicon.png',
                      ),
                  errorWidget: (context, url, error) =>
                      Image.asset(
                        'assets/images/appicon.png',
                      ),
                ),
              ),),
          ),
          Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: TextStyle(fontSize: 36.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    data.points != 0.00
                        ? Text(
                      "You have received " + data.points + " points.",
                      style: TextStyle(fontSize: 32.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                        : Text(
                      "You have used " + data.deductPoints + " points.",
                      style: TextStyle(fontSize: 32.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data.date,
                      style: TextStyle(fontSize: 30.sp, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )),
          data.points != 0.00
              ? Expanded(
            flex: 1,
            child: Text(
              ' +' + data.points,
              style: TextStyle(
                  fontSize: 46.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          )
              : Expanded(
            flex: 1,
            child: Text(
              ' -' + data.deductPoints,
              style: TextStyle(
                  fontSize: 46.sp,
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
