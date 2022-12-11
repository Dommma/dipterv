import 'package:dipterv/bloc/calendar/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_item_widget.dart';

class CalendarEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          if(state is CalendarInitialState) {
            if(state.events.isEmpty) {
              return const Text("No event on this day");
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.events.length,
                  itemBuilder: (context, int index) => EventItemWidget(event: state.events[index]));
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }

}