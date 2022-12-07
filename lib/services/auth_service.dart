import 'package:dipterv/services/constans.dart';

class AuthService {

  void loginUser(String userName, String password) async {
    final authData = await pocketBase.collection('users').authWithPassword(userName, password);

    if(pocketBase.authStore.isValid) {
      //pocketBase.authStore.model
    } else {

    }
  }
}