import 'package:flutter/material.dart';
import 'package:jdshop/services/cartServices.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:jdshop/widget/jdButton.dart';
import '../../config/config.dart';
import '../../services/eventBus.dart';
import 'cartNumber.dart';
import '../../../provider/cart.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    with AutomaticKeepAliveClientMixin {
  var _productContent;
  List _attr = [];
  String _selectedValue = "";
  var _actionEventBus;

  bool get wantKeepAlive => true;
  var cartProvider;

  @override
  void initState() {
    super.initState();
    _productContent = widget._productContentList[0];
    _attr = _productContent.attr;
    _initAttr();

    _getSelectedAttrValue();
    _actionEventBus = eventBus.on<ProductContentEvent>().listen((str) {
      // print(str);
      _attrBottomSheet();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _actionEventBus.cancel();
  }

  _initAttr() {
    var attr = _attr;
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({
            "title": attr[i].list[j],
            "checked": true,
          });
        } else {
          attr[i].attrList.add({
            "title": attr[i].list[j],
            "checked": false,
          });
        }
      }
    }
    print(attr[0].attrList);
  }

  List<Widget> _getAttrWidget(setBottomState) {
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
              children: _getAttrItemWidget(attrItem, setBottomState),
            ),
          )
        ],
      ));
    });
    return attrList;
  }

  _changeAttr(cate, title, setBottomState) {
    var attr = _attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]["checked"] = false;
          if (title == attr[i].attrList[j]["title"]) {
            attr[i].attrList[j]["checked"] = true;
          }
        }
      }
    }
    setBottomState(() {
      _attr = attr;
      _getSelectedAttrValue();
    });
  }

  _getSelectedAttrValue() {
    var _list = _attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].attrList.length; j++) {
        if (_list[i].attrList[j]["checked"] == true) {
          tempArr.add(_list[i].attrList[j]["title"]);
        }
      }
    }

    setState(() {
      _selectedValue = tempArr.join(', ');
      _productContent.selectedAttr = _selectedValue;
    });
  }

  _getAttrItemWidget(attrItem, setBottomState) {
    String cate = attrItem.cate;
    List<Widget> attrItemList = [];
    attrItem.attrList.forEach((item) {
      attrItemList.add(Container(
          margin: EdgeInsets.all(10),
          child: InkWell(
            child: Chip(
              label: Text("${item["title"]}",
                  style: TextStyle(
                      color: item["checked"] ? Colors.white : Colors.black54)),
              padding: EdgeInsets.all(10),
              backgroundColor: item["checked"] ? Colors.red : Colors.black26,
            ),
            onTap: () {
              _changeAttr(cate, item["title"], setBottomState);
            },
          )));
    });
    return attrItemList;
  }

  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, setBottomState) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _getAttrWidget(setBottomState),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: ScreenAdapter.height(80),
                        child: Row(
                          children: [
                            Text("Numbers: ",
                                style:
                                TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 10),
                            CartNumber(_productContent),
                          ],
                        ),
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
                                    onTap: () async {
                                      print("Add into cart");
                                      await CartServices.addCart(
                                          _productContent);
                                      Navigator.of(context).pop();
                                      cartProvider.updateCartList();
                                      Fluttertoast.showToast(
                                        msg: "Add into cart successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                      );
                                    }),
                                margin: EdgeInsets.fromLTRB(10, 0, 5, 0))),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: JdButton(
                                  color: Color.fromRGBO(253, 165, 0, 0.9),
                                  text: "Buy",
                                  onTap: () {
                                    print("Buy");
                                  }),
                              margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                            )),
                      ],
                    ))
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<Cart>(context);
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
            _attr.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    height: ScreenAdapter.height(80),
                    child: InkWell(
                      child: Row(
                        children: [
                          Text("Selected: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("${_selectedValue}"),
                        ],
                      ),
                      onTap: () {
                        _attrBottomSheet();
                      },
                    ),
                  )
                : Text(""),
            Divider(),
            Container(
                // margin: EdgeInsets.only(top: 10),
                height: ScreenAdapter.height(80),
                child: Row(
                  children: [
                    Text("Deliver fee: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("No deliver fee"),
                  ],
                )),
            Divider(),
          ],
        ));
  }
}
