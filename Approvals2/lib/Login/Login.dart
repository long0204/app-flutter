import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../Bloc/approval_bloc.dart';
import '../Screen/approval_screen.dart';
import 'CreateAcc.dart';
import 'Forgotpass.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final ApprovalBloc approvalBloc = BlocProvider.of<ApprovalBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
        body: BlocBuilder<ApprovalBloc, ApprovalState>(
        builder: (context, state) {
      bool _passwordVisible = false;
      TextEditingController emailController = TextEditingController();
      TextEditingController passwordController = TextEditingController();
      bool isEmailEntered = false;
      bool checkLoginPress = false;
      bool checkPassPress = false;

      void login() {
        String enteredEmail = emailController.text.trim();
        String enteredPassword = passwordController.text.trim();

        if (!isEmailEntered) {
          approvalBloc.add(CheckUserExistEvent(email: enteredEmail));
        } else {
          approvalBloc.add(RequestTokenEvent(email: enteredEmail, password: enteredPassword));
        }
      }
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_outlined,
                size: 64,
                color: Colors.green,
              ),
              SizedBox(height: 16),
              Text(
                'Log In',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email,
                      color: Colors.green),
                ),
              ),
              if (checkLoginPress && !isEmailEntered)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Tên đăng nhập sai/tài khoản chưa tồn tại!',
                      style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              if (isEmailEntered)
                SizedBox(height: 16),
              if (isEmailEntered)
                TextField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock,
                        color: Colors.green),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
              if (checkPassPress && isEmailEntered)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Mật khẩu sai !', style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic)),
                  ],
                ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Add logic to handle login
                  if(isEmailEntered){
                    checkPassPress =true;
                  }
                  login();
                  setState(() {
                    checkLoginPress =true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Set the background color to green
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAccountScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "I haven't already an account",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'CustomFont',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    );
  }
}
