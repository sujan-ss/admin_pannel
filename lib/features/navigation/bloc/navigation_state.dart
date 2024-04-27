part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

final class NavigationInitial extends NavigationState {
  const NavigationInitial();
}

final class NavigationIndex extends NavigationState {
  final int index;

  const NavigationIndex({this.index = 0});

  @override
  List<Object> get props => [index];
}
