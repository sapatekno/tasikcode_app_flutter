import 'package:tasikcode_app_flutter/base/base_presenter.dart';

abstract class DashboardContract extends BaseContract {}

class DashboardPresenter extends BasePresenter {
  DashboardContract _view;

  DashboardPresenter(this._view);

  void samplePresenter() {
    _view.sampleAbstract();
  }
}
