import 'package:flutter/material.dart';
import 'package:intern_flutter_challenge/pages/gps_maps/map_location_page.dart';
import 'package:intern_flutter_challenge/pages/main_page.dart';
import 'package:intern_flutter_challenge/pages/second_page.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int index = 0;
  final screens = [
    const MainPage(),
    const SecondPage(),
    const MapLocationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.lightBlue,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
          height: 70,
          backgroundColor: Colors.blue,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          animationDuration: const Duration(seconds: 3),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.phone_android_outlined,
                color: Colors.lightBlue.shade100,
              ),
              selectedIcon: const Icon(
                Icons.phone_android,
                color: Colors.white,
              ),
              label: "Page A",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.qr_code_outlined,
                color: Colors.lightBlue.shade100,
              ),
              selectedIcon: const Icon(
                Icons.qr_code,
                color: Colors.white,
              ),
              label: "Page B",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.map_outlined,
                color: Colors.lightBlue.shade100,
              ),
              selectedIcon: const Icon(
                Icons.map,
                color: Colors.white,
              ),
              label: "Page C",
            ),
          ],
        ),
      ),
    );
  }
}
