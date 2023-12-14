import 'package:branch/search_bloc.dart';
import 'package:flutter/material.dart';

class CreateNewScreen extends StatefulWidget {
  final List<Province> provinceList;
  final List<District> districtList;
  CreateNewScreen({required this.provinceList, required this.districtList});

  @override
  _CreateNewScreenState createState() => _CreateNewScreenState();
}

class _CreateNewScreenState extends State<CreateNewScreen> {
  String selectedProvince = "101"; // Default province code

  TextEditingController districtCodeController = TextEditingController();
  TextEditingController districtNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo mới huyện'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Mã tỉnh'),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedProvince,
                    items: getProvinceItems(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProvince = newValue ?? '';
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Tên tỉnh'),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    enabled: false,
                    controller: getProvinceNameController(selectedProvince),
                    decoration: InputDecoration(labelText: 'Tên tỉnh'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Mã huyện'),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: districtCodeController,
                    decoration: InputDecoration(labelText: 'Mã huyện'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Tên huyện'),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: districtNameController,
                    decoration: InputDecoration(labelText: 'Tên huyện'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await saveDistrict();
              },
              child: Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getProvinceItems() {
    return widget.provinceList.map((province) {
      return DropdownMenuItem<String>(
        value: province.provinceCode,
        child: Text(province.provinceCode),
      );
    }).toList();
  }

  TextEditingController getProvinceNameController(String provinceCode) {
    // Find the province name based on the selected province code
    String provinceName = widget.provinceList
        .firstWhere((province) => province.provinceCode == provinceCode)
        .provinceName;
    return TextEditingController(text: provinceName);
  }

  Future<void> saveDistrict() async {
    // Validate input
    if (districtCodeController.text.isEmpty || districtNameController.text.isEmpty) {
      // Show an error message
      return;
    }

    bool codeExists = widget.districtList.any((district) =>
        district.districtCode == districtCodeController.text);
    bool nameExists = widget.districtList.any((district) =>
        district.districtName == districtNameController.text);

    if (codeExists || nameExists) {
      if (codeExists) {
        // Show a SnackBar for code existence
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Mã huyện đã tồn tại.'),
          ),
        );
      }

      if (nameExists) {
        // Show a SnackBar for name existence
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Tên huyện đã tồn tại.'),
          ),
        );
      }
    } else {
      // Show a SnackBar for successful save
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Lưu thành công'),
        ),
      );

      District newDistrict = District(
        districtCode: districtCodeController.text,
        provinceCode: selectedProvince,
        districtName: districtNameController.text,
        flagActive: "1",
      );

      widget.districtList.add(newDistrict);
      Navigator.pop(context, widget.districtList);
    }
  }
}
