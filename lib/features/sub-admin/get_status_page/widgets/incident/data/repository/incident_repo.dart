import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/data/domain/incident_model.dart';
import 'package:admin_panel/repository/api.dart';
import 'package:admin_panel/utils/api_handler.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class IncidentRepo {
  Future<Either<List<IncidentModel>, String>> getIncident() async {
    try {
      final response = await apiHandler.callApi(
          ApiMethod.get, null, ApiConstants.getIncidentsUrl,
          isHeader: true);

      List<IncidentModel> attachFiles = (response.data['incidents'] as List)
          .map((e) => IncidentModel.fromJson(e))
          .toList();

      return left(attachFiles);
    } catch (e) {
      debugPrint(e.toString());
      return right("Something went wrong");
    }
  }

  Future<Either<bool, String>> deleteUser(
    String incidentId,
  ) async {
    try {
      final data = {
        "incidentId": incidentId,
      };

      await apiHandler.callApi(
          ApiMethod.delete, data, ApiConstants.deleteIncidentsUrl,
          isHeader: true);
      return left(true);
    } catch (e) {
      print(e);
      return right("Something went wrong");
    }
  }
}
