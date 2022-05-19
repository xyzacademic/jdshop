import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/storage.dart';

class Cart with ChangeNotifier {
  List _cartList = [];
  bool _isCheckedAll = false;
  double _allPrice = 0;
  List get cartList => _cartList;

  int get cartNumber => _cartList.length;

  bool get isCheckedAll => _isCheckedAll;
  double get allPrice => _allPrice;

  Cart() {
    init();
  }

  init() async {
    String? cartList = await Storage.getString('cartList');
    if (cartList != null) {
      _cartList = json.decode(cartList);
    }
    _isCheckedAll = isCheckedAllTrue();
    computeAllPrice();
    notifyListeners();
  }

  addData(value) {
    _cartList.add(value);
    notifyListeners();
  }

  deleteData(value) {
    _cartList.remove(value);
    notifyListeners();
  }

  updateCartList() {
    init();
  }

  itemCountChange() {
    computeAllPrice();
    Storage.setString('cartList', json.encode(_cartList));
    notifyListeners();
  }

  checkAll(value) {
    for (var i = 0; i < _cartList.length; i++) {
      _cartList[i]['checked'] = value;
    }
    _isCheckedAll = value;
    computeAllPrice();
    Storage.setString('cartList', json.encode(_cartList));
    notifyListeners();
  }

  bool isCheckedAllTrue() {
    if (_cartList.length > 0) {
      for (var i = 0; i < _cartList.length; i++) {
        if (_cartList[i]['checked'] == false) {
          return false;
        }
      }
      return true;
    }
    return false;

  }

  itemChange() {
    print('change item');
    _isCheckedAll = isCheckedAllTrue();
    // print(_isCheckedAll);
    computeAllPrice();
    Storage.setString('cartList', json.encode(_cartList));
    notifyListeners();
  }

  computeAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['checked'] == true) {
        tempAllPrice += _cartList[i]['price'] * _cartList[i]['count'];
      }
    }
    _allPrice = tempAllPrice;
  }

  removeItem(){
    List tempList = [];
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['checked'] == false) {
        tempList.add(_cartList[i]);
      }
    }

    _cartList = tempList;
    computeAllPrice();
    Storage.setString('cartList', json.encode(_cartList));

    notifyListeners();
  }
}
