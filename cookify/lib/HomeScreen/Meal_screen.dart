import 'package:cookify/HomeScreen/product_detail_screen.dart';
import 'package:cookify/bloc/meal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealScreen extends StatefulWidget {
  final List<Map<String, String>> products;

  MealScreen({required this.products});

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  late MealBloc _mealBloc;
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
      "Day": "Tue",
      "Bfcode": "CFSL001",
      "Luchcode": "CFSL002",
      "Snackcode": "CFSL003",
      "Dinnercode": "CFSL004",
      "Bftime": "6:30",
      "Lunchtime": "6:30",
      "Snacktime": "6:30",
      "Dinnertime": "6:30"
    },
    {
      "Day": "Wed",
      "Bfcode": "CFSL005",
      "Luchcode": "CFSL006",
      "Snackcode": "CFSL007",
      "Dinnercode": "CFSL008",
      "Bftime": "6:30",
      "Lunchtime": "6:30",
      "Snacktime": "6:30",
      "Dinnertime": "6:30"
    },
    {
      "Day": "Thu",
      "Bfcode": "CFSL008",
      "Luchcode": "CFSL005",
      "Snackcode": "CFSL002",
      "Dinnercode": "CFSL004",
      "Bftime": "6:30",
      "Lunchtime": "6:30",
      "Snacktime": "6:30",
      "Dinnertime": "6:30"
    },
    {
      "Day": "Fri",
      "Bfcode": "CFSL007",
      "Luchcode": "CFSL008",
      "Snackcode": "CFSL001",
      "Dinnercode": "CFSL003",
      "Bftime": "6:30",
      "Lunchtime": "6:30",
      "Snacktime": "6:30",
      "Dinnertime": "6:30"
    },
    {
      "Day": "Sat",
      "Bfcode": "CFSL008",
      "Luchcode": "CFSL004",
      "Snackcode": "CFSL006",
      "Dinnercode": "CFSL002",
      "Bftime": "6:30",
      "Lunchtime": "6:30",
      "Snacktime": "6:30",
      "Dinnertime": "6:30"
    },
    {
      "Day": "Sun",
      "Bfcode": "CFSL001",
      "Luchcode": "CFSL005",
      "Snackcode": "CFSL007",
      "Dinnercode": "CFSL005",
      "Bftime": "6:30",
      "Lunchtime": "6:30",
      "Snacktime": "6:30",
      "Dinnertime": "6:30"
    }
  ];

  @override
  void initState() {
    super.initState();
    _mealBloc = MealBloc(products: widget.products);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _mealBloc,
      child: BlocBuilder<MealBloc, MealState>(
        builder: (context, state) {
          return _buildScreen(state);
        },
      ),
    );
  }

  Widget _buildScreen(MealState state) {
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
                    context.read<MealBloc>().add(DaySelected(dayName));
                  },
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: state.selectedDay == dayName
                          ? Color.fromARGB(255, 250, 166, 166)
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
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.redAccent),
                ),
                Text(
                  'How much you should take?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.black),
                ),
                Row(
                  children: [
                    SizedBox(height: 56, width: 30,),
                    _buildNutrientInfo('${state.totalVA}', 'Vitamin A'),
                    SizedBox(height: 56, width: 50,),
                    _buildNutrientInfo('${state.totalVB}', 'Vitamin B'),
                    SizedBox(height: 56, width: 50,),
                    _buildNutrientInfo('${state.totalWA}', 'Water'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildMealList(state),
          ),
        ],
      ),
    );
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
  Map<String, String> selectedMealInfo = widget.products
      .firstWhere(
        (info) => info['Productcode'] == code,
        orElse: () => Map<String, String>.from({}),
      )
      .cast<String, String>();

  if (selectedMealInfo.isNotEmpty) {
    String productName = selectedMealInfo['Productname'] ?? '';
    String imageCode = selectedMealInfo['Imagecode'] ?? '';

    return Container(
      height: 60,
      width: 350,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                product: selectedMealInfo,
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
            //Spacer(),
            //Text('->'),
          ],
        ),
      ),
    );
  } else {
    return Container();
  }
}


  Widget _buildMealList(MealState state) {
    List<Map<String, dynamic>> selectedDayInfo = dailyInfo
        .where((info) => info['Day'].toLowerCase() == state.selectedDay.toLowerCase())
        .toList();

    return ListView.builder(
      itemCount: selectedDayInfo.length,
      itemBuilder: (context, index) {
        final info = selectedDayInfo[index];

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
      },
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
