import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_27/Widget/setting_single_image.dart';
import 'package:code_27/Widget/setting_single_image_vertical.dart';
import 'package:code_27/Widget/change_password_page.dart';
import 'package:code_27/Widget/profile_details_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:code_27/Utils/constants.dart';
import 'package:code_27/Widget/api_calling.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _loading = false;

  bool isLogoutClicked = false;
  late BuildContext dialogContext;
  late SharedPreferences prefs;
  String name = '';
  String email = '';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constants.PREF_NAME) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getName(),
        builder: (context, snapshot) {
          return SizedBox.expand(
              child: Container(
            color: Colors.white,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 800.h,
                      color: Colors.blue[300],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.h),
                        GestureDetector(
                          onTap: () {
                            // getProfilePicture();
                          },
                          child: Container(
                            width: 380.w,
                            height: 380.h,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                  'assets/images/appicon_profile_highres.png'),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(name,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 68.sp)),
                          margin: EdgeInsets.only(top: 10.h),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 530.h),
                      width: 0.9.sw,
                      height: 160.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (_) => ProfileDetailsPage(
                                //           name: name,
                                //           phone: phoneNumber,
                                //           email: email,
                                //         ))),
                            Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new ProfileDetailsPage(name: name,phone: phoneNumber,email: email,)),)
                                .then((val)=>val?updateName():null),
                            child: Container(
                              width: 0.40.sw,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              // margin: EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 12.w),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Image.asset(
                                      'assets/images/appicon_profile.png',
                                      width: 90.w,
                                      height: 90.h,
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Flexible(
                                    child: Text(
                                      'Profile',
                                      style: TextStyle(
                                        fontSize: 45.sp,
                                        color: Colors.grey,
                                      ),
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // SettingSingleImage(
                          //   data: "Profile",
                          //   image: 'assets/images/appicon_profile.png',
                          //   nextPage: ProfileDetailsPage(
                          //     name: name,
                          //     phone: phoneNumber,
                          //     email: email,
                          //   ),
                          //   widthSize: 0.40.sw,
                          // ),
                          SizedBox(
                            width: 0.1.sw,
                          ),
                          SettingSingleImage(
                            data: "Change Password",
                            image: 'assets/images/appicon_changePassword.png',
                            nextPage: ChangePasswordPage(),
                            widthSize: 0.40.sw,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 740.h),
                      width: 1.sw,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                    ),
                  ],
                ),
                Container(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SettingSingleImageVertical(
                      data: "About Us",
                      image: 'assets/images/appicon_aboutUs.png',
                      nextPage: ProfileDetailsPage(
                        name: name,
                        phone: phoneNumber,
                        email: email,
                      ),
                      onTap: () => refresh('about us'),
                    ),
                    SettingSingleImageVertical(
                      data: "Terms of Use",
                      image: 'assets/images/appicon_terms.png',
                      nextPage: ProfileDetailsPage(
                        name: name,
                        phone: phoneNumber,
                        email: email,
                      ),
                      onTap: () => refresh('termsofuse'),
                    ),
                    SettingSingleImageVertical(
                      data: "Privacy Policy",
                      image: 'assets/images/appicon_policy.png',
                      nextPage: ProfileDetailsPage(
                        name: name,
                        phone: phoneNumber,
                        email: email,
                      ),
                      onTap: () => refresh('privacypolicy'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.w,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SettingSingleImageVertical(
                      data: "Contact Us",
                      image: 'assets/images/appicon_contactUs.png',
                      nextPage: LoginPage(),
                      onTap: () => refresh('4'),
                    ),
                    SettingSingleImageVertical(
                      data: "Logout",
                      image: 'assets/images/appicon_logout.png',
                      // nextPage: ProfileDetailsPage(),
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            dialogContext = context;
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content: Text('Are you sure you want to logout?'),
                              actions: <Widget>[
                                new TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(dialogContext);
                                  },
                                  child: Text('No'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    prefs =
                                        await SharedPreferences.getInstance();

                                    prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool(Constants.PREF_LOGIN, false);
                                    prefs.setString(Constants.PREF_TOKEN, '');
                                    prefs.setString(Constants.PREF_ID, '');
                                    prefs.setString(Constants.PREF_NAME, '');
                                    prefs.setString(Constants.PREF_EMAIL, '');
                                    prefs.setString(Constants.PREF_PHONE, '');

                                    Navigator.of(context).pop(dialogContext);
                                    // logOut();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoginPage()));
                                    setState(() {
                                      // Navigaxtor.of(context).pop(dialogContext);
                                    });
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Container(
                      width: 0.3.sw,
                    ),
                  ],
                ),
              ],
            ),
          ));
        });
  }

  // getProfilePicture() async {
  //
  //   final ImagePicker _picker = ImagePicker();
  //   // Pick an image
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   // // Capture a photo
  //   // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  //   // // Pick a video
  //   // final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
  //   // // Capture a video
  //   // final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
  //   // // Pick multiple images
  //   // final List<XFile>? images = await _picker.pickMultiImage();
  //   String path = image!.path;
  //   print(path);
  // }

  updateName() async{
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constants.PREF_NAME) ?? '';
    String token = prefs.getString(Constants.PREF_TOKEN) ?? '';
    email = prefs.getString(Constants.PREF_EMAIL) ?? '';
    phoneNumber = prefs.getString(Constants.PREF_PHONE) ?? '';
    setState(() {

    });
  }

  getName() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constants.PREF_NAME) ?? '';
    String token = prefs.getString(Constants.PREF_TOKEN) ?? '';
    email = prefs.getString(Constants.PREF_EMAIL) ?? '';
    phoneNumber = prefs.getString(Constants.PREF_PHONE) ?? '';

  }

  logOut() async {
    _loading = true;

    Map<String, String> requestHeaders = {
      'deviceid':
          'cBxBBYu4Qvuklp4ySaPQcx:APA91bFiVRvYNQ3Zpuwmh1I_8d62DRkKWHVwABtZsfs5s92FKRNramHL8rueCUvm4de5J_cO3-fFGZGuAWd72-_EZaqI9HsI7UDWeZL--yZ9uutwGeKQHbPJkvtlfqiS6upVJFIxjKJJ',
      'Accept': 'application/json'
    };

    Map<String, String> requestBody = {};

    var responseData = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_LOGOUT,
        header: requestHeaders,
        context: context);
    if (responseData.code == 200) {
      prefs = await SharedPreferences.getInstance();
      prefs.setBool(Constants.PREF_LOGIN, false);
      prefs.setString(Constants.PREF_TOKEN, '');
      prefs.setString(Constants.PREF_ID, '');
      prefs.setString(Constants.PREF_NAME, '');
      prefs.setString(Constants.PREF_EMAIL, '');
      prefs.setString(Constants.PREF_PHONE, '');

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    } else {
      // prefs = await SharedPreferences.getInstance();
      // prefs.setBool(Constants.PREF_LOGIN, true);

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }
  }

  refresh(String selected) {
    if (selected == 'about us') {
      _launchUrl('https://developing27code.madxpanel.com/pages/2');
    }else if(selected == 'termsofuse'){
      _launchUrl('https://developing27code.madxpanel.com/pages/1');
    }else if(selected == 'privacypolicy'){
      _launchUrl('https://developing27code.madxpanel.com/pages/3');
    }else{
      _launchUrl('https://developing27code.madxpanel.com');
    }
    // setState(() {});
  }
  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }
}
