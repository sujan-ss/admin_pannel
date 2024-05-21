part of 'police_bloc.dart';

sealed class PoliceEvent extends Equatable {
  const PoliceEvent();

  @override
  List<Object> get props => [];
}

class AddPoilceEvent extends PoliceEvent {
  final String name;

  const AddPoilceEvent(this.name);

  @override
  List<Object> get props => [name];
}
