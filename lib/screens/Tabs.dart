import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipes/screens/categories_screen.dart';
import 'package:recipes/screens/filters_screen.dart';
import 'package:recipes/screens/meals_screen.dart';
import 'package:recipes/widgets/main_drwer.dart';
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

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identfier) async {
    Navigator.pop(context);

    if (identfier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
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
