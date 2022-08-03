import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import 'screens/meals_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'isGlutenFree': false,
    'isLactoseFree': false,
    'isVegan': false,
    'isVegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  void _toogleFavorites(String mealId) {
    final favoriteIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    setState(
      () {
        if (favoriteIndex >= 0) {
          favoriteMeals.removeAt(favoriteIndex);
        } else {
          favoriteMeals.add(
            DUMMY_MEALS.firstWhere((meal) => mealId == meal.id),
          );
        }
      },
    );
  }

  bool _isFavorite(String mealId) {
    return favoriteMeals.any((meal) => mealId == meal.id);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['isGlutenFree'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['isVegan'] as bool && !meal.isVegan) {
          return false;
        }
        if (_filters['isLactoseFree'] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['isVegetarian'] as bool && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
    print(availableMeals[0].title);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      //
      initialRoute: './',
      routes: {
        './': (context) => TabBarScreen(favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(availableMeals),
        MealDetailsScreen.routeName: (context) =>
            MealDetailsScreen(favoriteMeals, _toogleFavorites, _isFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_setFilters, _filters),
      },
    );
  }
}
