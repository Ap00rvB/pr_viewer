import 'package:book_shelf/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../screens/landing_screen/landing_screen.dart';

Route<dynamic> routeGenerator(RouteSettings settings) {
  dynamic route;
  switch (settings.name) {
    case LandingScreen.routeName:
      route = const LandingScreen();
      break;
    case HomeScreen.routeName:
      route =  const HomeScreen();
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
