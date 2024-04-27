import 'dart:async';

import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/data/domain/incident_model.dart';
import 'package:admin_panel/features/sub-admin/get_status_page/widgets/incident/data/repository/incident_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'incident_event.dart';
part 'incident_state.dart';

class IncidentBloc extends Bloc<IncidentEvent, IncidentState> {
  IncidentBloc() : super(IncidentInitial()) {
    on<IncidentEvent>(incidentEvent);
    on<DeleteIncident>(deleteIncident);
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
}
