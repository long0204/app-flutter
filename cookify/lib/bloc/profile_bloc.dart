import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ProfileEvent {}

class LogoutEvent extends ProfileEvent {}

// States
abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

// BLoC
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(InitialProfileState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LogoutEvent) {
      // Perform logout logic here if needed
      yield InitialProfileState();
    }
  }
}
