import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tasikcode_app_flutter/base/base_presenter.dart';

abstract class BaseStatefulWidget extends StatefulWidget {}

abstract class BaseState<T extends BaseStatefulWidget, R extends BasePresenter>
    extends State<T> implements BaseContract {
  @override
  void sampleAbstract() {
    print("dipanggil lewat base statefull");
  }

  @override
  void showAlert(
      {String message,
      Color primaryColor,
      Color secondaryColor,
      IconData iconData,
      onDismissed}) {
    Flushbar(
      backgroundColor: primaryColor,
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.BOTTOM,
      icon: Icon(
        iconData,
        color: secondaryColor,
      ),
      leftBarIndicatorColor: secondaryColor,
      message: message,
      margin: EdgeInsets.all(16),
      onStatusChanged: (FlushbarStatus status) {
        switch (status) {
          case FlushbarStatus.SHOWING:
            break;
          case FlushbarStatus.DISMISSED:
            onDismissed();
            break;
          case FlushbarStatus.IS_APPEARING:
            break;
          case FlushbarStatus.IS_HIDING:
            break;
        }
      },
    ).show(context);
  }
}
