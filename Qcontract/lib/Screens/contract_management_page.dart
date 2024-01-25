import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';

import 'FilterPage.dart';
import 'GuiPage.dart';
import 'KyHopDongScreen.dart';
import 'ContractDetailPage.dart'; // Import the ContractDetailPage

class Contract {
  final String contractCode;
  final String networkID;
  final String orgID;
  final String contractNo;
  final String tContractCode;
  final String contractName;
  final String contractDateUTC;
  final String effDateStart;
  final String effDateEnd;
  final String ContractFilePath;
  final String Remark;
  final String ContractDateUTC;
  final String TContracName;
  final String ContractStatus;

  Contract({
    required this.contractCode,
    required this.networkID,
    required this.orgID,
    required this.contractNo,
    required this.tContractCode,
    required this.contractName,
    required this.contractDateUTC,
    required this.effDateStart,
    required this.effDateEnd,
    required this.ContractFilePath,
    required this.Remark,
    required this.ContractDateUTC,
    required this.TContracName,
    required this.ContractStatus,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      contractCode: json['ContractCode'] ?? '',
      networkID: json['NetworkID'] ?? '',
      orgID: json['OrgID'] ?? '',
      contractNo: json['ContractNo'] ?? '',
      tContractCode: json['TContractCode'] ?? '',
      contractName: json['ContractName'] ?? '',
      contractDateUTC: json['ContractDateUTC'] ?? '',
      effDateStart: json['EffDateStart'] ?? '',
      effDateEnd: json['EffDateEnd'] ?? '',
      ContractFilePath: json['ContractFilePath'] ?? '',
      Remark: json['Remark'] ?? '',
      ContractDateUTC: json['ContractDateUTC'] ?? '',
      TContracName: json['TContracName'] ?? '',
      ContractStatus: json['ContractStatus'] ?? '',
    );
  }
}

class ContractUser {
  final String contractCode;
  final String UserCodeSysSign;
  final String UserCodeSign;
  final String UserToken;
  final String UserNameSign;
  final String UserZalo;
  final String UserSignSatus;
  final String FlagSendUser;
  final String PartyCode;

  ContractUser({
    required this.contractCode,
    required this.UserCodeSysSign,
    required this.UserCodeSign,
    required this.UserToken,
    required this.UserNameSign,
    required this.UserZalo,
    required this.UserSignSatus,
    required this.FlagSendUser,
    required this.PartyCode,
  });
  ContractUser copyWith({
    String? contractCode,
    String? UserCodeSysSign,
    String? UserCodeSign,
    String? UserToken,
    String? UserNameSign,
    String? UserZalo,
    String? UserSignSatus,
    String? FlagSendUser,
    String? PartyCode,
  }) {
    return ContractUser(
      contractCode: contractCode ?? this.contractCode,
      UserCodeSysSign: UserCodeSysSign ?? this.UserCodeSysSign,
      UserCodeSign: UserCodeSign ?? this.UserCodeSign,
      UserToken: UserToken ?? this.UserToken,
      UserNameSign: UserNameSign ?? this.UserNameSign,
      UserZalo: UserZalo ?? this.UserZalo,
      UserSignSatus: UserSignSatus ?? this.UserSignSatus,
      FlagSendUser: FlagSendUser ?? this.FlagSendUser,
      PartyCode: PartyCode ?? this.PartyCode,
    );
  }

  factory ContractUser.fromJson(Map<String, dynamic> json) {
    return ContractUser(
      contractCode: json['ContractCode'] ?? '',
      UserCodeSysSign: json['UserCodeSysSign'] ?? '',
      UserCodeSign: json['UserCodeSign'] ?? '',
      UserToken: json['UserToken'] ?? '',
      UserNameSign: json['UserNameSign'] ?? '',
      UserZalo: json['UserZalo'] ?? '',
      UserSignSatus: json['UserSignSatus'] ?? '',
      FlagSendUser: json['FlagSendUser'] ?? '',
      PartyCode:  json['PartyCode'] ?? '',
    );
  }
}

class ContractParty {
  final String contractCode;
  final String PartyCode;
  final String MST;
  final String CustomerName;
  final String CustomerAddress;
  final String CustomerEmail;
  final String CustomerPhoneNo;
  final String RepresentName;
  final String ContractType;
  final String ContractTypeName;
  final String ContractPartyStatus;

  ContractParty({
    required this.contractCode,
    required this.PartyCode,
    required this.MST,
    required this.CustomerName,
    required this.CustomerAddress,
    required this.CustomerEmail,
    required this.CustomerPhoneNo,
    required this.RepresentName,
    required this.ContractType,
    required this.ContractTypeName,
    required this.ContractPartyStatus,
  });

