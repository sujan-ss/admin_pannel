import 'package:admin_panel/repository/api.dart';
import 'package:admin_panel/repository/access_token_repo.dart';
import 'package:dio/dio.dart';

enum ApiMethod { get, post, put, delete }

bool isAlertDialougeOpen = false;

final apiHandler = ApiHandler();

class ApiHandler {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    receiveTimeout: const Duration(seconds: 100),
    connectTimeout: const Duration(seconds: 100),
    sendTimeout: const Duration(seconds: 100),

    ///15 seconds
  ));

  Future callApi(
    ApiMethod method,
    dynamic body,
    String url, {
    bool isHeader = false,
    Map<String, dynamic>? queryparameter,
  }) async {
    final String accessToken = await AccessTokenRepo().getAccessToken() ?? "";
    print(accessToken);
    try {
      final headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'authorization': 'Bearer $accessToken'
      };
      dynamic response;

      if (method == ApiMethod.get) {
        response = await dio.get(url,
            queryParameters: queryparameter,
            options: Options(
              headers: isHeader ? headers : null,
            ));
        return response;
      } else if (method == ApiMethod.post) {
        response = await dio.post(url,
            data: body,
            options: Options(
              headers: headers,
            ));
        return response;
      } else if (method == ApiMethod.put) {
        response = await dio.put(url,
            data: body,
            options: Options(
              headers: headers,
            ));
        return response;
      } else if (method == ApiMethod.delete) {
        response = await dio.delete(url,
            data: body,
            options: Options(
              headers: headers,
            ));
        return response;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        // String? refreshToken = box.get("refreshToken");
        // return getRefreshToken(refreshToken!, method, body, url, isHeader);
      } else {
        rethrow;
      }
    }
  }

  // Future getRefreshToken(String refreshToken, ApiMethod method,
  //     Map<String, dynamic>? body, String url, bool isHeader) async {
  //   try {
  //     debugPrint("refresh token called");
  //     Box box = Hive.box("localData");
  //     String refreshToken = box.get("refreshToken");
  //     // final headers = {
  //     //   'Content-Type': 'application/json;charset=UTF-8',
  //     //   'Charset': 'utf-8',
  //     //   'authorization': 'Bearer $refreshToken'
  //     // };
  //     final response =
  //         await dio.post(regenerateToken, data: {"token": refreshToken});

  //     box.put("accessToken", response.data["accessToken"]);
  //     final responseReturn = callApi(method, body, url, isHeader: isHeader);
  //     return responseReturn;
  //   } on DioException catch (e) {
  //     Box box = Hive.box("localData");
  //     if (e.response?.statusCode == 403) {
  //       debugPrint("Refresh token expired");
  //       DialogBox.showAlertDialouge(
  //           isDismissible: false,
  //           context: navigatorKey.currentContext!,
  //           title: "Sesson Expired",
  //           buttonText: "Login",
  //           buttonFunction: () {
  //             box.put("isLoggedIn", false);
  //             navigatorKey.currentState!
  //                 .pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
  //           },
  //           content: "Your session has expired. Please login again.");

  //       rethrow;
  //     }
  //   }
  // }
}
