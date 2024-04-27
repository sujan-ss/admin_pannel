import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<ChangeIndexEvent>(changeIndexEvent);
  }

  FutureOr<void> changeIndexEvent(
      ChangeIndexEvent event, Emitter<NavigationState> emit) {
    emit(NavigationIndex(index: event.index));
  }
}
