import 'package:appbooking/Home/HomeWidget.dart';
import 'package:appbooking/Home/MapWidget.dart';
import 'package:appbooking/Home/ProfileWidget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String accountName;
  final String accountEmail;

  HomeScreen({required this.accountName, required this.accountEmail});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> holtel =[
    {
        "Hocode": "CF001",
        "Honame": "Wartennal",
        "Address": "Mỹ Đình",
        "Rate": "4.4",
        "Price": "400",
        "Sercode": "SC001",
        "Imagecode": "city1",
        "Day":"1",
        "Percount":"1",
        "x":"21.022890",
        "y":"105.774146",
        "Des":"The commercial center and supermarket area is also very large, up to 230,000m², and divided into 2 basements and 2 floors. In the entertainment area of ​​the center, there is the largest ice rink in Vietnam with an area of ​​3,000m². The center is built into an underground parking system with an area of ​​more than 300,000m².The apartment complex in Royal City Hanoi is a miniature picture of a European city, giving residents the feeling of living in a real royal city. The apartment complex is located in 6 buildings, R1, R2, R3, R4, R5, R6"
    },
    {
        "Hocode": "CF002",
        "Honame": "Home 2",
        "Address": "Thanh Xuân ,Hà Nội",
        "Rate": "4.1",
        "Price": "400",
        "Sercode": "SC002",
         "Imagecode": "city2",
        "Day":"1",
        "Percount":"1",
        "x":"21.005706",
        "y":"105.809706",
        "Des":"The commercial center and supermarket area is also very large, up to 230,000m², and divided into 2 basements and 2 floors. In the entertainment area of ​​the center, there is the largest ice rink in Vietnam with an area of ​​3,000m². The center is built into an underground parking system with an area of ​​more than 300,000m².The apartment complex in Royal City Hanoi is a miniature picture of a European city, giving residents the feeling of living in a real royal city. The apartment complex is located in 6 buildings, R1, R2, R3, R4, R5, R6"
    
    },
    {
        "Hocode": "CF003",
        "Honame": "The Golden Palm",
        "Address": "Thanh Xuân, Hà Nội",
        "Rate": "4.6",
        "Price": "400",
        "Sercode": "SC001",
         "Imagecode": "city3",
        "Day":"1",
        "Percount":"1",
        "x":"21.006498",
        "y":"105.806805",  
        "Des":"The commercial center and supermarket area is also very large, up to 230,000m², and divided into 2 basements and 2 floors. In the entertainment area of ​​the center, there is the largest ice rink in Vietnam with an area of ​​3,000m². The center is built into an underground parking system with an area of ​​more than 300,000m².The apartment complex in Royal City Hanoi is a miniature picture of a European city, giving residents the feeling of living in a real royal city. The apartment complex is located in 6 buildings, R1, R2, R3, R4, R5, R6"
    
    },
    {
        "Hocode": "CF004",
        "Honame": "Royal city",
        "Address": "Thanh Xuân, Hà Nội",
        "Rate": "5",
        "Price": "400",
        "Sercode": "SC002",
         "Imagecode": "city4",
        "Day":"1",
        "Percount":"1",
        "x":"21.001307",
        "y":"105.816850", 
        "Des":"The commercial center and supermarket area is also very large, up to 230,000m², and divided into 2 basements and 2 floors. In the entertainment area of ​​the center, there is the largest ice rink in Vietnam with an area of ​​3,000m². The center is built into an underground parking system with an area of ​​more than 300,000m².The apartment complex in Royal City Hanoi is a miniature picture of a European city, giving residents the feeling of living in a real royal city. The apartment complex is located in 6 buildings, R1, R2, R3, R4, R5, R6"
     
    },
    {
        "Hocode": "CF005",
        "Honame": "Chung Cư 29T1 Hoàng Đạo Thúy",
        "Address": "Cầu Giấy, Hà Nội",
        "Rate": "4.7",
        "Price": "400",
        "Sercode": "SC002",
         "Imagecode": "city5",
        "Day":"1",
        "Percount":"1",
        "x":"21.007718",
        "y":"105.801481",
        "Des":"The commercial center and supermarket area is also very large, up to 230,000m², and divided into 2 basements and 2 floors. In the entertainment area of ​​the center, there is the largest ice rink in Vietnam with an area of ​​3,000m². The center is built into an underground parking system with an area of ​​more than 300,000m².The apartment complex in Royal City Hanoi is a miniature picture of a European city, giving residents the feeling of living in a real royal city. The apartment complex is located in 6 buildings, R1, R2, R3, R4, R5, R6"
      
    },
    {
        "Hocode": "CF006",
        "Honame": "Sunny Hotel II",
        "Address": "Cầu Giấy, Hà Nội",
        "Rate": "3.0",
        "Price": "500",
        "Sercode": "SC001",
         "Imagecode": "city5",
        "Day":"1",
        "Percount":"1",
        "x":"21.010411",
        "y":"105.805950", 
        "Des":"The commercial center and supermarket area is also very large, up to 230,000m², and divided into 2 basements and 2 floors. In the entertainment area of ​​the center, there is the largest ice rink in Vietnam with an area of ​​3,000m². The center is built into an underground parking system with an area of ​​more than 300,000m².The apartment complex in Royal City Hanoi is a miniature picture of a European city, giving residents the feeling of living in a real royal city. The apartment complex is located in 6 buildings, R1, R2, R3, R4, R5, R6"
     
    },
    {
        "Hocode": "CF007",
        "Honame": "Vincom Center Trần Duy Hưng",
        "Address": "Cầu Giấy, Hà Nội",
        "Rate": "4.1",
        "Price": "490",
        "Sercode": "SC002",
        "Imagecode": "city5",
        "Day":"1",
        "Percount":"1",
        "x":"21.006960",
        "y":"105.795239", 
        "Des":"The commercial center and supermarket area is also very large, up to 230,000m², and divided into 2 basements and 2 floors. In the entertainment area of ​​the center, there is the largest ice rink in Vietnam with an area of ​​3,000m². The center is built into an underground parking system with an area of ​​more than 300,000m².The apartment complex in Royal City Hanoi is a miniature picture of a European city, giving residents the feeling of living in a real royal city. The apartment complex is located in 6 buildings, R1, R2, R3, R4, R5, R6" 
    }
];
  List<Map<String, String>> bookedHotels = [];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(_currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        buttonBackgroundColor: Colors.blue,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.map, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return HomeWidget(
          accountName: widget.accountName,
          accountEmail: widget.accountEmail,
          hotelList: holtel,
          bookedHotels: bookedHotels,
        );
      case 1:
        return MapWidget(
          accountName: widget.accountName,
          accountEmail: widget.accountEmail,
          hotelList: holtel,
        );
      case 2:
        return ProfileWidget(
          accountName: widget.accountName,
          accountEmail: widget.accountEmail,
          bookedHotels: bookedHotels,
        );
      default:
        return Container(); // Trả về một widget mặc định nếu index không hợp lệ
    }
  }
}