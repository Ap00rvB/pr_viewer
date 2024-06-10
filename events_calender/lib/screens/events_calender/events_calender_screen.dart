import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'events_calender_screen_vm.dart';

class EventsCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function selectedCallback;
  final Function focusedCallback;
  final bool fillViewPort;
  final DateTime? minDate;
  final DateTime? maxDate;

  const EventsCalendar({
    Key? key,
    required this.selectedDate,
    required this.selectedCallback,
    required this.focusedCallback,
    this.fillViewPort = true,
    this.minDate,
    this.maxDate,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return ChangeNotifierProvider(
      create: (context) {
        return EventsCalendarVM(
          selectedDate,
          selectedCallback,
          focusedCallback,
          minDate,
          maxDate,
        );
      },
      child: _body(),
    );
  }

  Widget _body() {
    return Consumer<EventsCalendarVM>(
      builder: (context, vm, __) {
        return TableCalendar(
          firstDay: vm.firstDateTime,
          lastDay: vm.lastFacilityDate,
          shouldFillViewport: fillViewPort,
          focusedDay: vm.focusedDay,
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          weekendDays: const [],
          availableGestures: AvailableGestures.horizontalSwipe,
          pageAnimationEnabled: false,
          daysOfWeekHeight: 25.0,
          daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) =>
                  DateFormat.E(locale).format(date)[0],
              weekdayStyle: TextStyle(
                color: Color(0xFF8a8a8a),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ).copyWith(color: Color(0xFF202124))),
          selectedDayPredicate: vm.isDaySelected,
          onDaySelected: vm.onDaySelected,
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              color: Color(0xFF202124),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          calendarStyle: CalendarStyle(
            isTodayHighlighted: false,
            outsideDaysVisible: false,
            selectedDecoration:
                BoxDecoration(color: Color(0xFF539819), shape: BoxShape.circle),
          ),
          // onDaySelected: _onDaySelected,
          onPageChanged: (focusedDay) {
            vm.focusedDay = focusedDay;
          },
        );
      },
    );
  }
}
