import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductContentEvent{
  String _str="";

  ProductContentEvent(String str){
    _str = str;
  }

}

class UserEvent{
  String _str="";
  String get str=>_str;
  UserEvent(String str){
    _str = str;
  }


}


class AddressEvent{
  String _str="";
  String get str=>_str;
  AddressEvent(String str){
    _str = str;
  }
}


class CheckOutEvent{
  String _str="";
  String get str=>_str;
  CheckOutEvent(String str){
    _str = str;
  }
}