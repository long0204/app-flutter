import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'contract_management_page.dart';

class GuiHopDongPage extends StatefulWidget {
  final Contract contract;
  final List<ContractUser> contractuser1;
  late final List<ContractUser> contractuser;
  final List<ContractParty> contractparty;
  final List<ContractChannel> contractchannel;
  final List<ContractChannelOTP> contractchannelotp;

  GuiHopDongPage({required this.contract, required this.contractuser1, required this.contractuser, required this.contractparty, required this.contractchannel, required this.contractchannelotp, required List<Contract> contracts});

  @override
  _GuiHopDongPageState createState() => _GuiHopDongPageState();
}

class _GuiHopDongPageState extends State<GuiHopDongPage> {
  late PDFViewController _pdfController;
  int _pageNumber = 1;
  bool _isLoading = false;

  Future<void> _startSigning() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 2));

      // Update the UserSignSatus for the specific ContractUser
      final updatedContractsUser = widget.contractuser1
          .map((user) {
        if (user.contractCode == widget.contract.contractCode) {
          return user.copyWith(FlagSendUser: '1');
        } else {
          return user;
        }
      })
          .toList();

      // Trigger a rebuild of the ContractManagementPage with the updated data
      Navigator.pop(context, updatedContractsUser);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hợp đồng đã được gửi thành công.'),
        ),
      );
    } catch (error) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Có lỗi xảy ra trong quá trình gửi hợp đồng. $error'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gửi hợp đồng', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Stack(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : _startSigning,
        child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Icon(Icons.send),
      ),
    );
  }
}
