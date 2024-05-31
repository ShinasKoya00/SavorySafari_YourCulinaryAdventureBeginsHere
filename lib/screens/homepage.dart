import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:savory_safari/models/recipe_category_model.dart';
import 'package:savory_safari/screens/onboarding_page.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/widgets/search_page.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.homePageGrey,
      body: Stack(
        children: [
          Container(
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
                        image: "assets/icons/more_2.png",
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const HeaderRow(
                  title: "Staff Picks",
                  subTitle: "View all",
                  icon: CupertinoIcons.chevron_down,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 200,
                  width: width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipeList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => RecipeCardCustom(
                      width: width,
                      recipeList: recipeList,
                      cardImage: recipeList[index].appimgUrl,
                      cardTitle: recipeList[index].applabel,
                      ingredientsCount: "12",
                      hoursCount: "1.5",
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
                      onTap: () {},
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
                SizedBox(height: 30),
                HeaderRow(
                    title: "You might like it", subTitle: "Explore", icon: CupertinoIcons.right_chevron),
                SizedBox(height: 20),
                SizedBox(
                  height: 220,
                  width: width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipeList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => RecipeCardCustom(
                      width: 200,
                      recipeList: recipeList,
                      cardImage: recipeList[index].appimgUrl,
                      cardTitle: recipeList[index].applabel,
                      ingredientsCount: "12",
                      hoursCount: "1.5",
                      imageFit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;

  const HeaderRow({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: title,
          fontSize: 30,
        ),
        ContainerShadowBox(
          onTap: () {},
          height: 30,
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          borderRadius: BorderRadius.circular(15),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(subTitle),
            Icon(
              icon,
              size: 11,
            )
          ]),
        )
      ],
    );
  }
}

class RecipeCardCustom extends StatelessWidget {
  final double width;
  final List<RecipeModel> recipeList;
  final String cardImage;
  final String cardTitle;
  final String hoursCount;
  final String ingredientsCount;
  final BoxFit imageFit;

  const RecipeCardCustom({
    super.key,
    required this.width,
    required this.recipeList,
    required this.cardTitle,
    required this.cardImage,
    required this.hoursCount,
    required this.ingredientsCount,
    required this.imageFit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black38,
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black,
            Colors.transparent,
          ],
        ),
        image: DecorationImage(
          image: NetworkImage(cardImage),
          fit: imageFit,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: const Alignment(0, -0.5),
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            right: 15,
            top: 20,
            child: Icon(
              CupertinoIcons.bookmark,
              size: 18,
              color: MyColors.grey,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TimeAndIngredientsText(
                  ingredientsCount: ingredientsCount,
                  hoursCount: hoursCount,
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TimeAndIngredientsText extends StatelessWidget {
  final String ingredientsCount;
  final String hoursCount;

  const TimeAndIngredientsText({
    super.key,
    required this.ingredientsCount,
    required this.hoursCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              ingredientsCount,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "ingrediants",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          children: [
            Text(
              hoursCount,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "hours",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}
