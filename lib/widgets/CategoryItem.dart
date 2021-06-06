import 'package:flutter/material.dart';
import 'package:meal/screens/CategoryMealScreen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  selectScreen(BuildContext cntx) {
    Navigator.of(cntx).pushNamed(CategoryMealScreen.routName, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectScreen(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            color.withOpacity(0.4),
            color,
          ]),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
