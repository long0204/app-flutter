import 'dart:async';
import 'dart:convert';
import 'package:approvals/Screen/search_bar.dart';
import 'package:approvals/Screen/template_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Login/Login.dart';
import 'ApprovalDetailScreen.dart';

class ApprovalScreen extends StatefulWidget {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  ApprovalScreen({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}
class _ApprovalScreenState extends State<ApprovalScreen> {
  late Future<Map<String, List<Map<String, dynamic>>>> futureApprovalData;
  String searchKeyword = '';
  String userCreate ='';
  String userAuth ='';
  String order ='aapprv.LUDTimeUTC asc';
  String statusFilter ='REQUESTED,ONPROCESS,REJECT,APPROVED';
  List<Map<String, dynamic>> lstapproval = [];


  @override
  void initState() {
    super.initState();
    futureApprovalData = fetchApprovalData();
    startTokenExpirationTimer();
  }

  void startTokenExpirationTimer() {
    Timer(Duration(seconds: widget.expiresIn), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  void refreshToken() async {
    startTokenExpirationTimer();
  }

  Future<Map<String, List<Map<String, dynamic>>>> fetchApprovalData() async {
    final apiUrl = 'https://devsyscm.inos.vn:12089/idocNet.Test.MobileGate.V10.WA/Approvals/WA_Apprv_Approval_Get';
    final token = 'ZUc5sUStUDU1W81UNjC8ueTL2gB0fpGjV7KeigxHgR8TB0FmU7SNiis3sQzdtM5qGaue0h01vye2RSaV5uXoKHM0YiV7JpJ_L9jzFXWiW4TryB-0T9qgezeDCTxWEFEEohhkimkdXO0-geXphOlegxhOmmggy7h97v-R3-H8-oABO5Bj-nzluR1xfMo9F8_s5lHBrbE39Gv2Mfjs1IZR3fpGKxhxxjeZaXXpB3phkLalZb_cUaqn3Q_m0QW7azXS';
    final Networkid = '4221896000';
    final Orgid = '4221896000';

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer ${widget.accessToken}',
      'Content-Type': 'application/x-www-form-urlencoded',
    }, body: {
      'NetworkID': '$Networkid',
      'OrgID': '$Orgid',
      'strKeyword': searchKeyword,
      'strFilterStatus': statusFilter,
      'strCreateBy': userCreate,
      'strUserCodeActualVA': '',
      'strUserCodeActual': '',
      'strOrderBy': order,
      'pageIndex': '0',
      'pageSize': '10',
    });

    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['Success'] == true) {
        final Map<String, List<Map<String, dynamic>>> result = {
          'Lst_Apprv_Approval': data['Data']['Lst_Apprv_Approval'].cast<Map<String, dynamic>>(),
          'Lst_Apprv_ApprovalWorkFlowUser': data['Data']['Lst_Apprv_ApprovalWorkFlowUser'].cast<Map<String, dynamic>>(),
          'Lst_Apprv_ApprovalAttachFile': data['Data']['Lst_Apprv_ApprovalAttachFile'].cast<Map<String, dynamic>>(),
        };

        return result;
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchKeyword = value;
                      });
                      _refreshApprovalData();
                    },
                    decoration: InputDecoration(
                      labelText: 'Tìm kiếm',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_box, color: Colors.black),
                  onPressed: () {
                    // Show the status filter bottom sheet
                    _showAddBottomSheet(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.filter_alt, color: Colors.black),
                  onPressed: () {
                    // Show the status filter bottom sheet
                    _showStatusFilterBottomSheet(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.swap_vert),
                  onPressed: (){
                    _showSwapPopup(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
              future: futureApprovalData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Loading indicator while fetching data
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final data = snapshot.data;
                  if (data != null) {
                  final lstapproval = data['Lst_Apprv_Approval'] ?? [];
                  final lstworkflowUser = data['Lst_Apprv_ApprovalWorkFlowUser'] ?? [];
                  final lstfile = data['Lst_Apprv_ApprovalAttachFile'] ?? [];

                  return ListView.builder(
                    itemCount: lstapproval.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          print(lstapproval[index]);
                          if(lstworkflowUser.length!=0)
                          {
                            if(lstfile.length!=0)
                              {
                                print(lstfile);
                                print('Cả 2');
                                final filteredWorkFlowUser = lstworkflowUser.where((element) =>
                                  element["ApprvCodeSys"] == lstapproval[index]["ApprvCodeSys"]).toList();
                                final filteredFile = lstfile.where((element) =>
                                  element["ApprvCodeSys"] == lstapproval[index]["ApprvCodeSys"]).toList();
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ApprovalDetailScreen(
                                      approvalData: lstapproval[index],
                                      lstWorkFlowUser: filteredWorkFlowUser,
                                      lstFile : filteredFile,
                                    ),
                                  ),
                                );
                                if (result != null && result is Map<String, dynamic>) {
                                  setState(() {
                                    lstapproval[index]["ApprvStatus"] = result["ApprvStatus"];
                                  });
                                }
                            }
                            else {
                              print('không có file');
                              final filteredWorkFlowUser = lstworkflowUser.where((element) =>
                              element["ApprvCodeSys"] == lstapproval[index]["ApprvCodeSys"]).toList();
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ApprovalDetailScreen(
                                    approvalData: lstapproval[index],
                                    lstWorkFlowUser: filteredWorkFlowUser,
                                    lstFile : [],
                                  ),
                                ),
                              );
                              if (result != null && result is Map<String, dynamic>) {
                                setState(() {
                                  lstapproval[index]["ApprvStatus"] = result["ApprvStatus"];
                                });
                              }
                            }
                          }
                          else {
                            print('Khng cả 2');
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ApprovalDetailScreen(
                                  approvalData: lstapproval[index],
                                  lstWorkFlowUser: [],
                                  lstFile : [],
                                ),
                              ),
                            );
                            if (result != null && result is Map<String, dynamic>) {
                              setState(() {
                                lstapproval[index]["ApprvStatus"] = result["ApprvStatus"];
                              });
                            }}
                        },
                        child: Card(
                          color: lstapproval[index]["ApprvStatus"] == 'REQUESTED' ? Colors.greenAccent[100] :
                          lstapproval[index]["ApprvStatus"] == 'ONPROCESS' ? Colors.greenAccent[100] : Colors.white,
                          child: ListTile(
                            title: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: lstapproval[index]["ApprvStatus"] == 'REJECT' ? Colors.red[100] :
                                      lstapproval[index]["ApprvStatus"] == 'APPROVED' ? Colors.blue[100] :
                                      lstapproval[index]["ApprvStatus"] == 'REQUESTED' ? Colors.orangeAccent[100]
                                          : Colors.yellowAccent[100],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      '${lstapproval[index]["ApprvStatus"] ?? ''}',
                                      style: TextStyle(
                                          color: lstapproval[index]["ApprvStatus"] == 'REJECT' ? Colors.red :
                                          lstapproval[index]["ApprvStatus"] == 'APPROVED' ? Colors.blue :
                                          lstapproval[index]["ApprvStatus"] == 'REQUESTED' ? Colors.orange
                                              : Colors.yellow[800],
                                          fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    '${lstapproval[index]["CreateDTimeUTC"] ?? ''}',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(lstapproval[index]["ApprvName"] ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                Text('${lstapproval[index]["Remark"] ?? ''}'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.account_circle),
                                          Text('${lstapproval[index]["CreateBy"] ?? ''}'),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 130,
                                      child: Text('${lstapproval[index]["ApprvCode"] ?? ''}',
                                        style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic,color: Colors.grey),),
                                    )

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.account_circle),
                                          Text('${lstapproval[index]["ApprBy"] ?? ''}'),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      lstapproval[index]["mtpl_CatTplType"] == 'ATTENDENCE' ? 'Phê duyệt': 'Ký điện tử',
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
                }
                  else {
                    return Center(child: Text('No data'));
                  }
                }
              }
            ),
          ),
        ],
      ),
    );
  }

  void _showStatusFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          height: 300,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      userCreate = value;
                    });
                    _refreshApprovalData();
                  },
                  decoration: InputDecoration(
                    labelText: 'Người tạo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      userAuth = value;
                    });
                    _refreshApprovalData();
                  },
                  decoration: InputDecoration(
                    labelText: 'Người duyệt',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Text('Chọn trạng thái'),
              SizedBox(height: 8),
              DropdownButton<String>(
                value: statusFilter,
                onChanged: (String? newValue) {
                  setState(() {
                    statusFilter = newValue!;
                    print(statusFilter);
                  });
                  Navigator.pop(context);
                  _refreshApprovalData();
                },
                items: [
                  DropdownMenuItem(
                    value: 'REQUESTED,ONPROCESS,REJECT,APPROVED',
                    child: Text('Tất cả'),
                  ),
                  DropdownMenuItem(
                    value: 'REJECT',
                    child: Text('Hủy'),
                  ),
                  DropdownMenuItem(
                    value: 'APPROVED',
                    child: Text('Đã ký'),
                  ),
                  DropdownMenuItem(
                    value: 'ONPROCESS',
                    child: Text('Chờ duyệt'),
                  ),
                  DropdownMenuItem(
                    value: 'REQUESTED',
                    child: Text('Chờ duyệt lần 2'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> _refreshApprovalData() async {
    try {
      final data = await fetchApprovalData();
      setState(() {
        futureApprovalData = Future.value(data);
      });
    } catch (error) {
      print('Error fetching approval data: $error');
    }
  }
  void _showSwapPopup1(BuildContext context) {
    //String order = 'aapprv.LUDTimeUTC asc'; // Default ordering
    bool checkordr =false;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text('Thời gian tạo'),
                  RadioListTile(
                    title: Text('Tăng dần'),
                    value: 'aapprv.LUDTimeUTC asc',
                    groupValue: order,
                    onChanged: (value) {
                      setState(() {
                        order = value as String;
                        //Navigator.pop(context);
                        checkordr=true;
                        _refreshApprovalData();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Giảm dần'),
                    value: 'aapprv.LUDTimeUTC desc',
                    groupValue: order,
                    onChanged: (value) {
                      setState(() {
                        order = value as String;
                        //Navigator.pop(context);
                        checkordr=true;
                        _refreshApprovalData();
                      });
                    },
                  ),
                ],
              ),
              if(checkordr)
              Column(
                children: [
                  Text('Thời gian cập nhật'),
                  RadioListTile(
                    title: Text('Tăng dần'),
                    value: 'aapprv.LUDTimeUTC asc',
                    groupValue: order,
                    onChanged: (value) {
                      setState(() {
                        order = value as String;
                        Navigator.pop(context);
                        _refreshApprovalData();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Giảm dần'),
                    value: 'aapprv.LUDTimeUTC desc',
                    groupValue: order,
                    onChanged: (value) {
                      setState(() {
                        order = value as String;
                        Navigator.pop(context);
                        _refreshApprovalData();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  bool isTimeCreation = false;
  void _showSwapPopup(BuildContext context) {
     // Default to time creation
    //String order = 'aapprv.LUDTimeUTC asc'; // Default ordering

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //if (isTimeCreation)
                Column(
                  children: [
                    Text('Thời gian tạo'),
                    RadioListTile(
                      title: Text('Tăng dần'),
                      value: 'aapprv.LUDTimeUTC asc',
                      groupValue: order,
                      onChanged: (value) {
                        setState(() {
                          order = value as String;
                          isTimeCreation = false;
                          Navigator.pop(context);
                          _refreshApprovalData();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('Giảm dần'),
                      value: 'aapprv.LUDTimeUTC desc',
                      groupValue: order,
                      onChanged: (value) {
                        setState(() {
                          order = value as String;
                          isTimeCreation = false;
                          Navigator.pop(context);
                          _refreshApprovalData();
                        });
                      },
                    ),
                  ],
                ),
              SizedBox(height: 16),

            ],
          ),
        );
      },
    );
  }




  void _showAddBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          //height: 200, // Adjust the height as needed
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: ListTile(
                  title: Text('Tạo mới approval'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TemplateSelectionScreen(lstapproval: lstapproval,),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Cancel',style: TextStyle(color: Colors.grey),),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}