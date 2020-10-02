import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasikcode_app_flutter/pages/home/baraya/baraya_page.dart';
import 'package:tasikcode_app_flutter/pages/home/blog/blog_page.dart';
import 'package:tasikcode_app_flutter/pages/home/dashboard/dashboard_page.dart';
import 'package:tasikcode_app_flutter/utils/my_app.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:websafe_svg/websafe_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    BlogPage(),
    _eventBody(),
    BarayaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _bottomNavigationBar(context),
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
      actions: <Widget>[
        IconButton(
          icon: Icon(
            FontAwesome.bell_o,
            color: MyColors.bluePrimary,
          ),
          onPressed: () => null,
        )
      ],
    );
  }

  _bottomNavigationBar(BuildContext context) {
    TextStyle _labelStyle = GoogleFonts.montserrat();

    return BottomNavigationBar(
      selectedLabelStyle: _labelStyle,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: MyColors.bluePrimary,
      unselectedItemColor: MyColors.grey,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(FontAwesome.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
            icon: Icon(FontAwesome.newspaper_o), label: "Blog"),
        BottomNavigationBarItem(
            icon: Icon(FontAwesome.calendar_o), label: "Event"),
        BottomNavigationBarItem(icon: Icon(FontAwesome.users), label: "Baraya"),
      ],
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static _eventBody() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WebsafeSvg.asset(
              MyApps.pathAssetsImages("tcode_logo_small.svg"),
              width: 72,
              height: 72,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Coming ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: MyColors.bluePrimary),
                ),
                Text(
                  "Soon",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.yellowSecond),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
