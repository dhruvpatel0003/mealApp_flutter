import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'models/meal.dart';
import 'screens/category_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal){
            if(_filters['gluten']!&&!meal.isGlutenFree){
              return false;
            }
            if(_filters['lactose']!&&!meal.isLactoseFree){
              return false;
            }
            if(_filters['vegan']!&&!meal.isVegan){
              return false;
            }
            if(_filters['vegetarian']!&&!meal.isVegetarian){
              return false;
            }
            return true;

      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
   final existingIndex =  _favoriteMeals.indexWhere((meal) => meal.id == mealId);
   if(existingIndex>=0){
    setState(() {
      _favoriteMeals.removeAt(existingIndex);
    });
   }else{
     setState(() {
       _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId),);
     });
   }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal)=>meal.id==id);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodArea',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            // bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1),),
            // bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1),),
            titleMedium: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
      // home: MyHomePage(),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        // '/':(ctx) => CategoriesScreen(),
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters,_setFilters),
      },
      // onGenerateRoute:(settings){//execute when click on any unregister route
      //   print("inside onGenerateRoute");
      //   return MaterialPageRoute(builder: (ctx)=>CategoriesScreen(),);
      // },
    );
  }
}
