import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/screens/recipe_content_page.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/widgets/container_shadow_box.dart';

class IngredientsAndStepToggleContainer extends StatefulWidget {
  final RecipeModel recipe;
  final double width;

  const IngredientsAndStepToggleContainer({super.key, required this.recipe, required this.width});

  @override
  State<IngredientsAndStepToggleContainer> createState() => _IngredientsAndStepToggleContainerState();
}

class _IngredientsAndStepToggleContainerState extends State<IngredientsAndStepToggleContainer> {
  bool _isIngredientSelected = true;
  int? _stackIndex;

  @override
  void initState() {
    super.initState();
    _ingredientStepsToggleButton(true);
  }

  void _ingredientStepsToggleButton(bool isIngredient) {
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
    return Column(
      children: [
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ContainerShadowBox(
              onTap: () {
                _ingredientStepsToggleButton(true);
                _changeStackIndex(0);
              },
              height: 40,
              width: 100,
              borderRadius: BorderRadius.circular(50),
              color: _isIngredientSelected ? MyColors.darkGreen2 : MyColors.grey,
              text: "Ingredients",
              textColor: _isIngredientSelected ? MyColors.grey : MyColors.bottomNavTopBlack,
            ),
            const SizedBox(width: 50),
            ContainerShadowBox(
              onTap: () {
                _ingredientStepsToggleButton(false);
                _changeStackIndex(1);
              },
              height: 40,
              width: 100,
              borderRadius: BorderRadius.circular(50),
              color: _isIngredientSelected ? MyColors.grey : MyColors.darkGreen2,
              text: "Steps",
              textColor: _isIngredientSelected ? MyColors.bottomNavTopBlack : MyColors.grey,
            ),
          ],
        ),
        const SizedBox(height: 20),
        IndexedStack(
          index: _stackIndex,
          children: [
            SizedBox(
              height: 300,
              width: widget.width,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.recipe.appIngredientsLabel.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      widget.recipe.appIngredientsLabel[index],
                      style: const TextStyle(fontSize: 17),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 150,
              width: widget.width,
              child: SizedBox(
                height: 170,
                width: widget.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "For the Detailed recipe,",
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(height: 10),
                      ContainerShadowBox(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeContentPage(
                                      appRecipeContentUrl: widget.recipe.appRecipeContentUrl)));
                        },
                        height: 30,
                        width: 100,
                        borderRadius: BorderRadius.circular(7),
                        color: MyColors.darkGreen2,
                        text: "Click Here",
                        textColor: MyColors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
