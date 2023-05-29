import 'dart:convert';

import 'package:dipterv/core/locator.dart';
import 'package:dipterv/services/http_service.dart';
import 'package:dio/dio.dart';

class LoginService {
  final httpService = locator.get<HttpService>();

  Future<String> login(String userName, String password) async {
    var response = await httpService.post('/login', {'username': userName, 'password': password}, authHeaderNeeded: false);
    var jsonData = json.decode(response.toString());
    return jsonData['token'];
  }
}