import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import '../../model/focusModel.dart';
import '../../model/productModel.dart';
import '../../services/screenAdapter.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../config/config.dart';
import '../../widget/loadingWidget.dart';
import '../../services/searchServices.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];

  @override
  void initState() {
    super.initState();

    _getFocusData();
    _getHotProductData();
    _getBestProductData();
    // SearchServices.setHistoryList("");
  }

  _getFocusData() async {
    var api = '${Config.domain}/api/focus';
    var result = await Dio().get(api);
    var focusList = result.data is Map
        ? FocusModel.fromJson(result.data)
        : FocusModel.fromJson(json.decode(result.data));

    setState(() {
      _focusData = focusList.result!;
    });
  }

  _getHotProductData() async {
    var api = '${Config.domain}/api/plist?is_hot=1';
    var result = await Dio().get(api);

    var hotProductList = result.data is Map
        ? ProductModel.fromJson(result.data)
        : ProductModel.fromJson(json.decode(result.data));

    setState(() {
      _hotProductList = hotProductList.result!;
    });
  }

  _getBestProductData() async {
    var api = '${Config.domain}/api/plist?is_best=1';
    var result = await Dio().get(api);

    var bestProductList = result.data is Map
        ? ProductModel.fromJson(result.data)
        : ProductModel.fromJson(json.decode(result.data));

    setState(() {
      _bestProductList = bestProductList.result!;
    });
  }

  @override
  void dispose() {

    super.dispose();
  }

  Widget _swiperWidget() {
    if (_focusData.length > 0) {
      return Container(
          child: AspectRatio(
              aspectRatio: 2 / 1,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  String pic = _focusData[index].pic;
                  return Image.network(
                    '${Config.imgDomain}/${pic.replaceAll("\\", "/")}',
                    fit: BoxFit.fill,
                  );
                },
                itemCount: _focusData.length,
                pagination: const SwiperPagination(),
                autoplay: true,
              )));
    } else {
      return LoadingWidget();
    }
  }

  Widget _titleWidget(value) {
    return Container(
        height: ScreenAdapter.height(34),
        margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
        padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
            color: Colors.red,
            width: ScreenAdapter.width(10),
          )),
        ),
        child: Text(value,
            style: TextStyle(
                color: Colors.black54, fontSize: ScreenAdapter.size(26))));
  }

  Widget _userLikeList() {
    if (_hotProductList.length > 0) {
      return Container(
          height: ScreenAdapter.height(220),
          width: double.infinity,
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          child: ListView.builder(

            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String sPic = this._hotProductList[index].sPic;
              sPic = Config.domain + '/' + sPic.replaceAll('\\', '/');
              return Column(children: <Widget>[
                Container(
                  height: ScreenAdapter.height(140),
                  width: ScreenAdapter.width(140),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(21)),
                  child: Image.network(
                      sPic,
                      fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                  height: ScreenAdapter.height(34),
                  child: Text("\$${this._hotProductList[index].price}",
                      style: TextStyle(color: Colors.red)),
                ),
              ]);
            },
            itemCount: this._hotProductList.length,
          ));
    } else {
      return Text("");
    }
  }

  Widget _recProductListWidget(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this._bestProductList.map((value){
          return _recProductList(value);
        }).toList(),
      ),
    );
  }

  Widget _recProductList(value) {
    var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;
    var sImg = value.sPic;
    sImg = Config.domain + '/' + sImg.replaceAll('\\', '/');
      return InkWell(
        child: Container(
            padding: EdgeInsets.all(10),
            width: itemWidth,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(233, 233, 233, 0.9),
                  width: 1,
                )),
            child: Column(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                            sImg,
                            fit: BoxFit.cover))),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                  child: Text(value.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                      )),
                ),
                Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          child: Text("\$${value.price}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              )),
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                          child: Text("\$${value.oldPrice}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                              )),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    )),
              ],
            )
        ),
        onTap: (){
          Navigator.pushNamed(context, '/productContent',
          arguments: {"id": value.sId});
        }
      );


  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _swiperWidget(),
        SizedBox(height: ScreenAdapter.height(20)),
        _titleWidget("Guess what you will like."),
        SizedBox(height: ScreenAdapter.height(20)),
        _userLikeList(),
        // SizedBox(height: ScreenAdapter.height(20)),
        _titleWidget("Recommend"),
        _recProductListWidget(),
      ],
    );
  }


}
