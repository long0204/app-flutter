import 'package:appshopping/Home/CheckImage.dart';
import 'package:appshopping/Home/HomeWidget.dart';
import 'package:appshopping/Home/Mealscreen.dart';
import 'package:appshopping/Home/Profile.dart';
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
  final List<Map<String, String>> categories = [
    {"Catecode": "ALL", "Catename": "ALL"},
    {"Catecode": "CF001", "Catename": "Fastfood"},
    {"Catecode": "CF002", "Catename": "Pizza"},
    {"Catecode": "CF003", "Catename": "Cake"},
    {"Catecode": "CF004", "Catename": "SeaFood"},
    {"Catecode": "CF005", "Catename": "Drink"},
    {"Catecode": "CF006", "Catename": "Salad"},
    {"Catecode": "CF007", "Catename": "Rice"},
    {"Catecode": "CF008", "Catename": "Chicken"},
    {"Catecode": "CF009", "Catename": "Beef"},
    {"Catecode": "CF010", "Catename": "Noodles"}
  ];

  List<Map<String, String>> products = [
    {
      "Catecode": "CF003",
      "Productcode": "CFSL001",
      "Productname": "Dumplings",
      "Calories": "250",
      "Carbo": "30",
      "Protein": "9",
      "Ingredients": "1 cup all-purpose flour,2 teaspoons baking powder,1 teaspoon white sugar,½ teaspoon salt,1 tablespoon margarine,½ cup milk",
      "Preparation": "1. Chop the prepared Chinese cabbage, then add 1 teaspoon of salt to marinate, about 15 minutes;2. Wash the leeks, and drain the water carefully, then cut all of them into the ends and set aside;3. Boil the pot, start a fire, use pepper and oil, and squeeze some pepper oil;4. Chop and break up the pork, add 1 tablespoon of soy sauce, pour in the pepper oil, and stir well;5. Pour the marinated chopped cabbage and spare leeks together, add salt and sesame oil, and continue to stir evenly.",
      "Imagecode": "dumplings",
    },
    {
      "Catecode": "CF008",
      "Productcode": "CFSL002",
      "Productname": "Butter Chicken",
      "Calories": "200",
      "Carbo": "20",
      "Protein": "5",
      "Ingredients": "1 cup all-purpose flour,2 teaspoons baking powder,1 teaspoon white sugar,½ teaspoon salt,1 tablespoon margarine,½ cup milk",
      "Preparation": "1. Chop the prepared Chinese cabbage, then add 1 teaspoon of salt to marinate, about 15 minutes;2. Wash the leeks, and drain the water carefully, then cut all of them into the ends and set aside;3. Boil the pot, start a fire, use pepper and oil, and squeeze some pepper oil;4. Chop and break up the pork, add 1 tablespoon of soy sauce, pour in the pepper oil, and stir well;5. Pour the marinated chopped cabbage and spare leeks together, add salt and sesame oil, and continue to stir evenly.",
      "Imagecode": "butterchicken",
    },
    {
      "Catecode": "CF009",
      "Productcode": "CFSL003",
      "Productname": "Beaf steak",
      "Calories": "350",
      "Carbo": "40",
      "Protein": "11",
      "Ingredients": "1 cup all-purpose flour,2 teaspoons baking powder,1 teaspoon white sugar,½ teaspoon salt,1 tablespoon margarine,½ cup milk",
      "Preparation": "1. Chop the prepared Chinese cabbage, then add 1 teaspoon of salt to marinate, about 15 minutes;2. Wash the leeks, and drain the water carefully, then cut all of them into the ends and set aside;3. Boil the pot, start a fire, use pepper and oil, and squeeze some pepper oil;4. Chop and break up the pork, add 1 tablespoon of soy sauce, pour in the pepper oil, and stir well;5. Pour the marinated chopped cabbage and spare leeks together, add salt and sesame oil, and continue to stir evenly.",
      "Imagecode": "beafsteak",
    },
    {
      "Catecode": "CF010",
      "Productcode": "CFSL004",
      "Productname": "Ramen noodles",
      "Calories": "350",
      "Carbo": "40",
      "Protein": "11",
      "Ingredients": "1 cup all-purpose flour,2 teaspoons baking powder,1 teaspoon white sugar,½ teaspoon salt,1 tablespoon margarine,½ cup milk",
      "Preparation": "1. Chop the prepared Chinese cabbage, then add 1 teaspoon of salt to marinate, about 15 minutes;2. Wash the leeks, and drain the water carefully, then cut all of them into the ends and set aside;3. Boil the pot, start a fire, use pepper and oil, and squeeze some pepper oil;4. Chop and break up the pork, add 1 tablespoon of soy sauce, pour in the pepper oil, and stir well;5. Pour the marinated chopped cabbage and spare leeks together, add salt and sesame oil, and continue to stir evenly.",
      "Imagecode": "ramennoodles",
    },
    {
      "Catecode": "CF002",
      "Productcode": "CFSL005",
      "Productname": "Mexican pizza",
      "Calories": "350",
      "Carbo": "40",
      "Protein": "11",
      "Ingredients": "1 cup all-purpose flour,2 teaspoons baking powder,1 teaspoon white sugar,½ teaspoon salt,1 tablespoon margarine,½ cup milk",
      "Preparation": "1. Chop the prepared Chinese cabbage, then add 1 teaspoon of salt to marinate, about 15 minutes;2. Wash the leeks, and drain the water carefully, then cut all of them into the ends and set aside;3. Boil the pot, start a fire, use pepper and oil, and squeeze some pepper oil;4. Chop and break up the pork, add 1 tablespoon of soy sauce, pour in the pepper oil, and stir well;5. Pour the marinated chopped cabbage and spare leeks together, add salt and sesame oil, and continue to stir evenly.",
      "Imagecode": "mexicanpizza",
    },
    {
      "Catecode": "CF008",
      "Productcode": "CFSL006",
      "Productname": "Chicken Burger",
      "Calories": "350",
      "Carbo": "40",
      "Protein": "11",
      "Ingredients": "1 cup all-purpose flour,2 teaspoons baking powder,1 teaspoon white sugar,½ teaspoon salt,1 tablespoon margarine,½ cup milk",
      "Preparation": "1. Chop the prepared Chinese cabbage, then add 1 teaspoon of salt to marinate, about 15 minutes;2. Wash the leeks, and drain the water carefully, then cut all of them into the ends and set aside;3. Boil the pot, start a fire, use pepper and oil, and squeeze some pepper oil;4. Chop and break up the pork, add 1 tablespoon of soy sauce, pour in the pepper oil, and stir well;5. Pour the marinated chopped cabbage and spare leeks together, add salt and sesame oil, and continue to stir evenly.",
      "Imagecode": "ChickenBurger",
    },
    {
      "Catecode": "CF003",
      "Productcode": "CFSL007",
      "Productname": "French toast",
      "Calories": "350",
      "Carbo": "40",
      "Protein": "11",
      "Ingredients": "1 cup all-purpose flour,2 teaspoons baking powder,1 teaspoon white sugar,½ teaspoon salt,1 tablespoon margarine,½ cup milk",
      "Preparation": "1. Chop the prepared Chinese cabbage, then add 1 teaspoon of salt to marinate, about 15 minutes;2. Wash the leeks, and drain the water carefully, then cut all of them into the ends and set aside;3. Boil the pot, start a fire, use pepper and oil, and squeeze some pepper oil;4. Chop and break up the pork, add 1 tablespoon of soy sauce, pour in the pepper oil, and stir well;5. Pour the marinated chopped cabbage and spare leeks together, add salt and sesame oil, and continue to stir evenly.",
      "Imagecode": "frenchtoast",
    },
    {
      "Catecode": "CF002",
      "Productcode": "CFSL008",
      "Productname": "Cheese Pizza",
      "Calories": "350",
      "Carbo": "40",
      "Protein": "11",
      "Ingredients": "1 cup all-purpose flour,2 teaspoons baking powder,1 teaspoon white sugar,½ teaspoon salt,1 tablespoon margarine,½ cup milk",
      "Preparation": "1. Chop the prepared Chinese cabbage, then add 1 teaspoon of salt to marinate, about 15 minutes;2. Wash the leeks, and drain the water carefully, then cut all of them into the ends and set aside;3. Boil the pot, start a fire, use pepper and oil, and squeeze some pepper oil;4. Chop and break up the pork, add 1 tablespoon of soy sauce, pour in the pepper oil, and stir well;5. Pour the marinated chopped cabbage and spare leeks together, add salt and sesame oil, and continue to stir evenly.",
      "Imagecode": "Cheese Pizza",
    }
  ];

  String selectedCategory = "ALL"; 
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  void _onCategorySelected(String catecode) {
    setState(() {
      selectedCategory = catecode;
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          // Screen 1 - FirstHomeScreen
          HomeWidget( accountName: widget.accountName,
          accountEmail: widget.accountEmail,products:products,categories: categories,onCategorySelected: _onCategorySelected,selectedCategory:selectedCategory),

          // // Screen 2 - CategoriesScreen
          // CategoriesScreen(
          //   categories: categories,
          //   selectedCategory: selectedCategory,
          //   onCategorySelected: _onCategorySelected,
          //   products: products,
          // ),
          Checkimage(accountName: widget.accountName,accountEmail: widget.accountEmail,products: products),

          // Screen 3 - MealScreen
          MealScreen(products: products),

          // // Screen 4 - ProfileScreen
           ProfileWidget(accountName: widget.accountName,accountEmail: widget.accountEmail,),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        items: <Widget>[
          Icon(Icons.home, size: 40),
          Icon(Icons.menu_book_rounded, size: 30),
          Icon(Icons.fastfood, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
