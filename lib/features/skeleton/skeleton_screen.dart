import 'package:flutter/material.dart';

import '../AI Classifier/pages/ClassifierScreen.dart';
import '../Home/pages/home_screen.dart';
import '../Mustadam Hub/pages/items_list_screen.dart';
import '../Profile/presentation/pages/profile_screen.dart';

class SkeletonScreen extends StatefulWidget {
  const SkeletonScreen({super.key});

  @override
  _SkeletonScreenState createState() => _SkeletonScreenState();
}

class _SkeletonScreenState extends State<SkeletonScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ClassifierScreen(),
    ItemsListScreen(),
    ProfileScreen(),
  ];

  Widget _navItem({required IconData icon, required int index}) {
    final bool isSelected = _currentIndex == index;
    return Container(
      decoration:
          isSelected
              ? BoxDecoration(
                color: Colors.teal[300],
                borderRadius: BorderRadius.circular(8),
              )
              : null,
      padding: EdgeInsets.all(6),
      child: Icon(icon, color: isSelected ? Colors.white : Colors.teal[700]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFE6FFFA),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: _navItem(icon: Icons.home, index: 0),
            label: '',
          ),
          // TODO change icon
          BottomNavigationBarItem(
            icon: _navItem(icon: Icons.face, index: 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _navItem(icon: Icons.eco, index: 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _navItem(icon: Icons.person, index: 3),
            label: '',
          ),
        ],
      ),
    );
  }
}
