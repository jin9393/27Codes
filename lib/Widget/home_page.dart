import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:code_27/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/Widget/api_calling.dart';
import 'package:code_27/Widget/merchant_list_item.dart';
import 'package:code_27/Model/merchant_model.dart';
import 'package:code_27/Utils/constants.dart';
import 'package:code_27/Widget/login_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}
// TopBar();

class _HomePageState extends State<HomePage> {
  List<String> imgList = [];

  int _current = 0;
  final CarouselController _carouselController = CarouselController();
  late Future<List<MerchantModel>> _tasks;
  List<MerchantModel> lists = [];
  late SharedPreferences prefs;

  bool _isLoading = false;
  bool _isError = false;
  bool _isLogin = false;
  String name = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks = getdatafromserver();
    });
  }

  // Widget buildStuff(){
  //   return FutureBuilder<List<ObjectClass>>(
  //     future: fetchJson(), // api call method here, to fetch json/data
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return Container(); // widget to be shown on any error
  //       }
  //
  //       return snapshot.hasData
  //           ? _bodyBuild(data: snapshot.data)
  //           : Text("Loading"); // widget to be shown while data is being loaded from api call method
  //     },
  //   );
  // }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            snapshot.hasData == null) {
          return SizedBox.expand(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 250.h,
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 55.h),
                        //   child: Text(
                        //     "27th Codes",
                        //     style: TextStyle(color: Colors.white, fontSize: 20),
                        //   ),
                        // ),
                        Image.asset(
                          'assets/images/logo_27_long_white.png',
                          width: 600.w,
                          height: 180.h,
                          fit: BoxFit.fitWidth,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 130.h),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  margin: EdgeInsets.all(15),
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  height: 130.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Row(
                                            children: [
                                              Container(
                                                  child: GestureDetector(
                                                      child: Image.asset(
                                                    'assets/images/appicon_profile.png',
                                                    width: 80.w,
                                                    height: 80.h,
                                                  )),
                                                  margin: EdgeInsets.only(
                                                      left: 10)),
                                              _isLogin
                                                  ? Flexible(
                                                      child: Container(
                                                          child: Text(
                                                            name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 8)))
                                                  : Flexible(
                                                      child: Container(
                                                          child: Text(
                                                            name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 8)))
                                            ],
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                  child: GestureDetector(
                                                      child: Image.asset(
                                                    'assets/images/appicon_27thcoin.png',
                                                    width: 55.w,
                                                    height: 55.h,
                                                  )),
                                                  margin: EdgeInsets.only(
                                                      right: 5)),
                                              Container(
                                                child: Text(
                                                  "0",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                margin:
                                                    EdgeInsets.only(right: 8),
                                                alignment:
                                                    Alignment.centerRight,
                                              ),
                                            ],
                                          ))
                                    ],
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 40.w),
                        child: Text(
                          "What's new",
                          style: TextStyle(
                              fontSize: 50.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 0.9.sw,
                      height: 400.h,
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
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 360.h,
                          autoPlay: true,
                        ),
                        items: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/car_stock_1.jpg',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: 360.w,
                            height: 360.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/car_stock_2.jpg',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: 360.w,
                            height: 360.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/car_stock_4.jpg',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: 360.w,
                            height: 360.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/car_stock_5.jpg',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: 360.w,
                            height: 360.h,
                          ),
                        ],
                      ),
                      // child: ListView(
                      //   scrollDirection: Axis.horizontal,
                      //   children: [
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //             image: AssetImage(
                      //               'assets/images/car_stock_1.jpg',
                      //             ),
                      //             fit: BoxFit.cover),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(14)),
                      //       ),
                      //       margin: EdgeInsets.symmetric(horizontal: 20.w),
                      //       width: 360.w,
                      //       height: 360.h,
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //             image: AssetImage(
                      //               'assets/images/car_stock_2.jpg',
                      //             ),
                      //             fit: BoxFit.cover),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(14)),
                      //       ),
                      //       margin: EdgeInsets.symmetric(horizontal: 20.w),
                      //       width: 360.w,
                      //       height: 360.h,
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //             image: AssetImage(
                      //               'assets/images/car_stock_4.jpg',
                      //             ),
                      //             fit: BoxFit.cover),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(14)),
                      //       ),
                      //       margin: EdgeInsets.symmetric(horizontal: 20.w),
                      //       width: 360.w,
                      //       height: 360.h,
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //             image: AssetImage(
                      //               'assets/images/car_stock_5.jpg',
                      //             ),
                      //             fit: BoxFit.cover),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(14)),
                      //       ),
                      //       margin: EdgeInsets.symmetric(horizontal: 20.w),
                      //       width: 360.w,
                      //       height: 360.h,
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //             image: AssetImage(
                      //               'assets/images/car_stock_6.jpg',
                      //             ),
                      //             fit: BoxFit.cover),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(14)),
                      //       ),
                      //       margin: EdgeInsets.symmetric(horizontal: 20.w),
                      //       width: 360.w,
                      //       height: 360.h,
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //             image: AssetImage(
                      //               'assets/images/car_stock_7.jpg',
                      //             ),
                      //             fit: BoxFit.cover),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(14)),
                      //       ),
                      //       margin: EdgeInsets.symmetric(horizontal: 20.w),
                      //       width: 360.w,
                      //       height: 360.h,
                      //     ),
                      //   ],
                      // )
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 40.w, top: 20.h),
                        child: Text(
                          "Popular merchant",
                          style: TextStyle(
                              fontSize: 50.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox.expand(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 250.h,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 55.h),
                      //   child: Text(
                      //     "27th Codes",
                      //     style: TextStyle(color: Colors.white, fontSize: 20),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Image.asset(
                          'assets/images/logo_27_long_trans.png',
                          width: 600.w,
                          height: 160.h,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 130.h),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                margin: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width * 0.90,
                                height: 130.h,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: Row(
                                          children: [
                                            Container(
                                                child: GestureDetector(
                                                    child: Image.asset(
                                                  'assets/images/appicon_profile.png',
                                                  width: 80.w,
                                                  height: 80.h,
                                                )),
                                                margin:
                                                    EdgeInsets.only(left: 10)),
                                            _isLogin
                                                ? Flexible(
                                                    child: Container(
                                                        child: Text(
                                                          prefs.getString(Constants
                                                                  .PREF_NAME) ??
                                                              '',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            left: 8)))
                                                : Flexible(
                                                    child: Container(
                                                        child: const Text(
                                                          "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            left: 8)))
                                          ],
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                                child: GestureDetector(
                                                    child: Image.asset(
                                                  'assets/images/appicon_27thcoin.png',
                                                  width: 70.w,
                                                  height: 70.h,
                                                )),
                                                margin:
                                                    EdgeInsets.only(right: 5)),
                                            Container(
                                              child: Text(
                                                "0",
                                                style: TextStyle(color: Colors.blueAccent, fontSize: 46.sp),
                                              ),
                                              margin: EdgeInsets.only(right: 40.w),
                                              alignment: Alignment.centerRight,
                                            ),
                                          ],
                                        ))
                                  ],
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 40.w),
                      child: Text(
                        "What's new",
                        style: TextStyle(
                            fontSize: 50.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 0.95.sw,
                    height: 460.h,
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
                        CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                              height: 355.h,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 10),
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }
                              // enlargeCenterPage: true,
                              ),
                          items: imgList
                              .map((item) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(14)),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                            imageUrl: item,
                                            fit: BoxFit.cover,
                                            width: 1.sw)),
                                  ))
                              .toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () =>
                                  _carouselController.animateToPage(entry.key),
                              child: Container(
                                width: 16.w,
                                height: 16.h,
                                margin: EdgeInsets.symmetric(
                                    vertical: 14.h, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.grey)
                                        .withOpacity(
                                            _current == entry.key ? 0.9 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 40.w, top: 20.h),
                      child: Text(
                        "Popular merchant",
                        style: TextStyle(
                            fontSize: 50.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : _isError
                          ? Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text('No internet connection'),
                              ),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: lists.length,
                              itemBuilder: (BuildContext context, int index) {
                                MerchantModel merchant = lists[index];
                                return MerchantListItem(data: merchant);
                              },
                            )
                ],
              ),
            ),
          ),
        );
      },
      future: _tasks,
    );
  }

  Future<List<MerchantModel>> getdatafromserver() async {
    _isLoading = true;
    prefs = await SharedPreferences.getInstance();
    lists = [];

    name = prefs.getString(Constants.PREF_NAME) ?? '';
    _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    Map<String, String> requestHeaders = {
    };

    var returnData = await ApiCall().get(
        arg: requestHeaders,
        method: Constants.NETWORK_GET_VENDOR_LIST,
        header: requestHeaders,
        context: context);

    List<Merchant> merchants = [];

    if (returnData.code == 200) {

      returnData.data['sections'].forEach((mer) {
        mer['restorants'].forEach((res) {
          lists.add(MerchantModel.fromJson(res));
          imgList.add(res['picture']);
        });
        merchants.add(Merchant.fromJson(mer, lists));
      });
      _isLoading = false;
      _isError = false;
      // Iterable l = json.decode(hmmm.data['sections']['restorants']);
      // List<MerchantModel> posts =
    } else {
      _isLoading = false;
      _isError = true;
    }

    return lists;
  }
}
