import 'package:flutter/material.dart';
import 'package:tasikcode_app_flutter/utils/my_app.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:websafe_svg/websafe_svg.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: _body(context),
            ),
          ),
        );
      },
    );
  }

  _body(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: WebsafeSvg.asset(
                  MyApps.pathAssetsImages("tcode_logo_small.svg"),
                  width: 72,
                  height: 72,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Coming ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.bluePrimary),
                  ),
                  Text(
                    "Soon",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.yellowSecond),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
