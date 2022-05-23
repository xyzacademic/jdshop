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

class AddressEdit extends StatefulWidget {
  Map? arguments;
  AddressEdit({Key? key, this.arguments}) : super(key: key);

  @override
  State<AddressEdit> createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {
  String _area = "City";
  String _name = '';
  String _phone = '';
  String _address = '';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();



  @override
  void initState(){
    super.initState();

    _nameController.text = widget.arguments?['name'];
    _phoneController.text = widget.arguments?['phone'];
    _addressController.text = widget.arguments?['address'];
  }

  dispose(){
    super.dispose();
    // eventBus.fire(CheckOutEvent("Add"));
    eventBus.fire(AddressEvent("Edit"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Edit address")
        ),
        body: Container(
            padding: EdgeInsets.all(ScreenAdapter.height(20)),
            child: ListView(
              children: [
                SizedBox(height: ScreenAdapter.height(10)),
                JDText(
                  text: "Receiver",
                  controller: _nameController,
                  onChanged: (value) {
                    _nameController.text = value;
                  },
                ),
                SizedBox(height: ScreenAdapter.height(10)),
                JDText(
                    text: "Phone number",
                    controller: _phoneController,
                    onChanged: (value) {
                      _phoneController.text = value;
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
                    controller: _addressController,
                    maxLines: 4,
                    height: 200,
                    onChanged: (value) {
                      _addressController.text = "${_area} " + value;
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
                  text: "Save",
                  color: Colors.red,
                  onTap: () async {
                    List userInfo = await UserServices.getUserInfo();
                    var tempJsonData = {
                      'uid': userInfo[0]['_id'],
                      'name': _nameController.text,
                      'id': widget.arguments?['id'],
                      'phone': _phoneController.text,
                      'address': _addressController.text,
                      'salt': userInfo[0]['salt'],
                    };
                    var sign = SignServices.getSign(tempJsonData);
                    var api = "${Config.domain}/api/editAddress";
                    var result = await Dio().post(api, data: {
                      'uid': userInfo[0]['_id'],
                      'id': widget.arguments?['id'],
                      'name': _nameController.text,
                      'phone': _phoneController.text,
                      'address': _addressController.text,
                      'sign': sign,

                    });
                    // print(result);
                    if (result.data['success']){
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )),
    );
  }
}
