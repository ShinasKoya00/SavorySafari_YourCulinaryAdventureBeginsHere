import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
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
  List recipeCategoryList = [
    {
      "imgUrl":
          "https://img.freepik.com/free-photo/healthy-homemade-meal-beef-curry-with-naan-generated-by-ai_188544-41071.jpg",
      "heading": "Paneer"
    },
    {
      "imgUrl":
          "https://img.freepik.com/free-photo/closeup-shot-deliciously-prepared-chicken-served-with-onions-chili-sauce_181624-61705.jpg",
      "heading": "Grills"
    },
    {
      "imgUrl":
          "https://img.freepik.com/free-photo/freshly-baked-bread-rustic-table-ready-eat-generated-by-artificial-intelligence_188544-126941.jpg",
      "heading": "Bread"
    },
  ];

  Future<void> getRecipe(String query) async {
    try {
      String url =
          "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=fbf9d0ca&app_key=1d93f048220627e517dec9b9915a937e";
      final response = await get(Uri.parse(url)).timeout(
        Duration(seconds: 10),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<RecipeModel> loadedRecipes = [];
        data["hits"].forEach((element) {
          RecipeModel recipeModel = RecipeModel.fromMap(element["recipe"]);
          loadedRecipes.add(recipeModel);
        });
        setState(() {
          recipeList = loadedRecipes;
        });
        print(data.toString());
      } else {
        log('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      log('Failed to load recipes: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipe('ladoo');
  }

  void _searchRecipe() {
    if (searchController.text.trim().isEmpty) {
      print("Blank search");
    } else {
      getRecipe(searchController.text);
      Future.delayed(Duration(seconds: 3), () {
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
                          GestureDetector(
                            onTap: _searchRecipe,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                              child: Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
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
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        scrollDirection: Axis.horizontal,
                        itemCount: recipeCategoryList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: InkWell(
                              onTap: () {
                                print("section [$index] clicked");
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      recipeCategoryList[index]["imgUrl"],
                                      fit: BoxFit.cover,
                                      height: height,
                                      width: width,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        color: Colors.black54,
                                        child: Text(
                                          recipeCategoryList[index]["heading"],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recipeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print("card [$index] clicked");
                          },
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
                                    fit: BoxFit.fitWidth,
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
                                  height: 30,
                                  width: 80,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.local_fire_department,
                                          size: 18,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          recipeList[index].appCalories.toStringAsFixed(2),
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
