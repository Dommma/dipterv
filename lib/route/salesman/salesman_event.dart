part of 'salesman_bloc.dart';

@immutable
abstract class SalesmanEvent {}

class SalesmanInitEvent extends SalesmanEvent {}

class SalesmanCallEvent extends SalesmanEvent {
  final String mobileNumber;

  SalesmanCallEvent(this.mobileNumber);
}

class SalesmanEmailEvent extends SalesmanEvent {
  final String emailAddress;

  SalesmanEmailEvent(this.emailAddress);
}


