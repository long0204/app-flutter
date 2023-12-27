import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QcontractPage extends StatefulWidget {
  @override
  _QcontractPageState createState() => _QcontractPageState();
}

class _QcontractPageState extends State<QcontractPage> {
  List<RptContractForDashboard> contractData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    try {
      final response = await http.post(
        Uri.parse('https://devsyscm.inos.vn:12089/idocNet.Test.MobileGate.V10.WA/QContract/WA_Rpt_ContractForDashboard_Get'),
        headers: {
          'GwUserCode': 'idocNet.idN.MobileGate.Sv',
          'GwPassword': 'idocNet.idN.MobileGate.Sv',
          'NetworkID': '4221896000',
          'OrgID': '4221896000',
          'Authorization': 'Bearer qb5yHphT7O1-RAl5kyzKzNsmIwKjqaON38JckJcS9r9wfduHMSYR0p-SJYze3xyTfG-sramJd3rsNfxA2VKr3YlEn-CzLZX6lijum2JOkXTCwfXi9bBH4O_ahBG2sJlx7xHrvpgy5dXZZmqg9z4QvkJJzLM1NGlE4mHX25LXv0IyY2-MBPvrFRJX6IAcAB8_cmx8Ns-eny2LPtbQNbWxgJZJG1nl2FwA1OkaIhxfRdO5IzUU2zjKl4xXDe68k5zz',
        },
        body: {
          'NetworkID': '4221896000',
          'OrgID': '4221896000',
          'WAUserCode': 'demo@inos.vn',
        },
      );
      //print("Data ${json.decode(response.body)['Data']}");
     //print("Body ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          contractData = (responseData['Data']['Lst_Rpt_ContractForDashboard'] as List)
              .map((contractJson) => RptContractForDashboard.fromJson(contractJson))
              .toList();
        });
        //print("Body ${contractData}");
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var contract in contractData)
                QContractCard(
                  title: contract.reportType,
                  description: contract.totalQty.toString(),
                  icon: Icons.ac_unit,
                  color: Colors.green,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class QContractCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  QContractCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      elevation: 3.0,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title == 'ContractCreatePending' ? 'Đang xử lý':title == 'PendingForUser' ? 'Chờ tôi ký': 'Chờ người khác ký',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: title == 'PendingForUser' ? Colors.red : Colors.grey,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: title == 'PendingForUser' ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: title == 'ContractCreatePending' ? Colors.orangeAccent : title == 'PendingForUser' ? Colors.lightBlueAccent : Colors.lightGreen,
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                ),
              ),
              child: Icon(
                title == 'ContractCreatePending' ? Icons.hourglass_empty : title == 'PendingForUser' ? Icons.edit : Icons.person,
                color: Colors.white,
              ),
            )
          ),
        ],
      ),
    );
  }
}
class RptContractForDashboard {
  final String? mst;
  final String reportType;
  final int? totalValExchange;
  final int? totalQtyContract;
  final int totalQty;
  final int? totalQtyUsed;
  final int? totalQtyCancel;
  final int? qtyRemain;

  RptContractForDashboard({
    this.mst,
    required this.reportType,
    this.totalValExchange,
    this.totalQtyContract,
    required this.totalQty,
    this.totalQtyUsed,
    this.totalQtyCancel,
    this.qtyRemain,
  });

  factory RptContractForDashboard.fromJson(Map<String, dynamic> json) {
    return RptContractForDashboard(
      mst: json['MST'],
      reportType: json['ReportType'],
      totalValExchange: json['TotalValExchange'],
      totalQtyContract: json['TotalQtyContract'],
      totalQty: json['TotalQty'],
      totalQtyUsed: json['TotalQtyUsed'],
      totalQtyCancel: json['TotalQtyCancel'],
      qtyRemain: json['QtyRemain'],
    );
  }
}
