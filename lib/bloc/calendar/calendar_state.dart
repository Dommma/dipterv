part of 'calendar_cubit.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
}

class CalendarInitialState extends CalendarState {
  final List<EventModel> events;
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final DateTime selectedDate;

  CalendarInitialState({calendarFormat, selectedDate, focusedDay, events})
  : calendarFormat = calendarFormat ?? CalendarFormat.month,
  selectedDate = selectedDate ?? DateTime.now(),
  focusedDay = focusedDay ?? DateTime.now(),
  events = events ?? List.empty();

  @override
  List<Object> get props => [calendarFormat, focusedDay, selectedDate, events];
}

class CalendarLoadingState extends CalendarState {
  @override
  List<Object?> get props => [];

}
