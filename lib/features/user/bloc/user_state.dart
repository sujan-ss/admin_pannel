part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserFetchFailure extends UserState {
  final String message;

  const UserFetchFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class UserFetchSuccess extends UserState {
  final List<UserModel> users;

  const UserFetchSuccess({required this.users});

  @override
  List<Object> get props => [users];
}
