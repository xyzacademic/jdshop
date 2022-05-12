import 'package:flutter/material.dart';

class ProductContentThird extends StatefulWidget {
  const ProductContentThird({Key? key}) : super(key: key);

  @override
  State<ProductContentThird> createState() => _ProductContentThirdState();
}

class _ProductContentThirdState extends State<ProductContentThird>
    with SingleTickerProviderStateMixin {
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
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("#${index}"),
          );
        },
      ),
    );
  }
}
