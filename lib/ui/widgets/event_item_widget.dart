import 'package:dipterv/models/event_model.dart';
import 'package:dipterv/ui/pages/calendar/calendar_event_view_page.dart';
import 'package:flutter/material.dart';

class EventItemWidget extends StatelessWidget {
  final EventModel event;

  EventItemWidget({required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => EventViewPage(event: event)));
      },
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text(event.name, maxLines: 1, overflow: TextOverflow.ellipsis,),
        subtitle: Text(getDateFormat()),
      ),
    );
  }

  String getDateFormat() {
    List<String> tmp = event.date.toString().split(" ");
    return tmp[1].substring(0, 5);
  }

}