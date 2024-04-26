import 'package:admin_panel/data/models/user_model.dart';
import 'package:admin_panel/repository/api.dart';
import 'package:admin_panel/utils/api_handler.dart';
import 'package:dartz/dartz.dart';

class VerificationServices {
  Future<Either<List<UserModel>, String>> getUnverifiedUser() async {
    try {
      final response = await apiHandler.callApi(
          ApiMethod.get, null, ApiConstants.getUnverifiedUser,
          isHeader: true);
      final List<UserModel> users = response.data['users']
          .map<UserModel>((user) => UserModel.fromJson(user))
          .toList();

      return left(users);
    } catch (e) {
      print(e);
      return right("Something went wrong");
    }
  }

  Future<Either<bool, String>> verifyUser(
    String userId,
  ) async {
    try {
      await apiHandler.callApi(
          ApiMethod.post, {"userId": userId}, ApiConstants.verifyUserUrl,
          isHeader: true);
      return left(true);
    } catch (e) {
      print(e);
      return right("Something went wrong");
    }
  }
}
