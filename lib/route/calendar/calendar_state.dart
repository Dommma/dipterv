part of 'calendar_bloc.dart';

@immutable
abstract class CalendarState {}

class CalendarLoadingState extends CalendarState {}

class CalendarBasicState extends CalendarState {
  final List<EventModel> events;
  final DateTime focusDay;
  final CalendarFormat calendarFormat;
  final DateTime? selectedDay;

  CalendarBasicState({required this.events, required this.focusDay, this.selectedDay, required this.calendarFormat});
}

