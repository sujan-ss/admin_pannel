part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class ChangeIndexEvent extends NavigationEvent {
  final int index;

  const ChangeIndexEvent(this.index);

  @override
  List<Object> get props => [index];
}
