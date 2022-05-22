import 'package:flutter/material.dart';

class AddressEdit extends StatefulWidget {
  const AddressEdit({Key? key}) : super(key: key);

  @override
  State<AddressEdit> createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Edit address")
        ),
        body: Text("empay")
    );
  }
}
