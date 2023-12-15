import 'package:cookify/bloc/first_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstHomeScreen extends StatelessWidget {
  final String accountName;

  FirstHomeScreen({required this.accountName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirstHomeBloc(),
      child: FirstHomeScreenContent(accountName: accountName),
    );
  }
}

class FirstHomeScreenContent extends StatelessWidget {
  final String accountName;

  FirstHomeScreenContent({required this.accountName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FirstHomeBloc, FirstHomeState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hello $accountName',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'New',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 200, 
              child: Image.asset(
                'images/banner.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Trending',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(height: 100,),
                  Image.asset(
                    'images/Burger.png',
                    width: 300,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/Cheese Pizza.jpg',
                    width: 300,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/Chicken Burger.jpg',
                    width: 300,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/Pizza.png',
                    width: 300,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                 
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Rate',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 20),
                  Image.asset(
                    'images/mexicanpizza.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/Cheese Pizza.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/butterchicken.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/frenchtoast.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                 
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Mostview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 20),
                  Image.asset(
                    'images/butterchicken.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/Cheese Pizza.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/butterchicken.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/frenchtoast.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Rate',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 20),
                  Image.asset(
                    'images/ramennoodles.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/frenchtoast.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/butterchicken.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'images/frenchtoast.jpg',
                    width: 300,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  
                ],
              ),
            ),
              ],
            ),
          );
        },
      ),
    );
  }
}
