part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

// click events
class HomeSnackbarEvent extends HomeEvent {}
