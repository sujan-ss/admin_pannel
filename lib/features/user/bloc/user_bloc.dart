import 'dart:async';

import 'package:admin_panel/data/models/user_model.dart';
import 'package:admin_panel/features/verification/data/repository/verification_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetUserEvent>(getUser);
    on<DeleteUserEvent>(deleteUser);
  }

  FutureOr<void> getUser(GetUserEvent event, Emitter<UserState> emit) async {
    final response = await UserServices().getUsers(mode: UserFetchMode.all);
    response.fold(
      (users) => emit(UserFetchSuccess(users: users)),
      (message) => emit(UserFetchFailure(message: message)),
    );
  }

  FutureOr<void> deleteUser(
      DeleteUserEvent event, Emitter<UserState> emit) async {
    final response = await UserServices().deleteUser(event.userId);
    response.fold((l) {
      emit(UserFetchSuccess(
          users: (state as UserFetchSuccess)
              .users
              .where((e) => e.id != event.userId)
              .toList()));
    }, (r) {
      emit(UserFetchFailure(message: r));
    });
  }
}
