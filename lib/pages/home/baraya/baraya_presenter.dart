import 'package:tasikcode_app_flutter/base/base_presenter.dart';

abstract class BarayaContract extends BaseContract {}

class BarayaPresenter extends BasePresenter {
  BarayaContract _view;

  BarayaPresenter(this._view);
}
