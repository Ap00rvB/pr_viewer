import 'package:flutter/material.dart';

import '../models/event_model.dart';
import '../screens/events_detail/events_detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/landing_screen/event_schedule_screen.dart';

Route<dynamic> routeGenerator(RouteSettings settings) {
  dynamic route;
  switch (settings.name) {
    case EventScheduleScreen.routeName:
      route = const EventScheduleScreen();
      break;
    case HomeScreen.routeName:
      route = const HomeScreen();
      break;
    case EventDetailScreen.routeName:
      final Map<dynamic, dynamic> args =
          settings.arguments as Map<dynamic, dynamic>;
      EventModel event = args[EventDetailScreen.paramEvent];

      route = EventDetailScreen(
        event: event,
      );
      break;
    default:
      throw Exception('Invalid route ${settings.name}');
  }
  return MaterialPageRoute(
    builder: (context) =>
        Directionality(textDirection: TextDirection.ltr, child: route),
    settings: settings,
  );
}
