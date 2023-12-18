import 'package:appbooking/Bloc/homewidget_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeWidget extends StatefulWidget {
  final String accountName;
  final String accountEmail;
  final List<Map<String, String>> hotelList;
  final List<Map<String, String>> bookedHotels;

  HomeWidget({required this.accountName, required this.accountEmail, required this.hotelList, required this.bookedHotels});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(widget.bookedHotels),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HotelBookedState) {
            // Show a success message when the hotel is booked
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('Hotel booked!'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is InitialHomeState) {
            // Handle other states if needed
          }
        },
        child: _BackgroundWidget(
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
        ),
      ),
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
      },
    );
  }

  Widget _buildHotelItem(Map<String, String> hotel) {
    final imageCode = hotel['Imagecode'] ?? 'default';
    final imageUrl = 'assets/images/$imageCode.jpg';

    return GestureDetector(
      onTap: () {
        // Chuyển sang màn hình chi tiết khi ấn vào phần tử khách sạn
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailScreen(hotel: hotel),
        //   ),
        // );
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
              height: 120,
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
                    context.read<HomeBloc>().add(BookHotelEvent(hotel));
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 40),
                    primary: Colors.blueAccent,
                  ),
                  child: Text(
                    'Book',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
      ),
    );
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
