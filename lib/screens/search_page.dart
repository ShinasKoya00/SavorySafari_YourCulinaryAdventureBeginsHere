import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/screens/recipe_details.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';
import 'package:savory_safari/widgets/bookmark_state.dart';
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
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  bool hasError = false;

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
          recipeList = loadedRecipes;
          isLoading = false;
          hasError = recipeList.isEmpty;
        });
        log(data.toString());
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
        log('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
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
    SizeConfig.init(context); // Initialize SizeConfig

    return Scaffold(
      backgroundColor: MyColors.homePageGrey,
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight,
          margin: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(20)),
          width: SizeConfig.screenWidth,
          child: Column(
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: SizeConfig.getHeight(15)),
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(12)),
                      height: SizeConfig.getHeight(55),
                      width: SizeConfig.screenWidth * 0.725,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(SizeConfig.getRadius(18)),
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
                            size: SizeConfig.getIconSize(22),
                            color: Colors.grey.shade700,
                          ),
                        ],
                      ),
                    ),
                    ContainerShadowBox(
                      height: SizeConfig.getHeight(55),
                      width: SizeConfig.getWidth(55),
                      margin: EdgeInsets.only(top: SizeConfig.getHeight(15)),
                      borderRadius: BorderRadius.circular(SizeConfig.getRadius(18)),
                      imageAsset: "assets/icons/more_2.png",
                    )
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.getHeight(30)),
              Align(
                alignment: Alignment.centerLeft,
                child: MyText(text: "Suitable recipe for ${widget.query}"),
              ),
              SizedBox(height: SizeConfig.getHeight(20)),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : hasError
                        ? const Center(
                            child: Text(
                              "No recipes found for your search.",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: recipeList.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) => ContainerShadowBox(
                              onTap: () {
                                log("search box pressed");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetails(recipe: recipeList[index]),
                                  ),
                                );
                              },
                              height: SizeConfig.getHeight(120),
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.only(bottom: SizeConfig.getHeight(20)),
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.getWidth(18),
                                vertical: SizeConfig.getHeight(15),
                              ),
                              borderRadius: BorderRadius.circular(SizeConfig.getRadius(25)),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  ContainerShadowBox(
                                    width: SizeConfig.getWidth(90),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(SizeConfig.getRadius(13)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(SizeConfig.getRadius(13)),
                                      child: Image.network(
                                        recipeList[index].appimgUrl,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: SizeConfig.getWidth(25)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.getWidth(SizeConfig.screenWidth - 200),
                                        child: Text(
                                          recipeList[index].applabel,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeConfig.getFontSize(28),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: SizeConfig.getHeight(7)),
                                      SizedBox(
                                        width: SizeConfig.getWidth(SizeConfig.screenWidth - 200),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TimeAndIngredientsText(
                                              ingredientsCount: recipeList[index].appIngredients,
                                              hoursCount: recipeList[index].appPrepTime,
                                              fontColor: Colors.grey.shade600,
                                              fontColorBold: Colors.grey.shade800,
                                              fontSize: SizeConfig.getFontSize(15),
                                              heightBetweenRows: SizeConfig.getHeight(4),
                                            ),
                                            const BookmarkState(color: Colors.black),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
