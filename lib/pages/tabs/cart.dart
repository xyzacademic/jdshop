import 'package:flutter/material.dart';
import 'package:jdshop/pages/cart/cartNumber.dart';
import 'package:jdshop/services/screenAdapter.dart';
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

  @override
  Widget build(BuildContext context) {
    var counterProvider = Provider.of<Counter>(context);
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: [IconButton(onPressed: () {

        }, icon: Icon(Icons.launch))],
      ),
      body: cartProvider.cartList.isNotEmpty? Stack(
        children: [
          ListView(
          children: [Column(
            children: cartProvider.cartList.map((value){
              return CartItem(value);
            }).toList(),
          ),
          SizedBox(height: ScreenAdapter.height(100))],
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
                      width:1,
                      color: Colors.black12,

                    )
                  )
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            width: ScreenAdapter.width(60),
                            child:Checkbox(
                                value: true,
                                activeColor: Colors.pink,
                                onChanged: (val){

                                }
                            ),
                          ),
                          Text("Select all")
                        ]

                      )
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child:
                        ElevatedButton(
                          child: Text("check in", style: TextStyle(
                              color: Colors.white
                          ),
                          ),

                          onPressed: (){

                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        )
                    )
                  ],
                )
              ))
        ],
      ): Text("Cart is empty."),

    );
  }
}
