import 'package:flutter/material.dart';
import 'package:tasikcode_app_flutter/base/base_presenter.dart';

abstract class BaseStatefulWidget extends StatefulWidget {}

abstract class BaseState<T extends BaseStatefulWidget, R extends BasePresenter>
    extends State<T> implements BaseContract {
  @override
  void sampleAbstract() {
    print("dipanggil lewat base statefull");
  }
}
