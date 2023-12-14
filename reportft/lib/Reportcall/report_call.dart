import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reportft/Reportcall/CallDetailScreen.dart';

class Reportcall extends StatefulWidget {
  final String detail;

  Reportcall(this.detail);

  @override
  _ReportcallState createState() => _ReportcallState();
}

class _ReportcallState extends State<Reportcall> {
  late String _selectedAgent;
  late DateTime _startDate;
  late DateTime _endDate;

  final List<Map<String, String>> agents = [
    {"agentcode": "000", "agentname": "Tất cả"},
    {"agentcode": "002", "agentname": "KH1"},
    {"agentcode": "003", "agentname": "KH2"},
  ];

  final List<Map<String, String>> typeCalls = [
    {"typecallcode": "001", "typecallname": "Tổng cuộc gọi"},
    {"typecallcode": "002", "typecallname": "Tổng cuộc gọi vào"},
    {"typecallcode": "003", "typecallname": "Tổng cuộc gọi ra"},
    {"typecallcode": "004", "typecallname": "Tổng cuộc gọi vào thành công"},
    {"typecallcode": "005", "typecallname": "Tổng cuộc gọi ra thành công"},
    {"typecallcode": "006", "typecallname": "Tổng cuộc gọi vào nhỡ"},
    {"typecallcode": "007", "typecallname": "Tổng cuộc gọi ra nhỡ"},
    {"typecallcode": "008", "typecallname": "Tổng thời gian nghe máy"},
    {"typecallcode": "009", "typecallname": "Tổng thời gian cuộc gọi vào"},
    {"typecallcode": "010", "typecallname": "Tổng thời gian cuộc gọi ra"},
    {"typecallcode": "011", "typecallname": "Trung bình thời gian cuộc gọi"},
    {"typecallcode": "012", "typecallname": "Trung bình thời gian đợi"},
    {"typecallcode": "013", "typecallname": "Trung bình thời gian giữ máy"},
  ];
  final List<Map<String, String>> typeCallsDataList = [
    {"typecallcode": "001", "Date":"2023-12-01 00:00","countcall":"10"},
    {"typecallcode": "001", "Date":"2023-12-01 01:00","countcall":"30"},
    {"typecallcode": "001", "Date":"2023-12-01 02:00","countcall":"5"},
    {"typecallcode": "001", "Date":"2023-12-01 03:00","countcall":"40"},
    {"typecallcode": "001", "Date":"2023-12-01 04:00","countcall":"20"},
    {"typecallcode": "001", "Date":"2023-12-01 05:00","countcall":"15"},
    {"typecallcode": "001", "Date":"2023-12-01 06:00","countcall":"17"},
    {"typecallcode": "001", "Date":"2023-12-01 07:00","countcall":"2"},
    {"typecallcode": "001", "Date":"2023-12-01 08:00","countcall":"23"},
    {"typecallcode": "001", "Date":"2023-12-01 09:00","countcall":"12"},
    {"typecallcode": "001", "Date":"2023-12-01 10:00","countcall":"35"},
    {"typecallcode": "001", "Date":"2023-12-01 11:00","countcall":"60"},
    {"typecallcode": "001", "Date":"2023-12-01 12:00","countcall":"20"},
    {"typecallcode": "001", "Date":"2023-12-01 13:00","countcall":"53"},
    {"typecallcode": "001", "Date":"2023-12-01 14:00","countcall":"16"},
    {"typecallcode": "001", "Date":"2023-12-01 15:00","countcall":"40"},
    {"typecallcode": "001", "Date":"2023-12-01 16:00","countcall":"80"},
    {"typecallcode": "001", "Date":"2023-12-01 17:00","countcall":"100"},
    {"typecallcode": "001", "Date":"2023-12-01 18:00","countcall":"33"},
    {"typecallcode": "001", "Date":"2023-12-01 19:00","countcall":"44"},
    {"typecallcode": "001", "Date":"2023-12-01 20:00","countcall":"53"},
    {"typecallcode": "001", "Date":"2023-12-01 21:00","countcall":"26"},
    {"typecallcode": "001", "Date":"2023-12-01 22:00","countcall":"40"},
    {"typecallcode": "001", "Date":"2023-12-01 23:00","countcall":"9"},
    {"typecallcode": "001", "Date":"2023-12-02 00:00","countcall":"35"},
    {"typecallcode": "002", "Date":"2023-12-02 00:00","countcall":"35"}
];

  late List<Map<String, dynamic>> typeCallsData;

  @override
  void initState() {
    super.initState();
    _selectedAgent = agents.isNotEmpty ? agents.first["agentname"]! : '';
    _startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    _endDate = DateTime.now();
    typeCallsData = List<Map<String, dynamic>>.from(typeCalls.map((typeCall) {
      return {
        "typecallcode": typeCall["typecallcode"],
        "typecallname": typeCall["typecallname"],
        "totalcountcall": 0,
      };
    }));
    _updateTypeCallsData();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
        } else {
          _endDate = selectedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detail),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButton<String>(
                value: _selectedAgent,
                items: agents.map((agent) {
                  return DropdownMenuItem<String>(
                    value: agent["agentname"],
                    child: Text(agent["agentname"]!),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedAgent = newValue!;
                  });
                },
                hint: Text('Chọn Agent'),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _selectDate(context, true),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Từ ngày',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(_startDate),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectDate(context, false),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Đến ngày',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(_endDate),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi nút được nhấn
                _updateTypeCallsData();
              },
              child: Text('Hiển thị danh sách'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: typeCallsData.length,
                itemBuilder: (context, index) {
                  final typeCall = typeCallsData[index];
                  return ListTile(
                    title: Text('${typeCall["typecallname"]}'),
                    subtitle: Text('Số lượng: ${typeCall["totalcountcall"]}'),
                    onTap: () {
                      // Navigate to the detail screen when the ListTile is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TypeCallDetailScreen(typeCall["typecallname"],_startDate,_endDate,typeCallsDataList),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateTypeCallsData() {
    // Tính tổng countcall ứng với mỗi typecallcode tương ứng
    typeCallsData.forEach((typeCall) {
      final String typeCallCode = typeCall["typecallcode"];
      final total = _calculateTotalCountCall(typeCallCode);
      typeCall["totalcountcall"] = total;
    });
  }

  int _calculateTotalCountCall(String typeCallCode) {
  // Tính tổng countcall dựa trên typeCallCode, startDate và endDate
  final List<Map<String, String>> filteredData = typeCallsDataList
      .where(
        (data) =>
            data["typecallcode"] == typeCallCode &&
            DateTime.parse(data["Date"]!).isAfter(_startDate) &&
            DateTime.parse(data["Date"]!).isBefore(_endDate.add(Duration(days: 1))),
      )
      .toList();

  return filteredData.fold(0, (sum, data) => sum + int.parse(data["countcall"]!));
}

}
