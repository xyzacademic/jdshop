import 'package:flutter/material.dart';
import 'package:jdshop/services/signServices.dart';
import 'package:jdshop/services/userServices.dart';
import '../../config/config.dart';
import '../../services/eventBus.dart';
import '../../services/screenAdapter.dart';
import 'package:dio/dio.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List _addressList = [];

  _getAddressList() async {
    List userInfo = await UserServices.getUserInfo();
    var tempJson = {
      'uid': userInfo[0]['_id'],
      'salt': userInfo[0]['salt'],
    };
    var sign = SignServices.getSign(tempJson);
    var api =
        '${Config.domain}/api/addressList?uid=${userInfo[0]['_id']}&sign=${sign}';
    var result = await Dio().get(api);
    // print(result);
    if (!mounted) return;
    setState(() {
      _addressList = result.data['result'];
    });
  }

  @override
  void initState() {
    super.initState();
    _getAddressList();
    eventBus.on<AddressEvent>().listen((event) {
      _getAddressList();
    });
  }

  @override
  dispose(){
    super.dispose();
    eventBus.fire(CheckOutEvent("Add"));
  }
  _changeDefaultAddress(id_) async {
    List userInfo = await UserServices.getUserInfo();
    var tempJsonData = {
      'uid': userInfo[0]['_id'],
      'id': id_,
      'salt': userInfo[0]['salt'],
    };
    var sign = SignServices.getSign(tempJsonData);
    var api = "${Config.domain}/api/changeDefaultAddress";
    var result = await Dio().post(api, data: {
      'uid': userInfo[0]['_id'],
      'id': id_,
      'sign': sign,
    });
    if (result.data['success']) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Address List")),
        body: Container(
            child: Stack(
          children: [
            ListView.builder(
                itemCount: _addressList.length,
                itemBuilder: (context, index) {
                  return _addressList[index]['default_address'] == 1
                      ? Column(
                          children: [
                            SizedBox(height: ScreenAdapter.height(20)),
                            ListTile(
                              leading: Icon(Icons.check, color: Colors.red),
                              title: InkWell(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${_addressList[index]["name"]} ${_addressList[index]["phone"]}"),
                                      SizedBox(
                                          height: ScreenAdapter.height(10)),
                                      Text("${_addressList[index]["address"]}")
                                    ],
                                  ),
                                  onTap: () {
                                     _changeDefaultAddress(
                                        _addressList[index]['_id']);
                                  }),
                              trailing: Icon(Icons.edit, color: Colors.blue),
                            ),
                            Divider(height: ScreenAdapter.height(20)),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(height: ScreenAdapter.height(20)),
                            ListTile(
                              // leading: Icon(Icons.check, color: Colors.red),
                              title: InkWell(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${_addressList[index]["name"]} ${_addressList[index]["phone"]}"),
                                      SizedBox(
                                          height: ScreenAdapter.height(10)),
                                      Text("${_addressList[index]["address"]}")
                                    ],
                                  ),
                                  onTap: ()  {
                                     _changeDefaultAddress(
                                        _addressList[index]['_id']);
                                  }),
                              trailing: Icon(Icons.edit, color: Colors.blue),
                            ),
                            Divider(height: ScreenAdapter.height(20)),
                          ],
                        );
                }),
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
                      color: Colors.red,
                      border: Border(
                        top: BorderSide(width: 1, color: Colors.black26),
                      )),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        Text("Add mailing address",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/addressAdd');
                    },
                  )),
            )
          ],
        )));
  }
}
