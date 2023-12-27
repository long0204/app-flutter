import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/app_bloc.dart';
import 'Screens/contract_management_page.dart';
import 'Screens/ecore_page.dart';
import 'Screens/hrm_page.dart';
import 'Screens/qcontract_page.dart';
import 'Screens/report_page.dart';
import 'Screens/work_page.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.android),
            title: Text("QCONTRACT",style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.green,
            actions: [
              IconButton(
                icon: Icon(Icons.message,color: Colors.white,),
                onPressed: () {
                  // Xử lý khi ấn nút messenger
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications,color: Colors.white,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContractManagementPage(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.account_circle,color: Colors.white,),
                onPressed: () {
                  // Xử lý khi ấn nút account
                },
              ),
            ],
          ),
          body: IndexedStack(
            index: currentIndex,
            children: [
              QcontractPage(),
              WorkPage(),
              ReportPage(),
              ECorePage(),
              HRMPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            //backgroundColor: Colors.green,
            currentIndex: currentIndex,
            onTap: (index) =>
                context.read<AppBloc>().add(index), // Add index to the Bloc
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.green,
                label: 'Work',
                icon: Icon(Icons.work),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.green,
                label: 'Qcontract',
                icon: Icon(Icons.business),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.green,
                label: 'Report',
                icon: Icon(Icons.bar_chart),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.green,
                label: 'eCore',
                icon: Icon(Icons.layers),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.green,
                label: 'HRM',
                icon: Icon(Icons.people),
              ),
            ],
            selectedLabelStyle: TextStyle(color: Colors.red), // Màu chữ khi được chọn
            unselectedLabelStyle: TextStyle(color: Colors.grey), // Màu chữ khi không được chọn
          ),
        );
      },
    );
  }
}
