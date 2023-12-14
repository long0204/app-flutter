import 'package:flutter/material.dart';
import 'package:branch/search_screen.dart'; // Import để sử dụng sampleProvinces

class CreateNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New District'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                 Text('Mã tỉnh: '),
              ],
            ),
            DropdownButton<String>(
              value: '101', // Mã tỉnh - mặc định là '0', bạn có thể thay đổi theo nhu cầu
              items: getProvinceItems(),
              onChanged: (String? newValue) {
                // Xử lý khi giá trị dropdown thay đổi
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Tên tỉnh: '),
                 SizedBox(width: 16.0),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(hintText: 'selectedProvinceName'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
             Row(
              children: [
                Text('Mã huyện: '),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Nhập mã huyện'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Tên huyện'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Xử lý sự kiện khi ấn nút "Lưu"
              },
              child: Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getProvinceItems() {
    List<Map<String, String>> sampleProvinces = [
      {"ProvinceCode": "101", "ProvinceName": "Thành phố Hà Nội", "FlagActive": "1"},
      {"ProvinceCode": "103", "ProvinceName": "TP Hải Phòng", "FlagActive": "1"},
      {"ProvinceCode": "107", "ProvinceName": "Tỉnh Hải Dương", "FlagActive": "1"},
    ];
    return sampleProvinces.map((province) {
      return DropdownMenuItem<String>(
        value: province["ProvinceCode"] ?? '',
        child: Text(province["ProvinceCode"] ?? ''),
      );
    }).toList();
  }
}
