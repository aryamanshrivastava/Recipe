// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:recepi/views/widgets/recepie_card.dart';

import '../models/recepi.dart';
import '../models/recepi_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> recipes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    recipes = await RecipeApi.getRecipe();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Food Recepies'),
            ],
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: recipes.length,
                itemBuilder: ((context, index) {
                  return RecipeCard(
                    // title: recipes[index].name,
                    cookTime: recipes[index].totalTime,
                    rating: recipes[index].rating.toString(),
                    thumbnailUrl: recipes[index].images, title: '',
                  );
                })));
  }
}
