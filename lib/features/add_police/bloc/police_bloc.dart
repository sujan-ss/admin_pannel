import 'dart:async';

import 'package:admin_panel/features/add_police/data/repository/add_police.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'police_event.dart';
part 'police_state.dart';

class PoliceBloc extends Bloc<PoliceEvent, PoliceState> {
  PoliceBloc() : super(PoliceInitial()) {
    on<AddPoilceEvent>(addPoilceEvent);
  }
  final addPoliceService = AddPoliceService();

  FutureOr<void> addPoilceEvent(
      AddPoilceEvent event, Emitter<PoliceState> emit) async {
    final response = await addPoliceService.addPolice(event.name);
    response.fold(
      (l) {
        emit(AddPoliceSuccess());
      },
      (r) => emit(AddPoliceFailure(r)),
    );
  }
}
