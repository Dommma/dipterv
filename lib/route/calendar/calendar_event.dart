part of 'calendar_bloc.dart';

@immutable
abstract class CalendarEvent {}

class CalendarInitEvent extends CalendarEvent {}

class CalendarSelectedDayChangeEvent extends CalendarEvent {
  final DateTime newSelectedDay;
  final DateTime newFocusDay;

  CalendarSelectedDayChangeEvent({required this.newSelectedDay, required this.newFocusDay});
}

class CalendarFocusDayChangeEvent extends CalendarEvent {
  final DateTime newFocusDay;

  CalendarFocusDayChangeEvent({required this.newFocusDay});
}

class CalendarFormatChangeEvent extends CalendarEvent {
  final CalendarFormat newCalendarFormat;

  CalendarFormatChangeEvent({required this.newCalendarFormat});
}

