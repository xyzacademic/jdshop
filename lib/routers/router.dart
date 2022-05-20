import 'package:flutter/material.dart';
import 'package:jdshop/pages/tabs/cart.dart';
import '../pages/tabs/tab.dart';
import '../pages/search.dart';
import '../pages/productList.dart';
import '../pages/productContent.dart';
import '../pages/login.dart';
import '../pages/register/registerFirst.dart';
import '../pages/register/registerSecond.dart';
import '../pages/register/registerThird.dart';

final routes = {
  '/': (context, {arguments}) => Tabs(),
  '/search': (context, {arguments}) => SearchPage(),
  '/productList': (context, {arguments}) =>
      ProductListPage(arguments: arguments),
  '/productContent': (context, {arguments}) =>
      ProductContentPage(arguments: arguments),
  '/cart': (context) => CartPage(),
  '/login': (context) => LoginPage(),
  '/registerFirst': (context) => RegisterFirstPage(),
  '/registerSecond': (context, {arguments}) => RegisterSecondPage(arguments: arguments),
  '/registerThird': (context) => RegisterThirdPage(),
  // '/registerFirst': (context, {arguments}) => RegisterFirstPage(arguments:
  // arguments),
  // '/registerSecond': (context, {arguments}) => RegisterSecondPage(arguments:
  // arguments),
};

var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
