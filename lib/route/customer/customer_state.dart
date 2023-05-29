part of 'customer_bloc.dart';

@immutable
abstract class CustomerState {}

class CustomerLoadingState extends CustomerState {}

class CustomerBasicState extends CustomerState {
  final List<CustomerModel>? customers;

  CustomerBasicState({this.customers});
}
