import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Events
abstract class EGenaralrptEvent {}

class DropdownChangeEvent extends EGenaralrptEvent {
  final String selectedOption;

  DropdownChangeEvent(this.selectedOption);
}

// States
class EGenaralrptState {
  final String selectedOption;

  EGenaralrptState(this.selectedOption);
}

// Bloc
class EGenaralrptBloc extends Bloc<EGenaralrptEvent, EGenaralrptState> {
  EGenaralrptBloc() : super(EGenaralrptState("Hôm nay"));

  @override
  Stream<EGenaralrptState> mapEventToState(EGenaralrptEvent event) async* {
    if (event is DropdownChangeEvent) {
      yield EGenaralrptState(event.selectedOption);
    }
  }
}

class EGenaralrpt extends StatefulWidget {
  final String detail;

  EGenaralrpt(this.detail);

  @override
  _EGenaralrptState createState() => _EGenaralrptState();
}

class _EGenaralrptState extends State<EGenaralrpt> {
  DateTime fromDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime toDate = DateTime.now();
  bool showDatePickers = false;
  bool isFullScreen = false;

  List<ChartData> filterChartDataByDateRange(List<ChartData> allChartData, DateTime fromDate, DateTime toDate) {
  return allChartData.where((data) {
    DateTime dataDate = DateTime.parse(data.date);
    return dataDate.isAfter(fromDate.subtract(Duration(days: 1))) && dataDate.isBefore(toDate.add(Duration(days: 1)));
  }).toList();
}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EGenaralrptBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Báo cáo tổng hợp eTicket'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<EGenaralrptBloc, EGenaralrptState>(
                    builder: (context, state) {
                      return DropdownButton<String>(
                        value: state.selectedOption,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            context
                                .read<EGenaralrptBloc>()
                                .add(DropdownChangeEvent(newValue));
                            if (newValue == 'Tùy chọn') {
                              setState(() {
                                showDatePickers = true;
                              });
                            } else {
                              setState(() {
                                showDatePickers = false;
                              });
                            }
                          }
                        },
                        items: <String>['Hôm nay', 'Tùy chọn']
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button click
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      primary: Colors.green,
                    ),
                    child: Text(
                      '...',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Visibility(
                visible: showDatePickers,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        DateTime? selectedFromDate = await showDatePicker(
                          context: context,
                          initialDate: fromDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (selectedFromDate != null) {
                          setState(() {
                            fromDate = selectedFromDate;
                          });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Từ ngày',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(fromDate),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    
                    GestureDetector(
                      onTap: () async {
                        DateTime? selectedToDate = await showDatePicker(
                          context: context,
                          initialDate: toDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (selectedToDate != null) {
                          setState(() {
                            toDate = selectedToDate;
                          });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Đến ngày',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(toDate),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildInfoRow("Mức độ hài lòng trung bình:", "4.5"),
              buildInfoRow("Tỉ lệ eTicket đáp ứng SLA:", ""),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoRow2("TG phản hồi lần đầu trung bình", "05:10"),
                    buildInfoRow2("TG phản hồi trung bình", "06:10"),
                  ],
                ),
              ),
              buildInfoRow("Thời gian xử lý:", ""),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoRow2("Ngắn nhất", "00:00:15"),
                    buildInfoRow2("Trung bình", "00:00:10"),
                    buildInfoRow2("Dài nhất", "01:00:00"),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                            _toggleFullscreen();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                         child: Icon(isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
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
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  child: buildStackedLineChart(fromDate, toDate),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleFullscreen() {
  setState(() {
    isFullScreen = !isFullScreen;
  });

  if (isFullScreen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            body: buildFullScreenChart(),
          );
        },
      ),
    ).then((_) {
      // Called when the full-screen page is popped.
      setState(() {
        isFullScreen = false;
      });
    });
  }
  // No need to handle else case here since popping the page will automatically set isFullScreen back to false.
}


  Widget buildFullScreenChart() {
      final List<Map<String, String>> chartDataList = [
        {"Date": "2023-12-01", "Create": "10", "Open": "20", "Processing": "5", "Sloved": "15", "Closed": "30"},
        {"Date": "2023-12-02", "Create": "20", "Open": "15", "Processing": "5", "Sloved": "25", "Closed": "20"},
        {"Date": "2023-12-03", "Create": "15", "Open": "28", "Processing": "8", "Sloved": "20", "Closed": "10"},
        {"Date": "2023-12-04", "Create": "8", "Open": "25", "Processing": "15", "Sloved": "25", "Closed": "16"},
        {"Date": "2023-12-05", "Create": "25", "Open": "20", "Processing": "15", "Sloved": "25", "Closed": "30"},
        {"Date": "2023-12-06", "Create": "10", "Open": "10", "Processing": "14", "Sloved": "15", "Closed": "10"},
        {"Date": "2023-12-07", "Create": "30", "Open": "5", "Processing": "10", "Sloved": "25", "Closed": "20"},
        {"Date": "2023-12-08", "Create": "14", "Open": "10", "Processing": "25", "Sloved": "15", "Closed": "9"},
        {"Date": "2023-12-09", "Create": "21", "Open": "10", "Processing": "35", "Sloved": "25", "Closed": "30"},
        {"Date": "2023-12-10", "Create": "6", "Open": "15", "Processing": "15", "Sloved": "15", "Closed": "10"},
        {"Date": "2023-12-11", "Create": "10", "Open": "30", "Processing": "35", "Sloved": "35", "Closed": "38"},
        {"Date": "2023-12-12", "Create": "19", "Open": "27", "Processing": "25", "Sloved": "35", "Closed": "26"},
        {"Date": "2023-12-13", "Create": "20", "Open": "20", "Processing": "15", "Sloved": "15", "Closed": "20"},
        {"Date": "2023-12-14", "Create": "30", "Open": "30", "Processing": "45", "Sloved": "15", "Closed": "10"},
      ];

      List<ChartData> chartData = chartDataList.map((data) {
        return ChartData(
          data['Date']!,
          double.parse(data['Create']!),
          double.parse(data['Open']!),
          double.parse(data['Processing']!),
          double.parse(data['Sloved']!),
          double.parse(data['Closed']!),
        );
      }).toList();

        return Scaffold(
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.greenAccent,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          //Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.zoom_in),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
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
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                    child: RotatedBox(
                      quarterTurns: 3, // xoay 90 độ theo chiều kim đồng hồ
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(),
                        legend: Legend(isVisible: true),
                        series: <ChartSeries>[
                          StackedLineSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.date,
                            yValueMapper: (ChartData data, _) => data.create,
                            name: 'Create',
                          ),
                          StackedLineSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.date,
                            yValueMapper: (ChartData data, _) => data.open,
                            name: 'Open',
                          ),
                          StackedLineSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.date,
                            yValueMapper: (ChartData data, _) => data.processing,
                            name: 'Processing',
                          ),
                          StackedLineSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.date,
                            yValueMapper: (ChartData data, _) => data.sloved,
                            name: 'Sloved',
                          ),
                          StackedLineSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.date,
                            yValueMapper: (ChartData data, _) => data.closed,
                            name: 'Closed',
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }
}

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow2(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget buildStackedLineChart(DateTime fromDate, DateTime toDate) {
    final List<Map<String, String>> chartDataList = [
      {"Date": "2023-12-01", "Create": "10", "Open": "20", "Processing": "5", "Sloved": "15", "Closed": "30"},
      {"Date": "2023-12-02", "Create": "20", "Open": "15", "Processing": "5", "Sloved": "25", "Closed": "20"},
      {"Date": "2023-12-03", "Create": "15", "Open": "28", "Processing": "8", "Sloved": "20", "Closed": "10"},
      {"Date": "2023-12-04", "Create": "8", "Open": "25", "Processing": "15", "Sloved": "25", "Closed": "16"},
      {"Date": "2023-12-05", "Create": "25", "Open": "20", "Processing": "15", "Sloved": "25", "Closed": "30"},
      {"Date": "2023-12-06", "Create": "10", "Open": "10", "Processing": "14", "Sloved": "15", "Closed": "10"},
      {"Date": "2023-12-07", "Create": "30", "Open": "5", "Processing": "10", "Sloved": "25", "Closed": "20"},
      {"Date": "2023-12-08", "Create": "14", "Open": "10", "Processing": "25", "Sloved": "15", "Closed": "9"},
      {"Date": "2023-12-09", "Create": "21", "Open": "10", "Processing": "35", "Sloved": "25", "Closed": "30"},
      {"Date": "2023-12-10", "Create": "6", "Open": "15", "Processing": "15", "Sloved": "15", "Closed": "10"},
      {"Date": "2023-12-11", "Create": "10", "Open": "30", "Processing": "35", "Sloved": "35", "Closed": "38"},
      {"Date": "2023-12-12", "Create": "19", "Open": "27", "Processing": "25", "Sloved": "35", "Closed": "26"},
      {"Date": "2023-12-13", "Create": "20", "Open": "20", "Processing": "15", "Sloved": "15", "Closed": "20"},
      {"Date": "2023-12-14", "Create": "30", "Open": "30", "Processing": "45", "Sloved": "15", "Closed": "10"},
    ];

    List<ChartData> allChartData = chartDataList.map((data) {
      return ChartData(
        data['Date']!,
        double.parse(data['Create']!),
        double.parse(data['Open']!),
        double.parse(data['Processing']!),
        double.parse(data['Sloved']!),
        double.parse(data['Closed']!),
      );
    }).toList();
    List<ChartData> filteredChartData = filterChartDataByDateRange(allChartData, fromDate, toDate);

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
      legend: Legend(isVisible: true),
      series: <ChartSeries>[
        StackedLineSeries<ChartData, String>(
          dataSource: allChartData,
          xValueMapper: (ChartData data, _) => data.date,
          yValueMapper: (ChartData data, _) => data.create,
          name: 'Create',
        ),
        StackedLineSeries<ChartData, String>(
          dataSource: allChartData,
          xValueMapper: (ChartData data, _) => data.date,
          yValueMapper: (ChartData data, _) => data.open,
          name: 'Open',
        ),
        StackedLineSeries<ChartData, String>(
          dataSource: allChartData,
          xValueMapper: (ChartData data, _) => data.date,
          yValueMapper: (ChartData data, _) => data.processing,
          name: 'Processing',
        ),
        StackedLineSeries<ChartData, String>(
          dataSource: allChartData,
          xValueMapper: (ChartData data, _) => data.date,
          yValueMapper: (ChartData data, _) => data.sloved,
          name: 'Sloved',
        ),
        StackedLineSeries<ChartData, String>(
          dataSource: allChartData,
          xValueMapper: (ChartData data, _) => data.date,
          yValueMapper: (ChartData data, _) => data.closed,
          name: 'Closed',
        ),
      ],
    );
  }
  
  List<ChartData> filterChartDataByDateRange(List<ChartData> allChartData, DateTime fromDate, DateTime toDate) {
  return allChartData.where((data) {
    DateTime dataDate = DateTime.parse(data.date);
    return dataDate.isAfter(fromDate.subtract(Duration(days: 1))) && dataDate.isBefore(toDate.add(Duration(days: 1)));
  }).toList();
}


extension DateTimeExtension on DateTime {
  DateTime firstDayOfMonth() {
    return DateTime(this.year, this.month, 1);
  }
}

class ChartData {
  final String date;
  final double create;
  final double open;
  final double processing;
  final double sloved;
  final double closed;

  ChartData(this.date, this.create, this.open, this.processing, this.sloved, this.closed);
}
