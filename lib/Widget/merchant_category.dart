import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_27/Widget/merchant_category_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MerchantCategory extends StatelessWidget {
  const MerchantCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: IntrinsicHeight(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  MerchantCategoryGrid(
                    data: "F&B",
                    image: 'assets/images/appicon_f&b.png',
                    maxLine: 1,
                    fSize: 12,
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Auto",
                    image: 'assets/images/appicon_auto.png',
                    maxLine: 1,
                    fSize: 12,
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Wellness",
                    image: 'assets/images/appicon_wellness.png',
                    maxLine: 1,
                    fSize: 12,
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Leisure",
                    image: 'assets/images/appicon_leisure.png',
                    maxLine: 1,
                    fSize: 12,
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Fashion",
                    image: 'assets/images/appicon_fashion.png',
                    maxLine: 1,
                    fSize: 12,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  MerchantCategoryGrid(
                    data: "IT",
                    image: 'assets/images/appicon_IT-2.png',
                    maxLine: 1,
                    fSize: 12,
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Grocery",
                    image: 'assets/images/appicon_grocery.png',
                    maxLine: 1,
                    fSize: 12,
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Stalls",
                    image: 'assets/images/appicon_stall.png',
                    maxLine: 1,
                    fSize: 12,
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Service",
                    image: 'assets/images/appicon_services.png',
                    maxLine: 1,
                    fSize: 12,
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Others",
                    image: 'assets/images/appicon_others.png',
                    maxLine: 1,
                    fSize: 12,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
