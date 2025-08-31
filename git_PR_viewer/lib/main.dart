import 'package:flutter/material.dart';
import 'package:git_pr_viewer/screens/pr_list_screen/pr_list_screen.dart';
import 'package:git_pr_viewer/services/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return (const MaterialApp(
      onGenerateRoute: routeGenerator,
      initialRoute: PrListScreen.routeName,
      debugShowCheckedModeBanner: false,
      title: "PR List Screen",
    ));
  }
}
