import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image1;
  File? _image2;
  List<ImageLabel> labels1 = [];
  List<ImageLabel> labels2 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kiểm tra ảnh'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImageWidget(_image1, 'Chưa chụp ảnh 1'),
              SizedBox(height: 20.0),
              _buildImageWidget(_image2, 'Chưa chụp ảnh 2'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _captureImage(1);
                },
                child: Text('Chụp ảnh 1'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _captureImage(2);
                },
                child: Text('Chụp ảnh 2'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _compareImages();
                },
                child: Text('So sánh'),
              ),
              // SizedBox(height: 20.0),
              // Text('Labels for Image 1: ${labels1.map((label) => label.label).join(', ')}'),
              // SizedBox(height: 20.0),
              // Text('Labels for Image 2: ${labels2.map((label) => label.label).join(', ')}'),
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

  Future<void> _captureImage(int imageIndex) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        switch (imageIndex) {
          case 1:
            _image1 = File(pickedFile.path);
            break;
          case 2:
            _image2 = File(pickedFile.path);
            break;
        }
      });

      await _initializeImageLabeling(imageIndex);
    } else {
      print('Không chụp được ảnh.');
    }
  }

  Future<void> _initializeImageLabeling(int imageIndex) async {
    final List<ImageLabel> labels = imageIndex == 1 ? labels1 : labels2;
    final File imageFile = imageIndex == 1 ? _image1! : _image2!;

    final ImageLabeler labeler = GoogleMlKit.vision.imageLabeler();
    final inputImage = InputImage.fromFilePath(imageFile.path);

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

  void _compareImages() {
    final Set<String> labelsSet1 = labels1.map((label) => label.label).toSet();
    final Set<String> labelsSet2 = labels2.map((label) => label.label).toSet();

    final double similarityPercentage = calculateSimilarityPercentage(labelsSet1, labelsSet2);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Độ tương đồng ảnh'),
          content: Text('Độ tương đồng: $similarityPercentage%'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  double calculateSimilarityPercentage(Set<String> set1, Set<String> set2) {
    if (set1.isEmpty || set2.isEmpty) {
      return 0.0;
    }

    final Set<String> commonLabels = set1.intersection(set2);
    final double similarityPercentage = (commonLabels.length / set1.union(set2).length) * 100;

    return similarityPercentage;
  }
}