import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/screenAdapter.dart';
import '../../widget/jdButton.dart';
import '../../widget/jdText.dart';
import 'package:dio/dio.dart';
import '../../config/config.dart';
import '../../services/storage.dart';
import '../../pages/tabs/tab.dart';

class RegisterThirdPage extends StatefulWidget {
  Map? arguments;

  RegisterThirdPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<RegisterThirdPage> createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  late String _tel;
  late String _code;
  String _password = "";
  String _rpassword = "";

  @override
  void initState() {
    super.initState();
    _tel = widget.arguments?['tel'];
    _code = widget.arguments?['code'];
  }

  doRegister() async {
    if (_password.length < 6) {
      Fluttertoast.showToast(
        msg: "Password length should contain at least 6 characters",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (_rpassword != _password) {
      Fluttertoast.showToast(
        msg: "re-enter password doesn't match with password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      var api = '${Config.domain}/api/register';
      var response = await Dio()
          .post(api, data: {"tel": _tel, 'code': _code, 'password': _password});
      if (response.data['success']) {
        print(response);
        Storage.setString('userInfo', json.encode(response.data['userinfo']));

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Tabs()),
            (route) => route == null);
      } else {
        Fluttertoast.showToast(
          msg: "${response.data['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Register - third step")),
        body: Container(
            padding: EdgeInsets.all(ScreenAdapter.height(50)),
            child: ListView(
              children: [
                SizedBox(height: ScreenAdapter.height(20)),
                // SizedBox(height: ScreenAdapter.height(10)),
                JDText(
                  text: "Please enter your password",
                  password: true,
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                SizedBox(height: ScreenAdapter.height(20)),
                JDText(
                  text: "Please enter your password again",
                  password: true,
                  onChanged: (value) {
                    _rpassword = value;
                  },
                ),
                SizedBox(height: ScreenAdapter.height(20)),
                JdButton(
                    text: "Sign up",
                    color: Colors.red,
                    height: 74,
                    onTap: doRegister)
              ],
            )));
  }
}
