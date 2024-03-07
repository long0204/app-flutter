import 'package:approvals/Screen/template_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterPopup extends StatefulWidget {
  late final String status;
  final Function(String) onFilterApplied; // Callback function

  FilterPopup({required this.status, required this.onFilterApplied});

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  String? selectedCreator;
  String? selectedApprover;
  String? selectedStatus;
  bool isPendingApproval = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            hint: Text('Người tạo'),
            value: selectedCreator,
            onChanged: (value) {
              setState(() {
                selectedCreator = value;
              });
            },
            items: [], // Add dropdown items
          ),
          DropdownButton<String>(
            hint: Text('Người duyệt'),
            value: selectedApprover,
            onChanged: (value) {
              setState(() {
                selectedApprover = value;
              });
            },
            items: [], // Add dropdown items
          ),
          DropdownButton<String>(
            hint: Text('Trạng thái'),
            value: selectedStatus,
            onChanged: (value) {
              setState(() {
                selectedStatus = value;
              });
            },
            items: [
              DropdownMenuItem(
                value: 'REQUESTED,ONPROCESS,APPROVED,REJECT',
                child: Text('Tất cả'),
              ),
              DropdownMenuItem(
                value: 'REQUESTED',
                child: Text('Chờ xử lý'),
              ),
              DropdownMenuItem(
                value: 'ONPROCESS',
                child: Text('Đang xử lý'),
              ),
              DropdownMenuItem(
                value: 'APPROVED',
                child: Text('Đã phê duyệt'),
              ),
              DropdownMenuItem(
                value: 'REJECT',
                child: Text('Từ chối'),
              ),
            ],
          ),
          // Checkbox for pending approval
          CheckboxListTile(
            title: Text('Phê duyệt đang chờ'),
            value: isPendingApproval,
            onChanged: (value) {
              setState(() {
                isPendingApproval = value!;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Close the popup without applying filters
                  Navigator.of(context).pop();
                },
                child: Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Apply the filters and close the popup
                  Navigator.of(context).pop();
                  // Pass the selected filters to the parent widget
                  print(widget.status);
                  print("Status: $selectedStatus");
                  widget.status =selectedStatus!;
                  widget.onFilterApplied(selectedStatus ?? widget.status);
                },
                child: Text('Lưu'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  final ValueChanged<String> onSearchTextChanged;
  final VoidCallback onSwapPressed;
  final VoidCallback onMorePressed;

  SearchCard({
    required this.onSearchTextChanged,
    required this.onSwapPressed,
    required this.onMorePressed,
  });

  String selectedStatus = '';

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: onSearchTextChanged,
            ),
          ),
          IconButton(
            color: Colors.green,
            icon: Icon(Icons.add_circle),
            onPressed: () {
              _showAddOptionsBottomSheet(context);
            },
          ),
          //IconButton(
          //  icon: Icon(Icons.filter_alt),
          //  onPressed: () {
          //    _showFilterPopup(context);
          //  },
          //),
          //IconButton(
          //  icon: Icon(Icons.swap_vert),
          //  onPressed: (){
          //    _showSwapPopup(context);
          //  },
          //),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: onMorePressed,
          ),
        ],
      ),
    );
  }

  void _showAddOptionsBottomSheet(BuildContext context) {
     (
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: ListTile(
                title: Text('Tạo mới approval'),
                onTap: () {

                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Cancel'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFilterPopup(BuildContext context) async {
    // Show the filter popup and wait for the result
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return FilterPopup(
          status: selectedStatus, // Pass the initial status value
          onFilterApplied: (String status) {
            // Handle the callback and update the status
            selectedStatus = status;
          },
        );
      },
    );
    print(result);
    // Handle the selected status after the popup is closed
    if (result != null) {
      print("Selected Status: $result");
      // You can perform further actions based on the selected status
    }
  }

  void _showSwapPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SortPopup();
      },
    );
  }
}

class SortPopup extends StatefulWidget {
  @override
  _SortPopupState createState() => _SortPopupState();
}

class _SortPopupState extends State<SortPopup> {
  SortOption _selectedSortOption = SortOption.ascending;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text('Lọc'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            setState(() {
              _selectedSortOption = SortOption.ascending;
            });
            Navigator.of(context).pop();
            // TODO: Implement logic for ascending sort
          },
          child: Text('Sắp xếp tăng dần'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            setState(() {
              _selectedSortOption = SortOption.descending;
            });
            Navigator.of(context).pop();
            // TODO: Implement logic for descending sort
          },
          child: Text('Sắp xếp giảm dần'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Hủy'),
      ),
    );
  }
}

enum SortOption {
  ascending,
  descending,
}
