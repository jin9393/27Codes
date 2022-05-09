import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_27/Widget/main_title_bar.dart';
import 'package:code_27/Widget/password_condition_text.dart';
import 'package:code_27/Widget/text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ProfileDetailsPage extends StatefulWidget {

  late String name;
  late String email;
  late String phone;

  ProfileDetailsPage({required this.name,required this.email,required this.phone});

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetailsPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String fullName = '';
  String email = '';
  String phoneNo = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController = TextEditingController(text: widget.name);
      emailController = TextEditingController(text: widget.email);

    });
  }

  removeNumber(String number){

    print('insideRemove');

    String getInitials(String bank_account_name) => bank_account_name.isNotEmpty
        ? bank_account_name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
    print('number');
    print(getInitials(number));
    if(getInitials(number)=='0'){
      print('inside');
      number = number.substring(1);
    }
    print(number);
    return number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
            height: 1.sw,
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
                        height: 700.h,
                        color: Colors.blue[300],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MainTitleBar(
                              title: 'Profile',
                              action: () => Navigator.pop(context)),
                          SizedBox(
                            height: 40.h,
                          ),
                          Container(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/appicon_profile_highres.png'),
                            ),
                            width: 400.w,
                            height: 400.w,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 640.h),
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
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: 'Name',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: IntlPhoneField(
                            initialValue: removeNumber(widget.phone),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            initialCountryCode: 'MY',
                            disableLengthCheck: true,
                            onChanged: (phone) {
                              phoneNo = phone.completeNumber;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                      ],
                    ),
                  ),
                  // TextButtonCustom(
                  //     text: 'Update',
                  //     width: 0.8.sw,
                  //     fillColor: Colors.orangeAccent,
                  //     fontSize: 50.sp),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton:
      Container(
        width: 0.8.sw,
        child: ElevatedButton(
          onPressed: () {

            fullName = nameController.value.text;
            email = emailController.value.text;

            print(fullName);
            print(email);
            print(phoneNo);

          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blue.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 15.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Update',
              style: TextStyle(fontSize: 50.sp),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
