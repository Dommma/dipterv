import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dipterv/models/salesman_model.dart';
import 'package:dipterv/services/salesman_service.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'salesman_event.dart';
part 'salesman_state.dart';

class SalesmanBloc extends Bloc<SalesmanEvent, SalesmanState> {
  final _salesmanService = locator.get<SalesmanService>();

  SalesmanBloc() : super(SalesManLoadingState()) {
    on<SalesmanInitEvent>(_initEvent);
    on<SalesmanCallEvent>(_callEvent);
    on<SalesmanEmailEvent>(_emailEvent);
  }

  Future<void> _initEvent(SalesmanInitEvent event, Emitter<SalesmanState> emit) async {
    try {
      emit(SalesManLoadingState());
      var salesmans = await _salesmanService.getSalesmans();
      emit(SalesmanBasicState(salesmans: salesmans.salesmans));
    } catch (e, stackTrace) {
      if(e is DioError) {
        emit(SalesmanBasicState(error: e.response?.data));
      }
    }
  }

  void _callEvent(SalesmanCallEvent event, Emitter<SalesmanState> emit) {
    final telLaunchUri = Uri(
      scheme: 'tel',
      path: event.mobileNumber,
    );
    launchUrl(telLaunchUri);
  }

  void _emailEvent(SalesmanEmailEvent event, Emitter<SalesmanState> emit) {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: event.emailAddress,
    );
    launchUrl(emailLaunchUri);
  }
}
