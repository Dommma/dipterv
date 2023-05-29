import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SafeStoreService {
  final _secureStorage = FlutterSecureStorage();

  final _tokenStorageKey = 'authToken';
  final _usernameStorageKey = 'username';
  final _passwordStorageKey = 'password';

  Future<String?> get userToken async {
    return await _secureStorage.read(key: _tokenStorageKey);
  }

  Future<bool> get isUserAuthorized async {
    return (await userToken) != null;
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenStorageKey, value: token);
  }

  Future<void> removeToken() async {
    await _secureStorage.delete(key: _tokenStorageKey);
  }

  Future<void> saveUsername(String username) async {
    await _secureStorage.write(key: _usernameStorageKey, value: username);
  }

  Future<void> removeUsername() async {
    await _secureStorage.delete(key: _usernameStorageKey);
  }

  Future<String?> get username async {
    return await _secureStorage.read(key: _usernameStorageKey);
  }

  Future<void> savePassword(String password) async {
    await _secureStorage.write(key: _passwordStorageKey, value: password);
  }

  Future<void> removePassword() async {
    await _secureStorage.delete(key: _passwordStorageKey);
  }

  Future<String?> get password async {
    return await _secureStorage.read(key: _passwordStorageKey);
  }
}