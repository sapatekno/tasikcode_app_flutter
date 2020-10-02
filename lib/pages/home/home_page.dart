import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Container(child: Center(child: Text('Index 1: Blog'))),
    Container(child: Center(child: Text('Index 2: Event'))),
    Container(child: Center(child: Text('Index 3: Baraya'))),
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
      type: BottomNavigationBarType.fixed,
      selectedItemColor: MyColors.bluePrimary,
      unselectedItemColor: MyColors.grey,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(FontAwesome.home),
          title: Text("Home", style: _labelStyle),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesome.newspaper_o),
          title: Text("Blog", style: _labelStyle),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesome.calendar_o),
          title: Text("Event", style: _labelStyle),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesome.users),
          title: Text("Baraya", style: _labelStyle),
        ),
      ],
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
