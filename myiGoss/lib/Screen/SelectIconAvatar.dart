// SelectIconAvatar.dart

import 'package:flutter/material.dart';

class SelectIconAvatar extends StatelessWidget {
  final List<Map<String, dynamic>> iconList = [
    {"Name": "account_box", "Icon": Icons.account_balance_outlined},
    {"Name": "report", "Icon": Icons.area_chart},
    {"Name": "setting", "Icon": Icons.settings},
    {"Name": "home", "Icon": Icons.home},
    {"Name": "star", "Icon": Icons.star},
    {"Name": "fact_check", "Icon": Icons.fact_check},
    {"Name": "work", "Icon": Icons.work},
    // Add more icons as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Avatar Icon',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: iconList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Return the selected icon data to the previous screen
              Navigator.pop(context, iconList[index]);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                iconList[index]["Icon"],
                size: 50.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
