import 'package:flutter/material.dart';
import 'package:code_27/home.dart';
import 'home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/constants.dart';
import 'Widget/login_page.dart';
// void main() {
//   runApp(
//     MyApp(
//     ),
//   );
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

  runApp(ScreenUtilInit(
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
          ),home: isLogin ? home() : LoginPage(),
        ),
  ));
}
// home: isLogin ? home() : LoginPage(),
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

