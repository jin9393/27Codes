import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'merchant_details_toolbar_item.dart';
import 'merchant_middle_toolbar.dart';
import 'merchant_middle_double_toolbar.dart';
import 'merchant_opening_hour_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/Widget/merchant_booking_page.dart';
import 'package:code_27/Widget/merchant_rating_page.dart';
import 'package:code_27/Model/merchant_model.dart';
import 'package:code_27/Model/working_hour_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:code_27/Utils/constants.dart';
import 'api_calling.dart';
import 'package:code_27/Model/merchant_details_model.dart';
import 'merchant_details_list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class MerchantDetailsPage extends StatefulWidget {
  late MerchantModel data;

  MerchantDetailsPage({required this.data});

  @override
  _MerchantDetailsState createState() => _MerchantDetailsState();
}

class _MerchantDetailsState extends State<MerchantDetailsPage> {
  //Create list
  Map<String, String> socialList = Map();
  Map<String, String> openingList = Map();
  Map<String, String> closingList = Map();
  String coverImage = '';
  String openTime = '';
  String closeTime = '';
  String desc = '';
  late Future<List<MerchantDetails>> _tasks;
  List<MerchantDetailsModel> itemLists = [];
  List<WorkingHour> openingHourLists = [];
  List<MerchantDetails> merchants = [];
  bool _isLoading = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks = getdatafromserver();
    });
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
                  color: Colors.white,
                  child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 1.sw,
                                height: 0.25.sh,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(""),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0.21.sh),
                                height: 90.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child:
                                    Icon(Icons.arrow_back, color: Colors.white),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  primary: Colors.black45, // <-- Button color
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            height: 240.h,
                            width: 1.sw,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.data.name,
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontSize: 50.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(height: 10.h),
                                Text('Open right now',
                                    style: TextStyle(color: Colors.lightBlue)),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 1.sw,
                                  child: Text(
                                    widget.data.address,
                                    overflow: TextOverflow.visible,
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        MerchantRatingPage(data: widget.data))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30.w,
                                ),
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  itemSize: 16,
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "(100 reviews)",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Container(
                            height: 200.h,
                            color: Colors.grey[200],
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                MerchantToolbarItem(
                                  data: 'Call',
                                  image: 'assets/images/appicon_callshop.png',
                                  nextPage: widget.data.phone,
                                  onTap: () {},
                                ),
                                MerchantToolbarItem(
                                  data: 'Social Media',
                                  image: 'assets/images/appicon_likes.png',
                                  nextPage: '',
                                  onTap: () {
                                    setupAlertDialoadContainer(socialList);
                                  },
                                ),
                                MerchantToolbarItem(
                                  data: 'Direction',
                                  image: 'assets/images/appicon_direction.png',
                                  nextPage: '',
                                  onTap: () {},
                                ),
                                MerchantToolbarItem(
                                  data: 'Booking',
                                  image: 'assets/images/appicon_booking.png',
                                  nextPage: MerchantBookingPage(
                                    merchantId: widget.data.id,
                                    itemId: '0',
                                    name: widget.data.name,
                                    desc: widget.data.address,
                                    photo: widget.data.picture,
                                    price: '',
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Container(
                              width: 1.sw,
                              padding:
                                  EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 20.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Opening Time & Closing Time',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 45.sp)),
                                  ),
                                  SizedBox(height: 40.h),
                                  Container(
                                    height: 150.h,
                                    width: 0.95.sw,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Stack(
                                          children: [
                                            MerchantOpeningHourText(
                                              data: 'OPEN',
                                              textColor: Colors.white,
                                              boxColor: Colors.green[900],
                                              fontWeight: FontWeight.bold,
                                              marginLeft: 0.sw,
                                              borderCircular:
                                                  Radius.circular(0),
                                              onTap: () {},
                                            ),
                                            MerchantOpeningHourText(
                                              data: '10:00 am',
                                              textColor: Colors.green[900],
                                              boxColor: Colors.green[600],
                                              fontWeight: FontWeight.bold,
                                              marginLeft: 0.20.sw,
                                              borderCircular:
                                                  Radius.circular(8),
                                              onTap: () {},
                                            ),
                                            MerchantOpeningHourText(
                                              data: 'CLOSE',
                                              textColor: Colors.white,
                                              boxColor: Colors.grey[800],
                                              fontWeight: FontWeight.bold,
                                              marginLeft: 0.48.sw,
                                              borderCircular:
                                                  Radius.circular(0),
                                              onTap: () {},
                                            ),
                                            MerchantOpeningHourText(
                                              data: '10.00 pm',
                                              textColor: Colors.grey[800],
                                              boxColor: Colors.grey[400],
                                              fontWeight: FontWeight.bold,
                                              marginLeft: 0.68.sw,
                                              borderCircular:
                                                  Radius.circular(8),
                                              onTap: () {},
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 20.w),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )),
                ),
              ),
            ));
          }
          return Scaffold(
              body: SafeArea(
            child: SizedBox.expand(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: coverImage,
                              placeholder: (context, url) => Image.asset(
                                'assets/images/merchant_background.jpg',
                                fit: BoxFit.cover,
                                width: 1.sw,
                                height: 0.25.sh,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/merchant_background.jpg',
                                fit: BoxFit.cover,
                                width: 1.sw,
                                height: 0.25.sh,
                              ),
                              width: 1.sw,
                              height: 0.25.sh,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0.21.sh),
                              height: 90.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                color: Colors.white,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child:
                                  Icon(Icons.arrow_back, color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                primary: Colors.black45, // <-- Button color
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          height: 240.h,
                          width: 1.sw,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.data.name,
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10.h),
                              Text('Open right now',
                                  style: TextStyle(color: Colors.lightBlue)),
                              SizedBox(height: 10.h),
                              Container(
                                width: 1.sw,
                                child: Text(
                                  widget.data.address,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      MerchantRatingPage(data: widget.data))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30.w,
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 16,
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "(100 reviews)",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          height: 200.h,
                          color: Colors.grey[200],
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              MerchantToolbarItem(
                                data: 'Call',
                                image: 'assets/images/appicon_callshop.png',
                                nextPage: widget.data.phone,
                                onTap: () {},
                              ),
                              MerchantToolbarItem(
                                  data: 'Social Media',
                                  image: 'assets/images/appicon_likes.png',
                                  nextPage: socialList,
                                  onTap: () {
                                    setupAlertDialoadContainer(socialList);
                                  }),
                              MerchantToolbarItem(
                                data: 'Direction',
                                image: 'assets/images/appicon_direction.png',
                                nextPage: widget.data,
                                onTap: () {},
                              ),
                              MerchantToolbarItem(
                                data: 'Booking',
                                image: 'assets/images/appicon_booking.png',
                                nextPage: MerchantBookingPage(
                                  merchantId: widget.data.id,
                                  itemId: '0',
                                  name: widget.data.name,
                                  desc: desc,
                                  photo: widget.data.picture,
                                  price: '',
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                            width: 1.sw,
                            padding:
                                EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 20.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Opening Time & Closing Time',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 45.sp)),
                                ),
                                SizedBox(height: 40.h),
                                Container(
                                  height: 150.h,
                                  width: 0.95.sw,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Stack(
                                        children: [
                                          MerchantOpeningHourText(
                                            data: 'OPEN',
                                            textColor: Colors.white,
                                            boxColor: Colors.green[900],
                                            fontWeight: FontWeight.bold,
                                            marginLeft: 0.sw,
                                            borderCircular: Radius.circular(0),
                                            onTap: () {setUpWorkingHourDialog(openingHourLists, true);},
                                          ),
                                          MerchantOpeningHourText(
                                            data: openTime,
                                            textColor: Colors.green[900],
                                            boxColor: Colors.green[600],
                                            fontWeight: FontWeight.bold,
                                            marginLeft: 0.20.sw,
                                            borderCircular: Radius.circular(8),
                                            onTap: () {setUpWorkingHourDialog(openingHourLists, true);},
                                          ),
                                          MerchantOpeningHourText(
                                            data: 'CLOSE',
                                            textColor: Colors.white,
                                            boxColor: Colors.grey[800],
                                            fontWeight: FontWeight.bold,
                                            marginLeft: 0.48.sw,
                                            borderCircular: Radius.circular(0),
                                            onTap: () {setUpWorkingHourDialog(openingHourLists, false);},
                                          ),
                                          MerchantOpeningHourText(
                                            data: closeTime,
                                            textColor: Colors.grey[800],
                                            boxColor: Colors.grey[400],
                                            fontWeight: FontWeight.bold,
                                            marginLeft: 0.68.sw,
                                            borderCircular: Radius.circular(8),
                                            onTap: () {setUpWorkingHourDialog(openingHourLists, false);},
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 20.w),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        _isLoading
                            ? CircularProgressIndicator()
                            : _isError
                                ? Dialog(
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text('No item at the moment'),
                                    ),
                                  )
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: merchants.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      MerchantDetails merchant =
                                          merchants[index];
                                      return MerchantDetailsListItem(
                                          data: merchant);
                                    },
                                  ),
                      ],
                    )),
              ),
            ),
          ));
        },
        future: _tasks);
  }

  Future<List<MerchantDetails>> getdatafromserver() async {
    itemLists = [];

    if (!_isLoading) {
      _isLoading = true;
      Map<String, String> requestHeaders = {
        'deviceid':
            'fxxYlHr9QNGnr-0W_3eifh:APA91bFWMiy8rRWPEZESx_1tfHhvmIrcqBEKuakLPoRt4tAAP9wiJCLFuXOJsST9dp3hNJ_h8iuwJWDDWAilRaBYW8gF-DmWI1C4vB89ux9Q-ThbG_Elp7qzxpZ_sh-tOJAkFK62KBOR',
        'appkey': 'fUPvZAmZnIArSZl9TauXbtVyTJHEaik6gju4qWDU',
        'Authorization': 'Bearer'
      };

      var responseData = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_VENDOR_ITEMS(widget.data.id),
          header: requestHeaders);

      merchants = [];
      if (responseData.code == 200) {
        dynamic dataFood = responseData.data['foodcourt'];
        dynamic dataRes = dataFood['restorant'];

        coverImage = dataRes['cover'];
        openTime = trim(true, dataRes['working_hour']);
        closeTime = trim(false, dataRes['working_hour']);
        desc = dataRes['description'];

        if (dataRes['facebook'].toString().isNotEmpty && dataRes['facebook'] != null) {
          // socialList['facebook'] = dataRes['facebook'];
          socialList['facebook'] = 'https://www.facebook.com/paultanautonews';
        }
        if (dataRes['instagram'] != '' && dataRes['instagram'] != null) {
          // socialList['instagram'] = dataRes['instagram'];
          socialList['instagram'] = 'https://www.instagram.com/paultancars/';
        }

        //Disable when social media is back up
        socialList['facebook'] = 'https://www.facebook.com/paultanautonews';
        socialList['instagram'] = 'https://www.instagram.com/paultancars/';

        dataRes['categories'].forEach((mer) {
          mer['items'].forEach((res) {
            itemLists.add(MerchantDetailsModel.fromJson(res));
          });
          merchants.add(MerchantDetails.fromJson(dataRes, itemLists));
          itemLists = [];
        });

        dataRes['time_list'].forEach((work) {
          openingHourLists.add(WorkingHour.fromJson(work));
        });

        _isLoading = false;
        _isError = false;
        // Iterable l = json.decode(hmmm.data['sections']['restorants']);
        // List<MerchantModel> posts =
      } else {
        _isLoading = false;
        _isError = true;
      }

      setState(() {
        itemLists = itemLists;
      });

      _isLoading = false;
    }

    return merchants;
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  setUpWorkingHourDialog(List<WorkingHour> openingHourLists, bool isOpen) {
    String selected = '';
    if(isOpen){
      selected = 'Opening hour';
    }else{
      selected = 'Closing hour';
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(selected),
            content: isOpen?ListView.builder(
              shrinkWrap: true,
              itemCount: openingHourLists.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(openingHourLists[index].day + '  -  ' +openingHourLists[index].open);
              },
            ):ListView.builder(
              shrinkWrap: true,
              itemCount: openingHourLists.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(openingHourLists[index].day + '  -  ' +openingHourLists[index].closing);
              },
            ),
          );
          // return SimpleDialog(
          //   title: Text(selected),
          //   children: [
              // isOpen
              //     ? ListTile(
              //     title: Text(openingHourLists[0].day),subtitle: Text(openingHourLists[0].open),)
              //     : ListTile(
              //     title: Text(openingHourLists[0].day),subtitle: Text(openingHourLists[0].closing),),
              // isOpen
              //     ? ListTile(
              //     title: Text(openingHourLists[1].day),subtitle: Text(openingHourLists[1].open),)
              //     : ListTile(
              //     title: Text(openingHourLists[1].day),subtitle: Text(openingHourLists[1].closing),),
              // isOpen
              //     ? ListTile(
              //     title: Text(openingHourLists[2].day),subtitle: Text(openingHourLists[2].open),)
              //     : ListTile(
              //     title: Text(openingHourLists[2].day),subtitle: Text(openingHourLists[2].closing),),
              // isOpen
              //     ? ListTile(
              //     title: Text(openingHourLists[3].day),subtitle: Text(openingHourLists[3].open),)
              //     : ListTile(
              //     title: Text(openingHourLists[3].day),subtitle: Text(openingHourLists[3].closing),),
              // isOpen
              //     ? ListTile(
              //     title: Text(openingHourLists[4].day),subtitle: Text(openingHourLists[4].open),)
              //     : ListTile(
              //     title: Text(openingHourLists[4].day),subtitle: Text(openingHourLists[4].closing),),
              // isOpen
              //     ? ListTile(
              //     title: Text(openingHourLists[5].day),subtitle: Text(openingHourLists[5].open),)
              //     : ListTile(
              //     title: Text(openingHourLists[5].day),subtitle: Text(openingHourLists[5].closing),),
              // isOpen
              //     ? ListTile(
              //     title: Text(openingHourLists[6].day),subtitle: Text(openingHourLists[6].open),)
              //     : ListTile(
              //     title: Text(openingHourLists[6].day),subtitle: Text(openingHourLists[6].closing),),

              // isOpen
              //     ? Text(openingHourLists[0].day + '  -  ' +openingHourLists[0].open)
              //     : Text(openingHourLists[0].day + '  -  ' +openingHourLists[0].closing),
              // isOpen
              //     ? Text(openingHourLists[1].day + '  -  ' +openingHourLists[1].open)
              //     : Text(openingHourLists[1].day + '  -  ' +openingHourLists[1].closing),
              // isOpen
              //     ? Text(openingHourLists[2].day + '  -  ' +openingHourLists[2].open)
              //     : Text(openingHourLists[2].day + '  -  ' +openingHourLists[2].closing),
          //   ],
          // );
          return Container(
            child: isOpen
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: openingHourLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(openingHourLists[index].day),
                        subtitle: Text(openingHourLists[index].open),
                      );
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: openingHourLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(openingHourLists[index].day),
                        subtitle: Text(openingHourLists[index].closing),
                      );
                    },
                  ),
          );
        });
  }

  setupAlertDialoadContainer(Map<String, String> widgetList) {
    String instagram = widgetList['instagram'] ?? '';
    String facebook = widgetList['facebook'] ?? '';
    bool isInsta = false;
    bool isFb = false;

    if (instagram != '') {
      isInsta = true;
    }
    if (facebook != '') {
      isFb = true;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Social Media'),
            children: [
              isInsta
                  ? GestureDetector(
                      onTap: () {
                        _launchUrl(instagram);
                      },
                      child: ListTile(
                        title: Text('Instagram'),
                      ),
                    )
                  : Container(),
              isFb
                  ? GestureDetector(
                      onTap: () {
                        _launchUrl(facebook);
                      },
                      child: ListTile(
                        title: Text('Facebook'),
                      ),
                    )
                  : Container(),
              // isInsta ? GestureDetector(onTap: (){print(instagram);}, child: Text('Instagram'),) : Container(),
              // isFb ? GestureDetector(onTap: (){print(facebook);}, child: Text('Facebook'),) : Container()
            ],
          );
        });
  }

  String trim(bool isBefore, String given) {
    String afterTrim = given;

    var parts = given.split('-');

    if (isBefore) {
      afterTrim = parts[0];
    } else {
      afterTrim = parts[1];
    }
    return afterTrim;
  }
}

// return Container(
//   height: 300.0, // Change as per your requirement
//   width: 300.0, // Change as per your requirement
//   child: ListView.builder(
//     itemCount: widgetList.length,
//     itemBuilder: (context, index) {
//       return widgetList[index];
//     },
//   ),
// );
// }
