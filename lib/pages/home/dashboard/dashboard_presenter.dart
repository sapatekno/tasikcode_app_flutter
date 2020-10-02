import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasikcode_app_flutter/base/base_presenter.dart';
import 'package:tasikcode_app_flutter/model/post_model.dart';

abstract class DashboardContract extends BaseContract {}

class DashboardPresenter extends BasePresenter {
  DashboardContract _view;

  DashboardPresenter(this._view);

  void samplePresenter() {
    _view.sampleAbstract();
  }

  Future<List<PostModel>> getArtikelTerbaru() async {
    final url =
        "http://blog.tasikcode.xyz/wp-json/wp/v2/posts?per_page=3&_embed";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<PostModel> result =
          List<PostModel>.from(data.map((i) => PostModel.fromJson(i)));
      return result;
    } else {
      // error load
    }

    return null;
  }
}
