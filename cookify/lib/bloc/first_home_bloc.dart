import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class FirstHomeEvent {}

// States
abstract class FirstHomeState {}

class InitialFirstHomeState extends FirstHomeState {}

// BLoC
class FirstHomeBloc extends Bloc<FirstHomeEvent, FirstHomeState> {
  FirstHomeBloc() : super(InitialFirstHomeState());

  @override
  Stream<FirstHomeState> mapEventToState(FirstHomeEvent event) async* {
    // Handle events and emit states if necessary
  }
}
