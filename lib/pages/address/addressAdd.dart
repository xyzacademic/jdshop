import 'package:flutter/material.dart';
import 'package:jdshop/services/screenAdapter.dart';
import 'package:jdshop/widget/jdButton.dart';
import '../../widget/jdText.dart';
import 'package:city_pickers/city_pickers.dart';

class AddressAdd extends StatefulWidget {
  const AddressAdd({Key? key}) : super(key: key);

  @override
  State<AddressAdd> createState() => _AddressAddState();
}

class _AddressAddState extends State<AddressAdd> {
  String _area = "City";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add address")),
        body: Container(
            padding: EdgeInsets.all(ScreenAdapter.height(20)),
            child: ListView(
              children: [
                SizedBox(height: ScreenAdapter.height(10)),
                JDText(text: "Receiver"),
                SizedBox(height: ScreenAdapter.height(10)),
                JDText(text: "Phone number"),
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
                            _area ="city";
                          });
                        } else {
                          setState(() {
                            _area =
                                "${result.provinceName}/${result.cityName}/${result.areaName}";
                          });
                        }
                      },
                    )),
                JDText(text: "Mailing address", maxLines: 4, height: 200),
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
                ),
              ],
            )));
  }
}
