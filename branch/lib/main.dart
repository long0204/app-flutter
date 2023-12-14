import 'package:branch/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_bloc.dart';
import 'detail_bloc.dart';  // Import DetailBloc

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'District Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SearchBloc()),
          BlocProvider(create: (context) => DetailBloc()),
        ],
        child: MaterialApp(
          home: SearchScreen(),
        ),
      )
    );
  }
}
