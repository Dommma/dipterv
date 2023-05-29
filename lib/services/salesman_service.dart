import 'dart:convert';

import 'package:dipterv/core/dto/salesman_response.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dipterv/models/salesman_model.dart';

import 'http_service.dart';

class SalesmanService {
  final httpService = locator.get<HttpService>();

  Future<SalesmanResponse> getSalesmans() async {
    var response = await httpService.get('/salesman');
    var jsonData = json.decode(response.toString());
    return SalesmanResponse.fromJson(jsonData);
  }

  Future<SalesmanModel> getChosenSalesman(String salesmanEmail) async {
    var response = await httpService.get('/salesman/$salesmanEmail');
    var jsonData = json.decode(response.toString());
    return SalesmanModel.fromJson(jsonData);
  }
}
