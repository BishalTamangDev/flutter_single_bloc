import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeSnackbarEvent>(homeSnackbarEvent);
  }

  FutureOr<void> homeInitialEvent(event, state) async {
    emit(HomeLoadingState());
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Random().nextBool()
        ? emit(HomeLoadingSuccessState())
        : emit(HomeLoadingFailureState());
  }

  homeSnackbarEvent(event, state) {
    emit(HomeScackbarState());
  }
}
