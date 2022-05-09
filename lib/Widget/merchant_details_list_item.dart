import 'package:code_27/Model/merchant_details_model.dart';
import 'merchant_details_per_item_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MerchantDetailsListItem extends StatelessWidget {
  late MerchantDetails data;

  MerchantDetailsListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.title,
                style: TextStyle(color: Colors.blue[200], fontSize: 60.sp),
              ),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.lists.length,
            itemBuilder: (BuildContext context, int index) {
              MerchantDetailsModel merchant = data.lists[index];
              return MerchantDetailsPerItemList(data: merchant,merchantId: data.id,);
            },
          ),
        ],
      ),
    );
  }
}
