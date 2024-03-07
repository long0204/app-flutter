import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ApprovalDetailScreen extends StatefulWidget {
  final Map<String, dynamic> approvalData;
  final List<Map<String, dynamic>> lstWorkFlowUser;
  final List<Map<String, dynamic>> lstFile;

  ApprovalDetailScreen({required this.approvalData, required this.lstWorkFlowUser, required this.lstFile});

  @override
  _ApprovalDetailScreenState createState() => _ApprovalDetailScreenState();
}

class _ApprovalDetailScreenState extends State<ApprovalDetailScreen> {
  void _updateApprovalStatus(String newStatus) {
    setState(() {
      widget.approvalData["ApprvStatus"] = newStatus;
    });

    // Close the screen with a result
    Navigator.pop(context, {"ApprvStatus": newStatus});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Approval: ${widget.approvalData["ApprvCode"]}"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.approvalData["ApprvName"]}',
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: widget.approvalData["ApprvStatus"] == 'REJECT'
                                ? Colors.red[100]
                                : widget.approvalData["ApprvStatus"] == 'APPROVED'
                                ? Colors.blue[100]
                                : widget.approvalData["ApprvStatus"] == 'REQUESTED'
                                ? Colors.orangeAccent[100]
                                : Colors.yellowAccent[100],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            '${widget.approvalData["ApprvStatus"] ?? ''}',
                            style: TextStyle(
                              color: widget.approvalData["ApprvStatus"] == 'REJECT'
                                  ? Colors.red
                                  : widget.approvalData["ApprvStatus"] == 'APPROVED'
                                  ? Colors.blue
                                  : widget.approvalData["ApprvStatus"] == 'REQUESTED'
                                  ? Colors.orange
                                  : Colors.yellow[800],
                            ),
                          ),
                        ),
                        Text(
                          widget.approvalData["ApprvStatus"] == 'Approval' ? 'Phê duyệt' : 'Ký điện tử',
                          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tài liệu Ký',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    if (widget.lstFile.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.lstFile.length,
                        itemBuilder: (context, index) {
                          final fileData = widget.lstFile[index];
                          return ListTile(
                            title: Text(fileData["FileName"] ?? ''),
                            // Add more details if needed
                          );
                        },
                      ),
                    if (widget.lstFile.isEmpty)
                      Text('No files available'),
                  ],
                ),
              ),
            ),

            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Luồng phê duyệt',
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          '(Phải phê duyệt theo đúng thứ tự)',
                          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: widget.lstWorkFlowUser?.length ?? 0,
                      itemBuilder: (context, index) {
                        final stepData = widget.lstWorkFlowUser[index];
                        return TimelineTile(
                          axis: TimelineAxis.vertical,
                          alignment: TimelineAlign.manual,
                          lineXY: 0.2,
                          isFirst: index == 0,
                          isLast: index == widget.lstWorkFlowUser!.length - 1,
                          indicatorStyle: IndicatorStyle(
                            width: 40,
                            height: 40,
                            color: Colors.green,
                            indicator: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                stepData["ApprvStatusWFUser"] == 'REQUESTED'
                                    ? Icons.schedule
                                    : stepData["ApprvStatusWFUser"] == 'Notify'
                                    ? Icons.notifications_active
                                    : stepData["ApprvStatusWFUser"] == 'implement'
                                    ? Icons.lightbulb
                                    : Icons.check,
                                color: stepData["ApprvStatusWFUser"] == 'REQUESTED'
                                    ? Colors.orange
                                    : stepData["ApprvStatusWFUser"] == 'Notify'
                                    ? Colors.yellow[700]
                                    : Colors.green,
                              ),
                            ),
                          ),
                          endChild: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      stepData["ApprvStatusWFUser"],
                                      style: TextStyle(
                                        color: stepData["ApprvStatusWFUser"] == 'REQUESTED'
                                            ? stepData["LogLUDTimeUTC"] != '' ? Colors.orange : Colors.grey
                                            : Colors.grey,
                                      ),
                                    ),
                                    Text(stepData["LogLUDTimeUTC"]),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.account_circle, color: Colors.grey),
                                    Text(
                                      stepData["UserCodeActual"],
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            if(widget.approvalData["ApprvStatus"] != 'APPROVED')
              if(widget.approvalData["ApprvStatus"] != 'REJECT')
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => _updateApprovalStatus("APPROVED"),
                          child: Text('Approve'),
                        ),
                        ElevatedButton(
                          onPressed: () => _updateApprovalStatus("REJECT"),
                          child: Text('Reject'),
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
