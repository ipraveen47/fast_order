import 'package:fast_order/features/order/domain/entity/order_model.dart';

class Order extends OrderModel {
  Order({
    required super.id,
    required super.orderName,
    required super.orderQuantity,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'orderName': orderName, 'orderQuantity': orderQuantity};
  }

  // Create Order from domain entity
  factory Order.fromDomain(OrderModel orderModel) {
    return Order(
      id: orderModel.id,
      orderName: orderModel.orderName,
      orderQuantity: orderModel.orderQuantity,
    );
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      orderName: map['orderName'] ?? '',
      orderQuantity: map['orderQuantity'] ?? '',
    );
  }
}
