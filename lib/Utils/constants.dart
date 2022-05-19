class Constants {
  // static const String SUCCESS_MESSAGE=" You will be contacted by us very soon.";

  static const String PREF_ = "pref";
  static const String PREF_LOGIN = "isLogin";
  static const String PREF_ID = "id";
  static const String PREF_NAME = "name";
  static const String PREF_TOKEN = "token";
  static const String PREF_DEVICE_ID = "deviceid";
  static const String PREF_EMAIL = "email";
  static const String PREF_PHONE = "phone";

  static const String NETWORK_ = "network";
  static const String NETWORK_LOGIN = "auth/login";
  static const String NETWORK_LOGOUT = "auth/logout";
  static const String NETWORK_REGISTER = "auth/register";
  static const String NETWORK_GET_REWARD = "orders/getreward";
  static const String NETWORK_GET_USER_DATA = "auth/userdata";
  static const String NETWORK_GET_VENDOR_LIST = "vendor/list?";
  static const String NETWORK_STORE_POINT = "orders/storepoint";
  static const String NETWORK_STORE_BOOKING = "orders/storebooking";
  static const String NETWORK_FORGET_PASSWORD = "auth/forgotpassword";
  static const String NETWORK_CHANGE_PASSWORD = "auth/changepassword";
  static const String NETWORK_UPDATE_PROFILE = "auth/updateprofile";
  static const String NETWORK_CHECKOUT_CART = "vendor/checkoutcart";

  static const String ERROR_MSG_ENTER_EMAIL = "Please enter email";
  static const String ERROR_MSG_INVALID_EMAIL = "Invalid email";
  static const String ERROR_MSG_EMPTY_USERNAME_PASSWORD = "Please make sure username and password is not empty";

  static const String SUCCESS_MSG_CREATE_ACCOUNT = "Successfully create account";

  static const String LABEL_OLD_PASSWORD = "Old Password";
  static const String LABEL_NEW_PASSWORD = "New Password";
  static const String LABEL_CONFIRM_PASSWORD = "Confirm Password";

  static const String LABEL_CHANGE_PASSWORD = "Change Password";
  static const String LABEL_CHANGE_YOUR_PASSWORD = "Change Your Password";
  static const String LABEL_CHANGE_PASSWORD_REMINDER = "In order to keep your account safe \n  you need to create a strong password.";

  static String NETWORK_GET_VENDOR_ITEMS(String id) {
    String url = 'vendor/$id/items';
    return url;
  }

  static const String NETWORK_GET_QR_ORDER_DETAILS = "orders/getqrdetails/";

  // static logoutFunction(){
  //   prefs.setBool(Constants.PREF_LOGIN, false);
  //   prefs.setString(Constants.PREF_TOKEN, '');
  //   prefs.setString(Constants.PREF_ID, '');
  //   prefs.setString(Constants.PREF_NAME, '');
  //   prefs.setString(Constants.PREF_EMAIL, '');
  //   prefs.setString(Constants.PREF_PHONE, '');
  // }

  // showLoaderDialog(BuildContext context){
  //   AlertDialog alert=AlertDialog(
  //     content: Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
  //       ],),
  //   );
  //   showDialog(barrierDismissible: false,
  //     context:context,
  //     builder:(BuildContext context){
  //       return alert;
  //     },
  //   );
  // }

}
