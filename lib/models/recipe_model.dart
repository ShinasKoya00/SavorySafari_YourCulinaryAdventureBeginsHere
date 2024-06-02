class RecipeModel {
  late String applabel;
  late String appimgUrl;
  late String appCalories;
  late String appCarbs;
  late String appProtein;
  late String appFat;

  late int appIngredients;
  late List<String> appIngredientsLabel;
  late String appPrepTime;
  late List<String> appMealType;
  final String appRecipeContentUrl;

  RecipeModel({
    this.applabel = "label",
    this.appimgUrl = "image",
    this.appCalories = "0.00",
    this.appCarbs = "0.00",
    this.appProtein = "0.00",
    this.appFat = "0.00",
    this.appIngredients = 0,
    this.appIngredientsLabel = const [],
    this.appPrepTime = "0.00",
    this.appMealType = const [],
    this.appRecipeContentUrl = "appRecipeContentUrl",
  });

  factory RecipeModel.fromMap(Map<String, dynamic> recipe) {
    int ingredientsCount = (recipe["ingredientLines"] as List).length;
    List<String> appMealType = (recipe["mealType"] as List<dynamic>).map((e) => e.toString()).toList();
    List<String> ingredientsLabel =
        (recipe["ingredientLines"] as List<dynamic>).map((e) => e.toString()).toList();
    String appCarbs = (recipe["totalNutrients"]["CHOCDF"]["quantity"] as double).toStringAsFixed(2);
    String appProtein = (recipe["totalNutrients"]["PROCNT"]["quantity"] as double).toStringAsFixed(2);
    String appFat = (recipe["totalNutrients"]["FAT"]["quantity"] as double).toStringAsFixed(2);
    String appCalories = recipe["calories"].toStringAsFixed(2);
    String appPrepTime = (recipe["totalTime"] / 60).toStringAsFixed(2);

    return RecipeModel(
      applabel: recipe["label"],
      appCalories: appCalories,
      appCarbs: appCarbs,
      appProtein: appProtein,
      appFat: appFat,
      appimgUrl: recipe["image"],
      appIngredients: ingredientsCount,
      appIngredientsLabel: ingredientsLabel,
      appPrepTime: appPrepTime,
      appMealType: appMealType,
      appRecipeContentUrl: recipe["url"],
    );
  }
}
