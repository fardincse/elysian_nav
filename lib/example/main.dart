import 'package:flutter/material.dart';
import 'package:elysian_nav/elysian_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElysianNav Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B48FF)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    Center(child: Text('🏠 Home Page', style: TextStyle(fontSize: 40))),
    Center(child: Text('🔍 Discover Page', style: TextStyle(fontSize: 40))),
    Center(child: Text('❤️ Favorites', style: TextStyle(fontSize: 40))),
    Center(child: Text('👤 Profile', style: TextStyle(fontSize: 40))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // ন্যাভবারের পিছনে কন্টেন্ট দেখানোর জন্য
      body: _pages[_selectedIndex],
      bottomNavigationBar: ElysianNav(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        height: 82,
        borderRadius: 42,
        backgroundGradient: const LinearGradient(
          colors: [Color(0xFF6B48FF), Color(0xFF00DDEB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
        enableGlowOnActive: true,
        items: [
          ElysianNavItem(
            icon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.home_outlined, color: Colors.white),
              colors: [Colors.white, Colors.blue[300]!],
            ),
            activeIcon: const Icon(Icons.home_rounded, color: Colors.white),
            label: 'Home',
          ),
          ElysianNavItem(
            icon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.explore_outlined, color: Colors.white),
              colors: [Colors.white, Colors.cyan[300]!],
            ),
            label: 'Discover',
          ),
          ElysianNavItem(
            icon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.favorite_border, color: Colors.white),
              colors: [Colors.white, Colors.pinkAccent],
            ),
            activeIcon: const Icon(Icons.favorite, color: Colors.white),
            label: 'Favorites',
          ),
          ElysianNavItem(
            icon: ElysianNav.celestialIcon(
              icon: const Icon(Icons.person_outline, color: Colors.white),
              colors: [Colors.white, Colors.purple[300]!],
            ),
            activeIcon: const Icon(Icons.person, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}