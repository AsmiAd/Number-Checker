import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'learn/learn_screen.dart';
import 'settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    LearnScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFADD8E6) ,
        selectedItemColor: Colors.black, 
        unselectedItemColor: Colors.grey, 
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        //selectedItemColor: Color(0xFFADD8E6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Check',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings', 
    ),
        ],
      ),
    );
  }
}
