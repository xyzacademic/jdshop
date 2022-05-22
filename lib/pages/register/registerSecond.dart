import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../config/config.dart';
import '../../services/screenAdapter.dart';
import '../../widget/jdButton.dart';
import '../../widget/jdText.dart';
import 'package:dio/dio.dart';

class RegisterSecondPage extends StatefulWidget {
  Map? arguments;

  RegisterSecondPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  late String _tel;
  late String _code;
  bool sendCodeBtn = false;
  int seconds = 10;
  var api = '${Config.domain}/api/sendCode';

  @override
  void initState() {
    super.initState();
    _tel = widget.arguments?['tel'];
    showTimer();
  }

  showTimer(){
    late Timer t;
    t = Timer.periodic(Duration(milliseconds: 1000), (timer){
      setState((){
        if(seconds>0){
          seconds--;
        }
      });
      if (seconds == 0){
        t.cancel();
        sendCodeBtn = true;
      }
    });

  }

  sendCode() async {
    RegExp reg = RegExp(r"^1\d{10}$");
    if (reg.hasMatch(_tel)) {
      print('correct');
      setState((){
        sendCodeBtn = false;
        seconds = 10;
        showTimer();
      });
      var response = await Dio().post(api, data: {"tel": _tel});
      if (response.data['success']) {
        print(response);
        // Navigator.pushNamed(context, '/registerSecond',
        //     arguments: {'tel': _tel});

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

  validateCode() async {
    var verifyApi = '${Config.domain}/api/validateCode';
    var response = await Dio().post(verifyApi, data: {"tel": _tel, 'code': _code});
    if(response.data['success']){

      Navigator.pushNamed(context, '/registerThird', arguments: {'tel': _tel, 'code': _code});
    } else {
      Fluttertoast.showToast(
        msg: "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Register - second step")),
        body: Container(
          padding: EdgeInsets.all(ScreenAdapter.width(50)),
          child: ListView(
            children: [
              Container(
                  padding: EdgeInsets.only(left: ScreenAdapter.width(10)),
                  margin: EdgeInsets.all(ScreenAdapter.height(20)),
                  child: Text(
                      "Verification code has been sent to your phone number ${_tel}. "
                      "Please enter the code in phone number #${this._tel}")),
              SizedBox(height: ScreenAdapter.height(20)),
              Stack(
                children: [
                  Container(
                    height: ScreenAdapter.height(100),
                    child: JDText(
                      text: "Please enter your code",
                      // password: true,
                      onChanged: (value) {
                        _code = value;
                      },
                    )
                  )
                  ,
                  Positioned(
                      right: 0,
                      top: 0,
                      child: sendCodeBtn
                          ? ElevatedButton(
                              child: Text("Resend"),
                              onPressed: sendCode,
                            )
                          : ElevatedButton(
                              child: Text("${seconds}s"),
                              onPressed: () {},
                            )),
                ],
              ),
              SizedBox(height: ScreenAdapter.height(20)),
              JdButton(
                  text: "Next step",
                  color: Colors.red,
                  height: 74,
                  onTap: validateCode,
              ),
            ],
          ),
        ));
  }
}

