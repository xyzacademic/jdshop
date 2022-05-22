import 'package:flutter/material.dart';
import 'routers/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'provider/counter.dart';
import 'provider/cart.dart';
import 'provider/checkOut.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
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
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (child) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(
               create: (BuildContext context) {
                 return Counter();
                 },
              ),
              ChangeNotifierProvider(
                create: (BuildContext context) {
                  return Cart();
                },
              ),
              ChangeNotifierProvider(
                create: (BuildContext context) {
                  return CheckOut();
                },
              ),
            ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // title: 'First Method',
            // You can use the library anywhere in the app even in theme

            initialRoute: '/cart',
            onGenerateRoute: onGenerateRoute,
            theme: ThemeData(
              // colorScheme: ColorScheme.light()
              // primarySwatch: Colors.grey,
              // brightness: Brightness.light,

              // primaryColor: Colors.black54,
              // backgroundColor: Colors.white,
            )));
      },
      // child: const HomePage(title: 'First Method'),
    );
  }
}
