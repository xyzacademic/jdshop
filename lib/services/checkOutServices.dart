import 'dart:convert';
import '../services/storage.dart';

class CheckOutServices{
  // calculate sum price

  static getAllPrice(checkOutListData){
    double tempAllPrice = 0;
    for (var i=0; i< checkOutListData.length; i++){
      if(checkOutListData[i]["checked"] == true){
        tempAllPrice += checkOutListData[i]['price'] * checkOutListData[i]['count'];
      }
    }
    return tempAllPrice;
  }

  static removeUnSelectedCartItem() async{



    List _cartList = [];
    String? cartList;
    List tempList = [];
    cartList = await Storage.getString('cartList');
    if (cartList!=null){
      List cartListData = json.decode(cartList);
      _cartList = cartListData;
    }

    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['checked'] == false) {
        tempList.add(_cartList[i]);
      }
    }
    print(tempList);
    await Storage.setString('cartList', json.encode(tempList));



  }
}