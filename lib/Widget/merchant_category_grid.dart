import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MerchantCategoryGrid extends StatelessWidget {

  late String data;
  late String image;
  late int maxLine;
  late double fSize;

  MerchantCategoryGrid({required this.data, required this.image, required this.maxLine, required this.fSize});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.tight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRect(
              child: Image.asset(
                image,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.fitWidth,
              ),
            ),
            Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(data,
                      style: TextStyle(
                        fontSize: fSize,
                        color: Colors.black,
                      ),
                      softWrap: false,
                      maxLines: maxLine,
                      overflow: TextOverflow.ellipsis),
                ))
          ],
        ));
  }
}
