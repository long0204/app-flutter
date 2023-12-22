import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AuthEvent {}

class GoToLoginEvent extends AuthEvent {}

class GoToSignInEvent extends AuthEvent {}

// States
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoginState extends AuthState {}

class SignInState extends AuthState {}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState()) {
    on<GoToLoginEvent>(_onGoToLoginEvent);
    on<GoToSignInEvent>(_onGoToSignInEvent);
  }


  void _onGoToLoginEvent(GoToLoginEvent event, Emitter<AuthState> emit) {
    emit(LoginState());
  }
  void _onGoToSignInEvent(GoToSignInEvent event, Emitter<AuthState> emit) {
    emit(SignInState());
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is GoToSignInEvent) {
      yield SignInState();
    }
    else
      {
        yield LoginState();
      }
  }
}
