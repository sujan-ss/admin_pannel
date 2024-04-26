part of 'attachfiles_bloc.dart';

sealed class AttachfilesEvent extends Equatable {
  const AttachfilesEvent();

  @override
  List<Object> get props => [];
}

final class GetAttachedFile extends AttachfilesEvent {}
