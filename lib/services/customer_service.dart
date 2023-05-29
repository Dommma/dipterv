import 'dart:convert';

import 'package:dipterv/core/dto/customer_response.dart';
import 'package:dipterv/core/dto/realestate_response.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dio/dio.dart';

import 'http_service.dart';

class CustomerService {
  final httpService = locator.get<HttpService>();

  Future<CustomerResponse> getCustomers() async {
    var response = await httpService.get('/customer');
    var jsonData = json.decode(response.toString());
    return CustomerResponse.fromJson(jsonData);
  }
}
