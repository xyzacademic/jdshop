import 'dart:convert';

import '../services/storage.dart';

class UserServices {
  static getUserInfo() async {
    String? userInfoList = await Storage.getString('userInfo');
    List _userInfo = userInfoList != null ? json.decode(userInfoList) : [];
    return _userInfo;
  }

  static getUserLoginState() async {
    var userInfo = await UserServices.getUserInfo();
    if (userInfo.length > 0 && userInfo[0]['username'] != "") {
      return true;
    }
    return false;
  }

  static logout() async {
    await Storage.remove('userInfo');

  }
}
