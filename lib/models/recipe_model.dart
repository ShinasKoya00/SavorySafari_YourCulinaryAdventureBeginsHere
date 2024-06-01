class RecipeModel {
  late String applabel;
  late String appimgUrl;
  late String appCalories;
  late String appCarbs;
  late String appProtein;
  late String appFat;
  late String appUrl;
  late int appIngredients;
  late List<String> appIngredientsLabel;
  late String appPrepTime;

  RecipeModel({
    this.applabel = "label",
    this.appimgUrl = "image",
    this.appCalories = "0.00",
    this.appCarbs = "0.00",
    this.appProtein = "0.00",
    this.appFat = "0.00",
    this.appUrl = "url",
    this.appIngredients = 0,
    this.appIngredientsLabel = const [],
    this.appPrepTime = "0.00",
  });

  factory RecipeModel.fromMap(Map<String, dynamic> recipe) {
    int ingredientsCount = (recipe["ingredientLines"] as List).length;
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
      appUrl: recipe["url"],
      appIngredients: ingredientsCount,
      appIngredientsLabel: ingredientsLabel!,
      appPrepTime: appPrepTime,
    );
  }
}
