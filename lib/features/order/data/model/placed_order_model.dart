import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_order/features/order/data/model/cart_item_model.dart';
import 'package:fast_order/features/order/domain/entity/placed_order_model.dart';

class PlacedOrderDataModel extends PlacedOrderModel {
  PlacedOrderDataModel({
    required super.id,
    required super.cartItems,
    required super.totalAmount,
    required super.status,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'cartItems': cartItems
          .map((e) => CartItemModel.fromEntity(e).toMap())
          .toList(),
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory PlacedOrderDataModel.fromMap(String id, Map<String, dynamic> map) {
    return PlacedOrderDataModel(
      id: id,
      cartItems: (map['cartItems'] as List)
          .map((item) => CartItemModel.fromMap(item).toEntity())
          .toList(),
      totalAmount: (map['totalAmount'] as num).toDouble(),
      status: map['status'] ?? 'pending',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  factory PlacedOrderDataModel.fromEntity(PlacedOrderModel entity) {
    return PlacedOrderDataModel(
      id: entity.id,
      cartItems: entity.cartItems,
      totalAmount: entity.totalAmount,
      status: entity.status,
      createdAt: entity.createdAt,
    );
  }

  PlacedOrderModel toEntity() {
    return PlacedOrderModel(
      id: id,
      cartItems: cartItems,
      totalAmount: totalAmount,
      status: status,
      createdAt: createdAt,
    );
  }
}
