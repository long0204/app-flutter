import 'package:cookify/HomeScreen/product_detail_screen.dart';
import 'package:cookify/bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesBloc(selectedCategory),
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return Scaffold(
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
                              onChanged: (query) {
                                context.read<CategoriesBloc>().add(CategorySelected(query));
                              },
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
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChoiceChip(
                          label: Column(
                            children: [
                              Icon(
                                _getIconData(categories[index]["Catename"]),
                                color: Colors.white,
                              ),
                              SizedBox(height: 4),
                              Text(
                                categories[index]["Catename"]!,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          selected: categories[index]["Catecode"] == state.selectedCategory,
                          onSelected: (selected) {
                            onCategorySelected(categories[index]["Catecode"]!);
                          },
                          backgroundColor: Colors.blue,
                          selectedColor: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var product in products)
                          if (product["Catecode"] == state.selectedCategory || state.selectedCategory == "ALL")
                            ListTile(
                              title: Text(
                                product["Productname"]!,
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'images/${product["Imagecode"]}.jpg',
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Calories: ${product["Calories"]} | "
                                    "Carbo: ${product["Carbo"]} | "
                                    "Protein: ${product["Protein"]}",
                                  ),
                                ],
                              ),
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
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
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
}
