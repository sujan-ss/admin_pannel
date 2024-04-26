part of 'verification_bloc.dart';

sealed class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class GetUnverifiedUser extends VerificationEvent {}

class VerifyUser extends VerificationEvent {
  final String userId;

  const VerifyUser({required this.userId});

  @override
  List<Object> get props => [userId];
}
