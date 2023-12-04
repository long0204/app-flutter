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
      // appBar: AppBar(
      //   title: Text('Image Comparison'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image1 == null
                ? Text('Select Image 1')
                : Image.file(
                    _image1!,
                    height: 200.0,
                  ),
            SizedBox(height: 20.0),
            _image2 == null
                ? Text('Select Image 2')
                : Image.file(
                    _image2!,
                    height: 200.0,
                  ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await _getImageFromGallery(1);
                await _initializeImageLabeling(1);
              },
              child: Text('Chọn ảnh 1'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await _getImageFromGallery(2);
                await _initializeImageLabeling(2);
              },
              child: Text('Chọn ảnh 2'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _compareImages();
              },
              child: Text('So sánh'),
            ),
            SizedBox(height: 20.0),
            Text('Labels for Image 1: ${labels1.map((label) => label.label).join(', ')}'),
            SizedBox(height: 20.0),
            Text('Labels for Image 2: ${labels2.map((label) => label.label).join(', ')}'),
          ],
        ),
      ),
    );
  }

  Future<void> _getImageFromGallery(int imageIndex) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

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
    } else {
      print('Không có ảnh nào được chọn.');
    }
  }

  Future<void> _initializeImageLabeling(int imageIndex) async {
    if (imageIndex == 1) {
      await _processImageLabels(_image1, labels1);
    } else if (imageIndex == 2) {
      await _processImageLabels(_image2, labels2);
    }
  }

  Future<void> _processImageLabels(File? imageFile, List<ImageLabel> labels) async {
    if (imageFile == null) {
      print('Không có ảnh nào được chọn');
      return;
    }

    final ImageLabeler labeler = GoogleMlKit.vision.imageLabeler();
    final inputImage = InputImage.fromFilePath(imageFile.path);

    try {
      final List<ImageLabel> detectedLabels = await labeler.processImage(inputImage);
      setState(() {
        labels.clear();
        labels.addAll(detectedLabels);
      });
    } catch (e) {
      print("Error during image labeling: $e");
    } finally {
      await labeler.close();
    }
  }

  void _compareImages() {
    if (labels1.isEmpty || labels2.isEmpty) {
      print('Vui lòng chọn 2 ảnh');
      return;
    }

    final Set<String> labelsSet1 = labels1.map((label) => label.label).toSet();
    final Set<String> labelsSet2 = labels2.map((label) => label.label).toSet();

    final Set<String> commonLabels = labelsSet1.intersection(labelsSet2);
    final double similarityPercentage =
        (commonLabels.length / labelsSet1.union(labelsSet2).length) * 100;

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
}
