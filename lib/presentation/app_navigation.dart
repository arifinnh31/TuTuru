import 'package:flutter/material.dart';
import 'package:tuturu/core/app_export.dart';

class AppNavigation extends StatefulWidget {
  AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int selectedTab = 0;

  final pageOptions = [
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageOptions[selectedTab],
      bottomNavigationBar: SizedBox(
        height: 97,
        child: BottomNavigationBar(
          selectedItemColor: Colors.black,
          elevation: 10,
          items: [
            BottomNavigationBarItem(
              icon: _buildIconBeranda(),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: _buildIconProfil(),
              label: 'Profil',
            ),
          ],
          currentIndex: selectedTab,
          onTap: (index) {
            setState(() {
              selectedTab = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildIconBeranda() {
    return SizedBox(
      width: 35,
      height: 35,
      child: Card(
        elevation: 10,
        child: Icon(Icons.home),
      ),
    );
  }

  Widget _buildIconProfil() {
    return SizedBox(
      width: 35,
      height: 35,
      child: Card(
        elevation: 10,
        child: Icon(Icons.person),
      ),
    );
  }
}
