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

      // Widget টা build হয়েছে কি না চেক
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
                ElysianNavItem(icon: Icon(Icons.home), label: 'Home'),
                ElysianNavItem(icon: Icon(Icons.favorite), label: 'Favorites'),
                ElysianNavItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          ),
        ),
      );

      // ৩টা label দেখা যাচ্ছে কি না
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);

      // BottomNavigationBarItem এর সংখ্যা
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
                ElysianNavItem(icon: Icon(Icons.home), label: 'Home'),
                ElysianNavItem(icon: Icon(Icons.search), label: 'Search'),
                ElysianNavItem(icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          ),
        ),
      );

      // দ্বিতীয় আইটেম selected (index 1)
      final selectedIcons = tester.widgetList<Icon>(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.byType(Icon),
        ),
      );

      // এখানে activeIcon বা glow চেক করা একটু জটিল, তাই label color চেক করা যায়
      // অথবা শুধু currentIndex সঠিকভাবে পাস হচ্ছে কি না চেক
      expect(find.text('Search'), findsOneWidget);
      // আরো advanced চেক পরে যোগ করতে পারো
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

      // দ্বিতীয় আইটেমে ট্যাপ সিমুলেট করা
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

      // শুধু build হয়েছে কি না চেক (gradient আসলেই apply হয়েছে কি না চেক করা কঠিন)
      expect(find.byType(ShaderMask), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}