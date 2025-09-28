import 'package:fast_order/features/order/presentation/widgets/placed_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'PlacesOrderCard displays correct item count, price, and status',
    (WidgetTester tester) async {
      // Arrange
      const itemCount = 3;
      const totalPrice = 250.50;
      const status = 'completed';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlacesOrderCard(
              itemCount: itemCount,
              totalPrice: totalPrice,
              status: status,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('3 items'), findsOneWidget);
      expect(find.text('₹250.50'), findsOneWidget);
      expect(find.text('COMPLETED'), findsOneWidget);

      // Check if the background color of status badge is correct
      final statusContainer = tester.widget<Container>(
        find.descendant(
          of: find.byType(PlacesOrderCard),
          matching: find.byType(Container).last,
        ),
      );

      final BoxDecoration? decoration =
          statusContainer.decoration as BoxDecoration?;
      expect(decoration?.color, equals(Colors.green.withOpacity(0.2)));
    },
  );

  testWidgets('PlacesOrderCard triggers onTap callback when tapped', (
    WidgetTester tester,
  ) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlacesOrderCard(
            itemCount: 1,
            totalPrice: 99.0,
            status: 'pending',
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PlacesOrderCard));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });
}
