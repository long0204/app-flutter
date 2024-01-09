import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> selectedItem;

  const DetailScreen({Key? key, required this.selectedItem}) : super(key: key);

  void _copyToClipboard(BuildContext context, String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green[400],
        content: Text('Đã sao chép địa chỉ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin quán', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent[100],
      ),
      body:
        Stack(
          children: [
            Positioned.fill(
              child: Lottie.asset(
                'asset/nhieutim.json',
                fit: BoxFit.cover,
                repeat: true,
                reverse: false,
                animate: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                      child:
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('STT:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('${selectedItem["STT"]}'),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Loại:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('${selectedItem["Loại"]}', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20)),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tên quán: ',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  '${selectedItem["Tên quán"]}',
                                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  _copyToClipboard(context, selectedItem["Tên quán"]);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Địa chỉ: ',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  '${selectedItem["Địa chỉ"]}',
                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  _copyToClipboard(context, selectedItem["Tên quán"] + selectedItem["Địa chỉ"]);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Giá:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('${selectedItem["Giá"]}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16),),
                            ],
                          ),
                        ],
                      )
                    ),],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Lottie.asset(
                    'asset/Food.json',
                    width: 200,
                    height: 300,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ],
              ),
            ),
          ],
      )
    );
  }
}
