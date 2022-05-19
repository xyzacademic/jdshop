import 'package:flutter/material.dart';

class Counter with ChangeNotifier{

  int _count = 1;

  Counter(){
    _count = 10;
  }
  int get count=>_count; //get status

  incCount(){
    _count++;
    notifyListeners(); // update status

  }
}