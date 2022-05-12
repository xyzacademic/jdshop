import 'package:flutter/material.dart';
import 'package:jdshop/services/screenAdapter.dart';

class ProductContentFirst extends StatefulWidget {
  const ProductContentFirst({Key? key}) : super(key: key);

  @override
  State<ProductContentFirst> createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
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
    return Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                    "https://www.itying.com/images/flutter/p1.jpg",
                    fit: BoxFit.cover)
            ),
            Container(
              padding: EdgeInsets.only(top:10),
              child: Text("think pad 480 laptop",
              style: TextStyle(
                color: Colors.black87,
                fontSize: ScreenAdapter.size(36),
              ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:10),
              child: Text("xxxxxxxxxxxxxxx",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: ScreenAdapter.size(28),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Price"),
                        Text("\$23",
                            style: TextStyle(
                                color: Colors.red,
                            fontSize: ScreenAdapter.size(46))),
                      ]
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Original Price"),
                          Text("\$53",
                              style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenAdapter.size(28),
                              decoration: TextDecoration.lineThrough)),
                        ]
                    ),
                  ),
                ],
              )
            ),
            Container(
              margin: EdgeInsets.only(top:10),
              height: ScreenAdapter.height(80),
              child: Row(
                children: [
                  Text("Selected:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("115, black, XL, 1"),
                ],
              ),
            ),
            Divider(),
            Container(
                // margin: EdgeInsets.only(top: 10),
              height: ScreenAdapter.height(80),
              child: Row(
                children: [
                  Text("Deliver fee:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("No deliver fee"),
                ],
              )
            ),
            Divider(),

          ],
        ));
  }
}
