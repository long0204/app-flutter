// auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class ForgotPasswordEvent extends AuthEvent {}

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingState extends AuthState {}

class LoggedInState extends AuthState {
  // Add user information if needed
}

class ForgotPasswordState extends AuthState {}

class ErrorState extends AuthState {
  final String error;

  ErrorState({required this.error});
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield LoadingState();

      // Authentication logic here
      try {
        await Future.delayed(Duration(seconds: 2));
        yield LoggedInState();
      } catch (e) {
        yield ErrorState(error: "Authentication failed. Please try again.");
      }
    } else if (event is ForgotPasswordEvent) {
      yield ForgotPasswordState();
    }
  }
}
