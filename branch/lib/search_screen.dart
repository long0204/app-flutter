import 'package:branch/search_bloc.dart';
import 'package:branch/search_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CreateNewScreen.dart';
import 'DetailScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<District> districtList = [
    District(
      districtCode: "10101",
      provinceCode: "101",
      districtName: "Quận Ba Đình",
      flagActive: "1",
    ),
    District(
      districtCode: "10103",
      provinceCode: "101",
      districtName: "Quận Tây Hồ",
      flagActive: "1",
    ),
    District(
      districtCode: "10105",
      provinceCode: "101",
      districtName: "Quận Hoàn Kiếm",
      flagActive: "1",
    ),
    District(
      districtCode: "10106",
      provinceCode: "101",
      districtName: "Quận Long Biên",
      flagActive: "1",
    ),
  ];

  List<Province> provinceList = [
    Province(
      provinceCode: "101",
      provinceName: "Thành phố Hà Nội",
      flagActive: "1",
    ),
    Province(
      provinceCode: "103",
      provinceName: "TP Hải Phòng",
      flagActive: "1",
    ),
    Province(
      provinceCode: "107",
      provinceName: "Tỉnh Hải Dương",
      flagActive: "1",
    ),
     Province(
      provinceCode: "109",
      provinceName: "Tỉnh Hưng Yên",
      flagActive: "1",
    ),
    Province(
      provinceCode: "111",
      provinceName: "Tỉnh Hà Nam",
      flagActive: "1",
    ),
    Province(
      provinceCode: "113",
      provinceName: "Tỉnh Nam Định",
      flagActive: "1",
    ),
     Province(
      provinceCode: "115",
      provinceName: "Tỉnh Thái Bình",
      flagActive: "1",
    ),
    Province(
      provinceCode: "117",
      provinceName: "Tỉnh Ninh Bình",
      flagActive: "1",
    ),
    Province(
      provinceCode: "201",
      provinceName: "Tỉnh Hà Giang",
      flagActive: "1",
    ),
     Province(
      provinceCode: "203",
      provinceName: "Tỉnh Cao Bằng",
      flagActive: "1",
    ),
    // Add more provinces as needed
  ];

  List<bool> selectedItems = [];

  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  bool isStatusChecked = false;
  bool isviewChecked = false;
  String selectedProvince = "0";

  @override
  void initState() {
    super.initState();
    selectedItems = List<bool>.filled(districtList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Mã tỉnh'),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedProvince,
                    items: getProvinceItems(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProvince = newValue ?? '';
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Text('Mã huyện'),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: districtController,
                    decoration: InputDecoration(labelText: 'Huyện'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Expanded(
                  child:  CheckboxListTile(
                  title: Text('Trạng thái'),
                  value: isStatusChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isStatusChecked = value ?? false;
                      statusController.text = isStatusChecked ? '1' : '0';
                    });
                  },
                ),
                ),
                Expanded(
                  child:  CheckboxListTile(
                  title: Text('View'),
                  value: isviewChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isviewChecked = value ?? false;
                      //statusController.text = isStatusChecked ? '1' : '0';
                    });
                  },
                ),
                ),
              ],
            ),
           
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      // Navigate to CreateNewScreen and wait for the result
                      final List<District>? updatedList = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNewScreen(
                            provinceList: provinceList,
                            districtList: districtList,
                          ),
                        ),
                      );

                      // Check if the result is not null and update the list
                      if (updatedList != null) {
                        // Dispatch the event to update the district list in SearchBloc
                        BlocProvider.of<SearchBloc>(context).add(
                          UpdateDistrictList(updatedList: updatedList),
                        );
                         BlocProvider.of<SearchBloc>(context).add(
                          SearchButtonPressed(
                            province: selectedProvince,
                            district: districtController.text,
                            status: statusController.text,
                          ),
                        );
                         selectedItems = List<bool>.filled(updatedList.length, false);
                      }
                    },
                    child: Text('Tạo mới'),
                  ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SearchBloc>(context).add(
                      SearchButtonPressed(
                        province: selectedProvince,
                        district: districtController.text,
                        status: statusController.text,
                      ),
                    );
                  },
                  child: Text('Tìm kiếm'),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    deleteSelectedItems();
                  },
                  child: Text('Xóa'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return CircularProgressIndicator();
                } else if (state is SearchSuccess) {
                  return buildSearchResults(districtList);
                } else if (state is SearchFailure) {
                  return Text('Error: ${state.error}');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getProvinceItems() {
    List<Map<String, String>> sampleProvinces = [
      {"ProvinceCode": "0","ProvinceName": "Tất cả","FlagActive": "1"},
      {
        "ProvinceCode": "101",
        "ProvinceName": "Thành phố Hà Nội",
        "FlagActive": "1"
      },
      { "ProvinceCode": "103", "ProvinceName": "TP Hải Phòng", "FlagActive": "1" },
      {
        "ProvinceCode": "107",
        "ProvinceName": "Tỉnh Hải Dương",
        "FlagActive": "1"
      },
      { "ProvinceCode": "109", "ProvinceName": "Tỉnh Hưng Yên", "FlagActive": "1" },
      { "ProvinceCode": "111", "ProvinceName": "Tỉnh Hà Nam", "FlagActive": "1" },
      { "ProvinceCode": "113", "ProvinceName": "Tỉnh Nam Định", "FlagActive": "1" },
      {
        "ProvinceCode": "115",
        "ProvinceName": "Tỉnh Thái Bình",
        "FlagActive": "1"
      },
      {
        "ProvinceCode": "117",
        "ProvinceName": "Tỉnh Ninh Bình",
        "FlagActive": "1"
      },
      { "ProvinceCode": "201", "ProvinceName": "Tỉnh Hà Giang", "FlagActive": "1" },
      { "ProvinceCode": "203", "ProvinceName": "Tỉnh Cao Bằng", "FlagActive": "1" }
    ];
    return sampleProvinces.map((province) {
      return DropdownMenuItem<String>(
        value: province["ProvinceCode"] ?? '',
        child: province["ProvinceCode"] =="0" ? Text(" ${province["ProvinceName"] ?? ''}"): Text("${province["ProvinceCode"] ?? ''} - ${province["ProvinceName"] ?? ''}"),
      );
    }).toList();
  }

  Widget buildSearchResults(List<District> searchResults) {
    if (isviewChecked) {
      // Display list view
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final district = searchResults[index];
            return Card(
              child: ListTile(
                title: Row(
                  children: [
                    Checkbox(
                      value: selectedItems.length > index ? selectedItems[index] : false,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedItems[index] = value ?? false;
                        });
                      },
                    ),
                    Text(district.districtName),
                  ],
                ),
                subtitle: Text('Province: ${district.provinceCode}, Status: ${district.flagActive}'),
                onTap: () async {
                  final List<District>? updatedList = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(districtCode: district, provinceList: provinceList, districtList: districtList,),
                    ),
                  );

                  if (updatedList != null) {
                    // Dispatch the event to update the district list in SearchBloc
                    BlocProvider.of<SearchBloc>(context).add(
                      UpdateDistrictList(updatedList: updatedList),
                    );
                    BlocProvider.of<SearchBloc>(context).add(
                      SearchButtonPressed(
                        province: selectedProvince,
                        district: districtController.text,
                        status: statusController.text,
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      );
    } else {
    // Display scrollable table view
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Số thứ tự')),
          DataColumn(label: Text('Mã huyện')),
          DataColumn(label: Text('Tên huyện')),
          DataColumn(label: Text('Mã tỉnh')),
          DataColumn(label: Text('Trạng thái')),
        ],
        rows: List<DataRow>.generate(
          searchResults.length,
          (index) => DataRow(
            cells: [
              DataCell(Text((index + 1).toString())),
              DataCell(Text(searchResults[index].districtCode)),
              DataCell(Text(searchResults[index].districtName)),
              DataCell(Text(searchResults[index].provinceCode)),
              DataCell(Text('${searchResults[index].flagActive =='1'? 'Active':'InActive'}')),
            ],
          ),
        ),
      ),
    );
  }
}
  void deleteSelectedItems() {

    List<District> itemsToDelete = [];

    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        itemsToDelete.add(districtList[i]);
      }
    }

    districtList.removeWhere((district) => itemsToDelete.contains(district));

    selectedItems = List<bool>.generate(districtList.length, (index) => false);

    BlocProvider.of<SearchBloc>(context).add(
      UpdateDistrictList(updatedList: districtList),
    );

    BlocProvider.of<SearchBloc>(context).add(
    SearchButtonPressed(
      province: selectedProvince,
      district: districtController.text,
      status: statusController.text,
    ),
  );
  }

}
