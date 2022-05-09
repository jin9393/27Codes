import 'package:code_27/Model/merchant_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/Widget/merchant_booking_page.dart';

class MerchantDetailsPerItemList extends StatelessWidget {

  late MerchantDetailsModel data;
  late String merchantId;

  MerchantDetailsPerItemList({required this.data,required this.merchantId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => MerchantBookingPage(
            merchantId: merchantId,
            itemId: data.id,
            name: data.name,
            desc: data.desc,
            photo : data.picture,
            price : data.price,
          ),
        ));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(10),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: data.picture,
              placeholder: (context, url) => Image.asset(
                'assets/images/appicon.png',
                height: 170.h,
                width: 190.w,
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/appicon.png',
                height: 170.h,
                width: 190.w,
              ),
              height: 170.h,
              width: 190.w,
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    data.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Text(
                    data.desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ])),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
