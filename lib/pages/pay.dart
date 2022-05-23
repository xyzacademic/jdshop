import 'package:flutter/material.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:jdshop/widget/jdButton.dart';

class PayPage extends StatefulWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List _payList = [
    {
      "title": "AliPay",
      "checked": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "Wechat Pay",
      "checked": false,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Go to pay")),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.all(ScreenAdapter.height(20)),
                height: ScreenAdapter.height(400),
                child: ListView.builder(
                    itemCount: _payList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading:
                                Image.network("${_payList[index]['image']}"),
                            title: Text("${_payList[index]['title']}"),
                            trailing: _payList[index]['checked']
                                ? Icon(Icons.check)
                                : Text(""),
                            onTap: () {
                              for (var i = 0; i < _payList.length; i++) {
                                setState(() {
                                  _payList[i]['checked'] = i == index;
                                });
                              }
                            },
                          ),
                          Divider(),
                        ],
                      );
                    })),
            JdButton(
              text: "Pay",
              color: Colors.red,
              height: 74,
              onTap: () {},
            )
          ],
        ));
  }
}
