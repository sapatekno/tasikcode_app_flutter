import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasikcode_app_flutter/utils/my_app.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:websafe_svg/websafe_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        child: Center(
            child: Text(
          "Blank App",
          style: TextStyle(
            color: MyColors.bluePrimary,
          ),
        )),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: WebsafeSvg.asset(
              MyApps.pathAssetsImages("tcode_logo_small.svg"),
            ),
          ),
          Text(
            "Tasik",
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w600,
              color: MyColors.bluePrimary,
            ),
          ),
          Text(
            "code",
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w600,
              color: MyColors.yellowSecond,
            ),
          ),
        ],
      ),
    );
  }
}
