import 'package:crypto/crypto.dart';
import 'dart:convert';

class SignServices{
  static getSign(jsonData){

    var attrKeys = jsonData.keys.toList();
    // sort
    attrKeys.sort();

    String str='';
    for(var i=0; i<attrKeys.length; i++){
      str += '${attrKeys[i]}${jsonData[attrKeys[i]]}';
    }
    // print(md5.convert(utf8.encode(str)));
    return md5.convert(utf8.encode(str)).toString();
  }


}