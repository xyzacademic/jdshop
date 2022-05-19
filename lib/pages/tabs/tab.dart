import 'package:flutter/material.dart';
import 'home.dart';
import 'category.dart';
import 'user.dart';
import 'cart.dart';
import '../../services/screenAdapter.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int _currentIndex = 0;
  PageController? _pageController;

  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _getAppBar() {
    if (_currentIndex != 3) {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.center_focus_weak, size: 28, color: Colors.black87),
          onPressed: null,
        ),
        title: InkWell(
          child: Container(
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.search),
                Text("Search",
                    style: TextStyle(fontSize: ScreenAdapter.size(28)))
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, "/search");
          },
        ),
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.message, size: 28, color: Colors.black87))
        ],
      );
    } else {
      return AppBar(
        title: Text("My profile")
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _getAppBar(),
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.center_focus_weak, size: 28, color: Colors.black87),
      //     onPressed: null,
      //   ),
      //   title: InkWell(
      //     child: Container(
      //       height: ScreenAdapter.height(68),
      //       decoration: BoxDecoration(
      //         color: Color.fromRGBO(233, 233, 233, 0.8),
      //         borderRadius: BorderRadius.circular(30),
      //       ),
      //       padding: EdgeInsets.only(left: 10),
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Icon(Icons.search),
      //           Text("Search",
      //               style: TextStyle(fontSize: ScreenAdapter.size(28)))
      //         ],
      //       ),
      //     ),
      //     onTap: () {
      //       Navigator.pushNamed(context, "/search");
      //     },
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: null,
      //         icon: Icon(Icons.message, size: 28, color: Colors.black87))
      //   ],
      // ),
      body: PageView(
        controller: _pageController,
        children: _pageList,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        //disable scroll vertically
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController?.jumpToPage(_currentIndex);
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Category"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Shopping Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: "My profile"),
        ],
      ),
    );
  }
}
