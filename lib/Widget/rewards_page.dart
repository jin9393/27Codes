import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_27/Utils/constants.dart';
import 'package:code_27/Widget/api_calling.dart';
import 'package:code_27/Model/reward_model.dart';
import 'package:code_27/Widget/reward_balance_bar.dart';
import 'package:code_27/Widget/rewards_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  String accPoints = '0';
  bool _isLoading = false;
  bool _isLogin = false;
  bool _isEmpty = false;
  late Future<List<RewardModel>> _tasks;
  List<RewardModel> lists = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks = getdatafromserver();
    });
    // setState(() {
    //   getdatafromserver();
    // });
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
                                "Rewards",
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
                                  RewardsBalanceBar(
                                    accPoints: accPoints,
                                  ),
                                ]),
                            Container(
                              height: 200.h,
                              width: 1.sw,
                              margin: EdgeInsets.only(top: 350.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(top: 440.h,left: 40.w,right: 40.w),
                            //   child: RewardsTabBar(),
                            // ),
                          ],
                        ),
                      ],
                    )),
              ),
            );
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
                              "Rewards",
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
                                RewardsBalanceBar(
                                  accPoints: accPoints,
                                ),
                              ]),
                          Container(
                            height: 200.h,
                            width: 1.sw,
                            margin: EdgeInsets.only(top: 350.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(top: 440.h,left: 40.w,right: 40.w),
                          //   child: RewardsTabBar(),
                          // ),
                          _isLoading
                              ? Container(
                                  margin: EdgeInsets.only(top: 400.h),
                                  child: CircularProgressIndicator(),
                                )
                              : _isEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(top: 0.5.sh),
                                      child: Text("No rewards at the moment"),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(top: 400.h),
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: lists.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          RewardModel model = lists[index];
                                          return RewardsListItem(
                                            data: model,
                                          );
                                        },
                                      ),
                                    )
                        ],
                      ),
                    ],
                  )),
            ),
          );
        },
        future: _tasks);
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<List<RewardModel>> getdatafromserver() async {
    _isLoading = true;

    prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    if (_isLogin) {
      Map<String, String> requestHeaders = {};

      Map<String, String> arg = {};

      var responseData = await ApiCall().get(
          arg: arg,
          method: Constants.NETWORK_GET_REWARD,
          header: requestHeaders,
          context: context);

      lists = [];
      List<RewardModel> rewards = [];
      print(responseData);
      if (responseData.code == 200) {
        _isLoading = false;
        responseData.data['reward_list'].forEach((res) {
          lists.add(RewardModel.fromJson(res));
        });
        accPoints = responseData.data['current'].toString();
        if (lists.length == 0) {
          _isEmpty = true;
        } else {
          _isEmpty = false;
        }
      } else {
      }

      setState(() {
        lists = lists;
      });
    } else {
      setState(() {
        lists = lists;
        _isLoading = false;
      });
    }

    return lists;
  }
}
