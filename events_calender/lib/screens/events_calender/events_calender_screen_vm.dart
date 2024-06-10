import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsCalendarVM extends ChangeNotifier {
  final Function _selectedDateCallback;
  final Function _focusedDateCallback;
  DateTime _selectedDay;
  final DateTime? _minDate;
  final DateTime? _maxDate;

  EventsCalendarVM(
      this._selectedDay,
      this._selectedDateCallback,
      this._focusedDateCallback,
      this._minDate,
      this._maxDate,
      ) {
    if (_minDate != null) {
      _focusedDay = _minDate!;
    }
  }

  DateTime _focusedDay = DateTime.now();
  final DateTime _firstDateTime = DateTime.now();

  DateTime get firstDateTime => _minDate ?? _firstDateTime;

  DateTime get focusedDay => _focusedDay;

  DateTime? get selectedDateTime => _selectedDay;

  DateTime get lastDay {
    var today = DateTime.now();
    return DateTime(today.year, today.month + 3, today.day);
  }

  DateTime get lastFacilityDate {
    var today = DateTime.now();
    return _maxDate ?? DateTime(today.year + 1, today.month, today.day);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _selectedDateCallback(_selectedDay);
    _focusedDay = focusedDay;
    _focusedDateCallback(_focusedDay);
    notifyListeners();
  }

  set focusedDay(DateTime value) {
    _focusedDay = value;
    _focusedDateCallback(value);
    notifyListeners();
  }

  bool isDaySelected(DateTime day) => isSameDay(selectedDateTime, day);
}
