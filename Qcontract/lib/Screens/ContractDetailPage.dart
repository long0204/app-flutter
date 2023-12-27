import 'package:flutter/material.dart';
import '../Screendetail/ContractContentPage.dart';
import '../Screendetail/ContractPartiesPage.dart';
import '../Screendetail/GeneralInfoPage.dart';
import 'contract_management_page.dart';

class ContractDetailPage extends StatefulWidget {
  final Contract contract;
  final List<ContractUser> contractuser;
  final List<ContractParty> contractparty;
  final List<ContractChannel> contractchannel;
  final List<ContractChannelOTP> contractchannelotp;

  ContractDetailPage({required this.contract,required this.contractuser, required this.contractparty, required this.contractchannel, required this.contractchannelotp});

  @override
  _ContractDetailPageState createState() => _ContractDetailPageState();
}

class _ContractDetailPageState extends State<ContractDetailPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết HĐ/TL',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert,color: Colors.white,),
            onPressed: () {

            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabItem(0, 'Thông tin chung'),
                _buildTabItem(1, 'Các bên ký kết'),
                _buildTabItem(2, 'Nội dung HĐ/TL'),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                GeneralInfoPage(
                  contract : widget.contract,
                  contractChannel : widget.contractchannel,
                  contractChannelOTP : widget.contractchannelotp,
                ),
                ContractPartiesPage(
                  contract: widget.contract,
                  contractparty: widget.contractparty,
                  contractchannel: widget.contractchannel,
                  contractchannelotp: widget.contractchannelotp, contractuser: widget.contractuser,
                ),
                ContractContentPage(
                  contract : widget.contract,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _currentPage == index ? Colors.green : Colors.transparent,
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: _currentPage == index ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}
