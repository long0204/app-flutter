import 'package:appbooking/Bloc/home_bloc.dart';
import 'package:appbooking/HomeScreen/HomeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  final String accountName;
  final String accountEmail;

  HomeScreen({required this.accountName, required this.accountEmail});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: HomeScreenContent(accountName: accountName, accountEmail: accountEmail),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  final String accountName;
  final String accountEmail;

  HomeScreenContent({required this.accountName, required this.accountEmail});

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is InitialTabState) {
            return _buildScreen(state.initialIndex);
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is InitialTabState) {
            return CurvedNavigationBar(
              index: state.initialIndex,
              backgroundColor: Colors.transparent,
              color: Colors.blue,
              buttonBackgroundColor: Colors.blue,
              height: 50.0,
              items: <Widget>[
                Icon(Icons.home, size: 30),
                Icon(Icons.map, size: 30),
                Icon(Icons.person, size: 30),
              ],
              onTap: (index) {
                context.read<HomeBloc>().add(ChangeTabEvent(index));
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return HomeWidget(
          accountName: widget.accountName,
          accountEmail: widget.accountEmail,
          hotelList: holtel,
          bookedHotels: bookedHotels,
        );
      case 1:
        return MapWidget(
          accountName: widget.accountName,
          accountEmail: widget.accountEmail,
          hotelList: holtel,
        );
      case 2:
        return ProfileWidget(
          accountName: widget.accountName,
          accountEmail: widget.accountEmail,
          bookedHotels: bookedHotels,
        );
      default:
        return Container(); // Trả về một widget mặc định nếu index không hợp lệ
    }
  }
}
