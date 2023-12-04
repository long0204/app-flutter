// profile_widget.dart
import 'package:appbooking/Detail/Mybooking.dart';
import 'package:appbooking/Welcomescreen.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String accountName;
  final String accountEmail;
  final List<Map<String, String>> bookedHotels;

  ProfileWidget({required this.accountName, required this.accountEmail, required this.bookedHotels});

  @override
  Widget build(BuildContext context) {
    return _BackgroundWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/bg.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              accountName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              accountEmail,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50),
             _buildCardButton(
              context,
              'My Booking',
              Icons.bookmark,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBookingScreen(bookedHotels: bookedHotels)),
                );
              },
            ),
            SizedBox(height: 16),
            _buildCardButton(
              context,
              'Information',
              Icons.info,
              () {
                // Handle the 'Information' button press
              },
            ),
            SizedBox(height: 16),
            _buildCardButton(
              context,
              'Setting',
              Icons.settings,
              () {
                // Handle the 'Setting' button press
              },
            ),
            SizedBox(height: 16),
            _buildCardButton(
              context,
              'Payment Method',
              Icons.payment,
              () {
                // Handle the 'Payment Method' button press
              },
            ),
            SizedBox(height: 16),
            _buildCardButton(
              context,
              'Log out',
              Icons.logout,
              () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      backgroundImage: 'assets/images/bg.jpg',
    );
  }

  Widget _buildCardButton(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundWidget extends StatelessWidget {
  final Widget child;
  final String backgroundImage;

  _BackgroundWidget({required this.child, required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          backgroundImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.white.withOpacity(0.7),
          width: double.infinity,
          height: double.infinity,
        ),
        child,
      ],
    );
  }
}
