import 'dart:async';

import 'package:budget_tracker/budget_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({Widget? child}) {
    return MaterialApp(
      home: child,
    );
  }

  Widget mockedListView() {
    return ListView(
        children: <String>['1', '2'].map<Widget>((String item) {
      return Text(item);
    }).toList());
  }

  bool refreshCalled = false;

  Future<void> refresh() {
    refreshCalled = true;
    return Future<void>.value();
  }

  Future<void> holdRefresh() {
    refreshCalled = true;
    return Completer<void>().future;
  }

  group("BudgetScreen", () {
    testWidgets('creates budget screen page ...', (WidgetTester tester) async {
      BudgetScreen budgetScreen = const BudgetScreen();

      await tester.pumpWidget(makeTestableWidget(child: budgetScreen));

      expect(find.text('Budget Tracker'), findsOneWidget);
    });

    testWidgets('RefreshIndicator', (WidgetTester tester) async {
      refreshCalled = false;
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget((makeTestableWidget(
          child: RefreshIndicator(
        onRefresh: refresh,
        child: mockedListView(),
      ))));

      await tester.fling(find.text('1'), const Offset(0.0, 300.0), 1000.0);
      await tester.pump();

      expect(
          tester.getSemantics(find.byType(RefreshProgressIndicator)),
          matchesSemantics(
            label: 'Refresh',
          ));

      await tester
          .pump(const Duration(seconds: 1)); // finish the scroll animation
      await tester.pump(
          const Duration(seconds: 1)); // finish the indicator settle animation
      await tester.pump(
          const Duration(seconds: 1)); // finish the indicator hide animation
      expect(refreshCalled, true);
      handle.dispose();
    });
  });
}
