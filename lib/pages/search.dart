import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
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

  var _keywords;

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
              onChanged: (value){
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
                  Navigator.pushReplacementNamed(context, '/productList', arguments:{
                    "keywords": _keywords
                  });
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
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text("Woman dress")
                  )
                ],

              ),
              SizedBox(height: 10),
              Container(
                child: Text("Search History",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Divider(),
              Column(
                children: [
                  ListTile(
                    title: Text("Woman dress"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Man dress")
                  ),
                  Divider(),
                ],
              ),
              SizedBox(height: 100),
              InkWell(
                child: Container(
                    width: ScreenAdapter.width(400),
                    height: ScreenAdapter.height(104),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(233, 233, 233, 0.9),
                          width: 1,
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete),
                        Text("Empty search history")
                      ],
                    )
                ),
                onTap: (){

                },
              )

            ],
          )
        ),

    );
  }
}
