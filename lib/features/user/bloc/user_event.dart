part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class GetUserEvent extends UserEvent {
  const GetUserEvent();
}

final class DeleteUserEvent extends UserEvent {
  final String userId;

  const DeleteUserEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
