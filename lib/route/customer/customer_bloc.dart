import 'package:bloc/bloc.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dipterv/models/customer_model.dart';
import 'package:dipterv/services/customer_service.dart';
import 'package:meta/meta.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final  _customerService = locator.get<CustomerService>();

  CustomerBloc() : super(CustomerLoadingState()) {
    on<CustomerInitEvent>((event, emit) async {
      emit(CustomerLoadingState());
      var customers = await _customerService.getCustomers();
      emit(CustomerBasicState(customers: customers.customers));
    });
  }
}
