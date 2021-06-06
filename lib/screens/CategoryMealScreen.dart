import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import '../widgets/MealItem.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routName = 'categoryMeal';
  final List<Meal>availableMeals;
CategoryMealScreen(this.availableMeals);
  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayMeal;

  void _removeMeal(String mealId) {
    setState(() {
      displayMeal.removeWhere((meal) => meal.id == mealId);
    });
  }
@override
  void didChangeDependencies() {
  final routArg =
  ModalRoute.of(context).settings.arguments as Map<String, String>;
  final categoryId = routArg['id'];
  categoryTitle = routArg['title'];
  displayMeal = widget.availableMeals
      .where((meal) => meal.categories.contains(categoryId))
      .toList();
    super.didChangeDependencies();
  }
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
          itemCount: displayMeal.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayMeal[index].id,
              title: displayMeal[index].title,
              imageUrl: displayMeal[index].imageUrl,
              duration: displayMeal[index].duration,
              complexity: displayMeal[index].complexity,
              affordability: displayMeal[index].affordability,
            );
          }),
    );
  }
}
