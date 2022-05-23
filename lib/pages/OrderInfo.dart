import 'package:flutter/material.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:jdshop/widget/jdButton.dart';

class OrderInfoPage extends StatefulWidget {
  const OrderInfoPage({Key? key}) : super(key: key);

  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order details")
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              child:Column(
                children: [
                  SizedBox(height: ScreenAdapter.height(10)),
                  ListTile(
                    leading: Icon(Icons.add_location),
                    title:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Zhang San 15209090909"),
                        SizedBox(height: ScreenAdapter.height(10)),
                        Text("403 N 2nd st")
                      ],
                    ),

                  ),
                  SizedBox(height: ScreenAdapter.height(10)),

                ],
              )
            )
          ],
        ),
      )
    );
  }
}
