import 'package:flutter/material.dart';

import '../services/screenAdapter.dart';

class JDText extends StatelessWidget {
  String? text;
  bool password;
  var onChanged;

  JDText({Key? key, this.text = "Enter", this.password = false, this.onChanged=null})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(88),
      decoration: BoxDecoration(
        // color: Color.fromRGBO(233, 233, 233, 0.8),
        // borderRadius: BorderRadius.circular(30),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          )
        )
      ),
      child: TextField(
        // autofocus: true,
        obscureText: this.password,
        decoration: InputDecoration(
            hintText: this.text,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30)
            )
        ),
        onChanged: this.onChanged,
      ),
    );
  }
}
