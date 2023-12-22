import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Screen/MyiGoss.dart';

import 'Screen/ETicketScreen.dart';
import 'Screen/EcoreScreen.dart';
import 'Screen/PersonalizedScreen.dart';
import 'Screen/ReportScreen.dart';
import 'Screen/SearchScreen.dart';
import 'Screen/Workscreen.dart';
import 'Screen/eServiceScreen.dart';

void main() {
  runApp(MyApp());
}

class TabCubit extends Cubit<int> {
  TabCubit() : super(0);

  void changeTab(int index) => emit(index);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocProvider(
        create: (context) => TabCubit(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Icon(Icons.account_circle, color: Colors.white),
            Text('My Igoss'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              // Xử lý khi nhấn nút tin nhắn
            },
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonalizedScreen()),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
      body: BlocBuilder<TabCubit, int>(
        builder: (context, tabIndex) {
          return IndexedStack(
            index: tabIndex,
            children: [
              Tab1(),
              Tab2(),
              Tab3(),
              Tab4(),
              Tab5(),
              Tab6(),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<TabCubit, int>(
        builder: (context, tabIndex) {
          return BottomNavigationBar(
            currentIndex: tabIndex,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onTap: (index) {
              context.read<TabCubit>().changeTab(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.work, color: Colors.green),
                label: 'Work',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.airplane_ticket, color: Colors.green),
                label: 'eTicket',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.autorenew, color: Colors.green),
                label: 'eService',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.insert_drive_file, color: Colors.green),
                label: 'Ecore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart, color: Colors.green),
                label: 'Report',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.switch_account_outlined, color: Colors.green),
                label: 'My iGoss',
              ),
            ],
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.black,
          );
        },
      ),
    );
  }
}
