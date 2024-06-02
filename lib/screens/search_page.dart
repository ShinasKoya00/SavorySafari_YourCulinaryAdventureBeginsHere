import 'dart:convert';
import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/screens/recipe_details.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/widgets/bookMarkState.dart';
import 'package:savory_safari/widgets/container_shadow_box.dart';
import 'package:savory_safari/widgets/my_text.dart';
import 'package:savory_safari/widgets/time_and_ingredients_text.dart';

class SearchPage extends StatefulWidget {
  final String query;

  const SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

  Future<void> getRecipe(String query) async {
    try {
      String url =
          "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=fbf9d0ca&app_key=1d93f048220627e517dec9b9915a937e";
      final response = await get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<RecipeModel> loadedRecipes = [];
        data["hits"].forEach((element) {
          RecipeModel recipeModel = RecipeModel.fromMap(element["recipe"]);
          loadedRecipes.add(recipeModel);
        });
        setState(() {
          _isLoading = false;
          recipeList = loadedRecipes;
        });
        log(data.toString());
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
    getRecipe(widget.query);
  }

  void _searchRecipe(String query) {
    query = query.trim();
    if (query.isEmpty) {
      log("Blank search");
    } else {
      log("search pressed");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SearchPage(query: query)),
      );
      Timer(const Duration(seconds: 10), () {
        searchController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.homePageGrey,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: width,
          child: Column(
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 55,
                      width: width * 0.725,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: "Let's cook something...",
                                hintStyle: TextStyle(color: Colors.grey.shade400),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (inputValue) {
                                _searchRecipe(inputValue);
                              },
                            ),
                          ),
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 22,
                            color: Colors.grey.shade700,
                          ),
                        ],
                      ),
                    ),
                    ContainerShadowBox(
                      height: 55,
                      width: 55,
                      margin: const EdgeInsets.only(top: 15),
                      borderRadius: BorderRadius.circular(18),
                      imageAsset: "assets/icons/more_2.png",
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: MyText(text: "Suitable recipe for ${widget.query}"),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipeList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => ContainerShadowBox(
                      onTap: () {
                        log("search box pressed");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipeDetails(
                                      recipe: recipeList[index],
                                    )));
                      },
                      height: 120,
                      width: width,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      child: Row(
                        children: [
                          ContainerShadowBox(
                            width: 90,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image.network(
                                recipeList[index].appimgUrl,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width - 200,
                                child: Text(
                                  recipeList[index].applabel,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                width: width - 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TimeAndIngredientsText(
                                      ingredientsCount: recipeList[index].appIngredients,
                                      hoursCount: recipeList[index].appPrepTime,
                                      fontColor: Colors.grey.shade600,
                                      fontColorBold: Colors.grey.shade800,
                                      fontSize: 15,
                                      heightBetweenRows: 4,
                                    ),
                                    Bookmarkstate(

                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
