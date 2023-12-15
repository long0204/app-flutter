import 'package:cookify/MainScreen/forgotpassword_screen.dart';
import 'package:cookify/MainScreen/login_screen.dart';
import 'package:cookify/bloc/create_account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => CreateAccountBloc(),
          child: CreateAccountScreenContent(),
        ),
      ),
    );
  }
}


// ignore: must_be_immutable
class CreateAccountScreenContent extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showPassword = false;

  // Controllers for text fields
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.white,
                height: double.infinity,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 64,
                      color: Colors.redAccent,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'CustomFont',
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: accountNameController,
                      decoration: InputDecoration(
                        labelText: 'Account Name',
                        prefixIcon: Icon(Icons.person, color: Colors.redAccent),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: accountEmailController,
                      decoration: InputDecoration(
                        labelText: 'Account Email',
                        prefixIcon: Icon(Icons.email, color: Colors.redAccent),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Colors.redAccent),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            _showPassword = !_showPassword;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
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
                            color: Colors.redAccent,
                            fontFamily: 'CustomFont',
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                    onPressed: () {
                      String accountName = accountNameController.text.trim();
                      String accountEmail = accountEmailController.text.trim();
                      String password = passwordController.text.trim();

                      // Check if the account already exists
                      bool accountExists = accountsData.any(
                        (account) =>
                            account['Accountname'] == accountName ||
                            account['Accountemail'] == accountEmail,
                      );
                      if (accountExists) {
                        // Display a snackbar if the account already exists
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Tài khoản đã tồn tại'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        // Proceed with account creation logic
                        context.read<CreateAccountBloc>().add(
                          PerformCreateAccountEvent(
                            accountName: accountName,
                            accountEmail: accountEmail,
                            password: password,
                          ),
                        );
                       ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Tài khoản tạo thành công'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        // Navigate to the login screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                    },
                    child: Text('Create Account'),
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'I have Already have an account',
                            style: TextStyle(
                              color: Colors.redAccent,
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
            ],
          ),
        ),
      );
    }
  }
