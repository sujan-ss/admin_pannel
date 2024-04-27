part of 'incident_bloc.dart';

sealed class IncidentEvent extends Equatable {
  const IncidentEvent();

  @override
  List<Object> get props => [];
}

final class GetIncident extends IncidentEvent {
  const GetIncident();
}

final class DeleteIncident extends IncidentEvent {
  final String incidentId;

  const DeleteIncident(this.incidentId);

  @override
  List<Object> get props => [incidentId];
}
