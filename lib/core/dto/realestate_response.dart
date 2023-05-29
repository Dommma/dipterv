import 'package:dipterv/models/real_estate_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'realestate_response.g.dart';

@JsonSerializable()
class RealEstateResponse {
  List<RealEstateModel> realestates;

  RealEstateResponse(this.realestates);

  factory RealEstateResponse.fromJson(Map<String, dynamic> json) => _$RealEstateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateResponseToJson(this);
}