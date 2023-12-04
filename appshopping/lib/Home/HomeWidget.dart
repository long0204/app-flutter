import 'package:appshopping/Detail/Detail.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  final String accountName;
  final String accountEmail;
  final String selectedCategory;
  final List<Map<String, String>> products;
  final List<Map<String, String>> categories;
  final Function(String) onCategorySelected;

  HomeWidget({
    required this.accountName,
    required this.accountEmail,
    required this.selectedCategory,
    required this.products,
    required this.categories,
    required this.onCategorySelected
  });

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String searchQuery = "";
  String selectedCategory = "ALL";

  IconData _getIconData(String? categoryName) {
    switch (categoryName) {
      case 'Fastfood':
        return Icons.fastfood;
      case 'Pizza':
        return Icons.local_pizza;
      case 'Cake':
        return Icons.cake;
      case 'SeaFood':
        return Icons.set_meal;
      case 'Drink':
        return Icons.local_bar;
      case 'Salad':
        return Icons.grass;
      case 'Rice':
        return Icons.rice_bowl;
      case 'Beef':
        return Icons.brunch_dining;
      case 'Noodles':
        return Icons.ramen_dining;
      case 'Chicken':
        return Icons.fastfood;
      default:
        return Icons.food_bank;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredProducts = widget.products
        .where((product) =>
            product["Productname"]!.toLowerCase().contains(searchQuery.toLowerCase()) &&
            (selectedCategory == "ALL" || product["Catecode"] == selectedCategory))
        .toList();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0), // Điều chỉnh giá trị theo mong muốn
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.categories.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 8.0);
              },
              itemBuilder: (context, index) {
                String catename = widget.categories[index]["Catename"]!;
                String catecode = widget.categories[index]["Catecode"]!;

                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = catecode;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedCategory == catecode ? Colors.green : Colors.blueAccent,
                  ),
                  child: Row(
                    children: [
                      Icon(_getIconData(catename), color: Colors.white),
                      SizedBox(width: 8.0),
                      Text(catename, style: TextStyle(color: Colors.black)),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var product in filteredProducts)
                    if (product["Catecode"] == widget.selectedCategory || widget.selectedCategory == "ALL")
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  product: product,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/${product["Imagecode"]}.jpg',
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product["Productname"]!,
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


