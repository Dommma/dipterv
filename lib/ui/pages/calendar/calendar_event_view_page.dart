import 'package:dipterv/services/calendar_service.dart';
import 'package:flutter/material.dart';

import '../../../models/event_model.dart';

class EventViewPage extends StatelessWidget {
  EventModel event;

  EventViewPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
              onPressed: () {
                calendarService.deleteEvent(event.id);
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () => null,
              icon: Icon(Icons.edit))
        ],
      ),
      body: Column(
        children: [
          Text(event.name),
          Divider(),
          Row(
            children: [
              Icon(Icons.density_medium_sharp),
              Text(event.description)
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(Icons.access_time),
              Text(event.date.toString())
            ],
          )
        ],
      ),
    );
  }

}