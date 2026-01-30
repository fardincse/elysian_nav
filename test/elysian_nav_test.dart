import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:elysian_nav/elysian_nav.dart';

void main() {
  group('ElysianNav Widget Tests', () {
    testWidgets('should build without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ElysianNav(
              currentIndex: 0,
              onTap: (_) {},
              items: [
                ElysianNavItem(
                  icon: const Icon(Icons.home),
                  label: 'Home',
                ),
                ElysianNavItem(
                  icon: const Icon(Icons.search),
                  label: 'Search',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ElysianNav), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('should show correct number of items', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ElysianNav(
              currentIndex: 1,
              onTap: (_) {},
              items: [
                ElysianNavItem(icon: const Icon(Icons.home), label: 'Home'),
                ElysianNavItem(icon: const Icon(Icons.favorite), label: 'Favorites'),
                ElysianNavItem(icon: const Icon(Icons.person), label: 'Profile'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);

      expect(find.byType(BottomNavigationBarItem), findsNWidgets(3));
    });

    testWidgets('should highlight the current selected item', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ElysianNav(
              currentIndex: 1,
              onTap: (_) {},
              items: [
                ElysianNavItem(icon: const Icon(Icons.home), label: 'Home'),
                ElysianNavItem(icon: const Icon(Icons.search), label: 'Search'),
                ElysianNavItem(icon: const Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          ),
        ),
      );

     
      tester.widgetList<Icon>(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.byType(Icon),
        ),
      );

     
      expect(find.text('Search'), findsOneWidget);
     
    });

    testWidgets('should call onTap when item is tapped', (WidgetTester tester) async {
      int tappedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ElysianNav(
              currentIndex: 0,
              onTap: (index) {
                tappedIndex = index;
              },
              items: [
                ElysianNavItem(icon: const Icon(Icons.home), label: 'Home'),
                ElysianNavItem(icon: const Icon(Icons.star), label: 'Star'),
              ],
            ),
          ),
        ),
      );


      await tester.tap(find.text('Star'));
      await tester.pump();

      expect(tappedIndex, 1);
    });

    testWidgets('celestialIcon should apply gradient shader', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ElysianNav.celestialIcon(
                icon: const Icon(Icons.favorite, size: 60),
                colors: const [Colors.pink, Colors.purple],
              ),
            ),
          ),
        ),
      );

  
      expect(find.byType(ShaderMask), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}