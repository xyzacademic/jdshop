import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class JdButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? onTap;
  final double height;

  JdButton(
      {Key? key, this.color=Colors.black, this.text="Button", this.onTap,
      this.height=68})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          height: ScreenAdapter.height(this.height),
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
