import 'package:flutter/material.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:jdshop/widget/jdButton.dart';
import '../../config/config.dart';

class ProductContentFirst extends StatefulWidget {
  List _productContentList;

  ProductContentFirst(
    this._productContentList, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductContentFirst> createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with SingleTickerProviderStateMixin {
  var _productContent;
  List _attr = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _productContent = widget._productContentList[0];
    _attr = _productContent.attr;
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];
    _attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: [
          Container(
              width: ScreenAdapter.width(120),
              child: Padding(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(28)),
                  child: Text(
                    "${attrItem.cate}:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))),
          Container(
            width: ScreenAdapter.width(580),
            child: Wrap(
              children: _getAttrItemWidget(attrItem),
            ),
          )
        ],
      ));
    });
    return attrList;
  }

  _getAttrItemWidget(attrItem){
    List <Widget> attrItemList = [];
    attrItem.list.forEach((item){
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: Chip(
          label: Text("${item}"),
          padding: EdgeInsets.all(10),
        )
      ));
    });
    return attrItemList;
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getAttrWidget(),
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
                                  cb: () {
                                    print("Add into cart");
                                  }),
                              margin: EdgeInsets.fromLTRB(10, 0, 5, 0))),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: JdButton(
                                color: Color.fromRGBO(253, 165, 0, 0.9),
                                text: "Buy",
                                cb: () {
                                  print("Buy");
                                }),
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
    String pic = Config.domain + '/' + _productContent.pic;
    pic = pic.replaceAll("\\", '/');
    return Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.network(pic, fit: BoxFit.cover)),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "${_productContent.title}",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: ScreenAdapter.size(36),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "${_productContent.subTitle}",
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
                            Text("\$${_productContent.price}",
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
                            Text("\$${_productContent.oldPrice}",
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
