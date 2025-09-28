import 'package:fast_order/core/local_data/product.dart';
import 'package:fast_order/features/order/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProductCard displays product info correctly and handles tap', (
    WidgetTester tester,
  ) async {
    final product = Product(
      imagePath: "assets/salad2.png",
      title: "Test Product",
      subtitle: "Best Subtitle",
      price: 50.0,
      description: "Test description",
      deliveryTime: "20 min",
      id: "1",
    );

    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCard(product: product, onTap: () => tapped = true),
        ),
      ),
    );

    expect(find.text("Test Product"), findsOneWidget);
    expect(find.text("Best Subtitle"), findsOneWidget);
    expect(find.text("\$50.0"), findsOneWidget);

    await tester.tap(find.byType(ProductCard));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
