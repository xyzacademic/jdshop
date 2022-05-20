import 'package:flutter/material.dart';
import '../../services/screenAdapter.dart';
import '../../provider/counter.dart';
import 'package:provider/provider.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
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
    var counterProvider = Provider.of<Counter>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("User profile"),

        ),
        body: ListView(
          children: [
            Container(
              height: ScreenAdapter.height(220),
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://www.sketchappsources.com/resources/source-image/geometry-background.png"),
                      fit: BoxFit.cover

                  )
              ),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ClipOval(
                          child: Image.network(
                            "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
                            fit: BoxFit.cover,
                            width: ScreenAdapter.width(120),
                            height: ScreenAdapter.height(120),
                          )
                      )
                  ),
                  Expanded(
                    flex:1,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text("Login/Sign up",
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    )
                  ),
                  // Expanded(
                  //     flex: 1,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text("User name: 124124125",
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: ScreenAdapter.size(32)
                  //           ),
                  //         ),
                  //         Text("Regular member",
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: ScreenAdapter.size(24)
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  // ),

                ],
              ),
            ),


            ListTile(
                leading: Icon(Icons.home, color: Colors.red),
                title: Text("Orders")
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.payment, color: Colors.green),
                title: Text("Need to be paid")
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.local_car_wash, color: Colors.orange),
                title: Text("Need to be confirmed")
            ),

            Container(
              height: 10,
              width: double.infinity,
              color: Color.fromRGBO(242, 242, 242, 0.9),
            ),
            ListTile(
                leading: Icon(Icons.favorite, color: Colors.lightGreen),
                title: Text("My favoriate")
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.people, color: Colors.black54),
                title: Text("Customer services")
            ),
            Divider(),
          ],
        )
    );
  }
}
