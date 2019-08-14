import 'package:flutter/material.dart';
import 'package:recipes_app/dummy_data.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  // To set a default list of meals
  List<Meal> _availableMeals = DUMMY_MEALS;

  // Called inside the filters_screen
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData; 
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/', 
      routes: {   // Sets up named routes
        '/': (ctx) => TabsScreen(), // sets Home
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },
      // Below - Gets called if a named route is sent but doesn't exist. Settings allows access to the intended route like if settings.name == '' to return different route pages. Can also be usefule for dynamically generated pages.
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      // Below - Gets called if Flutter fails to build a screen with all measures, it's a last resort and can be used to show an error instead of a crash. Kind of like a 404 page error
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
