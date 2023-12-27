import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import '../Screens/contract_management_page.dart';

class ContractContentPage extends StatelessWidget {
  final Contract contract;

  ContractContentPage({required this.contract});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: _loadPdf(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return Container(
                    height: 500, // Adjust the height as needed
                    child: PDFView(
                      filePath: snapshot.data as String,
                      enableSwipe: true,
                      swipeHorizontal: true,
                    ),
                  );
                } else {
                  return Center(child: Text('Error loading PDF'));
                }
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading PDF'));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

        ],
      ),
    );
  }

  Future<String?> _loadPdf() async {
    final pdfUrl = "https://ftest.ecore.vn/20231226/03CQ21415.83021CB219CF43C18AB48B8CB03FE25F.pdf";

    // Use a custom http.Client to disable SSL verification
    final client = http.Client();
    try {
      final response = await client.get(Uri.parse(pdfUrl));

      if (response.statusCode == 200) {
        // Save the PDF to a temporary file (you might want to use a proper caching mechanism)
        final file = await _saveFile(response.bodyBytes, 'example.pdf');
        return file.path;
      } else {
        print('Failed to load PDF - Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loading PDF: $e');
      return null;
    } finally {
      client.close(); // Close the custom client to release resources
    }
  }


  Future<File> _saveFile(Uint8List data, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(data);
    return file;
  }
}
