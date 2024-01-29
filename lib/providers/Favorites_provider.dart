import 'package:recipes/models/meals.dart';
import 'package:riverpod/riverpod.dart';

class FavoritMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritMealsNotifier() : super([]);
//give data to super
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => meal.id != m.id).toList();
      return false;
    }
    if (!mealIsFavorite) {
      state = [...state, meal];
      return true;
    }
    return true;
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritMealsNotifier, List<Meal>>((ref) {
  return FavoritMealsNotifier();
});
