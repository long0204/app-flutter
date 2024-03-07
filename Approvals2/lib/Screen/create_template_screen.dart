import 'dart:math';

import 'package:flutter/material.dart';

import 'approval_screen.dart';

class CreateTemplateScreen extends StatefulWidget {
  final Map<String, dynamic> template;
  final List<Map<String, dynamic>> lstapproval;

  CreateTemplateScreen({required this.template, required this.lstapproval});

  @override
  _CreateTemplateScreenState createState() => _CreateTemplateScreenState();
}

class _CreateTemplateScreenState extends State<CreateTemplateScreen> {
  late TextEditingController _dateController;
  late TextEditingController _datetimeController;
  late TextEditingController _titleController;
  late TextEditingController _listController;
  late TextEditingController _numberController;
  late TextEditingController _refController;
  late TextEditingController _strController;
  late final List<Map<String, dynamic>> updatelist = widget.lstapproval;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _datetimeController = TextEditingController();
    _titleController = TextEditingController();
    _listController = TextEditingController();
    _numberController = TextEditingController();
    _refController = TextEditingController();
    _strController = TextEditingController();
  }
  void saveInformation() {
    int randomCode = Random().nextInt(90000) + 10000;
    // Create a data structure to store the entered information
    Map<String, dynamic> savedData = {
      "ApprvCodeSys": "APPRVCODESYS.BAV.$randomCode",
      'NetworkID': "4221896000",
      "OrgID": "4221896000",
      "ApprvCode": "APPRVCODESYS.BAV.$randomCode",
      "TplCodeSys": widget.template['TempCode'],
      "ApprvName": _titleController.text, // Fixed: Use .text to get the text value
      "ApprvDesc": _numberController.text, // Fixed: Use .text to get the text value
      "ApprvFileVersion": "62b5d337-f2f7-4913-9c59-fc45b89b72fb",
      "ApprvFilePath": "",
      "ApprvFileName": "",
      "ApprvFileType": "",
      "ApprvFileSpec": null,
      "CreateDTimeUTC": _dateController.text, // Fixed: Use .text to get the text value
      "CreateBy": "TEST1401@INOS.VN",
      "LUDTimeUTC": "2021 -10-31 08:24:16",
      "LUBy": "TEST1402@INOS.VN",
      "RejectDTimeUTC": null,
      "RejectBy": null,
      "ApprDTimeUTC": "",
      "ApprBy": "",
      "ApprvStatus": "ONPROCESS",
      "Remark": _strController.text, // Fixed: Use .text to get the text value
      "LogLUDTimeUTC": _datetimeController.text, // Fixed: Use .text to get the text value
      "LogLUBy": "TEST1402@INOS.VN",
      "FlagIsUpdateFilePath": null,
      "Idx": _refController.text, // Fixed: Use .text to get the text value
      "mtpl_TplName": widget.template['TempName'],
      "mtpl_TplAvatar": "UploadedFiles\\AllFile\\2021-11-26\\20211126.143254.0.jpe",
      "mtpl_FlagESign": "0",
      "mtpl_FlagAttachFile": "0",
      "mtpl_FlagSignFlowIdx": "1",
      "mtpl_CatTplType": "ATTENDENCE",
      "mtpl_TplDesc": "AllnNormal"
    };

    // Add the new information to lstapproval
    updatelist.add(savedData);

    // Return the updated lstapproval list to the previous screen
    Navigator.pop(context, updatelist);
  }
  // Date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // Handle date selection
      String formattedDate = "${picked.day}-${picked.month}-${picked.year}";
      // Update the TextField with the formatted date
      _dateController.text = formattedDate;
    }
  }

  // Date and time picker
  Future<void> _selectDatetime(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // Handle date selection
      String formattedDate = "${picked.day}-${picked.month}-${picked.year}";
      // Update the TextField with the formatted date
      _datetimeController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm mới approval',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Handle 'Account' button press
            },
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.send),
            onPressed: () {
              saveInformation();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display template information
              Card(
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: widget.template['Icon'] == Icons.access_time_filled
                          ? Colors.deepOrange[700]
                          : widget.template['Icon'] == Icons.domain
                          ? Colors.green
                          : widget.template['Icon'] == Icons.all_inbox
                          ? Colors.red
                          : widget.template['Icon'] ==
                          Icons.airplanemode_active
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      widget.template['Icon'],
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    '${widget.template['TempName']}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.template['Remark']}'),
                        Text(
                          widget.template['TempType'] == 'Approval'
                              ? 'Phê duyệt'
                              : 'Ký số điện tử',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Input fields for 'Tiêu đề', 'List', 'Number', 'Ref', 'Str'
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
              ),
              DropdownButton<String>(
                hint: Text('Người phê duyệt'),
                items: ['Person A', 'Person B', 'Person C']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  // Handle dropdown value change
                },
              ),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  prefixIcon: Icon(Icons.calendar_today), // Add this line for the calendar icon
                ),
                onTap: () {
                  // Show date picker
                  _selectDate(context);
                },
              ),
              TextField(
                controller: _datetimeController,
                decoration: InputDecoration(
                  labelText: 'End Date',
                  prefixIcon: Icon(Icons.calendar_today), // Add this line for the calendar icon
                ),
                onTap: () {
                  // Show date picker
                  _selectDatetime(context);
                },
              ),

              TextField(
                controller: _listController,
                decoration: InputDecoration(labelText: 'List'),
              ),
              TextField(
                controller: _numberController,
                decoration: InputDecoration(labelText: 'Number'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _refController,
                decoration: InputDecoration(labelText: 'Ref'),
              ),
              TextField(
                controller: _strController,
                decoration: InputDecoration(labelText: 'Str'),
              ),
              SizedBox(height: 8,),
              Card(),
              Text('Tài liệu tham chiếu'),
            ],
          ),
        ),
      ),
    );
  }
}
