import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jb_user_app/screens/home_screen.dart';
import 'package:jb_user_app/screens/my_progress.dart';

enum AppTab { Home, Progress, Notifications }

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  AppTab _currentTab = AppTab.Home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentTab(_currentTab),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCurrentTab(AppTab tab) {
    switch (tab) {
      case AppTab.Home:
        return HomeScreen();
      case AppTab.Progress:
        return MyProgress();
      case AppTab.Notifications:
        return MyProgress();
      default:
        return HomeScreen();
    }
  }

  Container _buildBottomNavigationBar() {
    return Container(
      height: 76.0,
      child: BottomNavigationBar(
        selectedItemColor: HexColor('EF6C00'),
        selectedLabelStyle: GoogleFonts.raleway(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        currentIndex: AppTab.values.indexOf(_currentTab),
        onTap: (index) {
          setState(() {
            _currentTab = AppTab.values[index];
          });
        },
        items: [
          _buildNavItem(Icons.home_filled, 'HOME'),
          _buildNavItem(Icons.account_circle_rounded, 'MY PROGRESS'),
          _buildNavItem(Icons.notifications, 'NOTIFICATIONS'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [Icon(icon), SizedBox(height: 7)],
      ),
      label: label,
    );
  }
}
