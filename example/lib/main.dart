import 'package:flutter/material.dart';
import 'package:elysian_nav/elysian_nav.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: 'ElysianNav Example',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Favorites Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ElysianNav(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        enableGlowOnActive: true,
        backgroundGradient: const LinearGradient(
          colors: [Color(0xFFF8F9FA), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        items: [
          ElysianNavItem(
            icon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.home_outlined),
              colors: [Colors.blue, Colors.purple],
            ),
            activeIcon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.home),
              colors: [Colors.blue, Colors.purple],
            ),
            label: 'Home',
          ),
          ElysianNavItem(
            icon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.search_outlined),
              colors: [Colors.pink, Colors.orange],
            ),
            activeIcon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.search),
              colors: [Colors.pink, Colors.orange],
            ),
            label: 'Search',
          ),
          ElysianNavItem(
            icon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.favorite_border),
              colors: [Colors.red, Colors.pink],
            ),
            activeIcon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.favorite),
              colors: [Colors.red, Colors.pink],
            ),
            label: 'Favorites',
          ),
          ElysianNavItem(
            icon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.person_outline),
              colors: [Colors.green, Colors.teal],
            ),
            activeIcon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.person),
              colors: [Colors.green, Colors.teal],
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
