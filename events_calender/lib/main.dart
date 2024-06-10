import 'package:events_calender/screens/home_screen.dart';
import 'package:events_calender/services/route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (const MaterialApp(
      onGenerateRoute: routeGenerator,
      initialRoute: HomeScreen.routeName,
      debugShowCheckedModeBanner: false,
      title: "Event Manager",
    ));
  }
}
