import 'package:flutter/material.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:jdshop/widget/jdButton.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("sdf"),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(80), 0, 0),
                padding: EdgeInsets.all(ScreenAdapter.height(16)),
                child: ListView(
              children: [
                Card(
                    child: Column(
                  children: [
                    ListTile(title: Text("Order number")),
                    SizedBox(height: ScreenAdapter.height(20)),
                    ListTile(
                      leading: Container(
                          width: ScreenAdapter.width(80),
                          height: ScreenAdapter.width(80),
                          child: Image.network(
                              "http://www.itying.com/images/flutter/list2.jpg",
                              fit: BoxFit.cover)),
                      title: Text(
                        "xxxxxxxxx",
                        maxLines: 1,
                      ),
                      trailing: Text('x1'),
                    ),
                    ListTile(
                      leading: Text("Sum price: \$345"),
                      trailing: TextButton(
                        child: Text("client services"),
                        onPressed: () {},
                      ),
                    )
                  ],
                )),
                Card(
                    child: Column(
                      children: [
                        ListTile(title: Text("Order number")),
                        SizedBox(height: ScreenAdapter.height(20)),
                        ListTile(
                          leading: Container(
                              width: ScreenAdapter.width(80),
                              height: ScreenAdapter.width(80),
                              child: Image.network(
                                  "http://www.itying.com/images/flutter/list2.jpg",
                                  fit: BoxFit.cover)),
                          title: Text(
                            "xxxxxxxxx",
                            maxLines: 1,
                          ),
                          trailing: Text('x1'),
                        ),
                        ListTile(
                          leading: Text("Sum price: \$345"),
                          trailing: TextButton(
                            child: Text("client services"),
                            onPressed: () {},
                          ),
                        )
                      ],
                    )),
                Card(
                    child: Column(
                      children: [
                        ListTile(title: Text("Order number")),
                        SizedBox(height: ScreenAdapter.height(20)),
                        ListTile(
                          leading: Container(
                              width: ScreenAdapter.width(80),
                              height: ScreenAdapter.width(80),
                              child: Image.network(
                                  "http://www.itying.com/images/flutter/list2.jpg",
                                  fit: BoxFit.cover)),
                          title: Text(
                            "xxxxxxxxx",
                            maxLines: 1,
                          ),
                          trailing: Text('x1'),
                        ),
                        ListTile(
                          leading: Text("Sum price: \$345"),
                          trailing: TextButton(
                            child: Text("client services"),
                            onPressed: () {},
                          ),
                        )
                      ],
                    )),
              ],
            )),
            // SizedBox(height: ScreenAdapter.height(100)),
            Positioned(
              top: 0,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(76),
              child: Container(
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(76),
                  color: Colors.white,
                  child: Row(
                children: [
                  Expanded(child: Text('All', textAlign: TextAlign.center)),
                  Expanded(child: Text('All', textAlign: TextAlign.center)),
                  Expanded(child: Text('All', textAlign: TextAlign.center)),
                  Expanded(child: Text('All', textAlign: TextAlign.center)),
                ],
              )),
            )
          ],
        ));
  }
}
