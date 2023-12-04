import 'package:appcook/Screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';

// Trong ProfileScreen
class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;

  ProfileScreen({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(150.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              // Đặt hình ảnh của người dùng ở đây
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent, // Màu nền của nút
                onPrimary: Colors.white, // Màu chữ trên nút
              ),
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