  factory ContractParty.fromJson(Map<String, dynamic> json) {
    return ContractParty(
      contractCode: json['ContractCode'] ?? '',
      PartyCode: json['PartyCode'] ?? '',
      MST: json['MST'] ?? '',
      CustomerName: json['CustomerName'] ?? '',
      CustomerAddress: json['CustomerAddress'] ?? '',
      CustomerEmail: json['CustomerEmail'] ?? '',
      CustomerPhoneNo: json['CustomerPhoneNo'] ?? '',
      RepresentName: json['RepresentName'] ?? '',
      ContractType: json['ContractType'] ?? '',
      ContractTypeName: json['ContractTypeName'] ?? '',
      ContractPartyStatus: json['ContractPartyStatus'] ?? '',
    );
  }
}

class ContractChannel {
  final String contractCode;
  final String ChannelType;

  ContractChannel({
    required this.contractCode,
    required this.ChannelType,
  });

  factory ContractChannel.fromJson(Map<String, dynamic> json) {
    return ContractChannel(
      contractCode: json['ContractCode'] ?? '',
      ChannelType: json['ChannelType'] ?? '',
    );
  }
}

class ContractChannelOTP {
  final String contractCode;
  final String ChannelTypeOTP;

  ContractChannelOTP({
    required this.contractCode,
    required this.ChannelTypeOTP,
  });

  factory ContractChannelOTP.fromJson(Map<String, dynamic> json) {
    return ContractChannelOTP(
      contractCode: json['ContractCode'] ?? '',
      ChannelTypeOTP: json['ChannelTypeOTP'] ?? '',
    );
  }
}


class ApiService {
  static const String baseUrl =
      'https://devsyscm.inos.vn:12089/idocNet.Test.MobileGate.V10.WA';

  static Future<http.Response> post(String path,
      {Map<String, String>? parram,Map<String, String>? headers, Map<String, String>? body}) async {
    final url = Uri.parse('$baseUrl/$path');

    final defaultHeaders = {
      'GwUserCode': 'idocNet.idN.MobileGate.Sv',
      'GwPassword': 'idocNet.idN.MobileGate.Sv',
      'NetworkID': '4221896000',
      'OrgID': '4221896000',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization':
      'Bearer NbgtFZdtAyhotSEaOwPtqEqc7VuhvhZfy0lzBLvhjulvu-Jfobx8Do8B_wxZhobOZV_KQ4fF2sXuGPNqtCpA2uFwC0hgzzpfZrhtxNJqKr-HZiAnqXXisHRLAVnZqtr5Fx0iIhkzNDJlkv4A_Soc_yKx444eA_au0l7ICeMrs69-GfBMG5MjTAviw1ecEbOR4L9NobhOoeDx9jVAx2IF1MQD3Yd-jbMhXcFDhhNzxhi3vPSGIeHdtyI0H0aHRSnV',
    };

    final mergedHeaders = {...defaultHeaders, ...?headers};

    return await http.post(url, headers: mergedHeaders, body: body);
  }
}

class ContractManagementPage extends StatefulWidget {
  @override
  _ContractManagementPageState createState() => _ContractManagementPageState();
}

class _ContractManagementPageState extends State<ContractManagementPage> {
  List<Contract> contracts = [];
  List<ContractUser> contractsuser = [];
  List<ContractParty> contractsparty = [];
  List<ContractChannel> contractschannel = [];
  List<ContractChannelOTP> contractschannelotp = [];
  bool isLoading = true;
  String searchKeyword = '';
  bool waitForMe = false;
  bool waitForOthers = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await ApiService.post(
        'QContract/WA_Contract_Contract_Get',
        body: {
          'NetworkID': '4221896000',
          'OrgID': '4221896000',
          'WAUserCode': 'demo@inos.vn',
          'pageIndex': '0',
          'pageSize': '10',
          'contractDateFrom': '2023-12-26',
          'UserSignByMe': waitForMe ? 'Pending' : '',
          'UserSignByOther': waitForOthers ? 'Pending' : '',
        },
        parram: {
          'ContractCode': searchKeyword,
        }
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        final List<dynamic> contractListJson =
        responseData['Data']['Lst_Contract_Contract'];

        final List<dynamic> contractuserListJson =
        responseData['Data']['Lst_Contract_ContractUser'];

        final List<dynamic> contractpartyJson =
        responseData['Data']['Lst_Contract_ContractParty'];

        final List<dynamic> contractChannelListJson =
        responseData['Data']['Lst_Contract_ContractChannel'];

        final List<dynamic> contractChannelOTPJson =
        responseData['Data']['Lst_Contract_ContractChannelOTP'];

        final List<Contract> fetchedContracts = contractListJson
            .map((contractJson) => Contract.fromJson(contractJson))
            .toList();

        final List<ContractUser> fetchedContractsuser = contractuserListJson
            .map((contractJson) => ContractUser.fromJson(contractJson))
            .toList();

        final List<ContractParty> fetchedContractsParty = contractpartyJson
            .map((contractJson) => ContractParty.fromJson(contractJson))
            .toList();

        final List<ContractChannel> fetchedContractChannel = contractChannelListJson
            .map((contractJson) => ContractChannel.fromJson(contractJson))
            .toList();
        final List<ContractChannelOTP> fetchedContractChannelOTP = contractChannelOTPJson
            .map((contractJson) => ContractChannelOTP.fromJson(contractJson))
            .toList();

        setState(() {
          contracts = fetchedContracts;
          contractsuser = fetchedContractsuser;
          contractsparty = fetchedContractsParty;
          contractschannel = fetchedContractChannel;
          contractschannelotp = fetchedContractChannelOTP;
          isLoading = false;
        });
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý HĐ/TL', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nhập từ khóa tìm kiếm',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onChanged: (searchText) {
                      // Xử lý khi thay đổi giá trị trong ô tìm kiếm
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterPage()),
                    );

