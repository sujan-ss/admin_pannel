import 'package:admin_panel/repository/local_storage_repo.dart';

class AccessTokenRepo {
  final LocalStorage _localStorage = LocalStorage();
  Future<void> saveAccessToken(String token, String userType) async {
    await _localStorage.saveData('access_token', token);
    await _localStorage.saveData('user_type', userType);
  }

  Future<String?> getAccessToken() async {
    return _localStorage.getData('access_token');
  }

  Future<String?> getUserType() async {
    return _localStorage.getData('user_type');
  }

  Future<void> removeAccessToken() async {
    await _localStorage.removeData('access_token');
  }
}
