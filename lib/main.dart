import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';
import 'package:meal/screens/CategoryMealScreen.dart';
import 'package:meal/screens/FilterScreen.dart';
import 'package:meal/screens/mealDetailScreen.dart';
import './screens/CategoriesScreen.dart';
import './screens/TabsScreen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0)
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id==id);
  }
  void _setFilters(Map<String, bool> _filterData) {
    setState(() {
      _filters = _filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        ;
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        ;
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        ;
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        ;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                headline4: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealScreen.routName: (context) =>
            CategoryMealScreen(_availableMeals),
        MealDetailScreen.routName: (context) => MealDetailScreen(_isMealFavorite,_toggleFavorite),
        FilterScreen.routName: (context) => FilterScreen(_filters, _setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
      ),
      body: CategoriesScreen(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
