import 'package:flutter/material.dart';
import 'package:jdshop/services/searchServices.dart';
import '../services/screenAdapter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var _keywords;
  List _historyListData = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    _getHistoryData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _getHistoryData() async {
    var historyListData = await SearchServices.getHistoryList();
    setState(() {
      _historyListData = historyListData;
    });
  }

  _alertDialog(keywords) async {
    var result = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Important message!!"),
            content: Text("Do you want to delete?"),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    await SearchServices.removeHistoryList(keywords);
                    _getHistoryData();
                    Navigator.pop(context, "Ok");
                  },

                  child: Text("Ok")),

              ElevatedButton(
                  onPressed: () {
                    print("Cancel");
                    Navigator.pop(context, "Cancel");
                  },
                  child: Text("Cancel")),

            ],
          );
        });
  }

  Widget _historyListWidget() {
    // print("length ${_historyListData.length}");
    if (_historyListData.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("Search History",
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Divider(),
          Column(
            children: _historyListData.map((value) {
              return Column(
                children: [
                  ListTile(
                    title: Text("${value}"),
                    onLongPress: () {
                      _alertDialog("$value");
                    },
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                    width: ScreenAdapter.width(400),
                    height: ScreenAdapter.height(64),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      width: 1,
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete),
                        Text("Empty search history")
                      ],
                    )),
                onTap: () {
                  SearchServices.clearHistoryList();
                  _getHistoryData();
                },
              )
            ],
          ),
        ],
      );
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.height(68),
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30))),
            onChanged: (value) {
              _keywords = value;
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
              // save searched keywords
              SearchServices.setHistoryList(_keywords);
              // swap to target page
              Navigator.pushReplacementNamed(context, '/productList',
                  arguments: {"keywords": _keywords});
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                child: Text("Hot search",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Divider(),
              Wrap(
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(233, 233, 233, 0.9),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("Woman dress"))
                ],
              ),
              SizedBox(height: 10),
              _historyListWidget(),
            ],
          )),
    );
  }
}
