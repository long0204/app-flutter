// AddNewMenu.dart

import 'package:flutter/material.dart';
import 'SelectIconAvatar.dart';

class AddNewMenu extends StatefulWidget {
  @override
  _AddNewMenuState createState() => _AddNewMenuState();
}

class _AddNewMenuState extends State<AddNewMenu> {
  // Selected icon data
  Map<String, dynamic>? selectedIcon;
  String? selectedFunction;

  // List of functions for the dropdown
  List<String> functions = ["Function 1", "Function 2", "Function 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết menu tính năng',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              // Xử lý khi nhấn nút Lưu ở đây
              // Đây có thể là nơi để lưu thông tin cá nhân hóa
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.S,
          children: [
            Container(
              //padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        // Display the selected icon in CircleAvatar
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          child: selectedIcon != null
                              ? Icon(
                            selectedIcon!["Icon"],
                            size: 50.0,
                          )
                              : null,
                        ),
                        Positioned(
                          top: 60,
                          right: -10,
                          child: IconButton(
                            icon: Icon(Icons.border_color),
                            onPressed: () {
                              // Navigate to SelectIconAvatar and receive selected icon
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectIconAvatar(),
                                ),
                              ).then((value) {
                                // Update the selectedIcon state when the user returns from SelectIconAvatar
                                if (value != null && value is Map<String, dynamic>) {
                                  setState(() {
                                    selectedIcon = value;
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(width: 16),
                Text(
                  'Order: ',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text('2'),
              ],
            ),
            SizedBox(height: 16),
            // Text input field with label
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  //border: OutlineInputBorder(),
                ),
                // You can handle the text input value using onChanged or controller.
                // onChanged: (value) {
                //   // Handle the value change
                // },
              ),
            ),
            Text(
              '* Vui lòng nhập dưới 10 ký tự để hiển thị phù hợp hơn',
              style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 16),
                Text(
                  'Chức năng: ',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  '*',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            Row(
              children: [
                    SizedBox(width: 16,),
                    DropdownButton<String>(
                      value: selectedFunction,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFunction = newValue;
                        });
                      },
                      items: functions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
              ],
            ),
            SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(width: 16),
                    Text(
                      'Loại: ',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text('User(Tùy chỉnh)'),
                  ],
                ),
            SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(width: 16),
                    Text(
                      'Solution: ',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text('Report'),
                  ],
                ),
            SizedBox(height: 16),// Dropdown for selecting function
                Row(
                  children: [
                    SizedBox(width: 16),
                    Text(
                      'Parameters: ',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text('dieuhuong'),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
