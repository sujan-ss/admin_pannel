part of 'police_bloc.dart';

sealed class PoliceState extends Equatable {
  const PoliceState();

  @override
  List<Object> get props => [];
}

final class PoliceInitial extends PoliceState {}

final class AddPoliceLoading extends PoliceState {}

final class AddPoliceSuccess extends PoliceState {}

final class AddPoliceFailure extends PoliceState {
  final String message;

  const AddPoliceFailure(this.message);

  @override
  List<Object> get props => [message];
}
