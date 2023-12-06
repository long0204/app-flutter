import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  final List<ChartData> chartData = [
    ChartData('India', 20, 30, 40, 50),
    ChartData('UK', 40, 30, 40, 50),
    ChartData('China', 40, 20, 10, 22),
    ChartData('USA', 10, 14, 22, 44)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Container(
              child: Column(
                children: [
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      StackedColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData ch, _) => ch.x,
                          yValueMapper: (ChartData ch, _) => ch.y1),
                      StackedColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData ch, _) => ch.x,
                          yValueMapper: (ChartData ch, _) => ch.y2),
                      StackedColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData ch, _) => ch.x,
                          yValueMapper: (ChartData ch, _) => ch.y3),
                      StackedColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData ch, _) => ch.x,
                          yValueMapper: (ChartData ch, _) => ch.y4),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              child: SfCircularChart(
                                series: <CircularSeries>[
                                  PieSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y1,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              child: SfCircularChart(
                                series: <CircularSeries>[
                                  PieSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y2,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              child: SfCircularChart(
                                series: <CircularSeries>[
                                  PieSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y3,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              child: SfCircularChart(
                                series: <CircularSeries>[
                                  PieSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y4,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 300,
                              child: SfPyramidChart(
                                series: PyramidSeries<ChartData, String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y1,
                                ),
                              ),
                            ),
                            // Container(
                            //   height: 150,
                            //   width: 150,
                             
                            // ),
                          ],
                        ),
                        // SizedBox(height: 20),
                        // Container(
                        //   height: 200,
                        //   child: SfPyramidChart(
                        //     series: PyramidSeries<ChartData, String>(
                        //       dataSource: chartData,
                        //       xValueMapper: (ChartData data, _) => data.x,
                        //       yValueMapper: (ChartData data, _) => data.y1,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
}
