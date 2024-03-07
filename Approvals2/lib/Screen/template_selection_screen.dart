import 'package:flutter/material.dart';
import 'create_template_screen.dart';

class TemplateSelectionScreen extends StatelessWidget {
  late final List<Map<String, dynamic>> lstapproval;

  TemplateSelectionScreen({required this.lstapproval});
  final List<Map<String, dynamic>> lstTmpActivity = [
    {
      "TempCode": "0D5007RF0040B39",
      "TempName": "(2.1)TPL.ResponsePending.TTT.1",
      "TempType":"Approval",
      "Remark": "Ghi chú",
      "Icon" : Icons.access_time_filled,
      "LogLUDTimeUTC": "2023-12-26 02:40:41",
      "LogLUBy": "DEMO@INOS.VN"
    },
    {
      "TempCode": "0D5007RF0040B40",
      "TempName": "Test",
      "Remark": "test",
      "TempType":"Approval",
      "Icon" : Icons.domain,
      "LogLUDTimeUTC": "2023-12-26 02:40:41",
      "LogLUBy": "DEMO@INOS.VN"
    },
    {
      "TempCode": "0D5007RF0040B41",
      "TempName": "Kiêm nhiệm nội bộ",
      "Remark": "Ghi chú",
      "TempType":"subject",
      "Icon" : Icons.error_outline,
      "LogLUDTimeUTC": "2023-12-26 02:40:41",
      "LogLUBy": "DEMO@INOS.VN"
    },
    {
      "TempCode": "0D5007RF0040B42",
      "TempName": "Kiêm nhiệm ngoài",
      "Remark": "Ghi chú",
      "TempType":"Subject",
      "Icon" : Icons.error_outline,
      "LogLUDTimeUTC": "2023-12-26 02:40:41",
      "LogLUBy": "DEMO@INOS.VN"
    },
    {
      "TempCode": "0D5007RF0040B43",
      "TempName": "Bổ nhiệm",
      "Remark": "BN 230310",
      "TempType":"Approval",
      "Icon" : Icons.error_outline,
      "LogLUDTimeUTC": "2023-12-26 02:40:41",
      "LogLUBy": "DEMO@INOS.VN"
    },
    {
      "TempCode": "0D5007RF0040B44",
      "TempName": "Đề xuất công tác",
      "Remark": "Đề xuất công tác",
      "TempType":"subject",
      "Icon" : Icons.airplanemode_active,
      "LogLUDTimeUTC": "2023-12-26 02:40:41",
      "LogLUBy": "DEMO@INOS.VN"
    }
    ,
    {
      "TempCode": "0D5007RF0040B45",
      "TempName": "Thanh toán hóa đơn đối tác",
      "Remark": "AllnNormal 230307",
      "TempType":"Subject",
      "Icon" : Icons.all_inbox,
      "LogLUDTimeUTC": "2023-12-26 02:40:41",
      "LogLUBy": "DEMO@INOS.VN"
    }
    ,
    {
      "TempCode": "0D5007RF0040B46",
      "TempName": "(2)TPL.ResponsePending.TTT.1",
      "Remark": "Ghi chú",
      "TempType":"Approval",
      "Icon" : Icons.access_time_filled,
      "LogLUDTimeUTC": "2023-12-26 02:40:41",
      "LogLUBy": "DEMO@INOS.VN"
    }
    ,
    {
      "TempCode": "0D5007RF0040B47",
      "TempName": "Công tác định kỳ",
      "Remark": "Ghi chú",
      "TempType":"Subject",
      "Icon" : Icons.access_time_filled,
      "LogLUDTimeUTC": "2023-12-26 02:40:41",
      "LogLUBy": "DEMO@INOS.VN"
    }, {
      "TempCode": "0D5007RF0040B48",
      "TempName": "Thanh toán hóa đơn đối tác",
      "Remark": "AllnNormal",
      "TempType":"Approval",
      "Icon" : Icons.all_inbox,
      "LogLUDTimeUTC": "2023-12-26 02:40:41",
      "LogLUBy": "DEMO@INOS.VN"
    }
  ];
  //List<Map<String, dynamic>> lstapproval = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chọn mẫu phê duyệt',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Activity',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lstTmpActivity.length,
              itemBuilder: (context, index) {
                final template = lstTmpActivity[index];
                return Card(
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: template['Icon'] == Icons.access_time_filled
                            ? Colors.deepOrange[700]
                            : template['Icon'] == Icons.domain
                            ? Colors.green
                            : template['Icon  '] == Icons.all_inbox
                            ? Colors.red
                            : template['Icon'] == Icons.airplanemode_active
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        template['Icon'],
                        color: Colors.white,
                      ),
                    ),
                    title: Text(template['TempName']),
                    subtitle: Text(template['Remark']),
                    onTap: () {
                      final updatedList = Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateTemplateScreen(template: template,lstapproval: lstapproval,),
                        ),
                      );
                      if (updatedList != null) {
                        lstapproval =updatedList as List<Map<String, dynamic>>;
                        print(lstapproval);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
