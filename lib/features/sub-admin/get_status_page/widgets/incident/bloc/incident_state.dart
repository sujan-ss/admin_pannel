part of 'incident_bloc.dart';

sealed class IncidentState extends Equatable {
  const IncidentState();

  @override
  List<Object> get props => [];
}

final class IncidentInitial extends IncidentState {}

final class IncidentFetchInProgress extends IncidentState {}

final class IncidentFetchFailure extends IncidentState {
  final String message;

  const IncidentFetchFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class IncidentFetchSuccess extends IncidentState {
  final List<IncidentModel> incidents;

  const IncidentFetchSuccess({required this.incidents});

  @override
  List<Object> get props => [incidents];
}

final class UpdateStatusSucess extends IncidentState {}
