import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ScanPage extends StatefulWidget {
  final File? image;

  ScanPage({Key? key, this.image}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  List<ImageLabel> labels = [];

  @override
  void initState() {
    super.initState();
    if (widget.image != null) {
      _initializeImageLabeling();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan ảnh'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImageWidget(widget.image, 'Chưa chụp ảnh'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Quay lại'),
              ),
              SizedBox(height: 20.0),
              Text('Nhãn ảnh: ${labels.map((label) => label.label).join(', ')}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(File? image, String placeholder) {
    return image == null
        ? Text(placeholder)
        : Image.file(
            image,
            height: 200.0,
          );
  }

  Future<void> _initializeImageLabeling() async {
    final ImageLabeler labeler = GoogleMlKit.vision.imageLabeler();
    final InputImage inputImage = InputImage.fromFilePath(widget.image!.path);

    try {
      final List<ImageLabel> detectedLabels = await labeler.processImage(inputImage);
      setState(() {
        labels.clear();
        labels.addAll(detectedLabels);
      });
    } catch (e) {
      print("Lỗi ảnh: $e");
    } finally {
      await labeler.close();
    }
  }
}
