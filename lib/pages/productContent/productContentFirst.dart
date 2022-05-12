import 'package:flutter/material.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:jdshop/widget/jdButton.dart';

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

  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Wrap(
                          children: [
                            Container(
                                width: ScreenAdapter.width(100),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenAdapter.height(22)),
                                    child: Text(
                                      "Color:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Container(
                              width: ScreenAdapter.width(610),
                              child: Wrap(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                        label: Text("White"),
                                        padding: EdgeInsets.all(10)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                        label: Text("Red"),
                                        padding: EdgeInsets.all(10)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          children: [
                            Container(
                                width: ScreenAdapter.width(100),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenAdapter.height(22)),
                                    child: Text(
                                      "Style:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Container(
                              width: ScreenAdapter.width(610),
                              child: Wrap(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                        label: Text("White"),
                                        padding: EdgeInsets.all(10)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                        label: Text("Red"),
                                        padding: EdgeInsets.all(10)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          children: [
                            Container(
                                width: ScreenAdapter.width(100),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenAdapter.height(22)),
                                    child: Text(
                                      "Size:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Container(
                              width: ScreenAdapter.width(610),
                              child: Wrap(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                        label: Text("White"),
                                        padding: EdgeInsets.all(10)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                        label: Text("Red"),
                                        padding: EdgeInsets.all(10)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(76),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: JdButton(
                                color: Color.fromRGBO(253, 1, 0, 0.9),
                                text: "Add into cart",
                                cb: (){
                                  print("Add into cart");
                                }
                            ),
                            margin: EdgeInsets.fromLTRB(10, 0, 5, 0)
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: JdButton(
                                color: Color.fromRGBO(253, 165, 0, 0.9),
                                text: "Buy",
                                cb: (){
                                  print("Buy");
                                }
                            ),
                              margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                          )),
                    ],
                  ))
            ],
          );
        });
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
                    fit: BoxFit.cover)),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "think pad 480 laptop",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: ScreenAdapter.size(36),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "xxxxxxxxxxxxxxx",
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
                          ]),
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
                          ]),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: ScreenAdapter.height(80),
              child: InkWell(
                child: Row(
                  children: [
                    Text("Selected:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("115, black, XL, 1"),
                  ],
                ),
                onTap: () {
                  _attrBottomSheet();
                },
              ),
            ),
            Divider(),
            Container(
                // margin: EdgeInsets.only(top: 10),
                height: ScreenAdapter.height(80),
                child: Row(
                  children: [
                    Text("Deliver fee:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("No deliver fee"),
                  ],
                )),
            Divider(),
          ],
        ));
  }
}
