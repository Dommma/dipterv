import 'dart:convert';

import 'package:dipterv/core/dto/event_response.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dipterv/models/event_model.dart';
import 'http_service.dart';

class EventService {
  final httpService = locator.get<HttpService>();

  Future<EventResponse> getEvents() async {
    var response = await httpService.get('/calendar');
    var jsonData = json.decode(response.toString());
    return EventResponse.fromJson(jsonData);
  }

  Future<void> saveEvent(EventModel event) async {
    await httpService.post('/calendar/new/${event.creator}', event.toJson());
  }
}