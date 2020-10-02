import 'package:tasikcode_app_flutter/base/base_presenter.dart';

abstract class BlogContract extends BaseContract {}

class BlogPresenter extends BasePresenter {
  BlogContract _view;

  BlogPresenter(this._view);
}
