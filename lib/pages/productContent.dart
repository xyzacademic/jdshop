import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';
import 'productContent/productContentFirst.dart';
import 'productContent/productContentSecond.dart';
import 'productContent/productContentThird.dart';
import '../widget/jdButton.dart';

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Stack(
          children: [
            TabBarView(
              children: [
                ProductContentFirst(),
                ProductContentSecond(),
                ProductContentThird(),
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
                    Container(
                        padding: EdgeInsets.only(top: ScreenAdapter.height(8)),
                        width: 100,
                        height: ScreenAdapter.height(80),
                        // color: Colors.black26,
                        child: Column(
                          children: [
                            Icon(Icons.shopping_cart, size: ScreenAdapter.size(38)),
                            Text("Cart", style: TextStyle(fontSize: ScreenAdapter.size(24))),
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: JdButton(
                          color: Color.fromRGBO(253, 1, 0, 0.9),
                          text: "Add into cart",
                          cb: (){
                            print("Add into cart");
                          }
                        )),
                    Expanded(
                        flex: 1,
                        child: JdButton(
                            color: Color.fromRGBO(253, 165, 0, 0.9),
                            text: "Buy",
                            cb: (){
                              print("Buy");
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
        ),
      ),
    );
  }
}
