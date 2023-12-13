import 'package:book_shelf/screens/home_screen/home_screen.dart';
import 'package:book_shelf/services/route.dart';
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
      title: "Book Shelf",
    ));
  }
}
