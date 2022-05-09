import 'dart:convert';
import 'package:code_27/Utils/constants.dart';
import 'package:code_27/Widget/api_calling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/Model/merchant_model.dart';
import 'package:code_27/Widget/main_title_bar.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:code_27/Model/merchant_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class MerchantBookingPage extends StatefulWidget {
  late String merchantId;
  late String itemId;
  late String name;
  late String desc;
  late String price;
  late String photo;

  MerchantBookingPage(
      {required this.merchantId,
      required this.itemId,
      required this.name,
      required this.desc,
      required this.price,
      required this.photo});

  @override
  _MerchantBookingPageState createState() => _MerchantBookingPageState();
}

enum BookingTime { today, nextDay }

class _MerchantBookingPageState extends State<MerchantBookingPage> {
  List<String> listBookingTime = [
    "09:30-10:00",
    "10:00-10:30",
    "10:30-11:00",
    "11:00-11:30",
    "11:30-12:00",
    "12:00-12:30",
    "12:30-13:00",
    "13:00-13:30",
    "13:30-14:00",
    "14:00-14:30",
    "14:30-15:00",
    "15:00-15:30",
    "15:30-16:00",
    "16:00-16:30",
    "16:30-17:00",
    "17:00-17:30",
    "17:30-18:00",
    "18:00-18:30",
    "19:30-19:00",
    "19:00-20:30",
    "20:30-20:00",
    "21:00-21:30",
    "21:30-22:00"
  ];

  int _itemCount = 1;

  String formattedDate = "";
  String formattedTime = "";
  String dropdownValue = '09:30-10:00';

  BookingTime? _days = BookingTime.today;
  TextEditingController _controller = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

