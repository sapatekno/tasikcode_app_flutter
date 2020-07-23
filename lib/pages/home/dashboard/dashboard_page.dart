import 'package:flutter/material.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
import 'package:tasikcode_app_flutter/pages/home/dashboard/dashboard_presenter.dart';

class DashboardPage extends BaseStatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends BaseState<DashboardPage, DashboardPresenter>
    implements DashboardContract {
  DashboardPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = new DashboardPresenter(this);
    // ignore: invalid_use_of_protected_member
    _presenter.setView(this);
    _presenter.samplePresenter();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
