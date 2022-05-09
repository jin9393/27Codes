import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardsBalanceBar extends StatelessWidget {

  late String accPoints;

  RewardsBalanceBar({required this.accPoints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Container(
        height: 110.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Current Balance: ",
                style: TextStyle(fontSize: 40.sp),
                overflow: TextOverflow.visible,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      child: GestureDetector(
                          child: Image.asset(
                            'assets/images/appicon_27thcoin.png',
                            width: 25,
                            height: 25,
                          )),
                      margin: EdgeInsets.only(right: 5)),
                  Container(
                    child: Text(
                      accPoints,
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    margin: EdgeInsets.only(right: 8),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
