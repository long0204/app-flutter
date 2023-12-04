import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;

class Checkimage extends StatefulWidget {
  final String accountName;
  final String accountEmail;
  final List<Map<String, String>> products;

  Checkimage({required this.accountName, required this.accountEmail, required this.products});

  @override
  _CheckimageState createState() => _CheckimageState();
}

class _CheckimageState extends State<Checkimage> {
  File? _image1;
  String? _selectedAssetImage;
  List<String> assetImageNames = [];

  @override
  void initState() {
    super.initState();
    // Lấy danh sách Imagecode từ danh sách sản phẩm
    assetImageNames = widget.products.map((product) => product["Imagecode"]!).toList();
  }

  Future<void> _getImageFromGallery() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image1 = File(image.path);
      });
    } else {
      print('Hủy chọn hình ảnh.');
    }
  }

  Future<void> _selectAssetImage() async {
    String? selectedImage = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Danh sách sản phẩm'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: assetImageNames.length,
              itemBuilder: (BuildContext context, int index) {
                String imageName = assetImageNames[index];
                return ListTile(
                  title: Text(imageName),
                  leading: Image.asset(
                    'assets/images/${imageName}.jpg',
                    width: 50.0, // Điều chỉnh kích thước của hình ảnh
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.pop(context, imageName);
                  },
                );
              },
            ),
          ),
        );
      },
    );
    if (selectedImage != null) {
      setState(() {
        _selectedAssetImage = selectedImage;
      });
      print('Đã chọn ảnh từ danh sách sản phẩm: $_selectedAssetImage');
    } else {
      print('Hủy chọn ảnh từ danh sách sản phẩm.');
    }
  }
  
  Future<void> _compareWithAssetImage() async {
    if (_selectedAssetImage == null) {
      print('Vui lòng chọn ảnh từ danh sách sản phẩm trước.');
      return;
    }

    String assetImagePath = _selectedAssetImage!;
    ByteData data = await rootBundle.load('assets/images/$assetImagePath.jpg');
    List<int> bytes = data.buffer.asUint8List();
    img.Image assetImage = img.decodeImage(Uint8List.fromList(bytes))!;

    double similarity = compareImages(_image1, assetImage);

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
  }

  double compareImages(File? image1, img.Image image2) {
    img.Image? decodedImage1 = _decodeImage(image1);
    if (decodedImage1 == null) {
      print('Lỗi giải mã hình ảnh 1.');
      return 0.0;
    }

    List<int> histogram1 = calculateHistogram(decodedImage1);
    List<int> histogram2 = calculateHistogram(image2);

    double similarity = compareHistograms(histogram1, histogram2, decodedImage1, image2);

    return similarity;
  }

  List<int> calculateHistogram(img.Image image) {
    List<int> histogram = List.filled(256, 0);
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        int pixel = image.getPixel(x, y);
        int intensity = img.getGreen(pixel);
        histogram[intensity]++;
      }
    }

    return histogram;
  }

  double compareHistograms(List<int> histogram1, List<int> histogram2, img.Image image1, img.Image image2) {
    double sum = 0;
    for (int i = 0; i < histogram1.length; i++) {
      sum += (histogram1[i] * histogram2[i]).toDouble();
    }

    double similarity = sum / (image1.width * image1.height * image2.width * image2.height);
    return similarity * 100;
  }

  img.Image? _decodeImage(File? file) {
    try {
      return file != null ? img.decodeImage(file.readAsBytesSync()) : null;
    } catch (e) {
      print('Lỗi giải mã hình ảnh: $e');
      return null;
    }
  }

  Widget _imageWidget() {
    return _image1 == null
        ? Text('Chọn một hình ảnh.')
        : Image.file(
            _image1!,
            height: 200.0,
          );
  }

  Widget _selectedAssetImageWidget() {
    return _selectedAssetImage == null
        ? Text('Chọn ảnh sản phẩm.')
        : Image.asset(
            'assets/images/${_selectedAssetImage}.jpg',
            height: 200.0,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Kiểm tra ảnh'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageWidget(),
            SizedBox(height: 20.0),
            _selectedAssetImageWidget(),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _getImageFromGallery();
                  },
                  child: Text('Ảnh thư viện'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _selectAssetImage();
                  },
                  child: Text('Ảnh Sản phẩm'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await _compareWithAssetImage();
              },
              child: Text('So sánh'),
            ),
          ],
        ),
      ),
    );
  }
}
