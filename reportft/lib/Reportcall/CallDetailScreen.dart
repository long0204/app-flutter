import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TypeCallDetailScreen extends StatefulWidget {
  final String typeCallcame;
  DateTime startdate;
  final DateTime endate;
  final List<Map<String, String>> typeCallsDataList;

  TypeCallDetailScreen(
      this.typeCallcame, this.startdate, this.endate, this.typeCallsDataList);

  @override
  _TypeCallDetailScreenState createState() => _TypeCallDetailScreenState();
}

class _TypeCallDetailScreenState extends State<TypeCallDetailScreen> {
  String? dropdownValue;
  DateTime? selectedDate;
  List<Map<String, String>> displayedData = [];
  bool isFullscreen = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Nếu đang ở chế độ fullscreen, hủy fullscreen khi bấm nút trở về
        if (isFullscreen) {
          setState(() {
            isFullscreen = false;
          });
          return false; // Không thoát màn hình
        }
        return true; // Thoát màn hình bình thường
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.typeCallcame),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            children: [
              _buildDateTimeDropdown(),
              _buildLineChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeDropdown() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Text('Hiển thị theo:'),
            SizedBox(
              width: 10,
            ),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue;
                  _updateDisplayedData();
                });
              },
              hint: Text('Hiển thị theo'),
              items: <String>['Ngày', 'Giờ']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        if (dropdownValue == 'Ngày')
          Text(
            "${DateFormat('yyyy-MM-dd HH:mm').format(widget.startdate)} - ${DateFormat('yyyy-MM-dd HH:mm').format(widget.endate)}",
          )
        else if (dropdownValue == 'Giờ')
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.greenAccent,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  _selectDate(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(
                      selectedDate ?? widget.startdate,
                    ),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 40,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.greenAccent,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  _toggleFullscreen();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.fullscreen),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.greenAccent,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  // Implement zoom out logic
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.zoom_out),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLineChart() {
    return Container(
      //height: isFullscreen ? MediaQuery.of(context).size.height : 300,
      padding: EdgeInsets.all(16),
      child: SfCartesianChart(
        primaryXAxis: dropdownValue == 'Ngày'
            ? DateTimeAxis(
                interval: 1.0, // Set the interval to 1 day
                dateFormat: DateFormat('dd'), // Format to display only the day
              )
            : DateTimeAxis(
                interval: 1.0, // Set the interval to 1 day
                dateFormat: DateFormat('HH:mm'), // Format to display only the day
              ),
        primaryYAxis: NumericAxis(),
        series: <ChartSeries>[
          LineSeries<Map<String, String>, DateTime>(
            dataSource: displayedData,
            xValueMapper: (Map<String, String> data, _) =>
                DateTime.parse(data['Date']!),
            yValueMapper: (Map<String, String> data, _) =>
                double.parse(data['countcall']!),
          ),
        ],
      ),
    );
  }

  void _updateDisplayedData() {
    setState(() {
      displayedData = dropdownValue == 'Ngày'
          ? _generateDataForChartByDay()
          : _generateDataForChartByHour();
    });
  }

  List<Map<String, String>> _generateDataForChartByDay() {
    List<Map<String, String>> dataForChart = [];
    DateTime currentDate = widget.startdate;

    while (currentDate.isBefore(widget.endate) ||
        currentDate.isAtSameMomentAs(widget.endate)) {
      // Generate data for each day
      String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
      Map<String, String> dayData = {"Date": formattedDate, "countcall": "0"};

      // Find the corresponding data in the original list
      for (Map<String, String> originalData in widget.typeCallsDataList) {
        if (originalData['Date']!.startsWith(formattedDate)) {
          dayData = originalData;
          break;
        }
      }

      dataForChart.add(dayData);

      // Move to the next day
      currentDate = currentDate.add(Duration(days: 1));
    }

    return dataForChart;
  }

  List<Map<String, String>> _generateDataForChartByHour() {
    List<Map<String, String>> dataForChart = [];
    DateTime currentDate = selectedDate ?? widget.startdate;
    DateTime lateDate = selectedDate?.add(const Duration(days: 1)) ?? widget.startdate.add(const Duration(days: 1));
    while (currentDate.isBefore(lateDate) ||
        currentDate.isAtSameMomentAs(lateDate)) {
      // Generate data for each hour
      String formattedDate = DateFormat('yyyy-MM-dd HH').format(currentDate);
      Map<String, String> hourData = {
        "Date": formattedDate,
        "countcall": "0",
      };

      // Find the corresponding data in the original list
      for (Map<String, String> originalData in widget.typeCallsDataList) {
        if (originalData['Date']!.startsWith(formattedDate)) {
          hourData = originalData;
          break;
        }
      }

      dataForChart.add(hourData);

      // Move to the next hour
      currentDate = currentDate.add(Duration(hours: 1));
    }

    return dataForChart;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.startdate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        this.selectedDate = selectedDate;
        _updateDisplayedData();
      });
    }
  }

  void _toggleFullscreen() {
    setState(() {
      isFullscreen = !isFullscreen;
    });
    if (isFullscreen) {
      // Chuyển đến màn hình fullscreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullscreenChart(
            displayedData: displayedData,
            dropdownValue: dropdownValue,
            startDate: widget.startdate,
            endDate: widget.endate,
            context: context, // Truyền context vào FullscreenChart
          ),
        ),
      );
    }
  }
}
class FullscreenChart extends StatelessWidget {
  final List<Map<String, String>> displayedData;
  final String? dropdownValue;
  final DateTime startDate;
  final DateTime endDate;
  final BuildContext context; // Add context to the constructor

  FullscreenChart({
    required this.displayedData,
    required this.dropdownValue,
    required this.startDate,
    required this.endDate,
    required this.context, // Add context to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildRotatedChart(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.greenAccent,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.fullscreen_exit),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.greenAccent,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      // Implement zoom out logic
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.zoom_out),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _buildRotatedChart() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      padding: EdgeInsets.all(16),
      child: RotatedBox(
        quarterTurns: 1, // Rotate the entire chart by 90 degrees
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(), // Use DateTimeAxis for horizontal axis
          primaryYAxis: NumericAxis(),
          series: <ChartSeries>[
            StackedLineSeries<Map<String, String>, DateTime>(
              dataSource: displayedData,
              xValueMapper: (Map<String, String> data, _) =>
                  DateTime.parse(data['Date']!),
              yValueMapper: (Map<String, String> data, _) =>
                  double.tryParse(data['countcall'] ?? '0') ?? 0,
              // Ensure 'countcall' is parsed to double, default to 0 if parsing fails
            ),
          ],
        ),
      ),
    );
  }
}
