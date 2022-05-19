import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:code_27/Widget/home_page.dart';
import 'package:code_27/Widget/profile_page.dart';
import 'package:code_27/Widget/merchant_page.dart';
import 'package:code_27/Widget/rewards_page.dart';
import 'package:code_27/Widget/qr_scan_page.dart';
import 'package:code_27/Widget/login_page.dart';
import 'package:code_27/Widget/qr_result_page.dart';
import 'package:code_27/Widget/bottom_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:code_27/Widget/api_calling.dart';
import 'package:code_27/Widget/api_result.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:code_27/Model/qr_scan_result_model.dart';
import 'Utils/constants.dart';

class home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<home> {

  bool _isLogin = false;
  int lastClicked = 0;
  late SharedPreferences prefs;
  GlobalKey<ConvexAppBarState> _appBarKey = GlobalKey<ConvexAppBarState>();

  @override
  void initState() {
    super.initState();
    setState(() {

      // getdatafromserver();
      // getdatafromserver().whenComplete(() => print ('done d $returnData'));
      // returnData = ApiCall().post(method: 'method');
    });
  }

  List<Widget> _pages = [
    HomePage(),
    MerchantPage(),
    QrScanPage(),
    RewardsPage(),
    ProfilePage()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child:
      _pages[_selectedIndex]
      ),
      bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar(
            key: _appBarKey,
            curveSize: 80,
            top: -20,
            style: TabStyle.fixed,
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Colors.orange,
            items: [
              TabItem(
                  icon: Image.asset('assets/images/appicon_home.png'),
                  title: 'Home',
                  activeIcon:
                      Image.asset('assets/images/appicon_home_active.png')),
              TabItem(
                  icon: Image.asset('assets/images/appicon_merchant.png'),
                  title: 'Merchant',
                  activeIcon:
                      Image.asset('assets/images/appicon_merchant_active.png')),
              TabItem(
                  icon: Image.asset(
                    'assets/images/appicon_qrcode.png',
                    width: 40.w,
                    height: 40.h,
                  ),
                  title: 'Scan QR'),
              TabItem(
                  icon: Image.asset('assets/images/appicon_rewards.png'),
                  title: 'Rewards',
                  activeIcon:
                      Image.asset('assets/images/appicon_rewards_active.png')),
              TabItem(
                  icon: Image.asset('assets/images/appicon_settings.png'),
                  title: 'Settings',
                  activeIcon:
                      Image.asset('assets/images/appicon_settings_active.png')),
            ],
            initialActiveIndex: 0,
            //optional, default as 0
            onTap: _onTap,
          )),
    );
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future _getLogin() async {
    prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    return _getLogin();
  }

  Future<void> _onTap(int index) async {

    if(index != 2){
      lastClicked = index;
    }
    _selectedIndex = index;
    _appBarKey.currentState?.animateTo(_selectedIndex);
    if (_selectedIndex == 2) {
      scanQRCode();
    } else {
      if (_selectedIndex == 0) {
        setState(() {});
      } else if (_selectedIndex == 1) {
        setState(() {});
      } else if (_selectedIndex == 3) {
        setState(() {});
      } else if (_selectedIndex == 4) {
        prefs = await SharedPreferences.getInstance();
        bool isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

        if (isLogin) {
          setState(() {});
        } else {
          var result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => LoginPage()));

          if (result == null) {
            _onTap(0);
          }

          if (result == true) {
            _onTap(4);
          }
        }
      }
    }
  }

  Future<void> scanQRCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.QR);

    try {
      var result = QrResult.fromJson(jsonDecode(barcodeScanRes));
      if (result.orderId.length != 0) {
        var returnResult = await Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new QrResultPage(data: result)));
        if (returnResult) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Successful payment"),
          ));
          _onTap(0);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Payment failed"),
          ));
        }
      } else {
        _onTap(0);
      }
    } catch (error) {
      prefs = await SharedPreferences.getInstance();
      bool isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

      if(!isLogin&&lastClicked==4){
        _onTap(0);
      }else{
        _onTap(lastClicked);
      }

    }
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 36;

  @override
  double get activeIconMargin => 0;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 36.sp, color: color);
  }
}
