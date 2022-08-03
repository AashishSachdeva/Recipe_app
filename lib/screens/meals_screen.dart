import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/Category-Meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late final List<Meal> categoryMeals;
  late final categoryTitle;
  bool didLoaded = false;
  @override
  void didChangeDependencies() {
    if (!didLoaded) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'] as String;
      categoryTitle = routeArgs['title'] as String;
      categoryMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      didLoaded = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(mealId) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Container(
        // height: 300,
        child: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              id: categoryMeals[index].id,
              imageUrl: categoryMeals[index].imageUrl,
              title: categoryMeals[index].title,
              duration: categoryMeals[index].duration,
              affordability: categoryMeals[index].affordability,
              complexity: categoryMeals[index].complexity,
              // removeMeal: _removeMeal,
            );
          },
        ),
      ),
    );
  }
}
