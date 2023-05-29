import 'dart:convert';

import 'package:dipterv/core/dto/realestate_response.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dio/dio.dart';

import 'http_service.dart';

class RealEstateService {
  final httpService = locator.get<HttpService>();

  Future<RealEstateResponse> getRealEstates() async {
    var response = await httpService.get('/realestate');
    var jsonData = json.decode(response.toString());
    return RealEstateResponse.fromJson(jsonData);
  }
}
