import 'package:flutter/material.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Loading data...",
            style: TextStyle(fontSize: 16.0)),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        )
      )
    );
  }
}
