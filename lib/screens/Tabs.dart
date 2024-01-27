import 'package:flutter/material.dart';
import 'package:recipes/screens/categories_screen.dart';
import 'package:recipes/screens/meal_data_screen.dart';
import 'package:recipes/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();
    String activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePage = const MealsScreen(meals: []);
      activePageTitle = 'Favoraites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.set_meal_rounded), label: 'Meals'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded), label: 'Fav\'s')
        ],
        onTap: (index) => _selectedPage(index),
      ),
    );
  }
}
