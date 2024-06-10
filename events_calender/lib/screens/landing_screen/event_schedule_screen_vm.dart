import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/event_model.dart';

class EventScheduleScreenVM extends ChangeNotifier {
  bool _isBusy = false;

  bool get isBusy => _isBusy;
  List<EventModel> _event = [];
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  String get titleText => "Your Schedule";

  String get statusTitleText => "Status: ";

  String get durationTitleText => "Duration: ";

  String get descriptionTitleText => "Description: ";

  String get startsAtText => "Starts at: ";

  String get createdAtText => "Created at: ";

  EventScheduleScreenVM() {
    _fetchDetails();
  }

  String selectedDay() {
    String formattedDate = DateFormat('dd MMM yyyy').format(selectedDate);
    return formattedDate;
  }

  String statusText(int index) {
    return _event[index].status;
  }

  int durationText(int index) {
    return _event[index].duration;
  }

  String descriptionText(int index) {
    return _event[index].description;
  }

  String startAtText(int index) {
    DateTime dateTime = DateTime.parse(_event[index].startAt);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  String createdAt(int index) {
    DateTime dateTime = DateTime.parse(_event[index].createdAt);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  String title(int index) {
    return _event[index].title;
  }

  EventModel eventModel(int index) {
    return _event[index];
  }

  int get slotLength => _event.length;

  void updateSelectedDate(DateTime dateTime) {
    _selectedDate = dateTime;
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    Response response;

    if (_isBusy) {
      return;
    }
    _isBusy = true;
    notifyListeners();
    final url =
        Uri.parse('https://mock.apidog.com/m1/561191-524377-default/Event');
    final headers = {
      'Authorization': 'Bearer 2f68dbbf-519d-4f01-9636-e2421b68f379',
    };
    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          _event = (data['data'] as List)
              .map((json) => EventModel.fromJson(json))
              .toList();
        }
      }
    } catch (e) {}

    _isBusy = false;
    notifyListeners();
  }
}
