import 'package:flutter/material.dart';
import '../../model/cateModel.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:dio/dio.dart';
import '../../config/config.dart';
import 'dart:convert';
import '../../widget/loadingWidget.dart';


class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  // late AnimationController _controller;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  int _selectedIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
    _getLeftCateData();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  _getLeftCateData() async {
    var api = '${Config.domain}/api/pcate';
    var result = await Dio().get(api);

    var leftCateList = result.data is Map
        ? CateModel.fromJson(result.data)
        : CateModel.fromJson(json.decode(result.data));

    setState(() {
      _leftCateList = leftCateList.result!;
    });
    _getRightCateData(leftCateList.result?[0].sId);
  }

  _getRightCateData(pid) async {
    var api = '${Config.domain}/api/pcate?pid=${pid}';
    var result = await Dio().get(api);

    var rightCateList = result.data is Map
        ? CateModel.fromJson(result.data)
        : CateModel.fromJson(json.decode(result.data));

    setState(() {
      _rightCateList = rightCateList.result!;
    });
  }

  Widget _leftCateWidget(leftWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
        child: ListView.builder(
            itemCount: this._leftCateList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    child: Container(
                      child: Text(
                        "${this._leftCateList[index].title}",
                        textAlign: TextAlign.center,
                      ),
                      width: double.infinity,
                      height: ScreenAdapter.height(84),
                      padding: EdgeInsets.only(top: ScreenAdapter.height(24)),
                      color: _selectedIndex == index
                          ? Color.fromRGBO(240, 246, 246, 0.9)
                          : Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        _getRightCateData(_leftCateList[index].sId);
                      });
                    },
                  ),
                  Divider(height: 1),
                ],
              );
            }),
        height: double.infinity,
        width: leftWidth,
        // color: Colors.redAccent,
      );
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (_rightCateList.length > 0) {
      return Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.all(10),
              height: double.infinity,
              color: Color.fromRGBO(240, 246, 246, 0.9),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: rightItemWidth / rightItemHeight,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _rightCateList.length,
                itemBuilder: (context, index) {
                  String pic = _rightCateList[index].pic;
                  pic = Config.domain + '/' + pic.replaceAll('\\', '/');
                  return InkWell(
                    child: Container(
                        // padding: EdgeInsets.all(10),
                        child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(pic, fit: BoxFit.cover),
                        ),
                        Container(
                          height: ScreenAdapter.height(28),
                          child: Text(_rightCateList[index].title),
                        ),
                      ],
                    )),
                    onTap: () {
                      // print('tap');
                      Navigator.pushNamed(context, '/productList', arguments: {
                        "cid": _rightCateList[index].sId,
                      });
                    },
                  );
                },
              )));
    } else {
      return Container(
        height: double.infinity,
        padding: EdgeInsets.all(10),
        color: Color.fromRGBO(240, 246, 246, 0.9),
        child: LoadingWidget(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var leftWidth = ScreenAdapter.getScreenWidth() / 4;
    // right width = screen width - left width - padding between each grid, and
    // container padding
    var rightItemWidth =
        (ScreenAdapter.getScreenWidth() - leftWidth - 20 - 20) / 3;
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    // height = image height + text height
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);

    return Scaffold(appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.center_focus_weak, size: 28, color: Colors.black87),
        onPressed: null,
      ),
      title: InkWell(
        child: Container(
          height: ScreenAdapter.height(68),
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.search),
              Text("Search",
                  style: TextStyle(fontSize: ScreenAdapter.size(28)))
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, "/search");
        },
      ),
      actions: [
        IconButton(
            onPressed: null,
            icon: Icon(Icons.message, size: 28, color: Colors.black87))
      ],
    ),
    body: Row(children: [
      _leftCateWidget(leftWidth),
      _rightCateWidget(rightItemWidth, rightItemHeight),
    ]),);
  }
}
