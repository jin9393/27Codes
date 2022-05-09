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
  final searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks = getdatafromserver(searchString);
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
                                child: MerchantCategory(),
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
                              child: MerchantCategory(),
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
                          itemBuilder:
                              (BuildContext context, int index) {
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

  Future<List<MerchantModel>> getdatafromserver(String search) async {

    lists = [];
    if(!_isLoading){
      _isLoading = true;
      Map<String, String> requestHeaders = {
        'deviceid':
        'fxxYlHr9QNGnr-0W_3eifh:APA91bFWMiy8rRWPEZESx_1tfHhvmIrcqBEKuakLPoRt4tAAP9wiJCLFuXOJsST9dp3hNJ_h8iuwJWDDWAilRaBYW8gF-DmWI1C4vB89ux9Q-ThbG_Elp7qzxpZ_sh-tOJAkFK62KBOR'
      };
      String searchParam = '';
      if(search.length!=0){
        searchParam = 'search=' + search;
      }

      print(searchParam);

      var hmmm = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_VENDOR_LIST+searchParam,
          header: requestHeaders);

      List<Merchant> merchants = [];

      if (hmmm.code == 200) {
        print(hmmm.data['sections']);

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
        print(merchants);
      } else {
        _isLoading = false;
        _isError = true;
        print('error');
      }
      print(lists.length);

      setState(() {
        lists = lists;
      });

      _isLoading = false;
    }

    return lists;
  }

  search() async {
    String searchText = searchTextController.text;
    print('oi im inside here $searchText');
    // if (selected == '5') {}
    // setState(() {});
    getdatafromserver(searchText);

  }
}
