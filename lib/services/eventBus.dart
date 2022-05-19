import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductContentEvent{
  String _str="";

  ProductContentEvent(String str){
    _str = str;
  }
}



