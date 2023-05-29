import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dipterv/models/real_estate_model.dart';
import 'package:dipterv/services/real_estates_service.dart';
import 'package:meta/meta.dart';

part 'real_estate_event.dart';
part 'real_estate_state.dart';

class RealEstateBloc extends Bloc<RealEstateEvent, RealEstateState> {
  final realEstateService = locator.get<RealEstateService>();

  RealEstateBloc() : super(RealEstateLoadingState()) {
    on<RealEstateInitEvent>((event, emit) async {
      emit(RealEstateLoadingState());
      var realestates = await realEstateService.getRealEstates();
      emit(RealEstateBasicState(realEstates: realestates.realestates));
    });
  }
}
