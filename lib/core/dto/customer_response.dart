import 'package:dipterv/models/customer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_response.g.dart';

@JsonSerializable()
class CustomerResponse {
  List<CustomerModel> customers;

  CustomerResponse(this.customers);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}