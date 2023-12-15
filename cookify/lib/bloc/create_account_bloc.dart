// create_account_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

// Define your events and states

abstract class CreateAccountEvent {}

class PerformCreateAccountEvent extends CreateAccountEvent {
  final String accountName;
  final String accountEmail;
  final String password;

  PerformCreateAccountEvent({
    required this.accountName,
    required this.accountEmail,
    required this.password,
  });
}

abstract class CreateAccountState {}

class TogglePasswordVisibilityEvent extends CreateAccountEvent {}

class InitialCreateAccountState extends CreateAccountState {}

class CreateAccountSuccessState extends CreateAccountState {}

class CreateAccountFailedState extends CreateAccountState {
  final String errorMessage;

  CreateAccountFailedState({required this.errorMessage});
}
List<Map<String, String>> accountsData = [
    {
      "Accountname": "A001",
      "Accountemail": "A001",
      "Password": "1",
      "FlagActive": "1"
    },
    {
      "Accountname": "A002",
      "Accountemail": "A002@gmail.com",
      "Password": "1q2w3E",
      "FlagActive": "1"
    },
    {
      "Accountname": "A003",
      "Accountemail": "A003@gmail.com",
      "Password": "1q2w3E",
      "FlagActive": "1"
    }
  ];

class CreateAccountBloc
    extends Bloc<CreateAccountEvent, CreateAccountState> {
  CreateAccountBloc() : super(InitialCreateAccountState());

  @override
  Stream<CreateAccountState> mapEventToState(CreateAccountEvent event) async* {
    if (event is PerformCreateAccountEvent) {
      try {
        bool accountExists = accountsData.any(
          (account) =>
              account['Accountemail'] == event.accountEmail,
        );
        print(accountExists);
        if (accountExists) {
          yield CreateAccountFailedState(errorMessage: 'Tài khoản đã tồn tại');
        } else {
          // Add the new account to the data
          accountsData.add({
            "Accountname": event.accountName,
            "Accountemail": event.accountEmail,
            "Password": event.password,
            "FlagActive": "1",
          });
        print(accountsData);
          yield CreateAccountSuccessState();
        }
      } catch (e) {
        yield CreateAccountFailedState(errorMessage: 'Đã xảy ra lỗi');
      }
    }
  }
}
