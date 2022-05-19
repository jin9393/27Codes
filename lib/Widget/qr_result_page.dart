import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/Model/merchant_model.dart';
import 'package:code_27/Widget/main_title_bar.dart';
import 'package:code_27/Model/qr_scan_result_model.dart';
import 'package:code_27/Model/get_qr_details_model.dart';
import 'qr_result_without_image.dart';
import 'qr_result_with_image.dart';
import 'package:code_27/Widget/api_calling.dart';
import 'package:code_27/Utils/constants.dart';

class QrResultPage extends StatefulWidget {
  final QrResult data;

  const QrResultPage({required this.data}) : super();

  @override
  _QrResultPageState createState() => _QrResultPageState();
}

enum PaymentType { cashPayment, cc }

class _QrResultPageState extends State<QrResultPage> {

  late GetQrDetailsModel returnData;
  PaymentType? _paymentType = PaymentType.cashPayment;
  String _redeemPoint = 'false';
  bool _isLoading = false;
  bool _isError = false;
  late Future<dynamic> futureVariable;


  @override
  void initState() {
    super.initState();

    returnData = new GetQrDetailsModel();
    futureVariable = getDataFromServer('32NcrJEk25jxLELHtIMhfZ3esWIf4KEIevqTDepVLfYCRrG7tIhfmh9pWiWzBhgx6nvIVNGj7St8PJJP');
    // setState(() {
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            snapshot.hasData == null) {
          return Scaffold(
            body: SafeArea(
              child: SizedBox.expand(
                child: Container(
                  height: 1.sw,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 1.sw,
                              height: 150.h,
                              color: Colors.blue[300],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MainTitleBar(
                                    title: 'Payment',
                                    action: () => Navigator.pop(context)),
                              ],
                            ),
                          ],
                        ),
                        QrResultWithoutImage(text: ''),
                        QrResultWithImage(
                          description: 'Amount',
                          data: '',
                          image: "assets/images/appicon_27thcoin_blue.png",
                        ),
                        QrResultWithImage(
                          description: 'Date',
                          data: '',
                          image: "assets/images/appicon_booking.png",
                        ),
                        QrResultWithImage(
                          description: 'Order number',
                          data: '',
                          image: "assets/images/appicon_stall.png",
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 60.w, top: 30.h),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Payment Selection',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text('Submit Payment'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
            body: SafeArea(
                child: SizedBox.expand(
                  child: Container(
                    height: 1.sw,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 1.sw,
                                height: 150.h,
                                color: Colors.blue[300],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MainTitleBar(
                                      title: 'Payment',
                                      action: () => Navigator.pop(context)),
                                ],
                              ),
                            ],
                          ),
                          QrResultWithoutImage(text: returnData!.from),
                          QrResultWithImage(
                            description: 'Amount',
                            data: returnData!.voucher_amount,
                            image: "assets/images/appicon_27thcoin_blue.png",
                          ),
                          QrResultWithImage(
                            description: 'Date',
                            data: returnData!.created_date,
                            image: "assets/images/appicon_booking.png",
                          ),
                          QrResultWithImage(
                            description: 'Order number',
                            data: returnData!.id,
                            image: "assets/images/appicon_stall.png",
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(14)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 60.w, top: 30.h),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Payment Selection',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    '100% cash payment',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  subtitle: Text(
                                    '+100 cc points',
                                    style: TextStyle(color: Colors.orangeAccent),
                                  ),
                                  leading: Radio(
                                    value: PaymentType.cashPayment,
                                    groupValue: _paymentType,
                                    onChanged: (PaymentType? value) {
                                      setState(() {
                                        _paymentType = value;
                                      });
                                    },
                                  ),
                                ),
                                _redeemPoint == 'true'
                                    ? ListTile(
                                  title: Text(
                                    'Pay with 20% cc',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  subtitle: Text(
                                    '-20 CC points',
                                    style: TextStyle(color: Colors.orangeAccent),
                                  ),
                                  leading: Radio(
                                    value: PaymentType.cc,
                                    groupValue: _paymentType,
                                    onChanged: (PaymentType? value) {
                                      setState(() {
                                        _paymentType = value;
                                      });
                                    },
                                  ),
                                )
                                    : Container()
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.pop(context, true);
                              setState(() {
                                showLoaderDialog(context);
                                if(_paymentType == PaymentType.cashPayment){
                                  submitPayment('add_point');
                                }else{
                                  submitPayment('deduct_point');
                                }
                              });


                            },
                            child: Text('Submit Payment'),
                          ),

                        ],
                      ),
                    ),
                  ),
                )));
      },
      future: futureVariable,
    );
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  submitPayment(String paymentType) async{
    _isLoading = true;

    Map<String, String> requestHeaders = {

    };

    Map<String, String> arg = {
      'action': paymentType,
      'order_id': widget.data.orderId
    };

    var responseData = await ApiCall().post(
        arg: arg,
        method: Constants.NETWORK_STORE_POINT,
        header: requestHeaders);
    print(responseData.message);
    print(responseData);

    if(responseData.code == 200){
      Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            responseData.message),
      ));
    }
    Navigator.pop(context);
    _isLoading = false;
  }

  Future getDataFromServer(String token) async {


    Map<String, String> requestHeaders = {

    };

    var responseData = await ApiCall().get(
        arg: requestHeaders,
        method: Constants.NETWORK_GET_QR_ORDER_DETAILS + widget.data.orderId,
        header: requestHeaders);
    print(responseData.message);
    print(responseData);
    List<Merchant> merchants = [];

    if (responseData.code == 200) {
      GetQrDetailsModel model =
      GetQrDetailsModel.fromJson(responseData.data['order']);
      returnData = model;
      _redeemPoint = model.use_point;
      print(_redeemPoint);
      //   hmmm.data['sections'].forEach((mer) {
      //     mer['restorants'].forEach((res) {
      //       lists.add(MerchantModel.fromJson(res));
      //     });
      //     merchants.add(Merchant.fromJson(mer, lists));
      //   });
      //   _isLoading = false;
      //   _isError =false;
      //   // Iterable l = json.decode(hmmm.data['sections']['restorants']);
      //   // List<MerchantModel> posts =
      //   print(merchants);
      // } else {
      //   _isLoading = false;
      //   _isError =true;
      //   print('error');
      // }
      _isLoading = false;
      return returnData;
    }
  }
}
