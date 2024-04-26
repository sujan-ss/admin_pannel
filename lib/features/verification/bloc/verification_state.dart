part of 'verification_bloc.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

final class VerificationInitial extends VerificationState {}

final class VerificationLoading extends VerificationState {}

final class VerificationLoaded extends VerificationState {
  final List<UserModel> users;

  const VerificationLoaded(this.users);

  @override
  List<Object> get props => [users];
}

final class VerificationError extends VerificationState {
  final String error;

  const VerificationError(this.error);

  @override
  List<Object> get props => [error];
}
