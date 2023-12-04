import 'package:flutter/material.dart';
import 'package:appcook/Screens/ProductDetailScreen.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Map<String, String>> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final List<Map<String, String>> products;

  CategoriesScreen({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.products,
  });

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late List<Map<String, String>> filteredProducts;

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = widget.products
          .where((product) =>
              product["Productcode"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  IconData _getIconData(String? iconName) {
  switch (iconName) {
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
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Categories'),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        onChanged: _filterProducts,
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                     label: Column(
                          children: [
                            Icon(
                                _getIconData(widget.categories[index]["Catename"]),
                                color: Colors.white, // Màu sắc của biểu tượng
                              ),
                            SizedBox(height: 4), // Khoảng cách giữa biểu tượng và văn bản
                            Text(
                              widget.categories[index]["Catename"]!,
                              style: TextStyle(
                                color: Colors.white, // Màu sắc của văn bản
                              ),
                            ),
                          ],
                        ),
                      selected: widget.categories[index]["Catecode"] == widget.selectedCategory,
                      onSelected: (selected) {
                        widget.onCategorySelected(widget.categories[index]["Catecode"]!);
                      },
                      backgroundColor: Colors.blue, // Change the background color
                      selectedColor: Colors.red, // Change the background color when selected
                    ),
                  );
                },
              ),
            ),

          // Display the list of filtered products
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var product in filteredProducts)
                    if (product["Catecode"] == widget.selectedCategory || widget.selectedCategory == "ALL")
                      ListTile(
                        title: Text(product["Productname"]!,style: TextStyle(fontSize: 30,fontWeight:FontWeight.w900),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'images/${product["Imagecode"]}.jpg', 
                              width: double.infinity,
                              height: 200, // Set the height as needed
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 8), // Adjust the spacing between image and text
                            Text(
                              "Calories: ${product["Calories"]} | "
                              "Carbo: ${product["Carbo"]} | "
                              "Protein: ${product["Protein"]}",
                            ),
                          ],
                        ),
                        onTap: () {
                          // Navigate to ProductDetailScreen when a product is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                              ),
                            ),
                          );
                        },
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
