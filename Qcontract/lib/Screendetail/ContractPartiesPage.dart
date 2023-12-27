import 'package:flutter/material.dart';

import '../Screens/contract_management_page.dart';

class ContractPartiesPage extends StatelessWidget {
  final Contract contract;
  final List<ContractUser> contractuser;
  final List<ContractParty> contractparty;
  final List<ContractChannel> contractchannel;
  final List<ContractChannelOTP> contractchannelotp;

  ContractPartiesPage(
      {required this.contract,
        required this.contractuser,
        required this.contractparty,
        required this.contractchannel,
        required this.contractchannelotp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: contractparty.length,
              itemBuilder: (context, index) {
                final party = contractparty[index];
                final matchingUsers = contractuser
                    .where((user) =>
                user.PartyCode == party.PartyCode)
                    .toList();
                return

                  Card(
                  child: ListTile(
                    title:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${party.CustomerName}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('MST/CCCD',style: TextStyle(color: Colors.grey,fontSize: 12  ),),
                            Text(
                              ' ${party.MST}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16,),
                        Text('Người ký',style: TextStyle(fontSize: 11,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    subtitle:
                    Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${party.RepresentName}',
                                style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                              Container(
                                //height: 24,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(20),
                                  color: matchingUsers[0].UserSignSatus == 'PENDING'
                                      ? Colors.deepOrangeAccent
                                      : Colors.blue,
                                ),
                                child: Text(
                                  matchingUsers[0].UserSignSatus == 'PENDING'
                                      ? 'Chưa ký'
                                      : 'Đã ký',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text('Email: ',style: TextStyle(color: Colors.grey),)
                                    ,
                                    Text(
                                      '${party.CustomerEmail}',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                //height: 24,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(20),
                                  color: matchingUsers[0].FlagSendUser == '0'
                                      ? Colors.deepOrangeAccent
                                      : Colors.blue,
                                ),
                                child: Text(
                                  matchingUsers[0].FlagSendUser == '0'
                                      ? 'Chưa gửi'
                                      : 'Dã gửi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child:
                                Row(
                                  children: [
                                    Text('SĐT: ',style: TextStyle(color: Colors.grey),)
                                    ,
                                    Text(
                                      '${party.CustomerPhoneNo}',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child:
                                Row(
                                  children: [
                                    Text('Zalo: ',style: TextStyle(color: Colors.grey),)
                                    ,
                                    Text(
                                      matchingUsers[0].UserZalo==''?'---':matchingUsers[0].UserZalo,
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child:
                                Row(
                                  children: [
                                    Text('',style: TextStyle(color: Colors.grey),)

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )

                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
