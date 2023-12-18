import 'package:appbooking/Bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void createAccount(BuildContext context) {
    BlocProvider.of<WelcomeBloc>(context).add(
      CreateAccountEvent(
        accountName: accountNameController.text,
        accountEmail: accountEmailController.text,
        password: passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WelcomeBloc, WelcomeState>(
        listener: (context, state) {
          if (state is CreateAccountErrorState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(state.errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state is CreateAccountSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.white.withOpacity(0.7),
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
                          color: Colors.blueAccent,
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
                            prefixIcon: Icon(Icons.person, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: accountEmailController,
                          decoration: InputDecoration(
                            labelText: 'Account Email',
                            prefixIcon: Icon(Icons.email, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ForgotPasswordScreen(
                              //       accountsData: accountsData,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'CustomFont',
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            createAccount(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: Colors.blueAccent,
                            minimumSize: Size(200.0, 50.0),
                          ),
                          child: Center(
                            child: Text(
                              'Create Account',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
