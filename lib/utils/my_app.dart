mixin MyApps {
  static String pathAssets(String path) => "assets/" + path;

  static String pathAssetsImages(String path) =>
      MyApps.pathAssets("images/" + path);
}
