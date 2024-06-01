class RecipeModel {
  late String applabel;
  late String appimgUrl;
  late String appCalories;
  late String appUrl;
  late int appIngredients;
  late String appPrepTime;

  RecipeModel({
    this.applabel = "label",
    this.appimgUrl = "image",
    this.appCalories = "0.00",
    this.appUrl = "url",
    this.appIngredients = 0,
    this.appPrepTime = "0.00",
  });

  factory RecipeModel.fromMap(Map<String, dynamic> recipe) {
    int ingredientsCount = (recipe["ingredientLines"] as List).length;
    String appCalories = recipe["calories"].toStringAsFixed(2);
    String appPrepTime = (recipe["totalTime"] / 60).toStringAsFixed(2);

    return RecipeModel(
      applabel: recipe["label"],
      appCalories: appCalories,
      appimgUrl: recipe["image"],
      appUrl: recipe["url"],
      appIngredients: ingredientsCount,
      appPrepTime: appPrepTime,
    );
  }
}
