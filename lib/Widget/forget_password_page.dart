import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/Widget/api_calling.dart';
import 'package:code_27/Utils/constants.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String email = '';
  bool _loading = false;
  late SharedPreferences prefs;

  TextEditingController emailController = TextEditingController();

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(10),
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
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Forget password',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Forget password'),
                        onPressed: () {
                          bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.value.text);
                          if (emailValid) {
                            forgetPassword();
                          } else {
                            if (emailController.value.text.length == 0) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                Text(Constants.ERROR_MSG_ENTER_EMAIL),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                Text(Constants.ERROR_MSG_INVALID_EMAIL),
                              ));
                            }
                          }
                        },
                      )),
                ],
              )),
        ),
      ),
    );
  }

  forgetPassword() async {
    _loading = true;

    Map<String, String> requestHeaders = {};

    Map<String, String> requestBody = {
      'email': email,
    };

    var hmmm = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_FORGET_PASSWORD,
        header: requestHeaders);
    print(hmmm.message);
    print(hmmm);
  }
}
