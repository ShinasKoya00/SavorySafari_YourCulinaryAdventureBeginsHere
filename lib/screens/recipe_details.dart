import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/screens/search_page.dart';

import '../models/recipe_model.dart';
import '../widgets/container_shadow_box.dart';

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
  bool _isIngredientSelected = true;
  int? _stackIndex;

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
    getRecipe("ladoo");
    _toggleButton(true);
  }

  void _searchRecipe(String query) {
    query = query.trim();
    if (query.isEmpty) {
      log("Blank search");
    } else {
      log("search pressed");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage(query: query)),
      );
      Timer(Duration(seconds: 10), () {
        searchController.clear();
      });
    }
  }

  void _toggleButton(bool isIngredient) {
    setState(() {
      _isIngredientSelected = isIngredient;
    });
  }

  _changeStackIndex(int index) {
    setState(() {
      _stackIndex = index;
    });
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
                  child: Icon(CupertinoIcons.left_chevron),
                ),
              ),

              // Details section
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 30),
                  height: height * 0.6,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: _isLoading
                      ? Container(
                          height: height * 0.6,
                          width: width,
                          child: Center(
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
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.center,
                                  height: 65,
                                  width: width,
                                  child: Text(
                                    widget.recipe.applabel,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: width,
                                  // color: Colors.red.withOpacity(0.5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.watch_later_outlined, size: 18),
                                          SizedBox(width: 5),
                                          Text(widget.recipe.appPrepTime,
                                              style: TextStyle(fontSize: 17, color: Colors.grey.shade600)),
                                          SizedBox(width: 3),
                                          Text("min",
                                              style: TextStyle(fontSize: 17, color: Colors.grey.shade600))
                                        ],
                                      ),
                                      SizedBox(width: 30),
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.heart, size: 18),
                                          SizedBox(width: 5),
                                          Text("256",
                                              style: TextStyle(fontSize: 17, color: Colors.grey.shade600)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 80,
                                  width: width,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CalorieCarbProteinFat(
                                        header: "Calories",
                                        value: widget.recipe.appCalories,
                                      ),
                                      SizedBox(width: 15),
                                      CalorieCarbProteinFat(
                                        header: "Carbs",
                                        value: widget.recipe.appCarbs,
                                      ),
                                      SizedBox(width: 15),
                                      CalorieCarbProteinFat(
                                        header: "Protein",
                                        value: widget.recipe.appProtein,
                                      ),
                                      SizedBox(width: 15),
                                      CalorieCarbProteinFat(
                                        header: "Fat",
                                        value: widget.recipe.appFat,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                // Flexible(
                                //   child: Container(
                                //     color: Colors.red.withOpacity(0.5),
                                //     width: width,
                                //     child: Text(
                                //       "akjndasjk askndasjk askjas xcjk asjk ass jk askjas xcjk asjk ass xckasassdfdasfndasjk aikaxckasassdfdasfndasjk aikasjkas asiojcas cxasjckndasjk askjakas kndasjk aikasjkas asiojcas cxasjckndasjk askja c, djasoid xcikasjkas asiojcas cxasjckasc, djasoid xcikasjkas asiojcas cxasjc",
                                //       overflow: TextOverflow.ellipsis,
                                //       maxLines: 6,
                                //       textAlign: TextAlign.center,
                                //       style: TextStyle(fontSize: 16),
                                //     ),
                                //   ),
                                // ),

                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: [
                                    ContainerShadowBox(
                                      onTap: () {
                                        _toggleButton(true);
                                        _changeStackIndex(0);
                                      },
                                      height: 40,
                                      width: 100,
                                      borderRadius: BorderRadius.circular(50),
                                      color: _isIngredientSelected ? MyColors.darkGreen2 : MyColors.grey,
                                      text: "Ingredients",
                                      textColor:
                                          _isIngredientSelected ? MyColors.grey : MyColors.bottomNavTopBlack,
                                    ),
                                    SizedBox(width: 50),
                                    ContainerShadowBox(
                                      onTap: () {
                                        _toggleButton(false);
                                        _changeStackIndex(1);
                                      },
                                      height: 40,
                                      width: 100,
                                      borderRadius: BorderRadius.circular(50),
                                      color: _isIngredientSelected ? MyColors.grey : MyColors.darkGreen2,
                                      text: "Steps",
                                      textColor:
                                          _isIngredientSelected ? MyColors.bottomNavTopBlack : MyColors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                IndexedStack(
                                  index: _stackIndex,
                                  children: [
                                    Container(
                                      height: 300,
                                      width: width,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: widget.recipe.appIngredientsLabel.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              widget.recipe.appIngredientsLabel[index],
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: width,
                                      child: Text("ajhd jhasbdj klasjda sjak"),
                                    )
                                  ],
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

class CalorieCarbProteinFat extends StatelessWidget {
  final String header;
  final String value;

  const CalorieCarbProteinFat({
    super.key,
    required this.header,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          header,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
