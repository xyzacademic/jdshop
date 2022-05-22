import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/screenAdapter.dart';
import '../../widget/jdButton.dart';
import '../../widget/jdText.dart';
import '../../config/config.dart';
import 'package:dio/dio.dart';

class RegisterFirstPage extends StatefulWidget {
  const RegisterFirstPage({Key? key}) : super(key: key);

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String _tel = "";
  var api = '${Config.domain}/api/sendCode';

  sendCode() async {
    RegExp reg = RegExp(r"^1\d{10}$");
    if (reg.hasMatch(_tel)) {
      print('correct');
      var response = await Dio().post(api, data: {"tel": _tel});
      if (response.data['success']) {
        print(response);
        Navigator.pushNamed(context, '/registerSecond',
            arguments: {'tel': _tel});
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
        appBar: AppBar(title: Text("Register - first step")),
        body: Container(
          padding: EdgeInsets.all(ScreenAdapter.width(50)),
          child: ListView(
            children: [
              SizedBox(height: ScreenAdapter.height(20)),
              JDText(
                text: "Please enter your phone number",
                // password: true,
                onChanged: (value) {
                  _tel = value;
                },
              ),
              SizedBox(height: ScreenAdapter.height(20)),
              JdButton(
                text: "Next step",
                color: Colors.red,
                height: 74,
                onTap: sendCode,
              )
            ],
          ),
        ));
  }
}
