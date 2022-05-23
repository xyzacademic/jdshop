import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/storage.dart';

class CheckOut with ChangeNotifier{
  List _checkOutListData = [];

  List get checkOutListData => _checkOutListData;

  changeCheckOutListData(data){
    _checkOutListData = data;
    notifyListeners();
  }


}