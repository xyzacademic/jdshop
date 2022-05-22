import 'package:flutter/material.dart';

import '../../services/screenAdapter.dart';


class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Address List")
        ),
        body: Container(
          child: Stack(
            children: [

              ListView(
                children: [
                  SizedBox(height: ScreenAdapter.height(20)),
                  ListTile(
                    leading: Icon(Icons.check, color: Colors.red),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("zhang san 15209090909"),
                        SizedBox(height: ScreenAdapter.height(10)),
                        Text("403 N 2nd ST")
                      ],
                    ),
                    trailing: Icon(Icons.edit, color: Colors.blue),
                  ),
                  Divider(height: ScreenAdapter.height(20)),
                  ListTile(
                    leading: Icon(Icons.check, color: Colors.red),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("zhang san 15209090909"),
                        SizedBox(height: ScreenAdapter.height(10)),
                        Text("403 N 2nd ST")
                      ],
                    ),
                    trailing: Icon(Icons.edit, color: Colors.blue),
                  ),
                  Divider(height: ScreenAdapter.height(20)),
                ],
              ),
              SizedBox(height: ScreenAdapter.height(100)),
              Positioned(
                bottom: 0,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(100),
                child: Container(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(100),
                    padding: EdgeInsets.all(ScreenAdapter.height(10)),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border(
                          top: BorderSide( width: 1, color: Colors.black26),

                        )
                    ),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          Text("Add mailing address", style: TextStyle(
                            color: Colors.white,
                          )),
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, '/addressAdd');
                      },
                    )),
              )
            ],
          )
        )
    );
  }
}
