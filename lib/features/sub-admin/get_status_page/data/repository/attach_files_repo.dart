import 'package:admin_panel/features/sub-admin/get_status_page/data/domain/attach_files_mode.dart';
import 'package:admin_panel/repository/api.dart';
import 'package:admin_panel/utils/api_handler.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class AttachFilesRepo {
  Future<Either<List<AttachFilesModel>, String>> getAttachFiles() async {
    try {
      final response = await apiHandler.callApi(
          ApiMethod.get, null, ApiConstants.getAttachedFilesUrl,
          isHeader: true);

      List<AttachFilesModel> attachFiles =
          (response.data['attachFiles'] as List)
              .map((e) => AttachFilesModel.fromJson(e))
              .toList();

      return left(attachFiles);
    } catch (e) {
      debugPrint(e.toString());
      return right("Something went wrong");
    }
  }
}
