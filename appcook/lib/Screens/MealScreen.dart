import 'package:appcook/Screens/ProductDetailScreen.dart';
import 'package:flutter/material.dart';

class MealScreen extends StatefulWidget {
  final List<Map<String, String>> products;

  MealScreen({required this.products});

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  late String selectedDay;
  int totalVA = 0;
  int totalVB = 0;
  int totalWA = 0;
  @override
  void initState() {
    super.initState();
    selectedDay = 'Mon'; // Ngày mặc định
    calculateTotalVA(); 
    calculateTotalVB();
    calculateTotalWA();
  }
     List<Map<String, dynamic>> dailyInfo = [
          {
        "Day": "Mon",
        "Bfcode": "CFSL001",
        "Luchcode": "CFSL003",
        "Snackcode": "CFSL005",
        "Dinnercode": "CFSL002",
        "Bftime": "6:30",
        "Lunchtime": "6:30",
        "Snacktime": "6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Tue",
       "Bfcode": "CFSL001",
        "Luchcode": "CFSL002",
        "Snackcode": "CFSL003",
        "Dinnercode": "CFSL004",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Wed",
      "Bfcode": "CFSL005",
        "Luchcode": "CFSL006",
        "Snackcode": "CFSL007",
        "Dinnercode": "CFSL008",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Thu",
       "Bfcode": "CFSL008",
        "Luchcode": "CFSL005",
        "Snackcode": "CFSL002",
        "Dinnercode": "CFSL004",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Fri",
        "Bfcode": "CFSL007",
        "Luchcode": "CFSL008",
        "Snackcode": "CFSL001",
        "Dinnercode": "CFSL003",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Sat",
       "Bfcode": "CFSL008",
        "Luchcode": "CFSL004",
        "Snackcode": "CFSL006",
        "Dinnercode": "CFSL002",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      },
      {
        "Day":"Sun",
       "Bfcode": "CFSL001",
        "Luchcode": "CFSL005",
        "Snackcode": "CFSL007",
        "Dinnercode": "CFSL005",
        "Bftime":"6:30",
        "Lunchtime":"6:30",
        "Snacktime":"6:30",
        "Dinnertime": "6:30"
      } 
    ];

    void calculateTotalVA() {
    // Reset totalVA
    totalVA = 0;

    // Lọc danh sách theo ngày được chọn
    List<Map<String, dynamic>> selectedDayInfo = dailyInfo
        .where((info) => info['Day'].toLowerCase() == selectedDay.toLowerCase())
        .toList();

    selectedDayInfo.forEach((info) {
      // Look up the 'VA' value from the product list based on 'Bfcode'
      Map<String, dynamic>? productInfoA = widget.products
          .firstWhere((product) => product['Productcode'] == info['Bfcode']);
       Map<String, dynamic>? productInfoB = widget.products
          .firstWhere((product) => product['Productcode'] == info['Luchcode']);
           Map<String, dynamic>? productInfoC = widget.products
          .firstWhere((product) => product['Productcode'] == info['Snackcode']);
           Map<String, dynamic>? productInfoD = widget.products
          .firstWhere((product) => product['Productcode'] == info['Dinnercode']);
      // If a matching product is found, add its 'VA' value to the total
      totalVA += int.tryParse(productInfoA['VA'] ?? '0') ?? 0 + 0;
      totalVA += int.tryParse(productInfoB['VA'] ?? '0') ?? 0 + 0;
      totalVA += int.tryParse(productInfoC['VA'] ?? '0') ?? 0 + 0;
      totalVA += int.tryParse(productInfoD['VA'] ?? '0') ?? 0 + 0;
        });
  }
    void calculateTotalVB() {
    // Reset totalVA
    totalVB = 0;

    // Lọc danh sách theo ngày được chọn
    List<Map<String, dynamic>> selectedDayInfo = dailyInfo
        .where((info) => info['Day'].toLowerCase() == selectedDay.toLowerCase())
        .toList();

    selectedDayInfo.forEach((info) {
      // Look up the 'VA' value from the product list based on 'Bfcode'
      Map<String, dynamic>? productInfoA = widget.products
          .firstWhere((product) => product['Productcode'] == info['Bfcode']);
       Map<String, dynamic>? productInfoB = widget.products
          .firstWhere((product) => product['Productcode'] == info['Luchcode']);
           Map<String, dynamic>? productInfoC = widget.products
          .firstWhere((product) => product['Productcode'] == info['Snackcode']);
           Map<String, dynamic>? productInfoD = widget.products
          .firstWhere((product) => product['Productcode'] == info['Dinnercode']);
      // If a matching product is found, add its 'VA' value to the total
      totalVB += int.tryParse(productInfoA['VB'] ?? '0') ?? 0 + 0;
      totalVB += int.tryParse(productInfoB['VB'] ?? '0') ?? 0 + 0;
      totalVB += int.tryParse(productInfoC['VB'] ?? '0') ?? 0 + 0;
      totalVB += int.tryParse(productInfoD['VB'] ?? '0') ?? 0 + 0;
        });
  }
    void calculateTotalWA() {
    // Reset totalVA
    totalWA = 0;

    // Lọc danh sách theo ngày được chọn
    List<Map<String, dynamic>> selectedDayInfo = dailyInfo
        .where((info) => info['Day'].toLowerCase() == selectedDay.toLowerCase())
        .toList();

    selectedDayInfo.forEach((info) {
      // Look up the 'VA' value from the product list based on 'Bfcode'
      Map<String, dynamic>? productInfoA = widget.products
          .firstWhere((product) => product['Productcode'] == info['Bfcode']);
       Map<String, dynamic>? productInfoB = widget.products
          .firstWhere((product) => product['Productcode'] == info['Luchcode']);
           Map<String, dynamic>? productInfoC = widget.products
          .firstWhere((product) => product['Productcode'] == info['Snackcode']);
           Map<String, dynamic>? productInfoD = widget.products
          .firstWhere((product) => product['Productcode'] == info['Dinnercode']);
      // If a matching product is found, add its 'VA' value to the total
      totalWA += int.tryParse(productInfoA['WA'] ?? '0') ?? 0 + 0;
      totalWA += int.tryParse(productInfoB['WA'] ?? '0') ?? 0 + 0;
      totalWA += int.tryParse(productInfoC['WA'] ?? '0') ?? 0 + 0;
      totalWA += int.tryParse(productInfoD['WA'] ?? '0') ?? 0 + 0;
        });
  }

