class RecipeModel {
  late String applabel;
  late String appimgUrl;
  late double appCalories;
  late String appUrl;

  RecipeModel({
    this.applabel = "label",
    this.appimgUrl = "image",
    this.appCalories = 0.00,
    this.appUrl = "url",
  });

  factory RecipeModel.fromMap(Map<String, dynamic> recipe) {
    return RecipeModel(
      applabel: recipe["label"],
      appCalories: recipe["calories"],
      appimgUrl: recipe["image"],
      appUrl: recipe["url"],
    );
  }
}
