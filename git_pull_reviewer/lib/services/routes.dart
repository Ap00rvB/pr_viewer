import 'package:flutter/material.dart';

import '../screens/login_screen/login_screen.dart';
import '../screens/pr_list_screen/pr_list_screen.dart';

Route<dynamic> routeGenerator(RouteSettings settings) {
  dynamic route;
  switch (settings.name) {
    case PrListScreen.routeName:
      route = const PrListScreen();
      break;
    case LoginScreen.routeName:
      route =  const LoginScreen();
      break;
    default:
      throw Exception('Invalid route ${settings.name}');
  }
  return MaterialPageRoute(
    builder: (context) => Directionality(
        textDirection: TextDirection.ltr, child: route),
    settings: settings,
  );
}
