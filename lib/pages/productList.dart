import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/config.dart';
import 'dart:convert';
import 'package:jdshop/services/screenAdapter.dart';
import '../model/productModel.dart';
import '../widget/loadingWidget.dart';

class ProductListPage extends StatefulWidget {
  Map? arguments;

  ProductListPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  ScrollController _scrollController = ScrollController();
  // initial page index
  int _page = 1;
  List _productList = [];
  String _sort = "";
  bool _flag = true;
  int _pageSize = 8;
  bool _hasMore = true;
  List _subHeaderList = [
    {
      "id": 1,
      "title": "All",
      "fields": "all",
      "sort": -1,
    },
    {
      "id": 2,
      "title": "Sold",
      "fields": "salecount",
      "sort": -1,
    },
    {
      "id": 3,
      "title": "Price",
      "fields": "price",
      "sort": -1,
    },
    {
      "id": 4,
      "title": "Filter",
    },

  ];
  int _selectHeaderId = 1;
  var _cid;
  var _keywords;
  bool _hasData = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // set value in search box
  var _initKeywordsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cid = widget.arguments?["cid"];
    print(_cid == null);
    print(_cid);
    _keywords = widget.arguments?["keywords"];
    _initKeywordsController.text = _keywords == null? "": _keywords;
    // assign value to search box
    // widget.arguments?["keywords"] == null? _initKeywordsController.text = "":
    // _initKeywordsController.text = widget.arguments?["keywords"];
    // _controller = AnimationController(vsync: this);
    _getProductListData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (_flag && _hasMore) {
          _getProductListData();
        }
      }
    });

  }

  _getProductListData() async {
    setState(() {
      _flag = false;
    });
    var api;

    if (_keywords == null){
      print("go cid");
      api =
          '${Config.domain}/api/plist?cid=${_cid}&page=${_page}&sort=${_sort}&pageSize=${_pageSize}';

    } else {
      print("go keywords");
      api =
          // '${Config.domain}/api/plist?search=${widget.arguments?["keywords"]}&page=${_page}&sort=${_sort}&pageSize=${_pageSize}';
      '${Config.domain}/api/plist?search=${_keywords}&page=${_page}&sort=${_sort}&pageSize=${_pageSize}';
    }

        var result = await Dio().get(api);
    // print(api);
    var productList = result.data is Map
        ? ProductModel.fromJson(result.data)
        : ProductModel.fromJson(json.decode(result.data));

    if (productList.result?.length == 0 && _page == 1){
      setState(() {
        _hasData = false;
      });
    } else{
      _hasData = true;
    }

    var currentLength = productList.result?.length;
    if (currentLength! < _pageSize) {
      setState(() {
        _productList.addAll(productList.result!);
        _hasMore = false;
      });
    } else {
      setState(() {
        _productList.addAll(productList.result!);
        _page++;
        _flag = true;
      });

    }

  }

  //


  _subHeaderChange(id) async {
    if (id == 4) {
    setState(() {
      _selectHeaderId = id;
      _scaffoldKey.currentState?.openEndDrawer();
    });
    } else {
      setState(() {
        _selectHeaderId = id;
        _sort = "${_subHeaderList[id-1]['fields']}_${_subHeaderList[id-1]['sort']}";
        // reset page
        _page = 1;
        // empty product list
        _productList = [];

        // back to top
        _scrollController.jumpTo(0);

        // reset hasMore
        _hasMore = true;

        //
        _subHeaderList[id-1]['sort'] *= -1;
        // load product data again
        _getProductListData();
      });
    }
  }
  Widget _showMore(index, page){
    if(_hasMore){
      return index == (_productList.length - 1) ? LoadingWidget() : Text("");
    } else{
      return (index == (_productList.length - 1) && (page > 1)) ? Text("Already reach the end"): Text("");
    }
  }

  // show icon

  Widget _showIcon(id){
    if (id == 2 || id == 3){
      if (_subHeaderList[id-1]["sort"] == 1){
        return Icon(Icons.arrow_drop_down);
      } else{
        return Icon(Icons.arrow_drop_up);
      }

    } else{
      return Text("");
    }
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdapter.height(80),
      width: ScreenAdapter.width(750),
      child: Container(
        height: ScreenAdapter.height(80),
        width: ScreenAdapter.width(750),
        // color: Colors.red,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
        child: Row(children: _subHeaderList.map((value){
          return Expanded(
            flex: 1,
            child: InkWell(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdapter.height(20), 0, ScreenAdapter.height(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${value['title']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (_selectHeaderId == value["id"])?Colors.red: Colors.black54,
                          )),
                      _showIcon(value["id"]),
                    ],
                  ),
              ),
              onTap: () {
                _subHeaderChange(value["id"]);
              },
            ),
          );
        }).toList()
        ),
      ),
    );
  }

  Widget _productListWidget() {
    if (_productList.length > 0) {
      return Container(
          margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _productList.length,
            itemBuilder: (context, index) {
              String pic = _productList[index].pic;
              pic = Config.domain + '/' + pic.replaceAll('\\', '/');
              return Column(children: <Widget>[
                Row(children: <Widget>[
                  Container(
                      width: ScreenAdapter.width(180),
                      height: ScreenAdapter.height(180),
                      child: Image.network(
                        pic,
                        fit: BoxFit.cover,
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                          // width: ScreenAdapter.width(180),
                          height: ScreenAdapter.height(180),
                          margin:
                              EdgeInsets.only(left: ScreenAdapter.width(10)),
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${_productList[index].title}",
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                              Row(
                                children: [
                                  Container(
                                    height: ScreenAdapter.height(36),
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(230, 230, 230, 0.9),
                                    ),
                                    child: Text("4g"),
                                  ),
                                  Container(
                                    height: ScreenAdapter.height(36),
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(230, 230, 230, 0.9),
                                    ),
                                    child: Text("5g"),
                                  ),
                                ],
                              ),
                              Text("${_productList[index].price}",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16))
                            ],
                          ))),
                ]),
                Divider(height: 20),
                _showMore(index, _page),
              ]);
            },
          ));
    } else {
      return LoadingWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.height(68),
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            autofocus: false,
            controller: _initKeywordsController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30))),
            onChanged: (value){
              setState(() {
                _keywords = value;
              });
            },
          ),

        ),
        actions: [
          InkWell(
            child: Container(
                height: ScreenAdapter.height(68),
                width: ScreenAdapter.width(102),
                child: Row(
                  children: [
                    Text("Search"),
                  ],
                )),
            onTap: () {
              _subHeaderChange(1);
            },
          )
        ],
      ),
      body: _hasData? Stack(
        children: [
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ): Center(
        child: Text("No records found")
      ),
      endDrawer: Drawer(
          child: Container(
        child: Text("Filter function"),
      )),
    );
  }
}
