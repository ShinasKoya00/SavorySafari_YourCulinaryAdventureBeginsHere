import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/utils/colors.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: MyColors.homePageGrey,
        body: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: width,
                  width: width,
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
                top: 60,
                left: 25,
                child: ContainerShadowBox(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  height: 45,
                  width: 45,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  child: const Icon(CupertinoIcons.left_chevron),
                ),
              ),

              // Details section
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
                  height: height * 0.6,
                  width: width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: height * 0.6,
                          width: width,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SingleChildScrollView(
                          child: SizedBox(
                            height: height * 0.7,
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.center,
                                  height: 65,
                                  width: width,
                                  child: Text(
                                    widget.recipe.applabel,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                HoursDineTypeContainer(
                                  width: width,
                                  widget: widget,
                                ),
                                const SizedBox(height: 15),
                                TotalNutrientsContainer(
                                  width: width,
                                  recipe: widget.recipe,
                                ),
                                const SizedBox(height: 30),
                                IngredientsAndStepToggleContainer(
                                  recipe: widget.recipe,
                                  width: width,
                                )
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
