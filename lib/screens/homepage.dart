import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:savory_safari/models/recipe_category_model.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/screens/recipe_details.dart';
import 'package:savory_safari/screens/search_page.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';
import 'package:savory_safari/widgets/container_shadow_box.dart';
import 'package:savory_safari/widgets/custom_bottom_nav_bar.dart';
import 'package:savory_safari/widgets/header_row.dart';
import 'package:savory_safari/widgets/recipe_card_custom.dart';
// Import SizeConfig

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  List<RecipeModel> recipeList1 = <RecipeModel>[];
  List<RecipeModel> recipeList2 = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

  Future<void> getRecipe1(String query1) async {
    try {
      String url =
          "https://api.edamam.com/api/recipes/v2?type=public&q=$query1&app_id=fbf9d0ca&app_key=1d93f048220627e517dec9b9915a937e";
      final response = await get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<RecipeModel> loadedRecipes1 = [];

        data["hits"].forEach((element) {
          RecipeModel recipeModel1 = RecipeModel.fromMap(element["recipe"]);

          loadedRecipes1.add(recipeModel1);
        });
        setState(() {
          _isLoading = false;
          recipeList1 = loadedRecipes1;
        });
        log(data.toString());
      } else {
        log('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      log('Failed to load recipes: $e');
    }
  }

  Future<void> getRecipe2(String query2) async {
    try {
      String url =
          "https://api.edamam.com/api/recipes/v2?type=public&q=$query2&app_id=fbf9d0ca&app_key=1d93f048220627e517dec9b9915a937e";
      final response = await get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<RecipeModel> loadedRecipes2 = [];

        data["hits"].forEach((element) {
          RecipeModel recipeModel2 = RecipeModel.fromMap(element["recipe"]);

          loadedRecipes2.add(recipeModel2);
        });
        setState(() {
          _isLoading = false;
          recipeList2 = loadedRecipes2;
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
    // Initialize SizeConfig
    getRecipe1('Indian chicken grill');
    getRecipe2("salad");
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

      Timer(const Duration(seconds: 10), () {
        searchController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;

    return Scaffold(
      backgroundColor: MyColors.homePageGrey,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          margin: EdgeInsets.symmetric(horizontal: SizeConfig.getHeight(15)),
          width: width,
          child: Column(
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.getHeight(15), right: SizeConfig.getWidth(12)),
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(12)),
                        height: SizeConfig.getHeight(55),
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
              SizedBox(height: SizeConfig.getHeight(25)),
              const HeaderRow(
                title: "Staff Picks",
                subTitle: "View all",
                icon: CupertinoIcons.chevron_down,
              ),
              SizedBox(height: SizeConfig.getHeight(20)),
              _isLoading
                  ? SizedBox(
                      height: SizeConfig.getHeight(200),
                      width: width,
                      child: const Center(child: CircularProgressIndicator()))
                  : SizedBox(
                      height: SizeConfig.getHeight(200),
                      width: width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: recipeList1.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => RecipeCardCustom(
                          onTap: () {
                            log("top slider is pressed");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecipeDetails(
                                          recipe: recipeList1[index],
                                        )));
                          },
                          width: width,
                          recipeList: recipeList1,
                          cardImage: recipeList1[index].appimgUrl,
                          cardTitle: recipeList1[index].applabel,
                          calorieCount: recipeList1[index].appCalories,
                          ingredientsCount: recipeList1[index].appIngredients,
                          hoursCount: recipeList1[index].appPrepTime,
                          imageFit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
              SizedBox(height: SizeConfig.getHeight(30)),
              SizedBox(
                height: SizeConfig.getHeight(60),
                width: width,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.getHeight(22),
                  ),
                  itemCount: recipeCategoryList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ContainerShadowBox(
                    onTap: () {
                      log("middle slider is pressed");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage(query: recipeCategoryList[index]["heading"])));
                    },
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(20)),
                    margin: EdgeInsets.only(right: SizeConfig.getWidth(10)),
                    borderRadius: BorderRadius.circular(SizeConfig.getRadius(5)),
                    child: Text(
                      recipeCategoryList[index]["heading"],
                      style: TextStyle(fontSize: SizeConfig.getFontSize(18), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.getHeight(10)),
              const HeaderRow(
                  title: "You might like it", subTitle: "Explore", icon: CupertinoIcons.right_chevron),
              SizedBox(height: SizeConfig.getHeight(15)),

              // bottom horizontal scroller
              _isLoading
                  ? SizedBox(
                      height: SizeConfig.getHeight(200),
                      width: width,
                      child: const Center(child: CircularProgressIndicator()))
                  : SizedBox(
                      height: SizeConfig.getHeight(220),
                      width: width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: recipeList2.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => RecipeCardCustom(
                          onTap: () {
                            log("bottom slider is pressed");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecipeDetails(
                                          recipe: recipeList2[index],
                                        )));
                          },
                          width: SizeConfig.getWidth(200),
                          recipeList: recipeList2,
                          cardImage: recipeList2[index].appimgUrl,
                          cardTitle: recipeList2[index].applabel,
                          calorieCount: recipeList2[index].appCalories,
                          ingredientsCount: recipeList2[index].appIngredients,
                          hoursCount: recipeList2[index].appPrepTime,
                          imageFit: BoxFit.fitHeight,
                          calorieIconSize: SizeConfig.getIconSize(13),
                          calorieFontSize: SizeConfig.getFontSize(12),
                          titleTimeLeftPosition: SizeConfig.getHeight(18),
                        ),
                      ),
                    ),
              SizedBox(height: SizeConfig.getHeight(30)),
              CustomBottomNavBar(width: width),
            ],
          ),
        ),
      ),
    );
  }
}
