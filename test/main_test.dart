import 'package:budget_tracker/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyApp has a title', (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(const MyApp());
    //Act
    final titleFinder = find.text('Budget Tracker');
    //Assert
    expect(titleFinder, findsOneWidget);
  });
}
