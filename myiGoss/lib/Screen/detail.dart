// DetailScreen.dart

import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String body;

  DetailScreen({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: $title',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Body: $body'),
            // Add more widgets to display other details if needed
          ],
        ),
      ),
    );
  }
}
