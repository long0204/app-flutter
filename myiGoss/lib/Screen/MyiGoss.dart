import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'RecordingScreen.dart';
import 'detail.dart'; // Import the DetailScreen

class Tab6 extends StatefulWidget {
  @override
  _Tab6State createState() => _Tab6State();
}

class _Tab6State extends State<Tab6> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  @override
  void initState() {
    super.initState();

    // Listen for changes in the text field and trigger search
    _searchController.addListener(() {
      String keyword = _searchController.text;
      if (keyword.isNotEmpty) {
        _search(keyword);
      }
    });
  }

  Future<void> _search(String keyword) async {
    final sanitizedKeyword = keyword ?? "";
    final encodedKeyword = Uri.encodeComponent(sanitizedKeyword);

    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        setState(() {
          // Filter the results based on the entered keyword
          _searchResults = jsonResponse.where((post) =>
              post['title'].toString().toLowerCase().contains(sanitizedKeyword.toLowerCase())
          ).toList();
        });
      } else {
        setState(() {
          _searchResults = [];
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _showContextMenu(BuildContext context, int itemId, String itemTitle, String itemName) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  //Navigator.pop(context);
                  final String itemIdString = itemId.toString();
                  // Implement your edit logic here
                  print('Edit item: $itemIdString');
                },
              ),
              ListTile(
                leading: Icon(Icons.delete,color: Colors.red,),
                title: Text('Delete'),
                onTap: () {
                  //Navigator.pop(context);
                  final String itemIdString = itemId.toString();
                  // Implement your delete logic here
                  print('Delete item: $itemIdString');
                },
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordingScreen()),
                    );
                  },
                ),
              ),
            ),
            Text(
              '(Nói "Tra cứu iGoss" để tìm kiếm bằng giọng nói)',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                child: Text('No results'),
              )
                  : ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final itemId = _searchResults[index]['id']; // Replace 'id' with the actual key for the unique identifier
                  final itemName = _searchResults[index]['body'];
                  final itemTitle = _searchResults[index]['title'];

                  return ListTile(
                    title: Text(itemTitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text(itemName),
                    onTap: () {
                      // Navigate to the detail screen when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(title: itemTitle, body: itemName),
                        ),
                      );
                    },
                    onLongPress: () {
                      // Show context menu on long press
                      _showContextMenu(context, itemId, itemTitle, itemName);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
