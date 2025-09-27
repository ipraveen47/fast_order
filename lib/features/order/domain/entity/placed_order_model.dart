import 'package:fast_order/features/order/domain/entity/cart_model.dart';

class PlacedOrderModel {
  final String id;
  final List<CartItem> cartItems;
  final double totalAmount;
  final String status;
  final DateTime createdAt;

  PlacedOrderModel({
    required this.id,
    required this.cartItems,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });
}
