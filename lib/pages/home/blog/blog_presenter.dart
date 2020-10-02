import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasikcode_app_flutter/base/base_presenter.dart';
import 'package:tasikcode_app_flutter/model/post_model.dart';

abstract class BlogContract extends BaseContract {
  void loadPosts(List<PostModel> posts);

  void setLoading(bool status);
}

class BlogPresenter extends BasePresenter {
  BlogContract _view;

  BlogPresenter(this._view);

  void getPosts() async {
    _view.setLoading(true);

    String url =
        "http://blog.tasikcode.xyz/wp-json/wp/v2/posts?per_page=20&_embed";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<PostModel> result =
          List<PostModel>.from(data.map((i) => PostModel.fromJson(i)));
      _view.loadPosts(result);
    } else {
      // error load
    }

    return null;
  }
}
