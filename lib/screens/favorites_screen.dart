import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isEmpty
        ? Center(
            child: Text('No favorites added yet!'),
          )
        : Container(
            // height: 300,
            child: ListView.builder(
              itemCount: favoriteMeals.length,
              itemBuilder: (ctx, index) {
                return MealItem(
                  id: favoriteMeals[index].id,
                  imageUrl: favoriteMeals[index].imageUrl,
                  title: favoriteMeals[index].title,
                  duration: favoriteMeals[index].duration,
                  affordability: favoriteMeals[index].affordability,
                  complexity: favoriteMeals[index].complexity,
                );
              },
            ),
          );
  }
}
