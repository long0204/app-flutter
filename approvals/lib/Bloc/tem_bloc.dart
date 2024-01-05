import 'dart:convert';
import 'package:approvals/Screen/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApprovalScreen1 extends StatefulWidget {
  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen1> {
  late Future<List<Map<String, dynamic>>> futureApprovalData;

  @override
  void initState() {
    super.initState();
    futureApprovalData = fetchApprovalData();
  }

  Future<List<Map<String, dynamic>>> fetchApprovalData() async {
    final apiUrl = 'https://devsyscm.inos.vn:12089/idocNet.Test.MobileGate.V10.WA/Approvals/WA_Apprv_Approval_Get';

    final response = await http.post(Uri.parse(apiUrl), body: {
      'NetworkID': '4221896000',
      'OrgID': '4221896000',
      'strKeyword': '',
      'strFilterStatus': 'REQUESTED,ONPROCESS',
      'strCreateBy': 'DEMO@INOS.VN',
      'strUserCodeActualVA': '',
      'strUserCodeActual': '',
      'strOrderBy': 'aapprv.LUDTimeUTC asc',
      'pageIndex': '0',
      'pageSize': '10',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['Success'] == true) {
        final List<Map<String, dynamic>> lstApprovals = data['Data']['Lst_Apprv_Approval'].cast<Map<String, dynamic>>();
        return lstApprovals;
      } else {
        throw Exception('API request failed: ${data['Messages']}');
      }
    } else {
      throw Exception('HTTP request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.apple_outlined),
            SizedBox(width: 8,),
            Text('Approval', style: TextStyle(color: Colors.white),),
          ],
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.question_answer, color: Colors.white,),
            onPressed: () {
              // Xử lý khi nhấn nút Messenger
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Xử lý khi nhấn nút Notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              // Xử lý khi nhấn nút Account
            },
          ),
        ],
      ),
      body: Column(
          children: [
          SearchCard(
          //onFilterPressed: (){},
          onMorePressed: (){},
      onSearchTextChanged: (searchText) {
        // Xử lý khi thay đổi giá trị trong ô tìm kiếm
      },
      onSwapPressed: (){},
    ),
    Expanded(
      child:
        FutureBuilder<List<Map<String, dynamic>>>(
          future: futureApprovalData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Loading indicator while fetching data
            }
            else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            else {
    final lstapproval = snapshot.data!;
    return ListView.builder(
    itemCount: lstapproval.length,
    itemBuilder: (context, index) {
    return GestureDetector(
    onTap: () {
    //Navigator.push(
    //  context,
    //  MaterialPageRoute(
    //    builder: (context) => ApprovalDetailScreen(
    //      approvalData: lstapproval[index],
    //    ),
    //  ),
    //);
    },
    child: Card(
    color: lstapproval[index]["StatusSign"] == 'Requested' ? Colors.greenAccent[100]:
    lstapproval[index]["StatusSign"] == 'ON PROCESS' ? Colors.greenAccent[100] : Colors.white,
    child: ListTile(
    title: Container(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Container(
    padding: EdgeInsets.all(8.0), // Add padding for better appearance
    decoration: BoxDecoration(
    color: lstapproval[index]["StatusSign"] == 'Rejected' ? Colors.red[100]:
    lstapproval[index]["StatusSign"] == 'Approved' ? Colors.blue[100]:
    lstapproval[index]["StatusSign"] == 'Requested' ? Colors.orangeAccent[100]:
    Colors.yellowAccent[100],
    borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
    '${lstapproval[index]["StatusSign"] ?? ''}',
    style: TextStyle(color:
    lstapproval[index]["StatusSign"] == 'Rejected' ? Colors.red:
    lstapproval[index]["StatusSign"] == 'Approved' ? Colors.blue:
    lstapproval[index]["StatusSign"] == 'Requested' ? Colors.orange:
    Colors.yellow[800],fontSize: 14),
    ),
    ),
    Text(
    '${lstapproval[index]["DateCreate"] ?? ''}',
    style: TextStyle(color: Colors.grey, fontSize: 14),
    ),
    ],
    ),

    ),
    subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(lstapproval[index]["NameApproval"] ?? '',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
    Text('${lstapproval[index]["Remark"] ?? ''}'),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Container(
    child: Row(
    children: [
    Icon(Icons.account_circle),
    Text('${lstapproval[index]["Usercreate"] ?? ''}'),
    ],
    ),
    ),
    Text('${lstapproval[index]["Approvalcode"] ?? ''}',
    style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic,color: Colors.grey),
    ),
    ],
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Container(
    child: Row(
    children: [
    Icon(Icons.account_circle),
    Text('${lstapproval[index]["Usersign"] ?? ''}'),
    ],
    ),
    ),
    Text(
    lstapproval[index]["TempType"] == 'Approval' ? 'Phê duyệt': 'Ký điện tử',
    style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic,color: Colors.grey),
    ),
    ],
    ),
    ],
    ),
    ),
    ),

    );
    },
    );
    }}
        ),
    ),
    ]),
    );
    }
    }
