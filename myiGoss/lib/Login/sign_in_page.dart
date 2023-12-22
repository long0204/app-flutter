import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign In Page Content',
              style: TextStyle(fontSize: 24),
            ),
            // Add sign in form or other components as needed
          ],
        ),
      ),
    );
  }
}