                    // Kiểm tra xem kết quả có giá trị không và áp dụng lọc dữ liệu nếu cần
                    if (result != null) {
                      // Áp dụng lọc dữ liệu ở đây sử dụng các giá trị từ result
                      // result.soHDTL, result.maTraCuu, result.benKy, result.nguoiKy, result.fromDate, result.toDate
                      // ...
                    }
                  },
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: waitForMe,
                onChanged: (value) {
                  setState(() {
                    waitForMe = value ?? false;
                  });
                  fetchData();
                },
              ),
              Text('Chờ tôi ký'),
              Checkbox(
                value: waitForOthers,
                onChanged: (value) {
                  setState(() {
                    waitForOthers = value ?? false;
                  });
                  fetchData();
                },
              ),
              Text('Chờ người khác ký'),
            ],
          ),
          Expanded(
            child: isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : contracts.isEmpty
                ? Center(
              child: Text('No contracts available.'),
            )
                : ListView.builder(
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                final contract = contracts[index];
                final matchingUsers = contractsuser
                    .where((user) =>
                user.contractCode == contract.contractCode)
                    .toList();
                final matchingParty = contractsparty
                    .where((party) =>
                party.contractCode == contract.contractCode)
                    .toList();
                final matchingChannel = contractschannel
                    .where((channel) =>
                channel.contractCode == contract.contractCode)
                    .toList();
                final matchingChannelOTP = contractschannelotp
                    .where((channelotp) =>
                channelotp.contractCode == contract.contractCode)
                    .toList();

                return Slidable(
                  child: Card(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to ContractDetailPage when the card is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ContractDetailPage(contract: contract, contractuser :matchingUsers, contractparty: matchingParty, contractchannel: matchingChannel, contractchannelotp: matchingChannelOTP, ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              contract.contractName,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(contract.contractNo,
                                style: TextStyle(fontSize: 12)),
                            trailing: Text(contract.contractCode,
                                style: TextStyle(fontSize: 12)),
                            onTap: () {
                              // Handle onTap
                            },
                          ),
                          if (matchingUsers.isNotEmpty)
                            for (var user in matchingUsers)
                              ListTile(
                                subtitle: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 220,
                                      height: 30,
                                      child: Text(
                                        '${user.UserCodeSign} ${user.UserNameSign}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        color: user.FlagSendUser == '1'
                                            ? Colors.blue
                                            :  Colors.deepOrangeAccent,
                                      ),
                                      child: Text(
                                        user.FlagSendUser == '1'
                                            ? 'Đã gửi'
                                            : 'Chưa gửi',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        color: user.UserSignSatus == 'PENDING'
                                            ? Colors.deepOrangeAccent
                                            : Colors.blue,
                                      ),
                                      child: Text(
                                        user.UserSignSatus == 'PENDING'
                                            ? 'Chưa ký'
                                            : 'Đã ký',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                  endActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: ((context) async {
                          // Navigate to 'Ký hợp đồng' screen
                          final updatedContractsUser = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GuiHopDongPage(
                                contract: contract,
                                contracts: contracts,
                                contractuser1: contractsuser,
                                contractuser: matchingUsers,
                                contractparty: matchingParty,
                                contractchannel: matchingChannel,
                                contractchannelotp: matchingChannelOTP,
                              ),
                            ),
                          );
                          // Check if updatedContractsUser is not null and update your state
                          if (updatedContractsUser != null) {
                            setState(() {
                              contractsuser = updatedContractsUser;
                            });
                          }
                        }),
                        icon: Icons.send,
                        backgroundColor: Colors.grey,
                        label: 'Gửi',
                      ),
                      SlidableAction(
                        onPressed: ((context) async {
                          // Navigate to 'Ký hợp đồng' screen
                          final updatedContractsUser = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KyHopDongPage(
                                contract: contract,
                                contractuser1: contractsuser,
                                contractuser: matchingUsers,
                                contractparty: matchingParty,
                                contractchannel: matchingChannel,
                                contractchannelotp: matchingChannelOTP,
                              ),
                            ),
                          );
                          // Check if updatedContractsUser is not null and update your state
                          if (updatedContractsUser != null) {
                            setState(() {
                              contractsuser = updatedContractsUser;
                            });
                          }
                        }),
                        icon: Icons.border_color,
                        backgroundColor: Colors.green.shade900,
                        label: 'Ký',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showFilterDialog() {
    // Implement filter dialog logic
  }
}
