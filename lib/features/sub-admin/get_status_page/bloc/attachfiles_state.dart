part of 'attachfiles_bloc.dart';

sealed class AttachfilesState extends Equatable {
  const AttachfilesState();

  @override
  List<Object> get props => [];
}

final class AttachfilesInitial extends AttachfilesState {}

final class AttachfilesLoading extends AttachfilesState {}

final class AttachedFileError extends AttachfilesState {
  final String message;

  const AttachedFileError(this.message);

  @override
  List<Object> get props => [message];
}

final class AttachfilesLoaded extends AttachfilesState {
  final List<AttachFilesModel> attachFiles;

  const AttachfilesLoaded(this.attachFiles);

  @override
  List<Object> get props => [attachFiles];
}
