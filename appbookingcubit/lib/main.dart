import 'package:appbooking/Bloc/auth_bloc.dart';
import 'package:appbooking/Login/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (BuildContext context) => WelcomeBloc(),
        child: WelcomeScreen(),
      ),
    );
  }
}
