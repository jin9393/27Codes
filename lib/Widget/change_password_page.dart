import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_27/Widget/main_title_bar.dart';
import 'package:code_27/Widget/password_condition_text.dart';
import 'package:code_27/Widget/text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_27/Widget/api_calling.dart';
import 'package:code_27/Utils/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  bool _loading = false;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  bool _isObscureOldPass = true;
  bool _isObscureNewPass = true;
  bool _isObscureConfirmPass = true;

  String oldPassword = '';
  String password = '';
  String passwordConfirmation = '';

  bool _amountChecking = false;
  bool _specialChecking = false;
  bool _numberChecking = false;
  bool _capsChecking = false;
  bool _passwordMatching = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox.expand(
        child: Container(
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
                      height: 820.h,
                      color: Colors.blue[300],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MainTitleBar(
                            title: Constants.LABEL_CHANGE_PASSWORD,
                            action: () => Navigator.pop(context)),
                        SizedBox(
                          height: 20.h,
                        ),
                        Image.asset(
                          'assets/images/appicon_changePassword.png',
                          width: 400.w,
                          height: 400.w,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          Constants.LABEL_CHANGE_YOUR_PASSWORD,
                          style:
                              TextStyle(fontSize: 60.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          Constants.LABEL_CHANGE_PASSWORD_REMINDER,
                          style:
                              TextStyle(fontSize: 38.sp, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 760.h),
                      width: 1.sw,
                      height: 70.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.w, 0, 35.w, 0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: TextField(
                            controller: oldPasswordController,
                            obscureText: _isObscureOldPass,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: Constants.LABEL_OLD_PASSWORD,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscureOldPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscureOldPass = !_isObscureOldPass;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: TextField(
                            controller: passwordController,
                            obscureText: _isObscureNewPass,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: Constants.LABEL_NEW_PASSWORD,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscureNewPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscureNewPass = !_isObscureNewPass;
                                  });
                                },
                              ),
                            ),
                            onChanged: (text) {
                              checkForPassword(text);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: TextField(
                            controller: passwordConfirmationController,
                            obscureText: _isObscureConfirmPass,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscureConfirmPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscureConfirmPass =
                                        !_isObscureConfirmPass;
                                  });
                                },
                              ),
                            ),
                            onChanged: (text) {
                              checkSimilarity(text);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 60.w,
                          ),
                          Text("NEW PASSWORD MUST CONTAIN"),
                        ],
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      _amountChecking
                          ? PasswordConditionText(
                              title: 'At least 8 characters',
                              imageAsset:
                                  'assets/images/appicon_greendot-01.png',
                            )
                          : PasswordConditionText(
                              title: 'At least 8 characters',
                              imageAsset: 'assets/images/appicon_reddot-01.png',
                            ),
                      _capsChecking
                          ? PasswordConditionText(
                              title: 'At least 1 upper case',
                              imageAsset:
                                  'assets/images/appicon_greendot-01.png',
                            )
                          : PasswordConditionText(
                              title: 'At least 1 upper case',
                              imageAsset: 'assets/images/appicon_reddot-01.png',
                            ),
                      _numberChecking
                          ? PasswordConditionText(
                              title: 'At least 1 number',
                              imageAsset:
                                  'assets/images/appicon_greendot-01.png',
                            )
                          : PasswordConditionText(
                              title: 'At least 1 number',
                              imageAsset: 'assets/images/appicon_reddot-01.png',
                            ),
                      _specialChecking
                          ? PasswordConditionText(
                              title: 'At least 1 special character',
                              imageAsset:
                                  'assets/images/appicon_greendot-01.png',
                            )
                          : PasswordConditionText(
                              title: 'At least 1 special character',
                              imageAsset: 'assets/images/appicon_reddot-01.png',
                            ),
                      _passwordMatching
                          ? PasswordConditionText(
                              title: 'New password & confirm password match.',
                              imageAsset:
                                  'assets/images/appicon_greendot-01.png',
                            )
                          : PasswordConditionText(
                              title: 'New password & confirm password match.',
                              imageAsset: 'assets/images/appicon_reddot-01.png',
                            ),
                      SizedBox(
                        height: 60.h,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 0.8.sw,
                  child: ElevatedButton(
                    onPressed: () {
                      oldPassword = oldPasswordController.value.text;
                      password = passwordController.value.text;
                      passwordConfirmation =
                          passwordConfirmationController.value.text;

                      if (oldPassword.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Please make sure old password is not empty."),
                        ));
                      } else {

                        if (!_specialChecking ||
                            !_numberChecking ||
                            !_capsChecking ||
                            !_amountChecking) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Please make sure password meet requirement."),
                          ));
                        } else if (password != passwordConfirmation) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Please make sure both new password match."),
                          ));
                        } else {
                          print('inside change');
                          changePassword();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 15.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Change Password',
                        style: TextStyle(fontSize: 50.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  checkForPassword(String password) {
    print(password);

    RegExp capsRegex = RegExp(r'^(?=.*?[A-Z])');
    RegExp specialRegex = RegExp(r'^(?=.*?[!@#\-?/+$&*~])');
    RegExp numRegex = RegExp(r'^(?=.*?[0-9])');
    RegExp amountRegex = RegExp(r'^.{8,}');

    if (!capsRegex.hasMatch(password)) {
      _capsChecking = false;
    } else {
      _capsChecking = true;
    }

    if (!specialRegex.hasMatch(password)) {
      _specialChecking = false;
    } else {
      _specialChecking = true;
    }
    if (!numRegex.hasMatch(password)) {
      _numberChecking = false;
    } else {
      _numberChecking = true;
    }
    if (!amountRegex.hasMatch(password)) {
      _amountChecking = false;
    } else {
      _amountChecking = true;
    }

    setState(() {});
  }

  checkSimilarity(String confirmPass) {
    String getNewPassword = passwordController.value.text;

    if (getNewPassword == confirmPass) {
      _passwordMatching = true;
    } else {
      _passwordMatching = false;
    }
    setState(() {});
  }

  changePassword() async {
    _loading = true;

    Map<String, String> requestHeaders = {};

    Map<String, String> requestBody = {
      'old_password': oldPassword,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };

    var responseData = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_CHANGE_PASSWORD,
        header: requestHeaders);
    print(responseData.message);
    print(responseData);
    if (responseData.code == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responseData.message),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responseData.message),
      ));
      // Navigator.pop(context);
    }
  }
}
