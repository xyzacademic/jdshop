import 'package:flutter_screenutil/flutter_screenutil.dart';


class ScreenAdapter{
  static height(num value){
    return ScreenUtil().setHeight(value);
  }

  static width(num value){
    return ScreenUtil().setWidth(value);
  }

  static size(num value){
    return ScreenUtil().setSp(value);
  }

  static getScreenWidth(){
    return ScreenUtil().screenWidth;
  }

  static getScreenHeight(){
    return ScreenUtil().screenHeight;
  }
}