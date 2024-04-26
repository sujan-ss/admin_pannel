import 'dart:async';

import 'package:admin_panel/data/models/user_model.dart';
import 'package:admin_panel/features/verification/data/repository/verification_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(VerificationInitial()) {
    on<GetUnverifiedUser>(_onGetUnverifiedUser);
    on<VerifyUser>(_onVerifyUser);
  }

  final VerificationServices _verificationServices = VerificationServices();

  FutureOr<void> _onGetUnverifiedUser(
      GetUnverifiedUser event, Emitter<VerificationState> emit) async {
    final response = await _verificationServices.getUnverifiedUser();
    response.fold(
      (users) => emit(VerificationLoaded(users)),
      (error) => emit(VerificationError(error)),
    );
  }

  FutureOr<void> _onVerifyUser(
      VerifyUser event, Emitter<VerificationState> emit) async {
    final response = await _verificationServices.verifyUser(event.userId);
    response.fold((l) {
      //remove the user from the list
      final currentState = state as VerificationLoaded;
      final users = currentState.users
          .where((element) => element.id != event.userId)
          .toList();
      emit(VerificationLoaded(users));
    }, (r) => {});
  }
}
