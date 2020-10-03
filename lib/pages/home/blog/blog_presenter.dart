import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasikcode_app_flutter/base/base_presenter.dart';
import 'package:tasikcode_app_flutter/model/category_model.dart';
import 'package:tasikcode_app_flutter/model/post_model.dart';

abstract class BlogContract extends BaseContract {
  void loadPosts(
      List<PostModel> posts, int totalPages, bool isRefresh, bool isLoad);

  void loadCategories(List<CategoryModel> categories) {}

  void setLoading(bool status);

  void showError(String message);
}

class BlogPresenter extends BasePresenter {
  BlogContract _view;

  BlogPresenter(this._view);

  void getPosts(
      {num catID = 0,
      bool isRefresh = false,
      bool isLoad = false,
      int page = 1}) async {
    print("is load adalah $isLoad");

    // ? tidak bisa pake OR ??
    if (!isRefresh) {
      if (!isLoad) {
        _view.setLoading(true);
      }
    }

    String url =
        "http://blog.tasikcode.xyz/wp-json/wp/v2/posts?per_page=5&_embed&page=$page" +
            (catID != 0 ? "&categories=$catID" : "");

    final response = await http.get(url).catchError((error) {
      _view.showError("Gagal mengambil data.");

      // ! Error for programmers
      print("PostData - Error $error");
    });

    int totalPages = int.parse(response.headers['x-wp-totalpages'] ?? 0);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<PostModel> result =
      List<PostModel>.from(data.map((i) => PostModel.fromJson(i)));
      _view.loadPosts(result, totalPages, isRefresh, isLoad);
    } else {
      // ! Error for programmers
      print("PostData - Error ${response.body}");
    }
  }

  void getCategories() async {
    String url = "http://blog.tasikcode.xyz/wp-json/wp/v2/categories";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<CategoryModel> result =
          List<CategoryModel>.from(data.map((i) => CategoryModel.fromJson(i)));
      _view.loadCategories(result);
    } else {
      // ! Error for programmers
      print("CategoriesData - Error ${response.body}");
    }
  }
}
