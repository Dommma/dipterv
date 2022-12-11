import 'package:dipterv/bloc/calendar/calendar_cubit.dart';
import 'package:dipterv/ui/pages/calendar/calendar_create_event_page.dart';
import 'package:dipterv/ui/widgets/calendar_events.dart';
import 'package:dipterv/ui/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarWidget(currentPage: "Calendar",),
      appBar: AppBar(
        title: const Text("Calendar"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => CreateEventPage()));
        },
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<CalendarCubit, CalendarState>(
        listener: (context,_) {},
        builder: (context, state) {
          if(state is CalendarInitialState) {
            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: state.focusedDay,
                  calendarFormat: state.calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(state.selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(state.selectedDate, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      context.read<CalendarCubit>().changeSelectedDay(focusedDay, selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    if (state.calendarFormat != format) {
                      context.read<CalendarCubit>().changeCalendarFormat(format);
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    context.read<CalendarCubit>().changeFocusedDay(focusedDay);
                  },
                ),
                Divider(),
                CalendarEvents()
              ],
            );
          } else {
            return Container();
          }
        },
      )
    );
  }
}