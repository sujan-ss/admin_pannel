import 'package:admin_panel/repository/api.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  Future<Either<SucessResponse, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = {"email": email, "password": password};
      final response = await Dio().post(ApiConstants.login, data: data);
      final accessToken = response.data['accessToken'];
      final type = response.data["role"];
      SucessResponse sucessResponse =
          SucessResponse(accessToken: accessToken, type: type);

      return left(sucessResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return right("Invalid email or password");
      }
      return right("Something went wrong");
    } catch (e) {
      return right("Something went wrong");
    }
  }
}

class SucessResponse {
  final String accessToken;
  final String type;
  SucessResponse({required this.accessToken, required this.type});
}
