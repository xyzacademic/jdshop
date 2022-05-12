import 'package:flutter/material.dart';


class ProductContentSecond extends StatefulWidget {
  const ProductContentSecond({Key? key}) : super(key: key);

  @override
  State<ProductContentSecond> createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Description page")
    );
  }
}
