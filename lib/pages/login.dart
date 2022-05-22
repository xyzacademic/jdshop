import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jdshop/services/screenAdapter.dart';
import '../config/config.dart';
import '../widget/jdText.dart';
import '../widget/jdButton.dart';
import 'package:dio/dio.dart';
import '../services/storage.dart';
import '../services/eventBus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';


  @override
  dispose(){
    super.dispose();
    eventBus.fire(UserEvent('Login Successfully'));
  }
  doLogin() async {
    String _tel = username;
    RegExp reg = RegExp(r"^1\d{10}$");
    if (reg.hasMatch(_tel)) {
      // print('correct');
      var api = '${Config.domain}/api/doLogin';
      var response =
          await Dio().post(api, data: {"username": _tel, "password": password});
      if (response.data['success']) {
        print(response);
        Storage.setString('userInfo', json.encode(response.data['userinfo']));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: "${response.data['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Invalid phone number format",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [TextButton(onPressed: () {}, child: Text("Customer"))],
            title: Text("Login Page")),
        body: Container(
          padding: EdgeInsets.all(ScreenAdapter.width(30)),
          child: ListView(
            children: [
              Center(
                  child: Container(
                      margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
                      height: ScreenAdapter.height(160),
                      width: ScreenAdapter.width(160),
                      // width: double.infinity,
                      child: Text(
                        "SkillUp",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.blue,
                            fontSize: ScreenAdapter.size(40)),
                      ))),
              SizedBox(height: ScreenAdapter.height(30)),
              JDText(
                text: "Please enter your username",
                onChanged: (value) {
                  username = value;
                },
              ),
              SizedBox(height: ScreenAdapter.height(10)),
              JDText(
                text: "Please enter your password",
                password: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: ScreenAdapter.height(30)),
              Container(
                  padding: EdgeInsets.all(ScreenAdapter.height(20)),
                  child: Stack(
                    children: [
                      Align(
                        child: Text("Forgot password"),
                        alignment: Alignment.centerLeft,
                      ),
                      Align(
                        child: InkWell(
                          child: Text("Sign up"),
                          onTap: () {
                            Navigator.pushNamed(context, '/registerFirst');
                          },
                        ),
                        alignment: Alignment.centerRight,
                      )
                    ],
                  )),
              JdButton(
                text: "Login",
                color: Colors.red,
                height: 74,
                onTap: doLogin,
              )
            ],
          ),
        ));
  }
}
