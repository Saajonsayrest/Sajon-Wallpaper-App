import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar(this.selectedIndex, this.onItemTapped, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.teal,
      unselectedItemColor: Colors.white.withOpacity(0.4),
      selectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: onItemTapped,
      items: [
        BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
              size: 28.h,
            )),
        BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.favorite,
              size: 28.h,
            )),
        BottomNavigationBarItem(
            label: 'Favorite',
            icon: Icon(
              Icons.person,
              size: 28.h,
            )),
      ],
    );
  }
}
