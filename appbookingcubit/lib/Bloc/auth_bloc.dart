import 'package:flutter_bloc/flutter_bloc.dart';

// Define events
abstract class WelcomeEvent {}

class LoginEvent extends WelcomeEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class CreateAccountEvent extends WelcomeEvent {
  final String accountName;
  final String accountEmail;
  final String password;

  CreateAccountEvent({
    required this.accountName,
    required this.accountEmail,
    required this.password,
  });
}

List<Map<String, String>> accountsData = [
  {
    "Accountname": "A001",
    "Accountemail": "A001",
    "Password": "1",
    "FlagActive": "1"
  },
];


// Define states
abstract class WelcomeState {}

class LoginErrorState extends WelcomeState {
  final String errorMessage;

  LoginErrorState({required this.errorMessage});
}

class CreateAccountErrorState extends WelcomeState {
  final String errorMessage;

  CreateAccountErrorState({required this.errorMessage});
}

class LoginSuccessState extends WelcomeState {
  final String accountName;
  final String accountEmail;

  LoginSuccessState({required this.accountName, required this.accountEmail});
}

class CreateAccountSuccessState extends WelcomeState {
  final String accountName;
  final String accountEmail;

  CreateAccountSuccessState({required this.accountName, required this.accountEmail});
}

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial());

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    if (event is LoginEvent) {
      yield* _mapLoginEventToState(event);
    }
  }

  Stream<WelcomeState> _mapLoginEventToState(LoginEvent event) async* {
    String enteredEmail = event.email.trim();
    String enteredPassword = event.password.trim();

    // Check if the entered email and password exist in accountsData
    bool credentialsMatch = accountsData.any(
      (account) => account['Accountemail'] == enteredEmail,
    );
    bool passMatch = accountsData.any(
      (account) => account['Password'] == enteredPassword,
    );

    if (credentialsMatch) {
      if (!passMatch) {
        yield LoginErrorState(errorMessage: 'Sai mật khẩu!');
      } else {
        String accountName = "";
        String? accountNameNullable = accountsData.firstWhere(
          (account) => account['Accountemail'] == enteredEmail,
        )['Accountname'];
        if (accountNameNullable != null) {
          accountName = accountNameNullable;
        }
        yield LoginSuccessState(
          accountName: accountName,
          accountEmail: enteredEmail,
        );
      }
    } else {
      yield LoginErrorState(errorMessage: 'Sai email!');
    }
  }
}

class WelcomeInitial extends WelcomeState {}
