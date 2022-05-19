import 'dart:convert';

import '../config/config.dart';
import '../services/storage.dart';

class CartServices {
  static addCart(item) async {
    item = CartServices.formatCartData(item);
    // print(item);
    String? cartList = await Storage.getString('cartList');

    if (cartList != null) {
      var cartListData = json.decode(cartList);
      var hasData = cartListData.any((value) {
        // if id exists and attr are the same, increment attr counts
        if (value['_id'] == item['_id'] &&
            value['selectedAttr'] == item['selectedAttr']) {
          return true;
        }
        return false;
      });
      if (hasData) {
        for (var i = 0; i < cartListData.length; i++) {
          if (cartListData[i]['_id'] == item['_id'] &&
              cartListData[i]['selectedAttr'] == item['selectedAttr']) {
            cartListData[i]['count'] += 1;
          }
        }
      } else {
        cartListData.add(item);
        await Storage.setString('cartList', json.encode(cartListData));
      }
    } else {
      List tempList = [];
      tempList.add(item);
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  //filter
  static formatCartData(item) {
    Map data = <String, dynamic>{};
    String sPic = item.pic;
    sPic = Config.domain + '/' + sPic.replaceAll('\\', '/');
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price is String? double.parse(item.price): item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = sPic;

    data['checked'] = true;

    return data;
  }
}
