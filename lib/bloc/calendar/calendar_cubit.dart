import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/event_model.dart';
import '../../services/constans.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitialState());

  void changeCalendarFormat(CalendarFormat format) {
    var state = this.state;
    if(state is CalendarInitialState) {
      emit(CalendarInitialState(calendarFormat: format, selectedDate: state.selectedDate, focusedDay: state.focusedDay, events: state.events));
    }
  }

  void changeFocusedDay(DateTime fDay) {
    var state = this.state;
    if(state is CalendarInitialState) {
      emit(CalendarInitialState(calendarFormat: state.calendarFormat, selectedDate: state.selectedDate, focusedDay: fDay, events: state.events));
    }
  }

  void changeSelectedDay(DateTime fDay, DateTime sDay) async {
    var state = this.state;
    emit(CalendarLoadingState());
    pocketBase.authStore.model.id;
    final resultList = await pocketBase.collection('events').getList(
      sort: 'date',
      filter: 'date ~ "${getDayFormat(sDay)}" && participants ~ "${pocketBase.authStore.model.id}"',
    );
    var tmp = <EventModel>[];
    for(var event in resultList.items) {
      tmp.add(EventModel.fromJson(event.toJson()));
    }
    if(state is CalendarInitialState) {
      if(tmp.isNotEmpty) {
        emit(CalendarInitialState(calendarFormat: state.calendarFormat, selectedDate: sDay, focusedDay: fDay, events: tmp));
      } else {
        emit(CalendarInitialState(calendarFormat: state.calendarFormat, selectedDate: sDay, focusedDay: fDay));
      }
    }
  }
  
  String getDayFormat(DateTime day) {
    List<String> tmp = day.toString().split(" ");
    return tmp[0];
  }
}
