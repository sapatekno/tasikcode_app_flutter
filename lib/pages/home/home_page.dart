import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasikcode_app_flutter/base/base_stateful_widget.dart';
import 'package:tasikcode_app_flutter/pages/home/baraya/baraya_page.dart';
import 'package:tasikcode_app_flutter/pages/home/blog/blog_page.dart';
import 'package:tasikcode_app_flutter/pages/home/dashboard/dashboard_page.dart';
import 'package:tasikcode_app_flutter/pages/home/event/event_page.dart';
import 'package:tasikcode_app_flutter/pages/home/home_presenter.dart';
import 'package:tasikcode_app_flutter/utils/my_app.dart';
import 'package:tasikcode_app_flutter/utils/my_colors.dart';
import 'package:websafe_svg/websafe_svg.dart';

class HomePage extends BaseStatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomePresenter> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    BlogPage(),
    EventPage(),
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
          tooltip: "Notifikasi",
          icon: Icon(
            FontAwesome.bell_o,
            color: MyColors.bluePrimary,
          ),
          onPressed: () {
            showAlert(
                message: "Belum ada notifikasi terbaru",
                color: MyColors.bluePrimary);
          },
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
      onTap: onItemTapped,
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

  onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
