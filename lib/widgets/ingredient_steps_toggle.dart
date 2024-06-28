import 'package:flutter/material.dart';
import 'package:savory_safari/models/recipe_model.dart';
import 'package:savory_safari/screens/recipe_content_page.dart';
import 'package:savory_safari/utils/colors.dart';
import 'package:savory_safari/utils/size_coonfiguration.dart';
import 'package:savory_safari/widgets/container_shadow_box.dart';

class IngredientsAndStepToggleContainer extends StatefulWidget {
  final RecipeModel recipe;
  final double width;

  const IngredientsAndStepToggleContainer({
    Key? key,
    required this.recipe,
    required this.width,
  }) : super(key: key);

  @override
  State<IngredientsAndStepToggleContainer> createState() => _IngredientsAndStepToggleContainerState();
}

class _IngredientsAndStepToggleContainerState extends State<IngredientsAndStepToggleContainer> {
  bool _isIngredientSelected = true;
  int _stackIndex = 0;

  void _toggleView(bool isIngredient) {
    setState(() {
      _isIngredientSelected = isIngredient;
      _stackIndex = isIngredient ? 0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    double buttonWidth = SizeConfig.getWidth(100); // Adjusted width for buttons
    double buttonHeight = SizeConfig.getHeight(40); // Adjusted height for container
    BorderRadius buttonBorderRadius =
        BorderRadius.circular(SizeConfig.getWidth(50)); // Adjusted height for container

    return Column(
      children: [
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ContainerShadowBox(
              onTap: () => _toggleView(true),
              height: buttonHeight,
              width: buttonWidth,
              borderRadius: buttonBorderRadius,
              // Dynamic borderRadius
              color: _isIngredientSelected ? MyColors.darkGreen2 : MyColors.grey,
              text: "Ingredients",
              textColor: _isIngredientSelected ? MyColors.grey : MyColors.bottomNavTopBlack,
            ),
            const SizedBox(width: 3), // Adjusted spacing
            ContainerShadowBox(
              onTap: () => _toggleView(false),
              height: buttonHeight,
              width: buttonWidth,
              borderRadius: buttonBorderRadius,
              // Dynamic borderRadius
              color: _isIngredientSelected ? MyColors.grey : MyColors.darkGreen2,
              text: "Steps",
              textColor: _isIngredientSelected ? MyColors.bottomNavTopBlack : MyColors.grey,
            ),
          ],
        ),
        const SizedBox(height: 10), // Adjusted spacing
        IndexedStack(
          index: _stackIndex,
          children: [
            SizedBox(
              height: SizeConfig.getHeight(300), // Dynamic height for ingredients list
              width: widget.width,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.recipe.appIngredientsLabel.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    widget.recipe.appIngredientsLabel[index],
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.getHeight(150), // Dynamic height for steps container
              width: widget.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "For the Detailed recipe,",
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    ContainerShadowBox(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeContentPage(
                              appRecipeContentUrl: widget.recipe.appRecipeContentUrl,
                            ),
                          ),
                        );
                      },
                      height: buttonHeight,
                      width: buttonWidth,
                      borderRadius: buttonBorderRadius,
                      color: MyColors.darkGreen2,
                      text: "Click Here",
                      textColor: MyColors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
