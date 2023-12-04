// home_widget.dart
import 'package:appbooking/Detail/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeWidget extends StatefulWidget {
  final String accountName;
  final String accountEmail;
  final List<Map<String, String>> hotelList;
  final List<Map<String, String>> bookedHotels;

  HomeWidget({required this.accountName, required this.accountEmail, required this.hotelList,required this.bookedHotels});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String searchText = '';
   //List<Map<String, String>> bookedHotels = [];
   void bookHotel(Map<String, String> hotel) {
      // Check if the hotel is already booked
      bool isAlreadyBooked = widget.bookedHotels.any((bookedHotel) {
        return bookedHotel['Hocode'] == hotel['Hocode'];
      });

      if (isAlreadyBooked) {
        // Show a message or handle the case when the hotel is already booked
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Hotel is already booked!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Get the current date in "dd/MMM" format
        String currentDate = DateFormat('dd/MMM').format(DateTime.now());
        String toDate = DateFormat('dd/MMM').format(DateTime.now().add(const Duration(days: 2)));
        // Add the hotel to the bookedHotels list with the current date
        widget.bookedHotels.add({
          "Hocode": hotel["Hocode"] ?? "",
          "Honame": hotel["Honame"] ?? "",
          "Checkin": currentDate,
          "Checkout": toDate, // Adjust as needed
          "Percount": "2",
          "Price": hotel["Price"] ?? "",
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('Hotel booked!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  @override
  Widget build(BuildContext context) {
    return _BackgroundWidget(
      child: Column(
        children: [
          SizedBox(height: 16),
          _buildSearchBox(),
          SizedBox(height: 16),
          Expanded(
            child: _buildHotelList(),
          ),
        ],
      ),
      backgroundImage: 'assets/images/bg.jpg',
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search by hotel name...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildHotelList() {
    final filteredHotels = widget.hotelList.where((hotel) {
      final honame = hotel['Honame'] ?? '';
      return honame.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredHotels.length,
      itemBuilder: (context, index) {
        return _buildHotelItem(filteredHotels[index]);
      },
    );
  }

  Widget _buildHotelItem(Map<String, String> hotel) {
    final imageCode = hotel['Imagecode'] ?? 'default'; // 'default' is a fallback image code
    final imageUrl = 'assets/images/$imageCode.jpg'; // Assuming your images have '.jpg' extension

    return
    GestureDetector(
      onTap: () {
        // Chuyển sang màn hình chi tiết khi ấn vào phần tử khách sạn
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(hotel: hotel),
          ),
        );
      },
    child: Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageUrl,
            width: double.infinity,
            height: 120, // Adjust the height as needed
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hotel['Honame'] ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Text(
                '\$${hotel['Price'] ?? ''}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.black, size: 16.0),
                  SizedBox(width: 4.0),
                  Text(
                    hotel['Address'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                   bookHotel(hotel);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150, 40), // Adjust the size as needed
                  primary: Colors.blueAccent, // Change the color to green
                ),
                child: Text(
                  'Book',
                  style: TextStyle(fontSize: 18,color: Colors.white), // Adjust the font size as needed
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.black, size: 16.0),
              SizedBox(width: 4.0),
              Text(
                "${hotel['Rate'] ?? ''} Ratings",
                style: TextStyle(
                   fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    ),);
  }

}
class _BackgroundWidget extends StatelessWidget {
  final Widget child;
  final String backgroundImage;

  _BackgroundWidget({required this.child, required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          backgroundImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.white.withOpacity(0.7),
          width: double.infinity,
          height: double.infinity,
          child: child,
        ),
      ],
    );
  }
}
