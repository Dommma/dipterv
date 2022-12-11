import 'constans.dart';

class CalendarService {

  void deleteEvent(String id) async {
    await pocketBase.collection('events').delete(id);
  }

  void createEvent() {

  }
}

final calendarService = CalendarService();