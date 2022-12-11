import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'real_estates_state.dart';

class RealEstatesCubit extends Cubit<RealEstatesState> {
  RealEstatesCubit() : super(RealEstatesInitial());
}
