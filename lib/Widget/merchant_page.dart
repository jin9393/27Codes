import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_27/Widget/setting_single_image.dart';
import 'package:code_27/Widget/search_input.dart';
import 'package:code_27/Widget/setting_single_image_vertical.dart';
import 'package:code_27/Widget/merchant_sorting_bar.dart';
import 'package:code_27/Widget/merchant_category_grid.dart';
import 'package:code_27/Widget/merchant_category.dart';
import 'package:code_27/Widget/merchant_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/Widget/api_calling.dart';
import 'package:code_27/Widget/api_result.dart';
import 'package:code_27/Model/merchant_model.dart';
import 'package:code_27/Model/other_category_model.dart';
import 'package:code_27/Utils/constants.dart';

// class MerchantPage extends StatefulWidget {
//   String? data;
//   MerchantPage({this.data});
//
//   @override
//   _MerchantPageState createState() => _MerchantPageState();
// }
//
// class _MerchantPageState extends State<MerchantPage> {
//   @override
//   Widget build(BuildContext context) {
//     String? test = widget.data;
//     return Container();
//   }
// }

class MerchantPage extends StatefulWidget {
  @override
  _MerchantPageState createState() => _MerchantPageState();
}

class _MerchantPageState extends State<MerchantPage> {
  late Future<List<MerchantModel>> _tasks;
  List<MerchantModel> lists = [];
  bool _isLoading = false;
  bool _isError = false;
  bool _isSearch = false;
  String searchString = '';
  var searchTextController = TextEditingController();
  String selected = '';
  List<OtherCategory> otherCategoryLists = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks = getdatafromserver(searchString);
      setUpList();
    });
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
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 440.h,
                            color: Colors.blue[300],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40.h),
                            child: Text(
                              "Merchants",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 150.h),
                                //Pass in empty search from here then update for search later.
                                SearchInput(
                                  textController: searchString,
                                  onTap: () => search(),
                                ),
                              ]),
                          Container(
                            margin: EdgeInsets.only(top: 350.h),
                            child: MerchantCategory(
                              selected: selected,
                              onTap: () => searchViaCategory(selected),
                            ),
                          ),
                        ],
                      ),
                      MerchantSortingBar(),
                      // Container(child: Text('No internet'),),
                    ],
                  )),
            ));
          }
          return SizedBox.expand(
              child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 440.h,
                          color: Colors.blue[300],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Text(
                            "Merchants",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 150.h),
                              SearchInput(
                                textController: searchTextController,
                                onTap: () => search(),
                              ),
                            ]),
                        Container(
                          margin: EdgeInsets.only(top: 350.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
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
                                          image:
                                              'assets/images/icon_f&b.png',
                                          maxLine: 1,
                                          fSize: 12,
                                          onTap: () => searchViaCategory('fnb'),
                                        ),
                                        VerticalDivider(
                                          width: 4,
                                          thickness: 1,
                                        ),
                                        MerchantCategoryGrid(
                                          data: "Auto",
                                          image:
                                              'assets/images/icon_automotive.png',
                                          maxLine: 1,
                                          fSize: 12,
                                          onTap: () =>
                                              searchViaCategory('auto'),
                                        ),
                                        VerticalDivider(
                                          width: 4,
                                          thickness: 1,
                                        ),
                                        MerchantCategoryGrid(
                                          data: "Wellness",
                                          image:
                                              'assets/images/icon_wellness.png',
                                          maxLine: 1,
                                          fSize: 12,
                                          onTap: () =>
                                              searchViaCategory('wellness'),
                                        ),
                                        VerticalDivider(
                                          width: 4,
                                          thickness: 1,
                                        ),
                                        MerchantCategoryGrid(
                                          data: "Leisure",
                                          image:
                                              'assets/images/icon_leisure.png',
                                          maxLine: 1,
                                          fSize: 12,
                                          onTap: () =>
                                              searchViaCategory('leisure'),
                                        ),
                                        VerticalDivider(
                                          width: 4,
                                          thickness: 1,
                                        ),
                                        MerchantCategoryGrid(
                                          data: "Fashion",
                                          image:
                                              'assets/images/icon_fashion.png',
                                          maxLine: 1,
                                          fSize: 12,
                                          onTap: () =>
                                              searchViaCategory('fashion'),
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
                                          image:
                                              'assets/images/appicon_IT-2.png',
                                          maxLine: 1,
                                          fSize: 12,
                                          onTap: () => searchViaCategory('it'),
                                        ),
                                        VerticalDivider(
                                          width: 4,
                                          thickness: 1,
                                        ),
                                        MerchantCategoryGrid(
                                          data: "Grocery",
                                          image:
                                              'assets/images/icon_grocery.png',
                                          maxLine: 1,
                                          fSize: 12,
                                          onTap: () =>
                                              searchViaCategory('grocery'),
                                        ),
                                        VerticalDivider(
                                          width: 4,
                                          thickness: 1,
                                        ),
                                        MerchantCategoryGrid(
                                          data: "Stalls",
                                          image:
                                              'assets/images/icon_stalls.png',
                                          maxLine: 1,
                                          fSize: 12,
                                          onTap: () =>
                                              searchViaCategory('stalls'),
                                        ),
                                        VerticalDivider(
                                          width: 4,
                                          thickness: 1,
                                        ),
                                        MerchantCategoryGrid(
                                          data: "Service",
                                          image:
                                              'assets/images/icon_services.png',
                                          maxLine: 1,
                                          fSize: 12,
                                          onTap: () =>
                                              searchViaCategory('service'),
                                        ),
                                        VerticalDivider(
                                          width: 4,
                                          thickness: 1,
                                        ),
                                        MerchantCategoryGrid(
                                          data: "Others",
                                          image:
                                              'assets/images/icon_others.png',
                                          maxLine: 1,
                                          fSize: 12,
                                          onTap: () =>
                                              searchViaCategory('other'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    MerchantSortingBar(),
                    // CircularProgressIndicator(),
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
                )),
          ));
        },
        future: _tasks);
  }

  setUpCategoryDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Other category'),
              content: ListView.builder(
                shrinkWrap: true,
                itemCount: otherCategoryLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return otherCategoryLists[index].header
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            otherCategoryLists[index].name,
                            style: TextStyle(
                                fontSize: 60.sp, fontWeight: FontWeight.bold),
                          ))
                      : GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            searchViaSub(otherCategoryLists[index].name);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Row(
                                children: [
                                  Image.asset(
                                    otherCategoryLists[index].picture,
                                    width: 80.w,
                                    height: 80.h,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Text(
                                    otherCategoryLists[index].name,
                                    style: TextStyle(fontSize: 50.sp),
                                  )
                                ],
                              )),
                        );
                },
              ));
        });
  }

  setUpList() {
    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'F&B',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Asian',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Western',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Dessert',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Beverage',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Bistro',
        picture: 'assets/images/appicon_services.png'));

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Beauty',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Hair',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Facial',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Aesthetic',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Nail medi-pedi',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Eyelashes',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Embroidery',
        picture: 'assets/images/appicon_services.png'));

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Car',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Wash',
        picture: 'assets/images/appicon_auto.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Workshop',
        picture: 'assets/images/appicon_auto.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Accessories',
        picture: 'assets/images/appicon_auto.png'));

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Leisure',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Hotel',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Theme park',
        picture: 'assets/images/appicon_services.png'));

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Retail',
        picture: 'assets/images/appicon_services.png'));

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Services',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Maid cleaning',
        picture: 'assets/images/appicon_services.png'));

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Wellness',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Gym',
        picture: 'assets/images/appicon_wellness.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Yoga',
        picture: 'assets/images/appicon_wellness.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Studio',
        picture: 'assets/images/appicon_wellness.png'));

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Others',
        picture: 'assets/images/appicon_services.png'));
  }

  Future<List<MerchantModel>> getdatafromserver(String search) async {
    lists = [];
    if (!_isLoading) {
      _isLoading = true;
      Map<String, String> requestHeaders = {};
      String searchParam = '';
      if (search.length != 0) {
        searchParam = 'search=' + search;
      }

      var hmmm = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_VENDOR_LIST + searchParam,
          header: requestHeaders,
          context: context);

      List<Merchant> merchants = [];

      if (hmmm.code == 200) {

        hmmm.data['sections'].forEach((mer) {
          mer['restorants'].forEach((res) {
            lists.add(MerchantModel.fromJson(res));
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

      setState(() {
        lists = lists;
      });

      _isLoading = false;
    }

    return lists;
  }

  Future<List<MerchantModel>> getdatafromserverCategory(String search) async {
    lists = [];
    if (!_isLoading) {
      _isLoading = true;
      Map<String, String> requestHeaders = {
              };
      String searchParam = '';
      if (search.length != 0) {
        searchParam = 'merchant_category=' + search;
      }

      var returnData = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_VENDOR_LIST + searchParam,
          header: requestHeaders,
          context: context);

      List<Merchant> merchants = [];

      if (returnData.code == 200) {

        returnData.data['sections'].forEach((mer) {
          mer['restorants'].forEach((res) {
            lists.add(MerchantModel.fromJson(res));
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

      setState(() {
        lists = lists;
      });

      _isLoading = false;
    }

    return lists;
  }

  search() async {
    String searchText = searchTextController.text;
    // if (selected == '5') {}
    // setState(() {});
    getdatafromserver(searchText);
  }

  searchViaSub(String subCategory) async {
    searchTextController = TextEditingController(text: subCategory);
    setState(() {});
  }

  searchViaCategory(String pass) async {
    if (pass == 'other') {
      setUpCategoryDialog();
    } else {
      getdatafromserverCategory(pass);
    }
    // String searchText = searchTextController.text;
    // print('oi im inside here $searchText');
    // if (selected == '5') {}
    // setState(() {});
  }
}
