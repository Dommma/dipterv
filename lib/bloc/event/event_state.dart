part of 'event_cubit.dart';

abstract class EventState extends Equatable {
  const EventState();
}

class EventInitialState extends EventState {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final DateTime dateTime;
  EventInitialState({nameController, dateTime, descriptionController})
  : nameController = nameController ?? TextEditingController(),
  descriptionController = descriptionController ?? TextEditingController(),
  dateTime = dateTime ?? DateTime(0);

  @override
  List<Object> get props => [nameController, dateTime];
}

class EventLoadingState extends EventState {
  @override
  List<Object?> get props => [];
}

class EventErrorState extends EventState {
  String errorMessage;

  EventErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [];
}

class EventFinishedState extends EventState {
  @override
  List<Object?> get props => [];
}
