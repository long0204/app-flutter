import 'package:flutter/material.dart';

import '../Screens/contract_management_page.dart';

class GeneralInfoPage extends StatelessWidget {
  final Contract contract;
  final List<ContractChannel> contractChannel;
  final List<ContractChannelOTP> contractChannelOTP;

  GeneralInfoPage({required this.contract ,required this.contractChannel, required this.contractChannelOTP});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child:  Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${contract.contractName}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mã tra cứu:',style: TextStyle(color: Colors.grey),),
                      //SizedBox(width: 16,),
                      Text('${contract.contractCode}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20),
                          color: contract.ContractStatus == 'PENDING'
                              ? Colors.deepOrangeAccent
                              : Colors.green,
                        ),
                        child: Text(
                          contract.ContractStatus == 'PENDING'
                              ? 'Đang xử lý'
                              : 'Chưa ký',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Số HĐ/TL:',style: TextStyle(color: Colors.grey),),
                      SizedBox(width: 16,),
                      Text('${contract.contractNo}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ngày HĐ/TL:',style: TextStyle(color: Colors.grey),),
                      SizedBox(width: 16,),
                      Text('${contract.ContractDateUTC}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mẫu HĐ/TL:',style: TextStyle(color: Colors.grey),),
                      SizedBox(width: 16,),
                      Text('${contract.TContracName}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ghi chú:',style: TextStyle(color: Colors.grey),),
                      SizedBox(width: 16,),
                      Text('${contract.Remark}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('HĐ/TL tham chiếu:',style: TextStyle(color: Colors.grey),),
                      SizedBox(width: 16,),
                      Text('---',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Kênh gửi HĐ/TL:',style: TextStyle(color: Colors.grey),),
                      SizedBox(width: 16,),
                      Container(
                        child:
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20),
                                color:Colors.lightGreen[100],
                              ),
                              child: Text(
                                '${contractChannel[0].ChannelType}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),
                              ),
                            ),
                            Icon(Icons.schedule,color: Colors.green,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Kênh gửi OTP:',style: TextStyle(color: Colors.grey),),
                      SizedBox(width: 16,),
                      Container(
                        child: 
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20),
                                color:Colors.lightGreen[100],
                              ),
                              child: Text(
                                '${contractChannelOTP[0].ChannelTypeOTP}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),
                              ),
                            ),
                            Icon(Icons.schedule,color: Colors.green,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('File HĐ/TL:',style: TextStyle(color: Colors.grey),),
                      SizedBox(width: 16,),
                      Container(
                        width: 220,
                        height: 40,
                        child: Text('${contract.ContractFilePath}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
           Card(
              child: Container(
                width: double.infinity,
                height: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tài liệu tham chiếu:',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

