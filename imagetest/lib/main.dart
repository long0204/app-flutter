import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
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
  //  img.Image image1 = img.Image(0, 0); 
  // img.Image image2 = img.Image(0, 0);
  File? _image1;
  File? _image2;

  Future<void> _getImageFromSource(ImageSource source, int imageIndex) async {
    final image = await ImagePicker().getImage(source: source);
    if (image != null) {
      setState(() {
        switch (imageIndex) {
          case 1:
            _image1 = File(image.path);
            break;
          case 2:
            _image2 = File(image.path);
            break;
        }
      });
    } else {
      print('Hủy chọn hình ảnh.');
    }
  }

  double _calculateSimilarity() {
    img.Image? img1 = _decodeImage(_image1);
    img.Image? img2 = _decodeImage(_image2);

    if (img1 == null || img2 == null) {
      // Xử lý lỗi, có thể hiển thị một thông báo cho người dùng.
      print('Lỗi giải mã hình ảnh.');
      return 0.0;
    }
    List<int> histogram1 = calculateHistogram(img1);
    List<int> histogram2 = calculateHistogram(img2);
    print("ANH $histogram1");
    print("ANH $histogram2");
    // Tính toán độ tương đồng sử dụng histogram
    double similarity = compareHistograms(histogram1, histogram2,img1,img2);

    return similarity;
  }
  List<int> calculateHistogram(img.Image image) {
    List<int> histogram = List.filled(256, 0);
    print("ANH $image ${image.height}");
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        int pixel = image.getPixel(x, y);
        int intensity = img.getGreen(pixel); // Use green channel for simplicity
        histogram[intensity]++;
      }
    }

    return histogram;
  }

  double compareHistograms(List<int> histogram1, List<int> histogram2,img.Image image1,img.Image image2) {
    double sum = 0;
    print("BBBBBB $histogram1");
    print("BBBBBB $histogram2");
    for (int i = 0; i < histogram1.length; i++) {
      sum += min(histogram1[i], histogram2[i]);
      
    }
    print("SUM     $sum");
    print("I!*I2    ${image1.width * image1.height}");
    double similarity = sum / (image1.width * image1.height);

    return similarity*100;
  }

  img.Image? _decodeImage(File? file) {
    try {
      return file != null ? img.decodeImage(file.readAsBytesSync()) : null;
    } catch (e) {
      print('Lỗi giải mã hình ảnh: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('So sánh hình ảnh'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= 2; i++)
              _imageWidget(i),
            SizedBox(height: 20.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 1; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await _getImageFromSource(ImageSource.gallery, i);
                        },
                        child: Text('Chọn ảnh'),
                      ),
                    ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                       await _getImageFromSource(ImageSource.gallery, 2);
                    },
                    child: Text('Chọn ảnh'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                double similarity = _calculateSimilarity();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Tương đồng hình ảnh'),
                      content: Text('Hình ảnh tương đồng $similarity%.'),
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
              },
              child: Text('So sánh hình ảnh'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageWidget(int index) {
    File? image;
    if (index == 1) {
      image = _image1;
    } else {
      image = _image2;
    }

    return image == null
        ? Text('Chọn một hình ảnh.')
        : Image.file(
            image,
            height: 200.0,
          );
  }
}
