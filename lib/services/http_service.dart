import 'dart:io';

import 'package:dipterv/core/environment.dart';
import 'package:dio/dio.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dipterv/services/safe_storage_service.dart';

class HttpService {

  final _safeStorageService = locator.get<SafeStoreService>();

  String get _serverURL => Environment.serverURL;
  final dio = Dio();

  Future<Response> get(String path, {bool authHeaderNeeded = true}) async {
    var client = await _client(authHeaderNeeded);
    var response = await client.get(path);
    return response;
  }

  Future<Response> post(String path, Map<String, dynamic> parameters, {bool authHeaderNeeded = true}) async {
    var client = await _client(authHeaderNeeded);
    var response = await client.post(path, data: parameters);
    return response;
  }

  Future<Dio> _client(bool authHeaderNeeded) async {
    final header = <String, dynamic>{};
    if(authHeaderNeeded) {
      header[HttpHeaders.authorizationHeader] = await _safeStorageService.userToken;
    }
    var client = Dio(BaseOptions(baseUrl: _serverURL, headers: header));
    return client;
  }
}