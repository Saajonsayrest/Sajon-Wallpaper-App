import 'package:flutter/material.dart';
import 'package:untitled1/app/view/bottom_nav_bar.dart';
import 'package:untitled1/app/view/exit_dialog.dart';
import 'package:untitled1/feature/favorites/view/favorites_view.dart';
import 'package:untitled1/feature/homepage/view/homepage_view.dart';
import 'package:untitled1/feature/profile/view/profile_view.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  static const routeName = "/dashBoardScreen";

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    HomepageView(),
    FavoriteView(),
    ProfileView()
  ];
  static const List<String> _appBarTitles = [
    'Homepage',
    'Favorites',
    'Profile',
  ];

  void _onItemTappedBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show exit confirmation dialog
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => const ExitDialog(),
        );

        return shouldExit ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: Text(
              _appBarTitles[_selectedIndex],
              style: const TextStyle(color: Colors.white),
            )),
        bottomNavigationBar:
            BottomNavBar(_selectedIndex, _onItemTappedBottomNavBar),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
