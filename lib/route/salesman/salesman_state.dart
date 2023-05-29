part of 'salesman_bloc.dart';

@immutable
abstract class SalesmanState {}

class SalesManLoadingState extends SalesmanState {}

class SalesmanBasicState extends SalesmanState {
  final List<SalesmanModel>? salesmans;
  final String? error;

  SalesmanBasicState({this.salesmans, this.error});
}
