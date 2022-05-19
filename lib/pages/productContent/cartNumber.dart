import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/counter.dart';
import '../../provider/cart.dart';
import '../../services/screenAdapter.dart';
class CartNumber extends StatefulWidget {
  var _productContent;

  CartNumber(this._productContent, {Key? key}) : super(key: key);

  @override
  State<CartNumber> createState() => _CartNumberState();
}

class _CartNumberState extends State<CartNumber> {
  var _productContent;
  @override
  void initState(){
    super.initState();
    _productContent = widget._productContent;
  }

  Widget _leftBtn(){
    return InkWell(
      onTap: (){
        if (_productContent.count > 1){
          setState((){

            _productContent.count--;
          });
        }

      },
      child:Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text("-"),
      )
    );
  }

  Widget _centerArea(){
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(70),
      height: ScreenAdapter.height(45),
      child: Text("${_productContent.count}"),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
            right: BorderSide(
              width: 1,
              color: Colors.black12,
            )
        )
      ),
    );
  }

  Widget _rightBtn(){
    return InkWell(
      onTap:(){
        setState((){
          _productContent.count++;
        });
      },
      child:Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text("+"),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Container(
      width: ScreenAdapter.width(165),
      decoration: BoxDecoration(
        border: Border.all(
          width:1,
          color: Colors.black12,
        )
      ),
      child: Row(
        children: [
            _leftBtn(),
            _centerArea(),
          _rightBtn(),
        ],
      ),
    );
  }
}
