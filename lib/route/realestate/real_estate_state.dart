part of 'real_estate_bloc.dart';

@immutable
abstract class RealEstateState {}

class RealEstateLoadingState extends RealEstateState {}

class RealEstateBasicState extends RealEstateState {
  final List<RealEstateModel>? realEstates;

  RealEstateBasicState({this.realEstates});
}
