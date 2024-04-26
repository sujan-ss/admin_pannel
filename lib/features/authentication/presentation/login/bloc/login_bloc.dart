import 'dart:async';

import 'package:admin_panel/features/authentication/data/repository/auth_repository.dart';
import 'package:admin_panel/repository/access_token_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<FormSubmitEvent>(formsubmitevent);
    on<TogglePasswordVisibility>(togglePasswordVisibiliy);
  }

  FutureOr<void> formsubmitevent(
      FormSubmitEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final response = await AuthRepository()
        .login(email: event.email, password: event.password);
    print("hello world");

    response.fold((l) {
      AccessTokenRepo().saveAccessToken(l);
      emit(LoginSuccess());
    }, (r) {
      emit(LoginFailure(message: r));
    });
  }

  FutureOr<void> togglePasswordVisibiliy(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    emit(TogglePasswordVisibilityState(isVisible: event.isVisible));
  }
}
