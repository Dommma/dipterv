import 'dart:collection';
import 'dart:ffi';

import 'package:dipterv/models/event_model.dart';
import 'package:dipterv/route/calendar/calendar_bloc.dart';
import 'package:dipterv/route/calendar/new_event_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<CalendarPage> {

  CalendarBloc get _bloc => context.read<CalendarBloc>();
  DateTime kFirstDay = DateTime(2010, 1, 1);
  DateTime kLastDay = DateTime(2035, 12, 31);

  List<EventModel> _getEventsForDay(DateTime day) {
    var currentState = _bloc.state;
    var returnList = <EventModel>[];
    if(currentState is CalendarBasicState) {
      for(var event in currentState.events) {
        if(event.dateTime.year == day.year &&
            event.dateTime.month == day.month &&
            event.dateTime.day == day.day) {
          returnList.add(event);
        }
      }
    }
    returnList.sort((a,b) => a.dateTime.compareTo(b.dateTime));
    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
        listener: (context, state) {},
        builder: (context, state) {
          var currentState = state;
          if(currentState is CalendarLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(currentState is CalendarBasicState) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  var result = await Navigator.push(context, MaterialPageRoute(builder: (_) => NewEventPage()));
                  if(result) {
                    _bloc.add(CalendarInitEvent());
                  }
                },
              ),
              body: Column(
                children: [
                  SizedBox(height: 20,),
                  TableCalendar<EventModel>(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: currentState.focusDay,
                    selectedDayPredicate: (day) => isSameDay(currentState.selectedDay, day),
                    calendarFormat: currentState.calendarFormat,
                    rangeSelectionMode: RangeSelectionMode.disabled,
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent
                      ),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent.shade100
                      ),
                      outsideDaysVisible: false,
                    ),
                    onDaySelected: (selectDay, focusDay) {
                      _bloc.add(CalendarSelectedDayChangeEvent(newSelectedDay: selectDay, newFocusDay: focusDay));
                    },
                    onFormatChanged: (format) {
                      _bloc.add(CalendarFormatChangeEvent(newCalendarFormat: format));
                    },
                    onPageChanged: (focusedDay) {
                      _bloc.add(CalendarFocusDayChangeEvent(newFocusDay: focusedDay));
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Divider(thickness: 1, color: Colors.blue,),
                  Expanded(
                    child: ListView.builder(
                          itemCount: _getEventsForDay(currentState.selectedDay!).length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                onTap: () {},
                                title: Text(listItemText(_getEventsForDay(currentState.selectedDay!)[index]), style: TextStyle(
                                  fontSize: 18
                                ),),
                              ),
                            );
                          },
                        )
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
    );
  }

  String listItemText(EventModel event) {
    return '${event.dateTime.hour}:${event.dateTime.minute}  -  ${event.title}';
  }
}