import 'package:flutter/material.dart';

abstract class BaseContract {
  void sampleAbstract();

  void showAlert({String message, Color primaryColor, Color secondaryColor});
}

abstract class BasePresenter<T extends BaseContract> {
  @protected
  T _view;

  @protected
  void setView(T view) {
    _view = view;
  }

  void samplePresenter() {
    _view.sampleAbstract();
  }
}
