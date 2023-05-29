import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dipterv/models/event_model.dart';
import 'package:dipterv/services/event_service.dart';
import 'package:meta/meta.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final _eventService = locator.get<EventService>();

  CalendarBloc() : super(CalendarLoadingState()) {
    on<CalendarInitEvent>(_initEvent);
    on<CalendarSelectedDayChangeEvent>(_selectedDayChange);
    on<CalendarFormatChangeEvent>(_calendarFormatChange);
    on<CalendarFocusDayChangeEvent>(_focusDayChange);
  }

  Future<void> _initEvent(CalendarInitEvent event, Emitter<CalendarState> emit) async {
    emit(CalendarLoadingState());
    CalendarFormat cFormat = CalendarFormat.month;
    DateTime focusedDay = DateTime.now();
    /*var events = <EventModel>[];
    events.add(EventModel("Fasz", DateTime(2023, 5, 19), "description", 'creator', null));
    events.add(EventModel("ASD", DateTime(2023, 5, 19), "description", 'creator', null));
    events.add(EventModel("lkofasz", DateTime(2023, 5, 21), "description", 'creator', null));*/
    var response = await _eventService.getEvents();
    emit(CalendarBasicState(events: response.events, focusDay: focusedDay, calendarFormat: cFormat, selectedDay: focusedDay));
  }

  void _selectedDayChange(CalendarSelectedDayChangeEvent event, Emitter<CalendarState> emit) {
    var currentState = state;
    if(currentState is CalendarBasicState) {
      if (!isSameDay(currentState.selectedDay, event.newSelectedDay)) {
        emit(CalendarBasicState(events: currentState.events, focusDay: event.newFocusDay,
            calendarFormat: currentState.calendarFormat, selectedDay: event.newSelectedDay));
      }
    }
  }

  void _calendarFormatChange(CalendarFormatChangeEvent event, Emitter<CalendarState> emit) {
    var currentState = state;
    if(currentState is CalendarBasicState) {
      if (currentState.calendarFormat != event.newCalendarFormat) {
        emit(CalendarBasicState(events: currentState.events, focusDay: currentState.focusDay,
            calendarFormat: event.newCalendarFormat, selectedDay: currentState.selectedDay));
      }
    }
  }

  void _focusDayChange(CalendarFocusDayChangeEvent event, Emitter<CalendarState> emit) {
    var currentState = state;
    if(currentState is CalendarBasicState) {
      emit(CalendarBasicState(events: currentState.events, focusDay: event.newFocusDay,
          calendarFormat: currentState.calendarFormat, selectedDay: currentState.selectedDay));
    }
  }
}
