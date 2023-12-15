import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class HomeEvent {}

class NavigateToScreenEvent extends HomeEvent {
  final int index;

  NavigateToScreenEvent(this.index);
}

// States
abstract class HomeState {}

class FirstHomeScreenState extends HomeState {}

class CategoriesScreenState extends HomeState {}

class MealScreenState extends HomeState {}

class ProfileScreenState extends HomeState {}

// BLoC
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(FirstHomeScreenState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is NavigateToScreenEvent) {
      yield _getStateForIndex(event.index);
    }
  }

  HomeState _getStateForIndex(int index) {
    switch (index) {
      case 0:
        return FirstHomeScreenState();
      case 1:
        return CategoriesScreenState();
      case 2:
        return MealScreenState();
      case 3:
        return ProfileScreenState();
      default:
        return FirstHomeScreenState();
    }
  }
}
