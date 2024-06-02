// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart';
import 'package:savory_safari/models/recipe_category_model.dart';
import 'package:savory_safari/screens/recipe_details.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/widgets/header_row.dart';
import 'package:savory_safari/widgets/recipe_card_custom.dart';
import 'package:savory_safari/screens/search_page.dart';

import '../models/recipe_model.dart';
import '../widgets/container_shadow_box.dart';

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
    getRecipe1('chicken');
    getRecipe2('ladoo');
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
              const SizedBox(height: 25),
              const HeaderRow(
                title: "Staff Picks",
                subTitle: "View all",
                icon: CupertinoIcons.chevron_down,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? SizedBox(height: 200, width: width, child: Center(child: CircularProgressIndicator()))
                  : SizedBox(
                height: 200,
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
              SizedBox(height: 30),
              SizedBox(
                height: 60,
                width: width,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    bottom: 22,
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
                    height: 30,
                    width: 120,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(right: 10),
                    borderRadius: BorderRadius.circular(5),
                    child: Text(
                      recipeCategoryList[index]["heading"],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              HeaderRow(title: "You might like it", subTitle: "Explore", icon: CupertinoIcons.right_chevron),
              SizedBox(height: 15),

              // bottom horizontal scroller
              _isLoading
                  ? SizedBox(height: 200, width: width, child: Center(child: CircularProgressIndicator()))
                  : SizedBox(
                height: 220,
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
                    width: 200,
                    recipeList: recipeList2,
                    cardImage: recipeList2[index].appimgUrl,
                    cardTitle: recipeList2[index].applabel,
                    calorieCount: recipeList2[index].appCalories,
                    ingredientsCount: recipeList2[index].appIngredients,
                    hoursCount: recipeList2[index].appPrepTime,
                    imageFit: BoxFit.fitHeight,
                    calorieIconSize: 13,
                    calorieFontSize: 12,
                    titleTimeLeftPosition: 18,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 60,
                width: width / 1.45,
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade800,
                      offset: Offset(0.0, 10.0),
                      blurRadius: 10.0,
                      spreadRadius: -5.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      MyColors.bottomNavTopBlack,
                      MyColors.bottomNavBottomBlack,
                    ],
                  ),
                ),
                child: GNav(
                  curve: Curves.easeInOut,
                  // tab animation curves
                  duration: Duration(milliseconds: 800),
                  tabBorderRadius: 10,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  color: Colors.grey,
                  // activeColor: MyColors.bottomNavBottomBlack,

                  tabBackgroundColor: MyColors.bottomNavGreenishYellow,
                  tabs: const [
                    GButton(
                      icon: CupertinoIcons.compass,
                    ),
                    GButton(
                      icon: CupertinoIcons.search_circle,
                    ),
                    GButton(
                      icon: CupertinoIcons.bookmark,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
