import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Login/Login.dart';
import 'Screen/approval_screen.dart';
import 'Bloc/approval_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ApprovalBloc>(
            create: (BuildContext context) => ApprovalBloc(),
          ),
        ],
        child: LoginScreen(),
      ),
    );
  }
}
