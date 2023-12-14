import 'package:flutter/material.dart';

class EsumnotSLArpt extends StatelessWidget {
  final String detail;

  EsumnotSLArpt(this.detail);

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
