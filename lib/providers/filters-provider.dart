import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes/providers/meals_providers.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegeterian,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegeterian: false,
        });
  void setFilters(Map<Filter, bool> chosenFilter) {
    state = chosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegeterian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
