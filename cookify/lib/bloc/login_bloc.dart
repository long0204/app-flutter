// login_bloc.dart
import 'package:cookify/bloc/create_account_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class LoginEvent {}

class PerformLoginEvent extends LoginEvent {
  final String email;
  final String password;

  PerformLoginEvent({required this.email, required this.password});
}

// States
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailedState extends LoginState {
  final String errorMessage;

  LoginFailedState({required this.errorMessage});
}

// BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is PerformLoginEvent) {
      try {
        // Replace the following with your actual authentication logic
        // For example, check the email and password against a database
        bool authenticationSuccessful = checkAuthentication(
          event.email,
          event.password,
        );

        if (authenticationSuccessful) {
          yield LoginSuccessState();
        } else {
          yield LoginFailedState(errorMessage: 'Incorrect email or password');
        }
      } catch (e) {
        yield LoginFailedState(errorMessage: 'Login failed. Please try again.');
      }
    }
  }

  bool checkAuthentication(String email, String password) {
  // Replace this with your actual authentication logic
  // Check if the provided email and password match any user account

  for (var account in accountsData) {
    if (account['Accountemail'] == email && account['Password'] == password) {
      // Authentication successful
      return true;
    }
  }

  // Authentication failed
  return false;
}

}
