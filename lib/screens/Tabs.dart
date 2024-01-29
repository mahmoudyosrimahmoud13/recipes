import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipes/models/meals.dart';
import 'package:recipes/screens/categories_screen.dart';
import 'package:recipes/screens/filters_screen.dart';
import 'package:recipes/screens/meals_screen.dart';
import 'package:recipes/widgets/main_drwer.dart';
import '../providers/meals_providers.dart';
import '../providers/Favorites_provider.dart';
import '../providers/filters-provider.dart';

const kinitialFilters = {
  Filter.lactoseFree: false,
  Filter.glutenFree: false,
  Filter.vegan: false,
  Filter.vegeterian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  Map<Filter, bool> _selectedFilters = {
    Filter.lactoseFree: false,
    Filter.glutenFree: false,
    Filter.vegan: false,
    Filter.vegeterian: false,
  };

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identfier) async {
    Navigator.pop(context);

    if (identfier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => FiltersScreen()));
      setState(() {
        final activeFilter = ref.watch(filterProvider)._selectedFilters =
            result ?? kinitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final _availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.vegeterian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: _availableMeals,
    );
    String activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Favoraites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_rounded), label: 'Meals'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded), label: 'Fav\'s')
        ],
        onTap: (index) => _selectedPage(index),
      ),
    );
  }
}
