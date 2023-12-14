import 'package:flutter/material.dart';

class EVariationrpt extends StatelessWidget {
  final String detail;

  EVariationrpt(this.detail);

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
