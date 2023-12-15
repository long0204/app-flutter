import 'package:cookify/bloc/product_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc(),
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          return _buildScreen(context, state);
        },
      ),
    );
  }

  Widget _buildScreen(BuildContext context, ProductDetailState state) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.01),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.redAccent),
            onPressed: () {
              // Handle heart icon tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 66),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product["Productname"]!,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Nutritions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 180,
                        child: _buildNutritionInfo(),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 190,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/${product["Imagecode"]}.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Ingredients',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildRichText(product["Ingredients"]),
              SizedBox(height: 8),
              Text(
                'Preparation',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildRichText(product["Preparation"]),
              SizedBox(height: 8),
              _buildVideoButton(context, 'https://www.youtube.com/watch?v=psDseYqhYME&ab_channel=TheReviewer'),
            ],
          ),
        ),
      ),
    );
  }

      Widget _buildNutritionInfo() {
        return Container(
                        width: 200,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          //borderRadius: BorderRadius.circular(30),
                          //color: Color.fromARGB(255, 15, 14, 14),
                        ),
                        child: Center(
                          child:
                          Column(
                            children: [
                              //Calories
                              Container(
                                width: 150,
                                height: 55,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color.fromARGB(255, 250, 166, 166),
                                ),
                                child: Center(
                                  child: 
                                   Row(
                                    children: [
                                      // Thông tin Calories
                                            SizedBox(width: 10),
                                            Container(
                                              width: 40,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.redAccent,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${product["Calories"]}",
                                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                          //Text 
                                        Column(
                                           children: [
                                            SizedBox(height: 10,),
                                         Text(
                                              'Calories',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ), 
                                             SizedBox(height: 6,),
                                            Text(
                                              'Kcal',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                           ]
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 6),
                              Container(
                                width: 150,
                                height: 55,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color.fromARGB(255, 250, 166, 166),
                                ),
                                child: Center(
                                  child: 
                                   Row(
                                    children: [
                                      // Thông tin Calories
                                            SizedBox(width: 10),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.greenAccent,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${product["Carbo"]}",
                                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                          //Text 
                                        Column(
                                           children: [
                                            SizedBox(height: 10,),
                                         Text(
                                              'Carbo',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ), 
                                             SizedBox(height: 6,),
                                            Text(
                                              'g',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                           ]
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 6),
                              Container(
                                width: 150,
                                height: 55,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color.fromARGB(255, 250, 166, 166),
                                ),
                                child: Center(
                                  child: 
                                   Row(
                                    children: [
                                      // Thông tin Calories
                                            SizedBox(width: 10),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blueAccent,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${product["Protein"]}",
                                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                          //Text 
                                        Column(
                                           children: [
                                            SizedBox(height: 10,),
                                         Text(
                                              'Protein',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ), 
                                             SizedBox(height: 4,),
                                            Text(
                                              'g',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                           ]
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );        
  }

  Widget _buildRichText(String? text) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14, color: Colors.black),
        children: text?.split(',').map<TextSpan>((ingredient) {
          return TextSpan(
            text: '$ingredient\n',
            style: TextStyle(fontWeight: FontWeight.w400),
          );
        }).toList() ?? [],
      ),
    );
  }

  Widget _buildVideoButton(BuildContext context, String videoUrl) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          context.read<ProductDetailBloc>().add(OpenVideoEvent(videoUrl));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.red,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.play_circle_filled,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                'Xem Video',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
