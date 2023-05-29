import 'package:dipterv/models/real_estate_model.dart';
import 'package:dipterv/models/salesman_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'salesman_response.g.dart';

@JsonSerializable()
class SalesmanResponse {
  List<SalesmanModel> salesmans;

  SalesmanResponse(this.salesmans);

  factory SalesmanResponse.fromJson(Map<String, dynamic> json) => _$SalesmanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SalesmanResponseToJson(this);
}