  Widget _buildNutrientInfo(String nutrientName, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nutrientName,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildMealButton(String mealName, String code, String calories) {
    Map<String, dynamic>? selectedMealInfo = widget.products
        .firstWhere((info) => info['Productcode'] == code);

    // ignore: unnecessary_null_comparison
    if (selectedMealInfo != null) {
      String productName = selectedMealInfo['Productname'] ?? '';
      String imageCode = selectedMealInfo['Imagecode'] ?? '';

      return Container(
        height: 60,
        width: 400,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  product: selectedMealInfo.cast<String, String>(),
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, 
          ),
          child: Row(
            children: [
              Image.asset(
                'images/$imageCode.jpg',
                height: 70,
                width: 70,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' $productName',
                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    ' Time: $calories',
                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Spacer(),
              Text('->'),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildMealList() {

    // Lọc danh sách theo ngày được chọn
    List<Map<String, dynamic>> selectedDayInfo = dailyInfo
        .where((info) => info['Day'].toLowerCase() == selectedDay.toLowerCase())
        .toList();

    // Hiển thị danh sách
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: selectedDayInfo.map((info) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Breakfast',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              children: [
                _buildMealButton('Breakfast', info['Bfcode'], info['Bftime']),
              ],
            ),
            Text(
              'Lunch',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              children: [
                _buildMealButton('Lunch', info['Luchcode'], info['Lunchtime']),
              ],
            ),
            Text(
              'Snacks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              children: [
                _buildMealButton('Snacks', info['Snackcode'], info['Snacktime']),
              ],
            ),
            Text(
              'Dinner',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              children: [
                _buildMealButton('Dinner', info['Dinnercode'], info['Dinnertime']),
              ],
            ),
            SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) {
      return CircularProgressIndicator(); // hoặc hiển thị thông báo lỗi
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 66),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Today's Plan",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                final currentDate = DateTime.now().add(Duration(days: index));
                final dayName = _getDayAbbreviation(currentDate.weekday);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = dayName;
                      calculateTotalVA(); 
                      calculateTotalVB();
                      calculateTotalWA();
                    });
                  },
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: selectedDay == dayName
                          ? Color.fromARGB(255, 250, 166, 166) // Màu nền khi được chọn
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${currentDate.day}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('$dayName')
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          // Box vitamin & mineral
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 166, 166),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Vitamin & Mineral',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.redAccent),
                ),
                Text(
                  'How much you should take?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,color: Colors.black),
                ),
                Row(
                    children: [
                SizedBox(height: 56,width: 30,),
                _buildNutrientInfo('$totalVA','Vitamin A'), 
                SizedBox(height: 56,width: 50,),
                _buildNutrientInfo('$totalVB','Vitamin B'),
                SizedBox(height: 56,width: 50,),
                _buildNutrientInfo( '$totalWA','Water'),
              ],),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Danh sách bữa ăn
          Expanded(
            child: _buildMealList(),
          ),
        ],
      ),
    );
  }

  String _getDayAbbreviation(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
}
