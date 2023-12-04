import 'package:appbooking/Detail/Review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, String> hotel;
  List<Map<String, String>> listService = [
    {"Servicecode": "SC001", "SeviceName": "Low cost"},
    {"Servicecode": "SC001", "SeviceName": "Paking"},
    {"Servicecode": "SC001", "SeviceName": "Party"},
    {"Servicecode": "SC001", "SeviceName": "Theater"},
    {"Servicecode": "SC001", "SeviceName": "Bar"},
    {"Servicecode": "SC001", "SeviceName": "Pool"},
    {"Servicecode": "SC001", "SeviceName": "Spa"},
    {"Servicecode": "SC001", "SeviceName": "Game"},
    {"Servicecode": "SC002", "SeviceName": "Low cost"},
    {"Servicecode": "SC002", "SeviceName": "Party"},
    {"Servicecode": "SC002", "SeviceName": "Theater"},
    {"Servicecode": "SC002", "SeviceName": "Spa"}
  ];

  DetailScreen({required this.hotel});

  IconData _getIconData(String? iconName) {
    switch (iconName) {
      case 'Low cost':
        return Icons.attach_money;
      case 'Paking':
        return Icons.local_parking;
      case 'Party':
        return Icons.party_mode;
      case 'Theater':
        return Icons.theater_comedy;
      case 'Bar':
        return Icons.local_bar;
      case 'Pool':
        return Icons.pool;
      case 'Spa':
        return Icons.spa;
      case 'Game':
        return Icons.games;
      default:
        return Icons.pool;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: _buildDetailContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: hotel['Imagecode'] != null
            ? Image.asset(
                'assets/images/${hotel['Imagecode']!}.jpg',
                fit: BoxFit.cover,
              )
            : Container(),
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hotel['Honame'] ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            hotel['Address'] ?? '',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Text(
                'Rating',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ ${hotel['Price']}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text("${hotel['Rate']}"),
                  RatingBar(
                    initialRating: double.parse(hotel['Rate'] ?? '0'),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.0,
                    ratingWidget: RatingWidget(
                      full: Icon(Icons.star, color: Colors.amber),
                      half: Icon(Icons.star_half, color: Colors.amber),
                      empty: Icon(Icons.star_border, color: Colors.amber),
                    ),
                    onRatingUpdate: (rating) {
                      // Điều chỉnh rating nếu cần
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),
          _buildServiceButtons(),
          SizedBox(height: 16.0),
          Text(
            'About',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          Text(
            hotel['Des'] ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Chuyển sang màn hình đánh giá
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReviewScreen(hotel: hotel,listService: listService,)),
              );
            },
            child: Text('Review'),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceButtons() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: listService.map((service) {
        bool isSelected = hotel['Sercode'] == service['Servicecode'];
        if(isSelected){
        return ElevatedButton.icon(
          onPressed: () {
            // Xử lý khi nút được nhấn
          },
          style: ElevatedButton.styleFrom(
            primary: isSelected ? Colors.white : null,
          ),
          icon: Icon(_getIconData(service['SeviceName'])),
          label: Text(service['SeviceName'] ?? ''),
        );
        }
        else{return SizedBox();}
      }).toList(),
    );
  }
}
