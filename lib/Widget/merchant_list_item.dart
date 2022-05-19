import 'package:code_27/Model/merchant_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_27/Widget/merchant_category_grid.dart';
import 'package:code_27/Widget/merchant_details_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/Model/merchant_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MerchantListItem extends StatelessWidget {
  late MerchantModel data;

  MerchantListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => MerchantDetailsPage(data: data,))),
      child: Container(
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
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(2),
                height: 170.h,
                width: 190.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    height: 170.h,
                    width: 190.w,
                    fit: BoxFit.cover,
                    imageUrl: data.picture,
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
                      style: TextStyle(color: Colors.blue.shade400, fontSize: 45.sp),
                    ),
                        SizedBox(height: 5.h,),
                    Text(
                      data.address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 30.sp,
                          color: Colors.black
                      ),
                    ),

                    // RatingBar.builder(
                    //   ignoreGestures: true,
                    //   itemSize: 13,
                    //   initialRating: 3,
                    //   minRating: 1,
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: false,
                    //   itemCount: 5,
                    //   itemBuilder: (context, _) => Icon(
                    //     Icons.star,
                    //     color: Colors.amber,
                    //   ),
                    //   onRatingUpdate: (rating) {
                    //     print(rating);
                    //   },
                    // ),
                        SizedBox(height: 5.h,),
                        Text(
                          data.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.grey.shade700
                          ),
                        ),
                  ])),
              SizedBox(
                width: 20.w,
              ),
              Container(
                child: Image.asset(
                  'assets/images/appicon_click_next.png',
                  height: 70.h,
                  width: 30.w,
                ),
              ),
              // CachedNetworkImage(imageUrl: data.picture,placeholder: (context,url) =>  Image.asset('assets/images/appicon_click_next.png',height: 70.h,width: 30.w,),width: 30.w,height: 70.h,),
              SizedBox(
                width: 20.w,
              ),
              // Column(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(left: 3),
              //       height: 100.h,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(10)),
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey.withOpacity(0.5),
              //             spreadRadius: 2,
              //             blurRadius: 5,
              //             offset: Offset(0, 3), // changes position of shadow
              //           ),
              //         ],
              //       ),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           SizedBox(
              //             width: 6.w,
              //           ),
              //           Image.asset(
              //             'assets/images/appicon_rewards_xs.png',
              //             width: 80.w,
              //             height: 80.h,
              //           ),
              //           SizedBox(
              //             width: 10.w,
              //           ),
              //           Expanded(child: Text(
              //             "Earn Rate x 1",
              //             textAlign: TextAlign.center,
              //             style: TextStyle(fontSize: 30.sp,color: Colors.blue[700]),
              //           ),)
              //         ],
              //       ),
              //     ),
              //     SizedBox(
              //       height: 19.h,
              //     ),
              //     Container(
              //         margin: EdgeInsets.only(left: 3),
              //         height: 100.h,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.all(Radius.circular(10)),
              //           color: Colors.white,
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey.withOpacity(0.5),
              //               spreadRadius: 2,
              //               blurRadius: 5,
              //               offset: Offset(0, 3), // changes position of shadow
              //             ),
              //           ],
              //         ),
              //         child: Row(
              //           children: [
              //             SizedBox(
              //               width: 6.w,
              //             ),
              //             Image.asset(
              //               'assets/images/appicon_27thcoin.png',
              //               width: 80.w,
              //               height: 80.h,
              //             ),
              //             SizedBox(
              //               width: 10.w,
              //             ),
              //            Expanded(child:  Column(
              //              mainAxisAlignment: MainAxisAlignment.center,
              //              crossAxisAlignment: CrossAxisAlignment.center,
              //              children: [
              //                Text(
              //                  "Redeem Rm 1",
              //                  style: TextStyle(fontSize: 30.sp,color: Colors.blue[700]),
              //                  maxLines: 1,
              //                  overflow: TextOverflow.ellipsis,
              //                ),
              //                Text(
              //                  "Min Spend Rm 50",
              //                  style: TextStyle(fontSize: 28.sp,color: Colors.blue[700]),
              //                  maxLines: 1,
              //                  overflow: TextOverflow.ellipsis,
              //                ),
              //              ],
              //            ))
              //           ],
              //         ))
              //   ],)
            ],
          ),
        ),
      ),
    );
  }
}
