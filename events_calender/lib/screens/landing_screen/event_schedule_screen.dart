import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/circular_progress.dart';
import '../events_calender/events_calender_screen.dart';
import '../events_detail/events_detail_screen.dart';
import 'event_schedule_screen_vm.dart';

class EventScheduleScreen extends StatefulWidget {
  static const routeName = 'event_schedule_screen';

  const EventScheduleScreen({Key? key}) : super(key: key);

  @override
  State<EventScheduleScreen> createState() => _EventScheduleScreenState();
}

class _EventScheduleScreenState extends State<EventScheduleScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return EventScheduleScreenVM();
      },
      child: _screen(context),
    );
  }

  Widget _screen(BuildContext context) {
    return Consumer<EventScheduleScreenVM>(
      builder: (context, vm, __) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(vm.titleText),
            backgroundColor: Colors.indigo[600],
          ),
          body: _body(context, vm),
        );
      },
    );
  }

  Widget _body(BuildContext context, EventScheduleScreenVM vm) {
    return vm.isBusy
        ? ModalCircularProgressIndicator(null, vm.isBusy)
        : _mainScreen(context, vm);
  }

  Widget _mainScreen(BuildContext context, EventScheduleScreenVM vm) {
    return Stack(
      children: [
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: const Color(0xFFFFFFFF),
                  height: 350,
                  child: EventsCalendar(
                    selectedDate: vm.selectedDate,
                    fillViewPort: true,
                    selectedCallback: (selectedDate) {
                      vm.updateSelectedDate(selectedDate);
                    },
                    focusedCallback: (selectedDate) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    vm.selectedDay(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: Color(0xFFFFFFFF),
                child: _eventList(vm),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _eventList(EventScheduleScreenVM vm) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        itemCount: vm.slotLength,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _availableEvent(context, vm, index));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 20);
        });
  }

  Widget _availableEvent(
      BuildContext context, EventScheduleScreenVM vm, int index) {
    return Column(
      children: [
        InkWell(
          child: Card(
            color: const Color(0xFFFFF3EA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
            ),
            elevation: 4,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    vm.title(index),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: vm.statusTitleText,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF202124))),
                      TextSpan(
                          text: vm.statusText(index),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF202124)))
                    ]),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: vm.durationTitleText,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF202124))),
                      TextSpan(
                          text: "${vm.durationText(index)}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF202124))),
                      const TextSpan(
                          text: " mins",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF202124)))
                    ]),
                  ),
                  const SizedBox(height: 10),
                  RichText(maxLines: 2,overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: vm.descriptionTitleText,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF202124))),
                      TextSpan(
                          text: vm.descriptionText(index),
                          style: const TextStyle(overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF202124)))
                    ]),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: vm.startsAtText,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF202124))),
                      TextSpan(
                          text: vm.startAtText(index),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF202124)))
                    ]),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: vm.createdAtText,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF202124))),
                      TextSpan(
                          text: vm.createdAt(index),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF202124)))
                    ]),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, EventDetailScreen.routeName,
                arguments: {
                  EventDetailScreen.paramEvent: vm.eventModel(index)
                });
          },
        ),
      ],
    );
  }
}
