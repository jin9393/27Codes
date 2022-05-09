import 'package:flutter/material.dart';
import 'package:code_27/home.dart';
import 'home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    MyApp(
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1080, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () =>
          MaterialApp(
            //... other code
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              //add this line
              ScreenUtil.setContext(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            theme: ThemeData(
              primaryColor:Colors.blue[300],
              textTheme: TextTheme(
                //To support the following, you need to use the first initialization method
                  button: TextStyle(fontSize: 45.sp)
              ),
            ),home: home(),
          ),
    );
  }
}

