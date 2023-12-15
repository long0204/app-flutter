import 'package:cookify/MainScreen/create_account_screen.dart';
import 'package:cookify/MainScreen/login_screen.dart';
import 'package:cookify/bloc/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenBloc(),
      child: HomeScreenContent(),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
   final List<Map<String, String>> listAccounts = [
    {
      "Accountname": "A001",
      "Accountemail": "A001",
      "Password": "1",
      "FlagActive": "1",
    },
    {
      "Accountname": "A002",
      "Accountemail": "A002@gmail.com",
      "Password": "1q2w3E",
      "FlagActive": "1",
    },
    // ...Thêm các tài khoản khác
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state is NavigatedToLoginState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else if (state is NavigatedToCreateAccountState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateAccountScreen()),
          );
        }
      },
      child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.red,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/boy.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Gửi sự kiện để chuyển đến màn hình đăng nhập
                      context.read<HomeScreenBloc>().add(NavigateToLoginEvent());
                    },
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Gửi sự kiện để chuyển đến màn hình tạo tài khoản
                      context.read<HomeScreenBloc>().add(NavigateToCreateAccountEvent());
                    },
                    child: Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        )
      );
    }
}

