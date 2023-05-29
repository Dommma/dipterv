import 'package:dipterv/models/event_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_response.g.dart';

@JsonSerializable()
class EventResponse {
  List<EventModel> events;

  EventResponse(this.events);

  factory EventResponse.fromJson(Map<String, dynamic> json) => _$EventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventResponseToJson(this);
}