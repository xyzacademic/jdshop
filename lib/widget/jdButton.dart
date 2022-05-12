import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class JdButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? cb;

  JdButton(
      {Key? key, this.color=Colors.black, this.text="Button", this.cb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cb,
      child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          height: ScreenAdapter.height(68),
          width: double.infinity,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(text,
                style: TextStyle(
                  color: Colors.white,
                )),
          )),
    );
  }
}
