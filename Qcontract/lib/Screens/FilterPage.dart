// filter_page.dart
import 'package:flutter/material.dart';
import '../Bloc/filter_result.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  TextEditingController soHDTLController = TextEditingController();
  TextEditingController maTraCuuController = TextEditingController();
  TextEditingController benKyController = TextEditingController();
  TextEditingController nguoiKyController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm nâng cao', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              // Truyền giá trị về màn hình ContractManagementPage
              Navigator.pop(
                context,
                FilterResult(
                  soHDTL: soHDTLController.text,
                  maTraCuu: maTraCuuController.text,
                  benKy: benKyController.text,
                  nguoiKy: nguoiKyController.text,
                  fromDate: fromDate,
                  toDate: toDate,
                ),
              );
            },
            icon: Icon(Icons.done_all, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: soHDTLController,
              decoration: InputDecoration(labelText: 'Số HĐ/TL',),
            ),
            TextField(
              controller: maTraCuuController,
              decoration: InputDecoration(labelText: 'Mã tra cứu'),
            ),
            TextField(
              controller: benKyController,
              decoration: InputDecoration(labelText: 'Bên ký'),
            ),

            SizedBox(height: 16.0),
            Text('Ngày ký HĐ/TL'),
            Row(
              children: [
                Icon(Icons.calendar_today,color: Colors.grey,), // Calendar icon for 'Từ ngày'
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: fromDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          fromDate = selectedDate;
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(),
                      child: Text(
                        fromDate != null
                            ? "${fromDate!.day}/${fromDate!.month}/${fromDate!.year}"
                            : '',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Icon(Icons.calendar_today,color: Colors.grey,), // Calendar icon for 'Đến ngày'
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: toDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          toDate = selectedDate;
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(),
                      child: Text(
                        toDate != null
                            ? "${toDate!.day}/${toDate!.month}/${toDate!.year}"
                            : '',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: nguoiKyController,
              decoration: InputDecoration(labelText: 'Người ký'),
            ),
          ],
        ),
      ),
    );
  }
}
