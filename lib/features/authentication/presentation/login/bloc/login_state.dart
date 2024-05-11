part of 'login_bloc.dart';

sealed class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginSuccess extends LoginState {
  final String type;
  @override
  List<Object?> get props => throw UnimplementedError();

  LoginSuccess({required this.type});
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class TogglePasswordVisibilityState extends LoginState {
  final bool isVisible;

  TogglePasswordVisibilityState({required this.isVisible});

  @override
  List<Object?> get props => throw UnimplementedError();
}
