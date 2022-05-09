import 'package:flutter/material.dart';
import 'package:code_27/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:code_27/Widget/sign_up_page.dart';
import 'package:code_27/Widget/forget_password_page.dart';
import 'package:code_27/Widget/api_calling.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  bool _loading = false;
  late SharedPreferences prefs;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60.h,
                  ),
                  Image.asset(
                    'assets/images/logo_27thcodes.png',
                    width: 580.w,
                    height: 360.h,
                    fit: BoxFit.cover,
                  ),
                  // Container(
                  //     alignment: Alignment.center,
                  //     padding: const EdgeInsets.all(10),
                  //     child: const Text(
                  //       '27 Codes',
                  //       style: TextStyle(
                  //           color: Colors.blue,
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: 30),
                  //     )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ForgetPasswordPage()));
                    },
                    child: const Text(
                      'Forgot Password',
                    ),
                  ),
                  Container(
                      height: 120.h,
                      width: 0.8.sw,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () async {
                          if (nameController.value.text.length != 0 &&
                              passwordController.value.text.length != 0) {
                            email = nameController.value.text;
                            password = passwordController.value.text;
                            login();
                            // Navigator.pop(context);
                            // print(nameController.text);
                            // print(passwordController.text);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  Constants.ERROR_MSG_EMPTY_USERNAME_PASSWORD),
                            ));
                          }
                        },
                      )),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SignUpPage()));
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    _loading = true;

    Map<String, String> requestHeaders = {
      'deviceid':
          'cBxBBYu4Qvuklp4ySaPQcx:APA91bFiVRvYNQ3Zpuwmh1I_8d62DRkKWHVwABtZsfs5s92FKRNramHL8rueCUvm4de5J_cO3-fFGZGuAWd72-_EZaqI9HsI7UDWeZL--yZ9uutwGeKQHbPJkvtlfqiS6upVJFIxjKJJ'
    };

    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };

    var responseData = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_LOGIN,
        header: requestHeaders);
    print(responseData.message);
    print(responseData);
    if (responseData.code == 200) {
      print('token');
      print(responseData.data['token']);

      prefs = await SharedPreferences.getInstance();
      prefs.setBool(Constants.PREF_LOGIN, true);
      prefs.setString(Constants.PREF_TOKEN, responseData.data['token']);
      prefs.setString(Constants.PREF_ID, responseData.data['id'].toString());
      prefs.setString(Constants.PREF_EMAIL, responseData.data['email']);
      prefs.setString(Constants.PREF_NAME, responseData.data['name']);
      prefs.setString(
          Constants.PREF_PHONE, responseData.data['phone'].toString());

      // Navigator.pop(context, true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => home()));

    } else {
      // prefs = await SharedPreferences.getInstance();
      // prefs.setBool(Constants.PREF_LOGIN, true);
      // Navigator.pop(context);
    }
  }
}
