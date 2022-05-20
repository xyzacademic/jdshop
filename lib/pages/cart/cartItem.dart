import 'package:flutter/material.dart';
import 'package:jdshop/pages/cart/cartNumber.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:provider/provider.dart';
import '../../provider/counter.dart';
import '../../provider/cart.dart';

class CartItem extends StatefulWidget {
  Map _itemData;

  CartItem(this._itemData, {Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late Map _itemData;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    _itemData = widget._itemData;
    var cartProvider = Provider.of<Cart>(context);
    return Container(
      padding: EdgeInsets.all(5),
      height: ScreenAdapter.height(220),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color: Colors.black12,
      ))),
      child: Row(
        children: [
          Container(
              width: ScreenAdapter.width(60),
              child: Checkbox(
                value: _itemData['checked'],
                onChanged: (val) {
                  _itemData['checked'] = !_itemData['checked'];

                  cartProvider.itemChange();
                },
                activeColor: Colors.pink,
              )),
          Container(
            width: ScreenAdapter.width(160),
            child: Image.network("${_itemData['pic']}", fit: BoxFit.cover),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_itemData['title']}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${_itemData['selectedAttr']}",
                      maxLines: 2,
                    ),
                    Stack(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("\$${_itemData["price"]}",
                                style: TextStyle(color: Colors.red))),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CartNumber(_itemData),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
