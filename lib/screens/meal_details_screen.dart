import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  final List<Meal> favoritMeals;
  final Function toogleFavorites;
  final Function isFavorite;

  MealDetailsScreen(this.favoritMeals, this.toogleFavorites, this.isFavorite);
  static const routeName = '/Meal-Details';
  Widget buildContainer(BuildContext ctx, {required Widget child}) {
    return Container(
      height: 150,
      width: 300,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: child,
    );
  }

  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Text(text, style: Theme.of(ctx).textTheme.headline6);
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final id = routeArgs['id'] as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);
    return Scaffold(
        appBar: AppBar(
          title: Text('Meals details'),
        ),
        //
        floatingActionButton: FloatingActionButton(
          onPressed: () => toogleFavorites(id),
          child: isFavorite(id) ? Icon(Icons.star) : Icon(Icons.star_border),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    '${selectedMeal.imageUrl}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                context,
                child: ListView.builder(
                  itemCount: selectedMeal.ingredients.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                            '${index + 1} )  ${selectedMeal.ingredients[index]}'),
                      ),
                    );
                  },
                ),
              ),
              buildSectionTitle(context, 'Steps'),
              buildContainer(
                context,
                child: ListView.builder(
                  itemCount: selectedMeal.steps.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${index + 1}'),
                          ),
                          title: Text(
                            selectedMeal.steps[index],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
