import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/circular_progress.dart';
import '../../models/event_model.dart';
import 'events_detail_screen_vm.dart';

class EventDetailScreen extends StatelessWidget {
  static const routeName = 'event_detail_screen';
  static const paramEvent = 'event_post';

  final EventModel event;

  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return EventDetailScreenVM(event);
      },
      child: _screen(context),
    );
  }

  Widget _screen(BuildContext context) {
    return Consumer<EventDetailScreenVM>(builder: (_, vm, __) {
      return Scaffold(
        appBar: AppBar(
          title: Text(vm.titleText),
          backgroundColor: Colors.indigo[600],
        ),
        body: _body(vm),
      );
    });
  }

  Widget _body(EventDetailScreenVM vm) {
    return vm.isBusy
        ? ModalCircularProgressIndicator(null, vm.isBusy)
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      vm.title(),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(
                            vm.statusText(),
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: event.status == "Confirmed"
                              ? Colors.green
                              : Colors.red,
                        ),
                        Text(
                          vm.startAtText(),
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Duration: ${vm.durationText()}",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      event.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Created at: ${vm.createdAt()}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                          },
                          child: Text('Edit'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                          },
                          child: Text('Delete'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
