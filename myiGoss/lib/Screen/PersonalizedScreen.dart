import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/Screen/AddNewMenu.dart';

class PersonalizedScreen extends StatefulWidget {
  @override
  _PersonalizedScreenState createState() => _PersonalizedScreenState();
}

class _PersonalizedScreenState extends State<PersonalizedScreen> {
  final List<Map<String, dynamic>> menuList = [
    {"Code": "1", "Name": "Ghi chép", "Icon": Icons.note},
    {"Code": "2", "Name": "Giao việc", "Icon": Icons.edit_calendar},
    {"Code": "3", "Name": "Nhận lệnh/ lắng nghe", "Icon": Icons.mic},
    {"Code": "4", "Name": "Cấu hình", "Icon": Icons.settings},
  ];
  final List<Map<String, dynamic>> menumobile = [
    {"Code": "1", "Name": "Work", "Icon": Icons.work},
    {"Code": "2", "Name": "eTicket", "Icon": Icons.airplane_ticket},
    {"Code": "3", "Name": "eService", "Icon": Icons.autorenew},
    {"Code": "4", "Name": "Ecore", "Icon": Icons.insert_drive_file},
    {"Code": "5", "Name": "Report", "Icon": Icons.bar_chart},
  ];

  File? _avatarImage;

  Future<void> _getAvatarImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _avatarImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cá nhân hóa trợ lí iGoss',
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
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Text(
                    'AVARTAR TRỢ LÝ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          backgroundImage: _avatarImage != null ? FileImage(_avatarImage!) : null,
                        ),
                        Positioned(
                          top: 70,
                          right: -5,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              _getAvatarImage();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text(
                      'MENU TRỢ LÝ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ...menuList.map(
                            (item) => ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.drag_indicator),
                              Icon(item['Icon'], color: Colors.yellow[800]),
                              SizedBox(width: 8),
                              Text("${item['Code'] ?? ''}  ${item['Name'] ?? ''}"),
                            ],
                          ),
                          onTap: () {
                            print('Clicked on menu: ${item['Name']}');
                          },
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.drag_indicator),
                            Icon(Icons.add, color: Colors.yellow[800]),
                            SizedBox(width: 8),
                            Text('Thêm mới'),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddNewMenu()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text(
                      'MENU FOOTER MOBILE',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ...menumobile.map(
                            (item) => ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.drag_indicator),
                              Icon(item['Icon'], color: Colors.green),
                              SizedBox(width: 8),
                              Text("${item['Code'] ?? ''}  ${item['Name'] ?? ''}"),
                            ],
                          ),
                          onTap: () {
                            print('Clicked on menu: ${item['Name']}');
                          },
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.drag_indicator),
                            Icon(Icons.add, color: Colors.yellow[500]),
                            SizedBox(width: 8),
                            Text('Thêm mới'),
                          ],
                        ),
                        onTap: () {
                          print('Clicked on Thêm mới');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
