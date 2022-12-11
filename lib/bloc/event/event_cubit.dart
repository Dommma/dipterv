import 'package:bloc/bloc.dart';
import 'package:dipterv/services/constans.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitialState());

  void saveSelectedDate(DateTime newDate) {
    var state = this.state;
    if(state is EventInitialState) {
      emit(EventInitialState(
          nameController: state.nameController,
          descriptionController: state.descriptionController,
          dateTime: newDate));
    }
  }

  void createEvent() async {
    var state = this.state;
    var body;
    if(state is EventInitialState) {
      if(state.nameController.text.isEmpty || state.dateTime.year == 0) {
        emit(EventErrorState(errorMessage: "Add title and date to the event!"));
        emit(state);
        return;
      }
      body = <String, dynamic>{
        "name": state.nameController.text,
        "date": state.dateTime.toString(),
        "description": state.descriptionController.text.isEmpty ? "No added description" : state.descriptionController.text,
        "type": "Valami",
        "participants": [
          pocketBase.authStore.model.id
        ]
      };
    }
    emit(EventLoadingState());
    final record = await pocketBase.collection('events').create(body: body);
    emit(EventFinishedState());
    emit(EventInitialState());
  }

}
