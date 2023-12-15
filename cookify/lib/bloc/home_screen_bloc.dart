// // home_screen_bloc.dart
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class HomeScreenEvent {}

// class NavigateToLoginEvent extends HomeScreenEvent {}

// class NavigateToCreateAccountEvent extends HomeScreenEvent {}

// abstract class HomeScreenState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class InitialHomeScreenState extends HomeScreenState {}

// class NavigatedToLoginState extends HomeScreenState {}

// class NavigatedToCreateAccountState extends HomeScreenState {}
// // home_screen_bloc.dart
// class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
//   HomeScreenBloc() : super(InitialHomeScreenState());

//   @override
//   Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
//     if (event is NavigateToLoginEvent) {
//       yield NavigatedToLoginState();
//     } else if (event is NavigateToCreateAccountEvent) {
//       yield NavigatedToCreateAccountState();
//     }
//   }
// }
// home_screen_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent {}

class NavigateToLoginEvent extends HomeScreenEvent {}

class NavigateToCreateAccountEvent extends HomeScreenEvent {}

abstract class HomeScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialHomeScreenState extends HomeScreenState {}

class NavigatedToLoginState extends HomeScreenState {}

class NavigatedToCreateAccountState extends HomeScreenState {}

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(InitialHomeScreenState());

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is NavigateToLoginEvent) {
      yield NavigatedToLoginState();
    } else if (event is NavigateToCreateAccountEvent) {
      yield NavigatedToCreateAccountState();
    }
  }
}
