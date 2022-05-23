import 'package:flutter/material.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:jdshop/services/signServices.dart';
import 'package:jdshop/services/userServices.dart';
import 'package:jdshop/widget/jdButton.dart';
import '../../config/config.dart';
import '../../widget/jdText.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import '../../services/eventBus.dart';
import 'package:event_bus/event_bus.dart';
class AddressAdd extends StatefulWidget {
  const AddressAdd({Key? key}) : super(key: key);

  @override
  State<AddressAdd> createState() => _AddressAddState();
}

class _AddressAddState extends State<AddressAdd> {
  String _area = "City";
  String _name = '';
  String _phone = '';
  String _address = '';

  @override
  dispose(){
    super.dispose();
    eventBus.fire(CheckOutEvent("Add"));
    eventBus.fire(AddressEvent("Add"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add address")),
        body: Container(
            padding: EdgeInsets.all(ScreenAdapter.height(20)),
            child: ListView(
              children: [
                SizedBox(height: ScreenAdapter.height(10)),
                JDText(
                  text: "Receiver",
                  onChanged: (value) {
                    _name = value;
                  },
                ),
                SizedBox(height: ScreenAdapter.height(10)),
                JDText(
                    text: "Phone number",
                    onChanged: (value) {
                      _phone = value;
                    }),
                SizedBox(height: ScreenAdapter.height(10)),
                Container(
                    padding: EdgeInsets.only(left: ScreenAdapter.height(5)),
                    height: ScreenAdapter.height(88),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1,
                      color: Colors.black12,
                    ))),
                    child: InkWell(
                      child: Row(
                        children: [
                          Icon(Icons.add_location),
                          Text("${_area}",
                              style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                      onTap: () async {
                        Result? result = await CityPickers.showCityPicker(
                          context: context,
                          // cancelWidget:
                          // confirmWidget:
                        );
                        print(result);
                        if (!mounted) {
                          return;
                        } else if (result == null) {
                          setState(() {
                            _area = "city";
                          });
                        } else {
                          setState(() {
                            _area =
                                "${result.provinceName}/${result.cityName}/${result.areaName}";
                          });
                        }
                      },
                    )),
                JDText(
                    text: "Mailing address",
                    maxLines: 4,
                    height: 200,
                    onChanged: (value) {
                      _address = "${_area} " + value;
                    }),
                SizedBox(height: ScreenAdapter.height(10)),
                // ElevatedButton(
                //   onPressed: () async {
                //     Result? result = await CityPickers.showCityPicker(
                //       context: context,
                //
                //     );
                //     // print(result);
                //   },
                //   child: Text("Select City"),
                // ),
                SizedBox(height: ScreenAdapter.height(40)),
                JdButton(
                  text: "Add",
                  color: Colors.red,
                  onTap: () async {
                    List userInfo = await UserServices.getUserInfo();
                    var tempJsonData = {
                      'uid': userInfo[0]['_id'],
                      'name': _name,
                      'phone': _phone,
                      'address': _address,
                      'salt': userInfo[0]['salt'],
                    };
                    var sign = SignServices.getSign(tempJsonData);
                    var api = "${Config.domain}/api/addAddress";
                    var result = await Dio().post(api, data: {
                      'uid': userInfo[0]['_id'],
                      'name': _name,
                      'phone': _phone,
                      'address': _address,
                      'sign': sign,

                    });
                    // print(result);
                    if (result.data['success']){
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )));
  }
}
