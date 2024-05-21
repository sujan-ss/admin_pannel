import 'package:admin_panel/repository/api.dart';
import 'package:admin_panel/utils/api_handler.dart';
import 'package:dartz/dartz.dart';

class AddPoliceService {
  Future<Either<bool, String>> addPolice(String name) async {
    try {
      apiHandler.callApi(
          ApiMethod.post, {"name": name}, ApiConstants.addPoliceUrl,
          isHeader: true);
      return const Left(true);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
