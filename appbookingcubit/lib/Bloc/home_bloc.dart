import 'package:flutter_bloc/flutter_bloc.dart';

// Define events
abstract class HomeEvent {}

class ChangeTabEvent extends HomeEvent {
  final int tabIndex;

  ChangeTabEvent(this.tabIndex);
}

// Define states
abstract class HomeState {}

class InitialTabState extends HomeState {
  final int initialIndex;

  InitialTabState(this.initialIndex);
}

// Define the bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialTabState(0));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is ChangeTabEvent) {
      yield InitialTabState(event.tabIndex);
    }
  }
}
