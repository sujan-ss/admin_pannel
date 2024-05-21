import 'dart:async';
import 'dart:convert';

import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/data/domain/incident_model.dart';
import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/data/repository/incident_repo.dart';
import 'package:admin_panel/repository/api.dart';
import 'package:admin_panel/utils/api_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'incident_event.dart';
part 'incident_state.dart';

class IncidentBloc extends Bloc<IncidentEvent, IncidentState> {
  IncidentBloc() : super(IncidentInitial()) {
    on<IncidentEvent>(incidentEvent);
    on<DeleteIncident>(deleteIncident);
    on<ChangeIncidentStatus>(changeIncidentStatus);
    on<GetPoliceEvent>(getPoliceEvent);
    on<UpdatePolice>(updatePolice);
  }

  FutureOr<void> incidentEvent(
      IncidentEvent event, Emitter<IncidentState> emit) async {
    final response = await IncidentRepo().getIncident();
    response.fold((l) {
      emit(IncidentFetchSuccess(incidents: l));
    }, (r) {
      emit(IncidentFetchFailure(message: r));
    });
  }

  FutureOr<void> deleteIncident(
      DeleteIncident event, Emitter<IncidentState> emit) async {
    final response = await IncidentRepo().deleteUser(event.incidentId);
    response.fold((l) {
      emit(IncidentFetchSuccess(
          incidents: (state as IncidentFetchSuccess)
              .incidents
              .where((element) => element.id != event.incidentId)
              .toList()));
    }, (r) {
      emit(IncidentFetchFailure(message: r));
    });
  }

  FutureOr<void> changeIncidentStatus(
      ChangeIncidentStatus event, Emitter<IncidentState> emit) async {
    final response = await IncidentRepo()
        .changeIncidentStatus(event.incidentId, event.status);
    response.fold((l) {
      emit(IncidentFetchSuccess(
          incidents: (state as IncidentFetchSuccess)
              .incidents
              .map((e) => e.id == event.incidentId
                  ? e.copyWith(status: event.status)
                  : e)
              .toList()));
      emit(UpdateStatusSucess());
    }, (r) {
      emit(IncidentFetchFailure(message: r));
    });
  }

  FutureOr<void> getPoliceEvent(
      GetPoliceEvent event, Emitter<IncidentState> emit) async {
    try {
      emit(PoliceFetchInProgress());

      final response = await apiHandler.callApi(
          ApiMethod.get, {}, ApiConstants.getPoliceUrl,
          isHeader: true);
      List<String> police = (response.data["police"] as List).map((e) {
        final name = e["name"];

        return name.toString();
      }).toList();

      emit(PoliceFetchSuccess(police: police));
    } catch (e) {
      print("error: $e");
      emit(PoliceFetchFailure(message: e.toString()));
    }
  }

  FutureOr<void> updatePolice(
      UpdatePolice event, Emitter<IncidentState> emit) async {
    try {
      final response = await apiHandler.callApi(
          ApiMethod.put,
          {"police": event.police, "incidentId": event.incidentId},
          ApiConstants.assignPolice,
          isHeader: true);
      emit(UpdateStatusSucess());
    } catch (e) {
      print("This is the errror");
      print(e);
    }
  }
}
