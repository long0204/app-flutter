import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reportft/Campaignreport/Campaignrpt.dart';
import 'package:reportft/Eticketreport/EAPISLArpt.dart';
import 'package:reportft/Eticketreport/EDetailrpt.dart';
import 'package:reportft/Eticketreport/EGenaralrpt.dart';
import 'package:reportft/Eticketreport/EMisscallrpt.dart';
import 'package:reportft/Eticketreport/ETyperpt.dart';
import 'package:reportft/Eticketreport/EVariationrpt.dart';
import 'package:reportft/Eticketreport/EnotAgentrpt.dart';
import 'package:reportft/Eticketreport/EsumnotSLArpt.dart';
import 'package:reportft/Reportcall/report_call.dart';

class Report {
  final String title;
  final List<String> details;

  Report(this.title, this.details);
}

class TreeView extends StatelessWidget {
  final List<Report> reports;

  TreeView({required this.reports});

  Widget _buildTiles(BuildContext context, Report report) {
    return BlocProvider(
      create: (context) => EGenaralrptBloc(), // Provide the bloc here
      child: ExpansionTile(
        key: PageStorageKey<Report>(report),
        title: Text(report.title),
        children: report.details.map((detail) {
          return ListTile(
            title: Text(detail),
            onTap: () {
            // Khi người dùng nhấp vào chi tiết, kiểm tra detail để quyết định chuyển màn hình nào
            if (detail == 'Báo cáo thông kê cuộc gọi') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Reportcall(detail),
                ),
              );
            } else if (detail == 'Báo cáo tổng hợp eTicket') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EGenaralrpt('Báo cáo tổng hợp eTicket'),
                  ),
                );
              
            } else if (detail == 'Báo cáo chi tiết eTicket') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EDetailrpt('Báo cáo chi tiết eTicket'),
                ),
              );
            }  else if (detail == 'Báo cáo API theo SLA') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EAPISLArpt('Báo cáo API theo SLA'),
                ),
              );
            } else if (detail == 'Báo cáo cuộc gọi nhỡ') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EMisscallrpt('Báo cáo cuộc gọi nhỡ'),
                ),
              );
            } else if (detail == 'Báo cáo tổng hợp loại eTicket') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ETyperpt('Báo cáo tổng hợp loại eTicket'),
                ),
              );
            } else if (detail == 'Báo cáo biến động eTicket') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EVariationrpt('Báo cáo biến động eTicket'),
                ),
              );
            } else if (detail == 'Báo cáo tổng hợp eTicket không đáp ứng SLA') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EsumnotSLArpt('Báo cáo tổng hợp eTicket không đáp ứng SLA'),
                ),
              );
            } else if (detail == 'Báo cáo tổng hợp eTicket không đáp ứng SLA theo Agent') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EnotAgentrpt('Báo cáo tổng hợp eTicket không đáp ứng SLA theo Agent'),
                ),
              );
            } else if (detail == 'Báo cáo chiến dịch') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Campaignrpt('Báo cáo chiến dịch'),
                ),
              );
            } 
          },
        );
      }).toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) => _buildTiles(context, reports[index]),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String detail;

  DetailScreen(this.detail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết'),
      ),
      body: Center(
        child: Text(detail),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => EGenaralrptBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Báo cáo'),
            backgroundColor: Colors.green,
          ),
          body: TreeView(
            reports: [
              Report('Báo cáo cuộc gọi', ['Báo cáo thông kê cuộc gọi']),
              Report('Báo cáo eTicket', [
                'Báo cáo tổng hợp eTicket', 'Báo cáo chi tiết eTicket', 'Báo cáo API theo SLA',
                'Báo cáo cuộc gọi nhỡ', 'Báo cáo tổng hợp loại eTicket', 'Báo cáo biến động eTicket',
                'Báo cáo tổng hợp eTicket không đáp ứng SLA', 'Báo cáo tổng hợp eTicket không đáp ứng SLA theo Agent'
              ]),
              Report('Báo cáo chiến dịch', ['Báo cáo chiến dịch']),
            ],
          ),
        ),
      ),
    );
  }
}
