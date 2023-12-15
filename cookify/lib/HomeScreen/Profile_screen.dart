import 'package:cookify/MainScreen/home_screen.dart';
import 'package:cookify/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;

  ProfileScreen({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: ProfileScreenContent(username: username, email: email),
    );
  }
}

class ProfileScreenContent extends StatelessWidget {
  final String username;
  final String email;

  ProfileScreenContent({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is InitialProfileState) {
          return _buildProfileScreen(context);
        }
        return Container(); // Handle other states as needed
      },
    );
  }

  Widget _buildProfileScreen(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(150.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/boy.png'),
            ),
            SizedBox(height: 20),
            Text(
              username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Add the logout event to the profile bloc
                BlocProvider.of<ProfileBloc>(context).add(LogoutEvent());

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                onPrimary: Colors.white,
              ),
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}

