import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/storage.dart';


class Cart with ChangeNotifier{

  List _cartList = [];

  List get cartList=>_cartList;
  int get cartNumber=>_cartList.length;

  Cart(){
    init();
  }

  init() async {
    String? cartList = await Storage.getString('cartList');
    if (cartList != null) {
      _cartList = json.decode(cartList);
    }
    notifyListeners();
  }
  addData(value){
    _cartList.add(value);
    notifyListeners();
  }

  deleteData(value){
    _cartList.remove(value);
    notifyListeners();
  }

  updateCartList(){
    init();
  }
}