  List<MerchantModel> lists = [];
  bool _isLoading = false;
  bool _isError = false;
  bool _isPriceEmpty = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      getCurrentDate();
      getCurrentTime();
      print(widget.desc);
    });

    if(widget.photo.isNotEmpty){
      _isPriceEmpty = true;
    }
    // setState(() {
    //   getdatafromserver();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    width: 1.sw,
                    height: 300.h,
                    color: Colors.blue[300],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MainTitleBar(
                          title: 'Booking',
                          action: () => Navigator.pop(context)),
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.photo,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/merchant_background.jpg',
                          fit: BoxFit.cover,
                          height: 500.h,
                          width: 1.sw,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/merchant_background.jpg',
                          fit: BoxFit.cover,
                          height: 500.h,
                          width: 1.sw,
                        ),
                        height: 500.h,
                        width: 1.sw,
                      ),
                      // Container(
                      //     color: Colors.black,
                      //     height: 500.h,
                      //     width: 1.sw,
                      //     child: Image.asset(
                      //       'assets/images/shop_car_repair.jpg',
                      //       fit: BoxFit.cover,
                      //     )),
                    ],
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.name,
                    style: TextStyle(color: Colors.blue, fontSize: 55.sp),
                  ),
                ),
              ),
              // Expanded(
              //   flex: 20,
              //   child: Text(
              //   widget.desc,
              //   style: TextStyle(color: Colors.grey, fontSize: 40.sp),
              // ),),
              // _isPriceEmpty?Text(widget.price):SizedBox(width: 0,height: 0,),
              Container(
                width: 1.sw,
                margin: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.desc,
                    maxLines: 20,
                    overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.grey, fontSize: 40.sp),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Quantity',
                          style:
                              TextStyle(color: Colors.black, fontSize: 46.sp),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue[200],
                    ),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (_itemCount != 1) {
                                setState(() => _itemCount--);
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 30,
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white),
                          child: Text(
                            _itemCount.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() => _itemCount++);
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Booking time',
                    style: TextStyle(color: Colors.blue, fontSize: 60.sp),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Radio(
                      value: BookingTime.today,
                      groupValue: _days,
                      onChanged: (BookingTime? value) {
                        getCurrentDate();
                        setState(() {
                          _days = value;
                        });
                      },
                    ),
                    Text('Book for today'),
                    Expanded(child: Container()),
                    _days == BookingTime.today
                        ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue.shade200,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.blue.shade200,
                            ),
                            child: DropdownButton<String>(
                              underline: SizedBox(),
                              dropdownColor: Colors.blue.shade200,
                              value: dropdownValue,
                              hint: Text('Select time',style: TextStyle(color: Colors.white),),
                              items: listBookingTime.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: Colors.white),),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                          )
                        // Container(
                        // child: TextButton(
                        //     onPressed: () {
                        //       DatePicker.showTime12hPicker(context,
                        //           showTitleActions: true, onChanged: (date) {
                        //             setState(() {
                        //               formattedTime =
                        //                   DateFormat('kk:mm').format(date);
                        //             });
                        //             print('change $date');
                        //           }, onConfirm: (date) {
                        //             setState(() {
                        //               formattedTime =
                        //                   DateFormat('kk:mm').format(date);
                        //             });
                        //             print('confirm $date');
                        //           },
                        //           currentTime: DateTime.now(),
                        //           locale: LocaleType.en);
                        //     },
                        //     child: Container(
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 30.h, horizontal: 80.w),
                        //       decoration: BoxDecoration(
                        //         border: Border.all(
                        //           color: Colors.blue.shade200,
                        //         ),
                        //         borderRadius:
                        //         BorderRadius.all(Radius.circular(10)),
                        //         color: Colors.blue.shade200,
                        //       ),
                        //       child: Text(
                        //         formattedTime,
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //     )))
                        : Container(),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Radio(
                      value: BookingTime.nextDay,
                      groupValue: _days,
                      onChanged: (BookingTime? value) {
                        setState(() {
                          _days = value;
                        });
                      },
                    ),
                    Text('Book for other day')
                  ],
                ),
              ),
              _days == BookingTime.nextDay
                  ? Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(left: 40.w, right: 40.w),
                      width: 1.sw,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/appicon_booking.png",
                            fit: BoxFit.cover,
                            height: 60.h,
                            width: 60.h,
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2022, 3, 5),
                                      maxTime: DateTime(2040, 6, 7),
                                      onChanged: (date) {
                                    setState(() {
                                      formattedDate =
                                          DateFormat('yyyy-MM-dd').format(date);
                                    });
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    setState(() {
                                      formattedDate =
                                          DateFormat('yyyy-MM-dd').format(date);
                                    });
                                    print('confirm $date');
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.en);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30.h, horizontal: 40.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue.shade200,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.blue.shade200,
                                  ),
                                  child: Text(
                                    formattedDate,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue.shade200,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              color: Colors.blue.shade200,
                            ),
                            child: DropdownButton<String>(
                              underline: SizedBox(),
                              dropdownColor: Colors.blue.shade200,
                              value: dropdownValue,
                              hint: Text('Select time',style: TextStyle(color: Colors.white),),
                              items: listBookingTime.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: Colors.white),),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                          )
                          // Expanded(
                          //     child: TextButton(
                          //         onPressed: () {
                          //           DatePicker.showTime12hPicker(context,
                          //               showTitleActions: true,
                          //               onChanged: (date) {
                          //             setState(() {
                          //               formattedTime =
                          //                   DateFormat('kk:mm').format(date);
                          //             });
                          //             print('change $date');
                          //           }, onConfirm: (date) {
                          //             setState(() {
                          //               formattedTime =
                          //                   DateFormat('kk:mm').format(date);
                          //             });
                          //             print('confirm $date');
                          //           },
                          //               currentTime: DateTime.now(),
                          //               locale: LocaleType.en);
                          //         },
                          //         child: Container(
                          //           padding: EdgeInsets.symmetric(
                          //               vertical: 30.h, horizontal: 80.w),
                          //           decoration: BoxDecoration(
                          //             border: Border.all(
                          //               color: Colors.blue.shade200,
                          //             ),
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(10)),
                          //             color: Colors.blue.shade200,
                          //           ),
                          //           child: Text(
                          //             formattedTime,
                          //             style: TextStyle(color: Colors.white),
                          //           ),
                          //         )))
                        ],
                      ),
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Remark',
                    style: TextStyle(color: Colors.blue, fontSize: 60.sp),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(4),
                child: TextField(
                  controller: _remarkController,
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    hintText: 'Remark',
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    submitBooking();
                    print(widget.merchantId);
                    print(widget.itemId);
                    print(formattedTime);
                    print(formattedDate);
                    print(_itemCount);
                    print(_remarkController.value.text);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue.shade200,
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                      color: Colors.blue.shade200,
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 30.h, horizontal: 80.w),
                    child: Text(
                      'Confirm booking',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  submitBooking() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    if(!_isLogin){
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => LoginPage()));
    }else{
      String token = prefs.getString(Constants.PREF_TOKEN) ?? '';

      print(widget.merchantId);
      print(widget.itemId);
      print(formattedTime);
      print(formattedDate);
      print(_itemCount);
      print(_remarkController.value.text);

      Map<String, String> requestHeaders = {
        'deviceid':
        'cBxBBYu4Qvuklp4ySaPQcx:APA91bFiVRvYNQ3Zpuwmh1I_8d62DRkKWHVwABtZsfs5s92FKRNramHL8rueCUvm4de5J_cO3-fFGZGuAWd72-_EZaqI9HsI7UDWeZL--yZ9uutwGeKQHbPJkvtlfqiS6upVJFIxjKJJ',
        'Authorization': 'Bearer $token'
      };

      Map<String, String> arg = {
        // 'action': widget.id,
        // 'action': widget.id,
        // 'order_id': widget.id,
      };

      if (_days == BookingTime.today) {
        arg['timeslot'] = dropdownValue;
      } else {
        arg['timeslot'] = dropdownValue;
        arg['preorder_date'] = formattedDate;
      }
      arg['remark'] = _remarkController.value.text;

      var responseData = await ApiCall().post(
          arg: arg,
          method: Constants.NETWORK_CHECKOUT_CART,
          header: requestHeaders);

      print(responseData);

    }

  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getCurrentDate() {
    DateTime selectedDate = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    formattedTime = DateFormat('kk:mm').format(selectedDate);
    return formattedDate;
  }

  getCurrentTime() {
    DateTime selectedDate = DateTime.now();
    formattedTime = DateFormat('kk:mm').format(selectedDate);
    return formattedTime;
  }
}
