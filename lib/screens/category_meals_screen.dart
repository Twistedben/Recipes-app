import "package:flutter/material.dart";

import "../dummy_data.dart";
import "../widgets/meal_item.dart";

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // The information passed to this screen from category_item inkwell navigation, NOT using named routes. The way to do it with named routes is below in widget build.
  // final String categoryId, categoryTitle;
  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    // Below allows the use of the named route and digests the data passed from cetergoy_item Navigator mapped strings.
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(
          categoryId); // .contains() returns true if that contains a specific value
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            affordability: categoryMeals[index].affordability,
            complexity: categoryMeals[index].complexity,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
