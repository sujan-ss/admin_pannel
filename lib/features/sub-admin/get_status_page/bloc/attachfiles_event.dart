part of 'attachfiles_bloc.dart';

sealed class AttachfilesEvent extends Equatable {
  const AttachfilesEvent();

  @override
  List<Object> get props => [];
}

final class GetAttachedFile extends AttachfilesEvent {}

final class DeleteAttachedFile extends AttachfilesEvent {
  final String id;

  const DeleteAttachedFile(this.id);

  @override
  List<Object> get props => [id];
}

final class ChangeAttachFileStatus extends AttachfilesEvent {
  final String id;
  final String status;

  const ChangeAttachFileStatus(this.id, this.status);

  @override
  List<Object> get props => [id, status];
}
