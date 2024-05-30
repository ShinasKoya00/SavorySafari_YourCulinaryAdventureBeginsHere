import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/recipe_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

  void getRecipe(String query) async {
    String url =
        "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=28fad840&app_key=6bee9f39c7e7fb1c016093972a23984b";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // print(data);
    // log(data.toString());

    data["hits"].forEach((element) {
      RecipeModel recipeModel = RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      // log(recipeList.toString());
    });
    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
    });
  }

  @override
  void initState() {
    getRecipe(searchController.text);
    super.initState();
  }

  void _searchRecipe() {
    if (searchController.text.trim().isEmpty) {
      print("Blank search");
    } else {
      getRecipe(searchController.text);
      Future.delayed(Duration(seconds: 5), () {
        searchController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade100,
                  Colors.deepPurple.shade500,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                            child: Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Let's cook something",
                              ),
                              onSubmitted: (value) {
                                _searchRecipe();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "WHAT DO YOU WANT TO COOK TODAY?",
                        style: TextStyle(fontSize: 33, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Let's Cook Something New!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: recipeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                margin: EdgeInsets.only(top: 20),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        recipeList[index].appimgUrl,
                                        fit: BoxFit.cover,
                                        height: 220,
                                        width: width,
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.black38,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: Text(
                                          recipeList[index].applabel,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Text(recipeList[index].appCalories.toString().substring(0, 5)))
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
