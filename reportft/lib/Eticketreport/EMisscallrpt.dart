import 'package:flutter/material.dart';

class EMisscallrpt extends StatelessWidget {
  final String detail;

  EMisscallrpt(this.detail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Báo cáo chi tiết eTicket'),
      ),
      body: Center(
        child: Text(detail),
      ),
    );
  }
}
