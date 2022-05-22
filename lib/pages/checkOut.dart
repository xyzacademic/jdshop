import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';
import '../provider/checkOut.dart';
import '../widget/jdText.dart';
import '../widget/jdButton.dart';
import 'package:dio/dio.dart';
import '../services/storage.dart';
import '../services/eventBus.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Widget _checkOutItem(item) {
    return Row(
      children: [
        Container(
          width: ScreenAdapter.width(160),
          child: Image.network(
              "${item['pic']}",
              fit: BoxFit.cover),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item['title']}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${item['selectedAttr']}",
                    maxLines: 2,
                  ),
                  Stack(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("\$${item['price']}",
                              style: TextStyle(color: Colors.red))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("x${item['count']}"),
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var checkOutProvider = Provider.of<CheckOut>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Check out"),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: ScreenAdapter.height(10)),
                        ListTile(
                          leading: Icon(Icons.add_location),
                          title: Text("Please add your mailing address."),
                          trailing: Icon(Icons.navigate_next),
                          onTap: (){
                            Navigator.pushNamed(context, '/addressList');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.add_location),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("zhang san 15209090909"),
                              SizedBox(height: ScreenAdapter.height(10)),
                              Text("403 N 2nd ST")
                            ],
                          ),
                          trailing: Icon(Icons.navigate_next),
                        ),
                        SizedBox(height: ScreenAdapter.height(10)),
                      ],
                    )),
                SizedBox(height: ScreenAdapter.height(20)),
                Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(ScreenAdapter.width(20)),
                    child: Column(
                      children: checkOutProvider.checkOutListData.map((value){
                        return Column(
                          children: [
                            _checkOutItem(value),
                            Divider(),

                          ],
                        );
                      }).toList(),
                    )),
                SizedBox(height: ScreenAdapter.height(20)),
                Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(ScreenAdapter.height(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sum Price: \$100"),
                        Divider(),
                        Text(" reduced \$5"),
                        Divider(),
                        Text(" Express fee: \$4"),
                        Divider(),
                      ],
                    ))
              ],
            ),
            SizedBox(height: ScreenAdapter.height(100)),
            Positioned(
              bottom: 0,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              child: Container(
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(100),
                  padding: EdgeInsets.all(ScreenAdapter.height(10)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide( width: 1, color: Colors.black26),

                    )
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(" Sum price: \$140",
                        style: TextStyle(
                          color: Colors.red,
                        )
                        )
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          child: Text("Check out",
                            style: TextStyle(color: Colors.white),
                          ),

                          onPressed: (){},

                        )
                      )
                    ],
                  )),
            ),
          ],
        ));
  }
}
