import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../models/event_model.dart';

class EventDetailScreenVM extends ChangeNotifier {
  final EventModel _event;

  EventDetailScreenVM(this._event);

  bool _isBusy = false;

  String get titleText => "Event Details";

  bool get isBusy => _isBusy;

  String statusText() {
    return _event.status;
  }

  int durationText() {
    return _event.duration;
  }

  String descriptionText() {
    return _event.description;
  }

  String title() {
    return _event.title;
  }

  String startAtText() {
    DateTime dateTime = DateTime.parse(_event.startAt);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  String createdAt() {
    DateTime dateTime = DateTime.parse(_event.createdAt);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }
}