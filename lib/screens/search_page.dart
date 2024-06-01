import 'dart:convert';
import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/screens/onboarding_page.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/widgets/container_shadow_box.dart';
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
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: MyText(text: "Suitable recipe for ${widget.query}"),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipeList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => ContainerShadowBox(
                      onTap: () {},
                      height: 120,
                      width: width,
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
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
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: width - 195,
                                color: Colors.red.withOpacity(0.5),
                                child: Text(
                                  recipeList[index].applabel,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              TimeAndIngredientsText(
                                ingredientsCount: "12",
                                hoursCount: "0.4",
                                fontColor: Colors.grey.shade600,
                                fontColorBold: Colors.grey.shade800,
                                fontSize: 15,
                                heightBetweenRows: 4,
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

      // body: Stack(
      //   children: [
      //     Container(
      //       height: height,
      //       width: width,
      //       decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //           colors: [
      //             Colors.deepPurple.shade100,
      //             Colors.deepPurple.shade500,
      //           ],
      //         ),
      //       ),
      //     ),
      //     SafeArea(
      //       child: Padding(
      //         padding: const EdgeInsets.all(20.0),
      //         child: SingleChildScrollView(
      //           child: Column(
      //             children: [
      //               Container(
      //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(20),
      //                 ),
      //                 child: Row(
      //                   children: [
      //                     GestureDetector(
      //                       onTap: _searchRecipe,
      //                       child: const Padding(
      //                         padding: EdgeInsets.fromLTRB(3, 0, 7, 0),
      //                         child: Icon(
      //                           Icons.search,
      //                           color: Colors.blueAccent,
      //                         ),
      //                       ),
      //                     ),
      //                     Expanded(
      //                       child: TextField(
      //                         controller: searchController,
      //                         decoration: const InputDecoration(
      //                           border: InputBorder.none,
      //                           hintText: "Let's cook something",
      //                         ),
      //                         onSubmitted: (value) {
      //                           _searchRecipe();
      //                         },
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               const SizedBox(height: 30),
      //               Text("Your result for ${widget.query} is ready"),
      //               const SizedBox(height: 20),
      //               _isLoading
      //                   ? const CircularProgressIndicator()
      //                   : ListView.builder(
      //                       physics: const NeverScrollableScrollPhysics(),
      //                       shrinkWrap: true,
      //                       itemCount: recipeList.length,
      //                       itemBuilder: (context, index) {
      //                         return InkWell(
      //                           onTap: () {
      //                             log("card [$index] clicked");
      //                           },
      //                           child: Card(
      //                             shape: RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(15),
      //                             ),
      //                             margin: const EdgeInsets.only(top: 20),
      //                             child: Stack(
      //                               children: [
      //                                 ClipRRect(
      //                                   borderRadius: BorderRadius.circular(15),
      //                                   child: Image.network(
      //                                     recipeList[index].appimgUrl,
      //                                     fit: BoxFit.fitWidth,
      //                                     height: 220,
      //                                     width: width,
      //                                   ),
      //                                 ),
      //                                 Positioned(
      //                                   left: 0,
      //                                   bottom: 0,
      //                                   right: 0,
      //                                   child: Container(
      //                                     padding: const EdgeInsets.all(10),
      //                                     decoration: const BoxDecoration(
      //                                       color: Colors.black38,
      //                                       borderRadius: BorderRadius.only(
      //                                         bottomLeft: Radius.circular(15),
      //                                         bottomRight: Radius.circular(15),
      //                                       ),
      //                                     ),
      //                                     child: Text(
      //                                       recipeList[index].applabel,
      //                                       style: const TextStyle(
      //                                         color: Colors.white,
      //                                         fontSize: 16,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ),
      //                                 Positioned(
      //                                   top: 0,
      //                                   right: 0,
      //                                   height: 30,
      //                                   width: 80,
      //                                   child: Container(
      //                                     alignment: Alignment.centerLeft,
      //                                     decoration: const BoxDecoration(
      //                                       color: Colors.white,
      //                                       borderRadius: BorderRadius.only(
      //                                         topRight: Radius.circular(15),
      //                                         bottomLeft: Radius.circular(15),
      //                                       ),
      //                                     ),
      //                                     child: Row(
      //                                       mainAxisAlignment: MainAxisAlignment.center,
      //                                       crossAxisAlignment: CrossAxisAlignment.center,
      //                                       children: [
      //                                         const Icon(
      //                                           Icons.local_fire_department,
      //                                           size: 18,
      //                                         ),
      //                                         const SizedBox(width: 3),
      //                                         Text(
      //                                           recipeList[index].appCalories.toStringAsFixed(2),
      //                                           style: const TextStyle(fontWeight: FontWeight.bold),
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         );
      //                       },
      //                     ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
