// my_booking_screen.dart
import 'package:flutter/material.dart';

class MyBookingScreen extends StatelessWidget {
  final List<Map<String, String>> bookedHotels;

  MyBookingScreen({required this.bookedHotels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Booking'),
      ),
      body: _buildBookingList(),
    );
  }

  Widget _buildBookingList() {
    return ListView.builder(
      itemCount: bookedHotels.length,
      itemBuilder: (context, index) {
        final booking = bookedHotels[index];
        return ListTile(
          title: Text(booking['Honame'] ?? ''),
          subtitle: Text('Check-in: ${booking['Checkin']}, Check-out: ${booking['Checkout']}'),
          // Add more details if needed
        );
      },
    );
  }
}
