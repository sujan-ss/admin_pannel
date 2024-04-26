import 'dart:async';

import 'package:admin_panel/features/sub-admin/get_status_page/data/domain/attach_files_mode.dart';
import 'package:admin_panel/features/sub-admin/get_status_page/data/repository/attach_files_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'attachfiles_event.dart';
part 'attachfiles_state.dart';

class AttachfilesBloc extends Bloc<AttachfilesEvent, AttachfilesState> {
  AttachfilesBloc() : super(AttachfilesInitial()) {
    on<GetAttachedFile>(getAttachFile);
  }

  FutureOr<void> getAttachFile(
      GetAttachedFile event, Emitter<AttachfilesState> emit) async {
    emit(AttachfilesLoading());
    final response = await AttachFilesRepo().getAttachFiles();
    response.fold((attachFiles) {
      emit(AttachfilesLoaded(attachFiles));
    }, (error) {
      emit(AttachedFileError(error));
    });
  }
}
