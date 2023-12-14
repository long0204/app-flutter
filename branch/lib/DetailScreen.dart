import 'package:branch/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'detail_bloc.dart';

class DetailScreen extends StatefulWidget {
  final List<Province> provinceList;
  final List<District> districtList;
  final District districtCode;

  DetailScreen({required this.districtCode,required this.provinceList, required this.districtList});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late TextEditingController provinceCodeController;
  late TextEditingController districtCodeController;
  late TextEditingController districtNameController;
  late bool isStatusChecked;

  @override
  void initState() {
    super.initState();

    provinceCodeController =
        TextEditingController(text: widget.districtCode.provinceCode);
    districtCodeController =
        TextEditingController(text: widget.districtCode.districtCode);
    districtNameController =
        TextEditingController(text: widget.districtCode.districtName);
    isStatusChecked = widget.districtCode.flagActive == '1';

    BlocProvider.of<DetailBloc>(context)
        .add(LoadDetail(widget.districtCode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết'),
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailInitial) {
            return buildLoading();
          } else if (state is DetailLoaded) {
            return buildDetail(state.district);
          } else if (state is DetailError) {
            return buildFailure(state.error);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildDetail(District district) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDisabledField('Mã tỉnh', provinceCodeController),
          buildDisabledField('Tên tỉnh', TextEditingController(
              text: 'Tên tỉnh')), 
          buildDisabledField('Mã huyện', districtCodeController),
          buildEditableField('Tên huyện', districtNameController),
          buildStatusCheckbox('Trạng thái', isStatusChecked),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Call the update function with the updated values
              updateDistrict(
                provinceCodeController.text,
                districtCodeController.text,
                districtNameController.text,
                isStatusChecked ? '1' : '0',
              );
            },
            child: Text('Cập nhật'),
          ),
        ],
      ),
    );
  }

  Widget buildFailure(String error) {
    return Center(
      child: Text('Error: $error'),
    );
  }

  Widget buildDisabledField(String label, TextEditingController controller) {
    return TextFormField(
      enabled: false,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  Widget buildStatusCheckbox(String label, bool value) {
    return Row(
      children: [
        Text(label),
        Checkbox(
          value: value,
          onChanged: (bool? newValue) {
            setState(() {
              isStatusChecked = newValue ?? false;
            });
          },
        ),
      ],
    );
  }

  void updateDistrict(String provinceCode, String districtCode, String districtName, String flagActive) {
  // Create an instance of the updated district
  District updatedDistrict = District(
    districtCode: districtCode,
    provinceCode: provinceCode, // Replace with the actual updated province code
    districtName: districtName,
    flagActive: flagActive,
  );

  // Find the index of the district to be updated in the list
  int index = -1;
    for (int i = 0; i < widget.districtList.length; i++) {
      if (widget.districtList[i].districtCode == districtCode) {
        index = i;
        break;
      }
    }
  
  print("Mã huyện $districtCode");
  print("Chi nhánh $index");
  // Update the district in the list if it exists
  if (index != -1) {
    setState(() {
      widget.districtList[index] = updatedDistrict;
    });
  }
  for(int i=0;i <widget.districtList.length;i++)
  print("điểm $i : ${widget.districtList[i].districtName}");
  // Pop the DetailScreen and pass back the updated district
  Navigator.pop(context, widget.districtList);
}

}
