import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jdshop/pages/cart/cartNumber.dart';
import 'package:jdshop/services/cartServices.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:jdshop/services/userServices.dart';
import '../../provider/checkOut.dart';
import '../cart/cartItem.dart';
import '../../provider/counter.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isEdit = false;
  var checkOutProvider;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  doCheckOut() async {
    var checkOutData = await CartServices.getCheckOutData();
    checkOutProvider.changeCheckOutListData(checkOutData);

    // check if selectd list is empty
    if(checkOutData.isEmpty){
      Fluttertoast.showToast(
        msg: "You did not select any item",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      var loginState = await UserServices.getUserLoginState();
      if (loginState){
        Navigator.pushNamed(context, '/checkOut');
      } else{
        Fluttertoast.showToast(
          msg: "Please login firstly",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pushNamed(context, '/login');
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    var counterProvider = Provider.of<Counter>(context);
    var cartProvider = Provider.of<Cart>(context);
    checkOutProvider = Provider.of<CheckOut>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _isEdit = !_isEdit;
                });
              },
              icon: Icon(Icons.launch))
        ],
      ),
      body: cartProvider.cartList.isNotEmpty
          ? Stack(
              children: [
                ListView(
                  children: [
                    Column(
                      children: cartProvider.cartList.map((value) {
                        return CartItem(value);
                      }).toList(),
                    ),
                    SizedBox(height: ScreenAdapter.height(100))
                  ],
                ),
                Positioned(
                    bottom: 0,
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(78),
                    child: Container(
                        // color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(
                              width: 1,
                              color: Colors.black12,
                            ))),
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Row(children: [
                                  Container(
                                    width: ScreenAdapter.width(60),
                                    child: Checkbox(
                                        value: cartProvider.isCheckedAll,
                                        activeColor: Colors.pink,
                                        onChanged: (val) {
                                          cartProvider.checkAll(val);
                                        }),
                                  ),
                                  Text("Select all"),
                                  SizedBox(width: 20),
                                  !_isEdit?Text("Sum Price: "):Text(""),
                                  !_isEdit?Text(
                                    "${cartProvider.allPrice}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  ):Text(""),
                                ])),
                            !_isEdit
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      child: Text(
                                        "check out",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: doCheckOut,
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                    ))
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        cartProvider.removeItem();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                    ))
                          ],
                        )))
              ],
            )
          : Text("Cart is empty."),
    );
  }
}
