import 'package:admin_panel/data/models/user_model.dart';
import 'package:admin_panel/repository/api.dart';
import 'package:admin_panel/utils/api_handler.dart';
import 'package:dartz/dartz.dart';

enum UserFetchMode { all, unverified }

class UserServices {
  Future<Either<List<UserModel>, String>> getUsers({
    UserFetchMode mode = UserFetchMode.unverified,
  }) async {
    try {
      final response = await apiHandler.callApi(
          ApiMethod.get,
          null,
          mode == UserFetchMode.all
              ? ApiConstants.getVerifiedUserUrl
              : ApiConstants.getUnverifiedUser,
          isHeader: true);
      final List<UserModel> users = response.data['users']
          .map<UserModel>((user) => UserModel.fromJson(user))
          .toList();

      return left(users);
    } catch (e) {
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

  Future<Either<bool, String>> deleteUser(
    String userId,
  ) async {
    try {
      final data = {"userId": userId};

      await apiHandler.callApi(ApiMethod.delete, data, ApiConstants.deleteUser,
          isHeader: true);
      return left(true);
    } catch (e) {
      print(e);
      return right("Something went wrong");
    }
  }
}
