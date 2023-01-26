import 'dart:convert';

import 'recepi.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https(
        'yummly2.p.rapidapi.com', '/feeds/list', {'limit': '24', 'start': '0'});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "46ff7e1f27msh40f354641c46b71p1314aajsn75549f695ee3",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    if (response.body.isNotEmpty) {
      var data = jsonDecode(response.body);
      List temp = [];
      for (var i in data['feed']) {
        temp.add(i['content']['details']);
      }

      return Recipe.recipesFromSnapshot(temp);
    } else {
      return [];
    }
  }
}
