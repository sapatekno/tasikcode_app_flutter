import 'package:flutter/material.dart';
import 'package:tasikcode_app_flutter/pages/home/dashboard/dashboard_presenter.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    implements DashboardContract {
  DashboardPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = new DashboardPresenter(this);
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
