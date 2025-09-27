import 'package:fast_order/features/order/domain/entity/cart_model.dart';

class CartItemModel extends CartItem {
  CartItemModel({
    required super.totalPrice,
    required super.productName,
    required super.quantity,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      totalPrice: map['totalPrice'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  // ✅ Add this method
  CartItem toEntity() {
    return CartItem(
      totalPrice: totalPrice,
      productName: productName,
      quantity: quantity,
    );
  }

  /// Convert domain entity to model (useful in repository)
  factory CartItemModel.fromEntity(CartItem entity) {
    return CartItemModel(
      totalPrice: entity.totalPrice,
      productName: entity.productName,
      quantity: entity.quantity,
    );
  }
}
