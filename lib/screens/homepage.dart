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
    getRecipe('chicken');
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
                        itemCount: recipeList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => RecipeCardCustom(
                          onTap: () {
                            log("top slider is pressed");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetails()));
                          },
                          width: width,
                          recipeList: recipeList,
                          cardImage: recipeList[index].appimgUrl,
                          cardTitle: recipeList[index].applabel,
                          calorieCount: recipeList[index].appCalories,
                          ingredientsCount: recipeList[index].appIngredients,
                          hoursCount: recipeList[index].appPrepTime,
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
                      log("top slider is pressed");
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

              // below horizontal scroller
              _isLoading
                  ? SizedBox(height: 200, width: width, child: Center(child: CircularProgressIndicator()))
                  : SizedBox(
                      height: 220,
                      width: width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => RecipeCardCustom(
                          onTap: () {
                            log("top slider is pressed");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetails()));
                          },
                          width: 200,
                          recipeList: recipeList,
                          cardImage: recipeList[index].appimgUrl,
                          cardTitle: recipeList[index].applabel,
                          calorieCount: recipeList[index].appCalories,
                          ingredientsCount: recipeList[index].appIngredients,
                          hoursCount: recipeList[index].appPrepTime,
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
                    colors: [
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
                  tabs: [
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
