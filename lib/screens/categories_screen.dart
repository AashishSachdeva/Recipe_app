import 'package:flutter/material.dart';
import 'package:meals_app/widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 20,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
        ),
        children: [
          ...dummyCategories
              .map(
                (data) => CategoryItem(
                  id: data.id,
                  title: data.title,
                  color: data.color,
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
