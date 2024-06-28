import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';
import 'package:savory_safari/widgets/container_shadow_box.dart';
import 'package:savory_safari/widgets/hours_dinetype_container.dart';
import 'package:savory_safari/widgets/ingredient_steps_toggle.dart';
import 'package:savory_safari/widgets/total_nutrients_container.dart';

class RecipeDetails extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeDetails({super.key, required this.recipe});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
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
    getRecipe("salad");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    return Scaffold(
        backgroundColor: MyColors.homePageGrey,
        body: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: SizeConfig.screenWidth,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                      image: NetworkImage(widget.recipe.appimgUrl),
                      scale: 0.7,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: SizeConfig.getHeight(60),
                left: SizeConfig.getWidth(25),
                child: ContainerShadowBox(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  height: SizeConfig.getHeight(45),
                  width: SizeConfig.getWidth(45),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                  child: Icon(
                    CupertinoIcons.left_chevron,
                    size: SizeConfig.getIconSize(24),
                  ),
                ),
              ),

              // Details section
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.getWidth(25),
                    right: SizeConfig.getWidth(25),
                    top: SizeConfig.getHeight(30),
                  ),
                  height: SizeConfig.screenHeight * 0.6,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(SizeConfig.getRadius(40)),
                      topLeft: Radius.circular(SizeConfig.getRadius(40)),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: SizeConfig.screenHeight * 0.6,
                          width: SizeConfig.screenWidth,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SingleChildScrollView(
                          child: SizedBox(
                            height: SizeConfig.screenHeight * 0.7,
                            width: SizeConfig.screenWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.getWidth(10),
                                  ),
                                  alignment: Alignment.center,
                                  height: SizeConfig.getHeight(65),
                                  width: SizeConfig.screenWidth,
                                  child: Text(
                                    widget.recipe.applabel,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: SizeConfig.getFontSize(26),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: SizeConfig.getHeight(10)),
                                HoursDineTypeContainer(
                                  width: SizeConfig.screenWidth,
                                  recipe: widget,
                                ),
                                SizedBox(height: SizeConfig.getHeight(15)),
                                TotalNutrientsContainer(
                                  width: SizeConfig.screenWidth,
                                  recipe: widget.recipe,
                                ),
                                SizedBox(height: SizeConfig.getHeight(30)),
                                IngredientsAndStepToggleContainer(
                                  recipe: widget.recipe,
                                  width: SizeConfig.screenWidth,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ));
  }
}
