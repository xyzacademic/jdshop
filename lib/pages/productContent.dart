import 'dart:convert';
import 'package:flutter/material.dart';
import '../widget/loadingWidget.dart';
import '../services/screenAdapter.dart';
import 'productContent/productContentFirst.dart';
import 'productContent/productContentSecond.dart';
import 'productContent/productContentThird.dart';
import '../widget/jdButton.dart';
import '../model/productContentModel.dart';
import '../config/config.dart';
import 'package:dio/dio.dart';
import '../services/eventBus.dart';
import '../provider/cart.dart';
import 'package:provider/provider.dart';
import '../services/cartServices.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductContentPage extends StatefulWidget {
  Map? arguments;

  ProductContentPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductContentPage> createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _getContentData();
  }

  var _productContentList = [];

  _getContentData() async {
    // setState(() {
    //   _flag = false;
    // });
    var api;

    api = '${Config.domain}/api/pcontent?id=${widget.arguments?["id"]}';

    var result = await Dio().get(api);
    // print(api);
    var productContent = result.data is Map
        ? ProductContentModel.fromJson(result.data)
        : ProductContentModel.fromJson(json.decode(result.data));

    // print(productList.result is Map);

    setState(() {
      _productContentList.add(productContent.result);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenAdapter.width(400),
                child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  // same width as text
                  tabs: [
                    Tab(child: Text("Item")),
                    Tab(child: Text("Description")),
                    Tab(child: Text("Comments")),
                  ],
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(ScreenAdapter.width(600),
                          76, 10, 0),
                      items: [
                        PopupMenuItem(
                            child: Row(
                          children: [
                            Icon(Icons.home),
                            Text("Home"),
                          ],
                        )),
                        PopupMenuItem(
                            child: Row(
                          children: [
                            Icon(Icons.search),
                            Text("Search"),
                          ],
                        ))
                      ]);
                },
                icon: Icon(Icons.more_horiz))
          ],
        ),
        body: _productContentList.length>0? Stack(
          children: [
            TabBarView(
              children: [
                ProductContentFirst(_productContentList),
                ProductContentSecond(_productContentList),
                ProductContentThird(_productContentList),
              ],
            ),
            Positioned(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(88),
              bottom: 0,
              child: Container(
                // color: Colors.red,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/cart');
                      },
                        child: Container(
                        padding: EdgeInsets.only(top: ScreenAdapter.height(8)),
                        width: 100,
                        height: ScreenAdapter.height(80),
                        // color: Colors.black26,
                        child: Column(
                          children: [
                            Icon(Icons.shopping_cart, size: ScreenAdapter.size(38)),
                            Text("Cart", style: TextStyle(fontSize: ScreenAdapter.size(24))),
                          ],
                        ))),
                    Expanded(
                        flex: 1,
                        child: JdButton(
                          color: Color.fromRGBO(253, 1, 0, 0.9),
                          text: "Add into cart",
                          cb: () async {

                            if (_productContentList[0].attr.length>0){
                              eventBus.fire(ProductContentEvent("Add into cart"));
                            } else {
                              // print("Add into cart");
                              await CartServices.addCart(_productContentList[0]);
                              Navigator.of(context).pop();
                              cartProvider.updateCartList();
                              Fluttertoast.showToast(
                                  msg: "Add into cart successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                              );
                            }

                          }
                        )),
                    Expanded(
                        flex: 1,
                        child: JdButton(
                            color: Color.fromRGBO(253, 165, 0, 0.9),
                            text: "Buy",
                            cb: (){
                              if (_productContentList[0].attr.length>0) {
                                eventBus.fire(ProductContentEvent("Buy"));
                              } else {
                                print("Buy");
                              }


                            }
                        )),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black26,
                        width: 1,
                      ),
                    ),
                    color: Colors.white),
              ),
            ),
          ],
        ): LoadingWidget(),
      ),
    );
  }
}
